import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).primaryColor, width: 4.0),
          borderRadius: BorderRadiusDirectional.circular(8.0)),
      child: Column(
        children: [ImageNetworkWidget(url: url), UrlWidget(url: url)],
      ),
    );
  }
}

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.fill,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return frame == null ? LoadingWidget() : child;
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return LoadingWidget(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null);
      },
    );
  }
}

class UrlWidget extends StatelessWidget {
  const UrlWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Text(url,
          maxLines: 1,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              overflow: TextOverflow.ellipsis)),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.value,
  }) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      height: 64,
      width: 64,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.onPrimary,
        value: value,
      ),
    );
  }
}

class IpInfoItem extends StatelessWidget {
  const IpInfoItem({
    Key? key,
    required this.titleResult,
    required this.descriptionResult,
  }) : super(key: key);

  final String titleResult;
  final String descriptionResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          titleResult,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        minVerticalPadding: 16.0,
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "${descriptionResult.trimRight().trimLeft()}"
                .replaceAll(RegExp(r'\n'), ''),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
