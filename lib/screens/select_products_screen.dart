import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:vegefruit/widgets/collapsed_panel.dart';
import '../localization/demo_localization.dart';
import '../models/data_search.dart';
import '../models/product.dart';
import '../models/laguages.dart';
import '../models/is_arabic.dart';
import '../main.dart';
import '../widgets/render_select_grid_item.dart';

class SelectProductsScreen extends StatefulWidget {
  @override
  _SelectProductsScreenState createState() => _SelectProductsScreenState();
}

class _SelectProductsScreenState extends State<SelectProductsScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<String> selectedIdList = List();
  bool _selectionMode = false;
  bool _allHover = false;
  bool _vegetablesHover = false;
  bool _fruitsHover = false;
  bool _herbsHover = false;
  String _filterOption = 'all';
  String _type = 'fruits';

  Future<void> _updateSelectedValue(int i) async {
    try {
      await (FirebaseFirestore.instance
          .collection('products')
          .doc(selectedIdList[i])
          .update({'is_selected': true}));
    } catch (ex) {
      print(ex);
      _key.currentState.showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  void _selectStock() {
    try {
      for (int i = 0; i < selectedIdList.length; i++) {
        _updateSelectedValue(i);
      }
      _key.currentState.removeCurrentSnackBar();
      _key.currentState.showSnackBar(
          (SnackBar(content: Text(getTranslated(context, 'AddStockSuccess')))));
    } catch (ex) {
      print(ex);
      _key.currentState.showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  void _changeLanguage(Languages language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  void _changeSelection(String index) {
    _selectionMode = true;
    selectedIdList.add(index);
  }

  void _toggleSelection() {
    setState(() {
      _selectionMode = !_selectionMode;
      selectedIdList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buttons = List();
    final mq = MediaQuery.of(context);

    final allProducstList = Provider.of<List<Product>>(context);

    if (_selectionMode) {
      _buttons.add(IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            // reflect the database with isSelected field for each selected product + add the isSelected products to the SlidingUpPanel
            _selectStock();
            _toggleSelection();
          }));
    }
    final appBar = AppBar(
        backgroundColor: _selectionMode
            ? Colors.orange[600]
            : Theme.of(context).primaryColor,
        centerTitle: _selectionMode ? false : true,
        title: _selectionMode
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(getTranslated(context, 'done')),
                ],
              )
            : Text('LIME'),
        leading: _selectionMode
            ? new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  _toggleSelection();
                })
            : new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearch(allProducstList));
                }),
        actions: _selectionMode
            ? _buttons
            : <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton(
                        onChanged: (Languages language) {
                          _changeLanguage(language);
                        },
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.language,
                          color: Colors.black,
                        ),
                        items: Languages.languageList()
                            .map<DropdownMenuItem<Languages>>((lang) =>
                                DropdownMenuItem(
                                    value: lang,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(lang.name),
                                          Text(lang.flag),
                                        ])))
                            .toList()))
              ]);
    return Scaffold(
      key: _key,
      appBar: appBar,
      backgroundColor: Color.fromRGBO(255, 245, 229, 1),
      resizeToAvoidBottomInset: false,
      // body: SlidingUpPanel(
      //   panel: Container(
      //     child: ListView.builder(
      //       padding: const EdgeInsets.only(
      //         left: 20.0,
      //         right: 20.0,
      //         bottom: 20.0,
      //       ),
      //       itemCount: 8,
      //       itemBuilder: (ctx, i) {
      //         return ListItem(
      //             title: title, price: price, color: color, imageUrl: imageUrl);
      //       },
      //     ),
      //   ),
      //   minHeight: 60,
      //   maxHeight: mq-.size.height * 0.70,
      //   backdropEnabled: true,
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20),
      //   ),
      //   color: Theme.of(context).canvasColor,
      //   collapsed: collapsedPanel(context),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: (mq.size.height -
                        appBar.preferredSize.height -
                        mq.padding.top) *
                    0.011,
              ),
              Container(
                height: (mq.size.height -
                        appBar.preferredSize.height -
                        mq.padding.top) *
                    0.19,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _filterOption = 'all';
                        });
                        _colorOnHover(_filterOption);
                      },
                      child: typeIcon(
                        _allHover,
                        Color(0xFFFAA75A),
                        'assets/images/all.png',
                        getTranslated(context, 'all'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _filterOption = 'vegetables';
                          _type = 'vegetables';
                        });
                        _colorOnHover(_filterOption);
                      },
                      child: typeIcon(
                        _vegetablesHover,
                        Color(0xFFFC747F),
                        'assets/images/vegetables.png',
                        getTranslated(context, 'vegetables'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _filterOption = 'fruits';
                          _type = 'fruits';
                        });
                        _colorOnHover(_filterOption);
                      },
                      child: typeIcon(
                        _fruitsHover,
                        Color(0xFFA59FF5),
                        'assets/images/fruits.png',
                        getTranslated(context, 'fruits'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _filterOption = 'herbs';
                          _type = 'herbs';
                        });
                        _colorOnHover(_filterOption);
                      },
                      child: typeIcon(
                        _herbsHover,
                        Color(0xFF8ADB79),
                        'assets/images/herbs.png',
                        getTranslated(context, 'herbs'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0.0,
                indent: 10,
                endIndent: 10,
              ),
              Container(
                height: (mq.size.height -
                        appBar.preferredSize.height -
                        mq.padding.top) *
                    0.689,
                child: (allProducstList != null)
                    ? GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        //reverse: true,
                        itemCount: _filterOption != 'all'
                            ? allProducstList
                                .where((p) => (p.type == _type))
                                .toList()
                                .length
                            : allProducstList.length,
                        itemBuilder: (ctx, i) {
                          return renderSelectGridItem(
                            _filterOption != 'all'
                                ? allProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .id
                                : allProducstList[i].id,
                            isArabic(context)
                                ? _filterOption != 'all'
                                    ? allProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .titleAr
                                    : allProducstList[i].titleAr
                                : _filterOption != 'all'
                                    ? allProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .titleEn
                                    : allProducstList[i].titleEn,
                            _filterOption != 'all'
                                ? allProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .price
                                : allProducstList[i].price,
                            getTranslated(
                                context,
                                _filterOption != 'all'
                                    ? allProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .priceDescription
                                    : allProducstList[i].priceDescription),
                            _filterOption != 'all'
                                ? allProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .color
                                : allProducstList[i].color,
                            _filterOption != 'all'
                                ? allProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .image
                                : allProducstList[i].image,
                            _filterOption != 'all'
                                ? allProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .quantity
                                : allProducstList[i].quantity,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                      )
                    : Center(
                        child: Text('Loading...'),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.3),
          onPressed: () {
            Navigator.pushNamed(context, '/addProductScreen');
          },
          elevation: 0,
          tooltip: isArabic(context) ? 'منتج جديد!' : 'New Product!',
          child: Icon(
            Icons.add,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    );
  }

  void _colorOnHover(String type) {
    setState(() {
      if (type == 'all') {
        _allHover = true;
        _vegetablesHover = false;
        _fruitsHover = false;
        _herbsHover = false;
      }
      if (type == 'vegetables') {
        _allHover = false;
        _vegetablesHover = true;
        _fruitsHover = false;
        _herbsHover = false;
      }
      if (type == 'fruits') {
        _allHover = false;
        _vegetablesHover = false;
        _fruitsHover = true;
        _herbsHover = false;
      }
      if (type == 'herbs') {
        _allHover = false;
        _vegetablesHover = false;
        _fruitsHover = false;
        _herbsHover = true;
      }
    });
  }

  Widget typeIcon(bool arg, Color color, String image, String text) {
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.21,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: arg == true ? Colors.black.withOpacity(0.4) : color,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                image,
              ),
            ),
          ),
          Text(text),
        ],
      ),
    );
  }

  GridTile renderSelectGridItem(String id, String title, double price,
      String priceDescription, Color color, String imageUrl, double quantity) {
    if (_selectionMode) {
      return GridTile(
        header: GridTileBar(
          leading: Icon(
            selectedIdList.contains(id)
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: Colors.black,
          ),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                border: Border.all(color: Colors.orange[600], width: 10.0)),
            child: RenderSelectGridItem(
              id: id,
              title: title,
              price: price,
              priceDescription: priceDescription,
              color: color,
              imageUrl: imageUrl,
            ),
          ),
          onTap: () {
            setState(() {
              selectedIdList.contains(id)
                  ? selectedIdList.remove(id)
                  : selectedIdList.add(id);
            });
          },
        ),
      );
    } else {
      return GridTile(
        child: InkResponse(
          child: RenderSelectGridItem(
            id: id,
            title: title,
            price: price,
            priceDescription: priceDescription,
            color: color,
            imageUrl: imageUrl,
          ),
          onLongPress: () {
            setState(
              () {
                _changeSelection(id);
              },
            );
          },
        ),
      );
    }
  }
}
