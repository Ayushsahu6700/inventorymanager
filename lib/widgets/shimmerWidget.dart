import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerWidget.rectangular(
      {this.width = double.infinity, required this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class shimmerBox extends StatelessWidget {
  const shimmerBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < 7; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    //background color of box

                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        3.0, // Move to right 10  horizontally
                        3.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                                child: ShimmerWidget.rectangular(height: 10)),
                            Expanded(
                                child: ShimmerWidget.rectangular(height: 10)),
                            Expanded(
                                child: ShimmerWidget.rectangular(height: 10)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShimmerWidget.rectangular(height: 26),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
