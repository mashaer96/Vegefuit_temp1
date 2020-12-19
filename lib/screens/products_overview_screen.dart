import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../localization/demo_localization.dart';
import '../models/data_search.dart';
import '../models/product.dart';
import '../models/laguages.dart';
import '../models/is_arabic.dart';
import '../widgets/render_grid_item.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _allHover = false;
  bool _vegetablesHover = false;
  bool _fruitsHover = false;
  bool _herbsHover = false;
  String _filterOption = 'all';
  String _type = 'fruits';

  void _changeLanguage(Languages language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    final availableProducstList = Provider.of<List<Product>>(context);
    final appBar = AppBar(
      centerTitle: true,
      title: Text('LIME'),
      leading: new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: DataSearch(availableProducstList),
          );
        },
      ),
      actions: <Widget>[
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
                .map<DropdownMenuItem<Languages>>((lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(lang.name),
                          Text(lang.flag),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
    return Scaffold(
      key: _key,
      appBar: appBar,
      backgroundColor: Color.fromRGBO(255, 245, 229, 1),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
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
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.689,
                child: (availableProducstList != null)
                    ? GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: _filterOption != 'all'
                            ? availableProducstList
                                .where((p) => (p.type == _type))
                                .toList()
                                .length
                            : availableProducstList.length,
                        itemBuilder: (ctx, i) {
                          return RenderGridItem(
                            id: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .id
                                : availableProducstList[i].id,
                            title: isArabic(context)
                                ? _filterOption != 'all'
                                    ? availableProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .titleAr
                                    : availableProducstList[i].titleAr
                                : _filterOption != 'all'
                                    ? availableProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .titleEn
                                    : availableProducstList[i].titleEn,
                            price: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .price
                                : availableProducstList[i].price,
                            priceDescription: getTranslated(
                                context,
                                _filterOption != 'all'
                                    ? availableProducstList
                                        .where((p) => (p.type == _type))
                                        .toList()[i]
                                        .priceDescription
                                    : availableProducstList[i]
                                        .priceDescription),
                            color: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .color
                                : availableProducstList[i].color,
                            imageUrl: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .image
                                : availableProducstList[i].image,
                            quantity: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .quantity
                                : availableProducstList[i].quantity,
                            isSelected: _filterOption != 'all'
                                ? availableProducstList
                                    .where((p) => (p.type == _type))
                                    .toList()[i]
                                    .isSelected
                                : availableProducstList[i].isSelected,
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
                        child: Text(getTranslated(context, 'loading')),
                      ),
              ),
            ],
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
}
