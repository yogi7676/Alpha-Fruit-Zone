import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

customImage(String imageUrl,BoxFit fit) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    placeholder: (context, url) => const CupertinoActivityIndicator(),
  );
}