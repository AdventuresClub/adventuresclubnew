import 'dart:io';

import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class VersionContainer extends StatefulWidget {
  final String version;
  final String? prefix;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Border? border;
  final double? width;
  final double? height;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final VoidCallback? onTap;

  const VersionContainer({
    Key? key,
    required this.version,
    this.prefix,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.border,
    this.width,
    this.height,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onTap,
  }) : super(key: key);

  @override
  State<VersionContainer> createState() => _VersionContainerState();
}

class _VersionContainerState extends State<VersionContainer> {
  double version = 0;
  @override
  void initState() {
    if (Platform.isIOS) {
      version = Constants.iosCurrentVersion;
    } else {
      version = Constants.currentVersion;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: widget.width,
      height: widget.height,
      padding:
          widget.padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.prefix ?? 'v'}$version',
            style: widget.textStyle ??
                TextStyle(
                  fontSize: 12,
                  color: widget.textColor ?? Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTap: widget.onTap,
        child: child,
      );
    }

    return child;
  }
}
