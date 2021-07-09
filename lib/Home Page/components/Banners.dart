import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/Home%20Page/components/PhotoView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Others/Models/common.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';

class Banners extends StatefulWidget {
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  int selectedIndex = 0;

  Widget hasData(List<BannerModel> snapshot) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CarouselSlider.builder(
            itemCount: snapshot.length,
            itemBuilder: (context, index, count) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Photoview(
                            images: ["${snapshot[index].image}"],
                          )));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: "$serverUrl${snapshot[index].image}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(child: spinKit()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, CarouselPageChangedReason) {
                setState(() {
                  selectedIndex = index;
                });
              },
              aspectRatio: 1.80 / 1,
              pauseAutoPlayOnTouch: true,
              viewportFraction: 1.0,
              autoPlay: true,
              scrollPhysics: BouncingScrollPhysics(),
              autoPlayCurve: Curves.easeInOut,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
            ),
          ),
        ),
        Container(
            height: 9,
            child: Center(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                addRepaintBoundaries: true,
                addSemanticIndexes: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: selectedIndex == index ? 30 : 9,
                    decoration: BoxDecoration(color: selectedIndex == index ? kPrimaryColor : kPrimaryColor_1, borderRadius: borderRadius15),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget bannerCardShimmer() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: CarouselSlider.builder(
              itemCount: 10,
              itemBuilder: (context, index, count) {
                return Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: borderRadius10),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, CarouselPageChangedReason) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                aspectRatio: 1.80 / 1,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0,
                scrollPhysics: BouncingScrollPhysics(),
                autoPlayCurve: Curves.easeInOut,
                enableInfiniteScroll: true,
              ),
            ),
          ),
        ),
        Container(
            height: 9,
            child: Center(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                addRepaintBoundaries: true,
                addSemanticIndexes: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: AnimatedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: selectedIndex == index ? 30 : 9,
                      decoration: BoxDecoration(color: selectedIndex == index ? kPrimaryColor : kPrimaryColor_1, borderRadius: borderRadius15),
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget hasError() {
    return SizedBox(
      height: 200,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.refresh_outlined,
            size: 40,
            color: kPrimaryColor_1,
          ),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget noBanner() {
    return SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'Şu wagtlykça reklama ýok !',
          style: TextStyle(color: Colors.black, fontFamily: popPinsSemiBold, fontSize: 18),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<BannerModel>>(future: BannerModel.getAllBanners.then((value) {
          return value;
        }), builder: (context, snapshot) {
          if (snapshot.hasError)
            return hasError();
          else if (snapshot.hasData)
            return snapshot.data.length == 0 ? noBanner() : hasData(snapshot.data);
          else
            return bannerCardShimmer();
        }),
      ],
    );
  }
}
