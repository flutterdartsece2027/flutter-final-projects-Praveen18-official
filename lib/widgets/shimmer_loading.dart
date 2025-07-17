import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 4.0,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
          shape: shape,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;
  final EdgeInsets padding;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 100.0,
    this.spacing = 8.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => ShimmerLoading(
        height: itemHeight,
        borderRadius: 8.0,
      ),
    );
  }
}
