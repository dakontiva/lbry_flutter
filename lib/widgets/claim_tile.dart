import 'package:cached_network_image/cached_network_image.dart';
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
    return videoWidget(context);
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         height: 200,
    //         width: 400,
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10),
    //             topRight: Radius.circular(10),
    //           ),
    //           child: InkWrapper(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/show_claim', arguments: {
    //                 "permanent_url": claimProps["permanent_url"]
    //               });
    //             },
    //             child: FadeInImage.memoryNetwork(
    //               placeholder: kTransparentImage,
    //               image: claimProps["thumbnail_url"],
    //               imageErrorBuilder: (BuildContext context, Object exception,
    //                 StackTrace? stackTrace) {
    //                 return Container(
    //                   color: Colors.black,
    //                   child: Center(
    //                     child: Text(
    //                       'No Image',
    //                       style: TextStyle(
    //                         fontSize: 30,
    //                         color: theme.colors["textColor"],
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //       InkWrapper(
    //         onTap: () {
    //           Navigator.pushNamed(context, '/show_claim',
    //               arguments: {"permanent_url": claimProps["permanent_url"]});
    //         },
    //         child: Container(
    //           margin: EdgeInsets.only(top: 5, bottom: 5),
    //           child: Text(
    //             claimProps["title"],
    //             textAlign: TextAlign.left,
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: theme.colors["textColor"],
    //             ),
    //             overflow: TextOverflow.ellipsis,
    //             maxLines: 2,
    //           ),
    //         ),
    //       ),
    //       InkWrapper(
    //         onTap: () {},
    //         child: Row(
    //           children: <Widget>[
    //             FadeInImage.memoryNetwork(
    //               placeholder: kTransparentImage,
    //               width: 40,
    //               height: 40,
    //               image: claimProps["channel_thumbnail_url"],
    //               imageErrorBuilder: (BuildContext context, Object exception,
    //                   StackTrace? stackTrace) {
    //                 return Container(
    //                   width: 40,
    //                   height: 40,
    //                   color: Colors.black12,
    //                   child: Icon(
    //                     Icons.person,
    //                     size: 30.0,
    //                   ),
    //                 );
    //               },
    //               fit: BoxFit.contain,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 10.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   if (claimProps["channel_title"] != "")
    //                     Container(
    //                       padding: EdgeInsets.only(bottom: 3.0),
    //                       width: 300,
    //                       child: Text(
    //                         claimProps["channel_title"],
    //                         // "this is a really really really really really really really really really really really long title",
    //                         textAlign: TextAlign.left,
    //                         style: TextStyle(
    //                           fontSize: 15,
    //                           color: theme.colors["textColor"],
    //                         ),
    //                         overflow: TextOverflow.clip,
    //                         maxLines: 1,
    //                       ),
    //                     ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.only(right: 5.0),
    //                         child: Text(
    //                           claimProps["channel_name"],
    //                           textAlign: TextAlign.left,
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.bold,
    //                             color: theme.colors["textColor"],
    //                           ),
    //                           overflow: TextOverflow.fade,
    //                           maxLines: 1,
    //                         ),
    //                       ),
    //                       Icon(
    //                         Icons.circle,
    //                         size: 3.0,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 5.0),
    //                         child: Text(
    //                           findReleaseTime(),
    //                           textAlign: TextAlign.left,
    //                           style: TextStyle(
    //                             fontSize: 12,
    //                             color: theme.colors["textColor"],
    //                             // fontWeight: FontWeight.bold,
    //                           ),
    //                           overflow: TextOverflow.fade,
    //                           maxLines: 1,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  // TODO Post time, pressing/tapping and other gestures.
  Widget videoWidget(context) {
    print(claimProps["thumbnail_url"]);
    print(claimProps["channel_thumbnail_url"]);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/show_claim',
            arguments: {"permanent_url": claimProps["permanent_url"]});
        },
      child: Container(
          height: 350,
          margin: EdgeInsets.fromLTRB(8, 12, 8, 8),
          decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color : theme.colors["background2"],
                ),
          child: Stack(children: [
            Positioned(
              top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage.memoryNetwork(
                height: 265,
                alignment: Alignment.center,
                placeholder: kTransparentImage,
                image: claimProps["thumbnail_url"].isEmpty ? claimProps["thumbnail_url"] : "https://lbry2.vanwanet.com/speech/@EinoRauhala:b/thumbnailplaceholder:3",
                imageErrorBuilder: (context, url, error) => Icon(Icons.error),
              )
            )
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
                    Positioned(
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: FadeInImage.memoryNetwork(
                          width: 32,
                          height: 32,
                          placeholder: kTransparentImage,
                          image: claimProps["channel_thumbnail_url"].isEmpty ? claimProps["channel_thumbnail_url"] : "https://lbry2.vanwanet.com/speech/@EinoRauhala:b/thumbnailplaceholder:3",
                          imageErrorBuilder: (context, url, error) => Icon(Icons.error),
                        )
                      )                    ),
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
              )
              )
            ),
          ]
        )
      ),
    );
  } 
}

