import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../widgets/render_grid_item.dart';
import '../models/product.dart';
import '../models/is_arabic.dart';

class DataSearch extends SearchDelegate<String> {
  List<Product> _productsList;
  List<Product> _historyList = [];

  DataSearch(this._productsList) : super(keyboardType: TextInputType.name);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some results based one the selection
    final _suggestionList = _productsList
        .where((p) => (isArabic(context)
            ? p.titleAr.startsWith(query)
            : p.titleEn.startsWith(query)))
        .toList();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      margin: EdgeInsets.only(top: 20),
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _suggestionList.length,
        itemBuilder: (ctx, i) => RenderGridItem(
          id: _suggestionList[i].id,
          title: isArabic(context)
              ? _suggestionList[i].titleAr
              : _suggestionList[i].titleEn,
          price: _suggestionList[i].price,
          priceDescription:
              getTranslated(context, _suggestionList[i].priceDescription),
          color: _suggestionList[i].color,
          imageUrl: _suggestionList[i].image,
          isSelected: _suggestionList[i].isSelected,
          quantity: _suggestionList[i].quantity,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something
    final _suggestionList = query.isEmpty
        ? _historyList
        : _productsList
            .where((p) => (isArabic(context)
                ? p.titleAr.startsWith(query)
                : p.titleEn.startsWith(query)))
            .toList();
    return ListView.builder(
      itemBuilder: (context, i) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.history),
        title: RichText(
          text: TextSpan(
            text: isArabic(context)
                ? _suggestionList[i].titleAr.substring(0, query.length)
                : _suggestionList[i].titleEn.substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: isArabic(context)
                    ? _suggestionList[i].titleAr.substring(query.length)
                    : _suggestionList[i].titleEn.substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: _suggestionList.length,
    );
  }
}
