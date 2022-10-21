// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

// import 'package:validators/validators.dart';
// import 'package:validators/sanitizers.dart';

// class CacheImage extends StatefulWidget {
//   CacheImage(this.url, {this.fit = BoxFit.cover});
//   final String url;
//   final BoxFit fit;

//   @override
//   State<StatefulWidget> createState() {
//     return _CacheImageState();
//   }
// }

// class _CacheImageState extends State<CacheImage> {
//   String url = "";
//   bool checkingUrl = false;

//   @override
//   void initState() {
//     super.initState();
//     url = widget.url;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool hiurl = isURL(url, requireTld: false);

//     if (checkingUrl) {
//       return const CupertinoActivityIndicator();
//     }

//     return
//         CachedNetworkImage(
//       imageUrl: hiurl
//           ? url
//           : "https://www.genesisglobalschool.edu.in/wp-content/uploads/2016/09/noimage.jpg",
//       placeholder: (context, url) => const CupertinoActivityIndicator(),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//       fit: widget.fit,
//     );
//   }
// }
