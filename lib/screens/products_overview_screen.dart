import 'dart:ui';
import 'package:flutter/material.dart';


import '../localization/demo_localization.dart';
import '../models/data_search.dart';
import '../dummy_data.dart';
import '../main.dart';
import '../models/product.dart';
import '../widgets/render_grid_item.dart';
import '../models/laguages.dart';
import '../models/is_arabic.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  List<Product> _currentProducts = dummyData;
  bool _allHover = false;
  bool _vegetablesHover = false;
  bool _fruitsHover = false;
  bool _herbsHover = false;

  void _changeLanguage(Languages language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text('LIME'),
      leading: new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: DataSearch(),
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
      appBar: appBar,
      backgroundColor: Color.fromRGBO(255, 245, 229, 1),
      resizeToAvoidBottomInset: false,
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
                  itemBuilder: (ctx, i) => RenderGridItem(
                    id: _currentProducts[i].id,
                    title: isArabic(context)
                        ? _currentProducts[i].titleAr
                        : _currentProducts[i].titleEn,
                    price: _currentProducts[i].price,
                    priceDescription: isArabic(context)
                        ? _currentProducts[i].priceDescriptionAr
                        : _currentProducts[i].priceDescriptionEn,
                    color: _currentProducts[i].color,
                    imageUrl: _currentProducts[i].imageUrl,
                  ),
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
}
