import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lbry/utils/date_time.dart';
import 'package:lbry/widgets/ink_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lbry/theme.dart' as theme;


class ClaimTile extends StatelessWidget {
  final Map claimProps;

  const ClaimTile({
    Key? key,
    required this.claimProps,
  }) : super(key: key);

  String findReleaseTime() {
    if (claimProps["release_time"] != null)
      return timeAgo(int.parse(claimProps["release_time"]));
    else if (claimProps["timestamp"] != null)
      return timeAgo(int.parse(claimProps["timestamp"]));
    else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
          height: 350,
          margin: EdgeInsets.fromLTRB(8, 12, 8, 8),
          decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: theme.colors["background2"],
                  image: DecorationImage(
                    image: NetworkImage(
                        claimProps["thumbnail_url"].isEmpty ? "https://lbry2.vanwanet.com/speech/@EinoRauhala:b/thumbnailplaceholder:3" : claimProps["thumbnail_url"],),
                    fit: BoxFit.fill,
                    opacity: 0.5,
                  ),
            ),
          clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Stack(children: [
              Positioned(
                top: 0,
                child: InkWrapper(
                  splashColor: theme.colors["accent"]?.withOpacity(0.1),
                  // margin: EdgeInsets.fromLTRB(8, 12, 8, 8),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  onTap: () {
                    Navigator.pushNamed(context, '/show_claim',
                        arguments: {"permanent_url": claimProps["permanent_url"]});
                    },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        // The maximum width of the image is being set to the screen width minus the margins
                        // on the left and on the right for the widget to prevent overflow
                        maxWidth: screenSize.width-8-8,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: FadeInImage.memoryNetwork(
                              height: 265,
                              alignment: Alignment.center,
                              placeholder: kTransparentImage,
                              image: claimProps["thumbnail_url"].isEmpty ? "https://lbry2.vanwanet.com/speech/@EinoRauhala:b/thumbnailplaceholder:3" : claimProps["thumbnail_url"],
                              imageErrorBuilder: (context, url, error) => Icon(Icons.error, color: theme.colors["accent"],),
                            ),
                          ),
                        ] 
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  width: 430,
                  height: 60,
                  // color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 4,
                        child: Text(claimProps["title"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: theme.colors["textColor"],
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                          ),
                        )
                      ),
                      ChannelData(claimProps: claimProps),
                  ]
                )
                )
              ),
            ]
                  ),
          )
      );
  }
}

class ChannelData extends StatelessWidget {
  const ChannelData({
    Key? key,
    required this.claimProps,
  }) : super(key: key);

  final Map claimProps;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {print("Pressed on channel data");},
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage.memoryNetwork(
                width: 32,
                height: 32,
                placeholder: kTransparentImage,
                image: claimProps["channel_thumbnail_url"].isEmpty ? "https://lbry2.vanwanet.com/speech/@EinoRauhala:b/thumbnailplaceholder:3" : claimProps["channel_thumbnail_url"],
                imageErrorBuilder: (context, url, error) => Icon(Icons.error),
              )
            )
          ),
          Positioned(
            bottom: 16,
            left: 39,
            child: Text(claimProps["channel_title"], textAlign: TextAlign.left,
            style: TextStyle(
              color: theme.colors["textColor"],
              fontFamily: 'Roboto',
              fontSize: 13,
              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1
            ),
            )
          ),
          Positioned(
            left: 39,
            bottom: 2,
            child: Text(claimProps["channel_name"],
              textAlign: TextAlign.left,
              style: TextStyle(
                color: theme.colors["accent"],
                fontFamily: 'Roboto',
                fontSize: 10,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.normal,
                height: 1
              ),
              )
            ),
        ]
      ),
    );
  }
}

