import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MarketCard extends StatefulWidget {
  final Market market;

  const MarketCard({Key key, this.market}) : super(key: key);

  _MarketCardState createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '$serverUrl${widget.market.images[0]}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: spinKit()),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                )),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: AutoSizeText(
                        widget.market.name_tm,
                        presetFontSizes: [
                          16,
                          14,
                          12,
                          10,
                          8,
                          6,
                        ],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: popPinsMedium, color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(FeatherIcons.mapPin, color: kPrimaryColor_1, size: 18),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            widget.market.address_tm,
                            presetFontSizes: [
                              14,
                              12,
                              10,
                              8,
                              6,
                            ],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: popPinsRegular, color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(FeatherIcons.phoneCall, color: kPrimaryColor_1, size: 18),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            widget.market.phoneNumber,
                            presetFontSizes: [
                              14,
                              12,
                              10,
                              8,
                              6,
                            ],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: popPinsRegular, color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
