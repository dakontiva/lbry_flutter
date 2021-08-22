import 'package:flutter/material.dart';

class ClaimTile extends StatelessWidget {
  final Map claimProps;

  const ClaimTile({
    Key? key,
    this.claimProps = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                //TODO: handle error when fetching thumbnails
                //TODO: Use FadeInImage to show loading progress
                claimProps["thumbnail_url"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              claimProps["title"],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              claimProps["channel_name"],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
