import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListviewCard extends StatelessWidget {
  final Product product;
  final int userId;

  const ListviewCard({Key key, @required this.product, @required this.userId}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double rating = double.parse(product.rating);
    return Container(
      width: size.width,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 1,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: size.height,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200.withOpacity(0.6)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    colorBlendMode: BlendMode.difference,
                    imageUrl: '$serverUrl${product.images}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: spinKit()),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              product.name_tm ?? "Haryt",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              presetFontSizes: [
                                18,
                                16,
                                14,
                                12,
                                10,
                                8,
                              ],
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: popPinsSemiBold,
                              ),
                            ),
                          ),
                          Align(alignment: Alignment.topRight, child: likeButton(FeatherIcons.heart, false, product.favored, product.id, userId)),
                        ],
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: new TextSpan(
                        text: 'Satyjy : ',
                        style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsMedium),
                        children: <TextSpan>[
                          new TextSpan(
                            text: '${product.brand}',
                            style: TextStyle(fontSize: 18, fontFamily: popPinsMedium),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SmoothStarRating(
                          size: 20,
                          starCount: 5,
                          isReadOnly: true,
                          rating: rating,
                          color: kPrimaryColor,
                          borderColor: kPrimaryColor,
                          allowHalfRating: true,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            '${rating ?? 0.0}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            presetFontSizes: [15, 13, 11, 9, 7],
                            style: TextStyle(
                              fontFamily: popPinsSemiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: new TextSpan(
                        text: 'Bahasy : ',
                        style: TextStyle(color: kPrimaryColor_1, fontSize: 18, fontFamily: popPinsMedium),
                        children: <TextSpan>[
                          new TextSpan(
                            text: '${product.price ?? "0"}',
                            style: TextStyle(fontSize: 18, fontFamily: popPinsSemiBold),
                          ),
                          new TextSpan(
                            text: ' TMT',
                            style: TextStyle(fontSize: 14, fontFamily: popPinsMedium),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (userId != null) {
                            Cart().addProductToCartById(userId: userId, productId: product.id, qty: 1);
                            showMessage("Sebede goşuldy", context);
                          } else {
                            showMessage("Harydy sebediňize goşmak üçin ulgama giriň !", context);
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                        color: kPrimaryColor,
                        elevation: 1,
                        child: AutoSizeText(
                          'Sebede goş',
                          maxLines: 1,
                          stepGranularity: 1,
                          presetFontSizes: [16, 14, 12, 10, 8, 6],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsBold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
