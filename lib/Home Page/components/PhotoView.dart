import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

import '../../Others/constants/constants.dart';

class Photoview extends StatefulWidget {
  const Photoview({
    Key key,
    this.images,
  }) : super(key: key);

  final List images;

  @override
  _PhotoviewState createState() => _PhotoviewState();
}

class _PhotoviewState extends State<Photoview> {
  int selectedIndex = 0;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(FeatherIcons.x, color: Colors.white, size: 25)),
                  GestureDetector(
                      onTap: () {
                        Share.share("$serverUrl${widget.images[selectedIndex]}");
                      },
                      child: Icon(Icons.share, color: Colors.white, size: 25)),
                ],
              ),
            ),
            Expanded(
              child: PhotoView(
                      enableRotation: true,
                      minScale: 0.4,
                      maxScale: 2.0,
                      imageProvider: CachedNetworkImageProvider('$serverUrl${widget.images[selectedIndex]}'),
                      tightMode: true,
                    )
//                  : Swiper(
//                      onIndexChanged: (value) {
//                        setState(() {
//                          selectedIndex = value;
//                        });
//                      },
//                      itemBuilder: (BuildContext context, int index) {
//                        return PhotoView(
//                          enableRotation: true,
//                          minScale: 0.4,
//                          maxScale: 2.0,
//                          imageProvider: CachedNetworkImageProvider('$serverUrl${widget.images[index]}'),
//                          tightMode: true,
//                        );
//                      },
//                      pagination: new SwiperPagination(
//                        alignment: Alignment.bottomCenter,
//                        builder: new DotSwiperPaginationBuilder(size: 12, activeSize: 12, color: Colors.grey[200], activeColor: kPrimaryColor),
//                      ),
//                      itemCount: widget.images.length,
//                      curve: Curves.easeInOut,
//                      loop: true,
//                    ),
            ),
          ],
        ),
      ),
    );
  }
}
