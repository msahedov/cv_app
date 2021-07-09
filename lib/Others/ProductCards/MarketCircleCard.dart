import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/material.dart';

class MarketCircleCard extends StatefulWidget {
  final Market market;

  const MarketCircleCard({Key key, this.market}) : super(key: key);
  _MarketCircleCardState createState() => _MarketCircleCardState();
}

class _MarketCircleCardState extends State<MarketCircleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            child: Container(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: '$serverUrl${widget.market.images[0]}',
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
          Container(
            alignment: Alignment.center,
            width: 90,
            padding: const EdgeInsets.only(top: 8),
            child: AutoSizeText(
              widget.market.name_tm,
              maxLines: 1,
              //presetFontSizes: [16, 14, 12, 10, 8, 6],
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: popPinsMedium, fontSize: 16, color: kPrimaryColor_1),
            ),
          ),
        ],
      ),
    );
  }
}
