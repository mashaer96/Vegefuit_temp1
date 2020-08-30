import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:vegefruit/widgets/collapsed_panel.dart';
// import 'package:vegefruit/widgets/list_item.dart';

import '../localization/demo_localization.dart';
import '../models/data_search.dart';
import '../dummy_data.dart';
import '../main.dart';
import '../models/product.dart';
//import '../widgets/render_grid_item.dart';
import '../widgets/render_select_grid_item.dart';
import '../models/laguages.dart';
import '../models/is_arabic.dart';

class SelectProductsScreen extends StatefulWidget {
  @override
  _SelectProductsScreenState createState() => _SelectProductsScreenState();
}

class _SelectProductsScreenState extends State<SelectProductsScreen> {
  // final title = 'Watermelone';
  // final price = 2.45;
  // final priceDescription = 'Per unit';
  // final imageUrl = 'assets/images/watermelon.png';
  // final color = Color(0xFFFF3B4A);

  var _selectionMode = false; // must be in the product table in the firebase

  List<String> _selectedIdList = List();
  List<Product> _currentProducts = dummyData;
  bool _allHover = false;
  bool _vegetablesHover = false;
  bool _fruitsHover = false;
  bool _herbsHover = false;

  void _changeLanguage(Languages language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  void _changeSelection(String index) {
    _selectionMode = true;
    _selectedIdList.add(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _buttons = List();
    if (_selectionMode) {
      _buttons.add(IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            // reflect the database with isSelected field for each selected product + add the isSelected products to the SlidingUpPanel
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
                  //close(context, null);
                  setState(() {
                    _selectionMode = !_selectionMode;
                    _selectedIdList.clear();
                  });
                })
            : new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
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
      //   maxHeight: MediaQuery.of(context).size.height * 0.70,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.011,
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.19,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    typeIcon(
                      'all',
                      _allHover,
                      Color(0xFFFAA75A),
                      'assets/images/all.png',
                      getTranslated(context, 'all'),
                    ),
                    typeIcon(
                      'vegetables',
                      _vegetablesHover,
                      Color(0xFFFC747F),
                      'assets/images/vegetables.png',
                      getTranslated(context, 'vegetables'),
                    ),
                    typeIcon(
                      'fruits',
                      _fruitsHover,
                      Color(0xFFA59FF5),
                      'assets/images/fruits.png',
                      getTranslated(context, 'fruits'),
                    ),
                    typeIcon(
                      'herbs',
                      _herbsHover,
                      Color(0xFF8ADB79),
                      'assets/images/herbs.png',
                      getTranslated(context, 'herbs'),
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
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.689,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: _currentProducts.length,
                  itemBuilder: (ctx, i) => renderSelectGridItem(
                      _currentProducts[i].id,
                      isArabic(context)
                          ? _currentProducts[i].titleAr
                          : _currentProducts[i].titleEn,
                      _currentProducts[i].price,
                      isArabic(context)
                          ? _currentProducts[i].priceDescriptionAr
                          : _currentProducts[i].priceDescriptionEn,
                      _currentProducts[i].color,
                      _currentProducts[i].imageUrl),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //),
      // floatingActionButton: Container(
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.black.withOpacity(0.3),
      //     onPressed: () {
      //       Navigator.pushNamed(context, '/addProductScreen');
      //     },
      //     elevation: 0,
      //     tooltip: isArabic(context) ? 'منتج جديد!' : 'New Product!',
      //     child: Icon(
      //       Icons.add,
      //       color: Theme.of(context).canvasColor,
      //     ),
      //   ),
      // ),
    );
  }

  void _typeFilter(String type) {
    setState(() {
      _currentProducts = dummyData.where((product) {
        if (type == 'all') {
          _allHover = true;
          _vegetablesHover = false;
          _fruitsHover = false;
          _herbsHover = false;
          return true;
        }
        if ((type == 'vegetables') && (product.type != Type.Vegetables)) {
          _allHover = false;
          _vegetablesHover = true;
          _fruitsHover = false;
          _herbsHover = false;
          return false;
        }
        if ((type == 'fruits') && (product.type != Type.Fruits)) {
          _allHover = false;
          _vegetablesHover = false;
          _fruitsHover = true;
          _herbsHover = false;
          return false;
        }
        if ((type == 'herbs') && (product.type != Type.Herbs)) {
          _allHover = false;
          _vegetablesHover = false;
          _fruitsHover = false;
          _herbsHover = true;
          return false;
        }
        return true;
      }).toList();
    });
  }

  Flexible typeIcon(
      String type, bool arg, Color color, String image, String text) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _typeFilter(type);
            },
            child: Container(
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
          ),
          Text(text),
        ],
      ),
    );
  }

  GridTile renderSelectGridItem(String id, String title, double price,
      String priceDescription, Color color, String imageUrl) {
    if (_selectionMode) {
      return GridTile(
        header: GridTileBar(
          leading: Icon(
            _selectedIdList.contains(id)
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
              _selectedIdList.contains(id)
                  ? _selectedIdList.remove(id)
                  : _selectedIdList.add(id);
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
