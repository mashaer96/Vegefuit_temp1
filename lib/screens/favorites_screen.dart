import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vegefruit/widgets/empty_status.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../widgets/render_grid_item.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height =
        mq.size.height - AppBar().preferredSize.height - mq.padding.top;
    final width = mq.size.width;
    final users = Provider.of<List<UserAuth>>(context);
    final allProducstList = Provider.of<List<Product>>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            getTranslated(context, 'favorites'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
      body: (users.where((user) => (user.uid == uid)).first.favourites.length !=
              0)
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              height: height * 0.9,
              child: (allProducstList != null)
                  ? GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: users
                          .where((user) => (user.uid == uid))
                          .first
                          .favourites
                          .length,
                      itemBuilder: (ctx, i) {
                        return RenderGridItem(
                          id: users
                              .where((user) => (user.uid == uid))
                              .first
                              .favourites[i],
                          title: isArabic(context)
                              ? allProducstList
                                  .where((p) => (p.id ==
                                      users
                                          .where((user) => (user.uid == uid))
                                          .first
                                          .favourites[i]))
                                  .first
                                  .titleAr
                              : allProducstList
                                  .where((p) => (p.id ==
                                      users
                                          .where((user) => (user.uid == uid))
                                          .first
                                          .favourites[i]))
                                  .first
                                  .titleEn,
                          price: allProducstList
                              .where((p) => (p.id ==
                                  users
                                      .where((user) => (user.uid == uid))
                                      .first
                                      .favourites[i]))
                              .first
                              .price,
                          priceDescription: getTranslated(
                              context,
                              allProducstList
                                  .where((p) => (p.id ==
                                      users
                                          .where((user) => (user.uid == uid))
                                          .first
                                          .favourites[i]))
                                  .first
                                  .priceDescription),
                          color: allProducstList
                              .where((p) => (p.id ==
                                  users
                                      .where((user) => (user.uid == uid))
                                      .first
                                      .favourites[i]))
                              .first
                              .color,
                          imageUrl: allProducstList
                              .where((p) => (p.id ==
                                  users
                                      .where((user) => (user.uid == uid))
                                      .first
                                      .favourites[i]))
                              .first
                              .image,
                          quantity: allProducstList
                              .where((p) => (p.id ==
                                  users
                                      .where((user) => (user.uid == uid))
                                      .first
                                      .favourites[i]))
                              .first
                              .quantity,
                          isSelected: allProducstList
                              .where((p) => (p.id ==
                                  users
                                      .where((user) => (user.uid == uid))
                                      .first
                                      .favourites[i]))
                              .first
                              .isSelected,
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
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                EmptyStatus(
                    message: getTranslated(context, 'emptyStock')),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.4,
                      height: height * 0.08,
                      child: RaisedButton(
                        child: Text(
                          getTranslated(context, 'shopNow'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        textColor: Colors.black,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/tabScreen');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
