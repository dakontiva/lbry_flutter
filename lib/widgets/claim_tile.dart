import 'package:flutter/material.dart';
import 'package:lbry/widgets/ink_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';

class ClaimTile extends StatelessWidget {
  final Map claimProps;

  const ClaimTile({
    Key? key,
    required this.claimProps,
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
              child: InkWrapper(
                onTap: () {
                  Navigator.pushNamed(context, '/show_claim', arguments: {
                    "permanent_url": claimProps["permanent_url"]
                  });
                },
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: claimProps["thumbnail_url"],
                  imageErrorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'No Image',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          InkWrapper(
            onTap: () {
              Navigator.pushNamed(context, '/show_claim',
                  arguments: {"permanent_url": claimProps["permanent_url"]});
            },
            child: Container(
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
          ),
          InkWrapper(
            onTap: () {},
            child: Row(
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  width: 40,
                  height: 40,
                  image: claimProps["channel_thumbnail_url"],
                  imageErrorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      color: Colors.black12,
                      child: Icon(
                        Icons.person,
                        size: 30.0,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (claimProps["channel_title"] != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            claimProps["channel_title"],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          claimProps["channel_name"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
