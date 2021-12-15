import 'package:flutter/material.dart';
import 'package:lbry/widgets/lbry_video_player.dart';
import 'package:lbry/services/lbry_sdk/main.dart' as lbry_sdk_main;
import 'package:lbry/theme.dart' as theme;
import 'package:transparent_image/transparent_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowClaim extends StatefulWidget {
  const ShowClaim({Key? key}) : super(key: key);

  @override
  _ShowClaimState createState() => _ShowClaimState();
}

class _ShowClaimState extends State<ShowClaim> {
  late final Future<String> streamingUrl;
  late final Future<Map> claimData;

  late final Map claimProps;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    claimProps = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    claimData = lbry_sdk_main.resolve([claimProps["permanent_url"]]);
    streamingUrl = lbry_sdk_main.get(claimProps["permanent_url"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.colors["background1"],
        appBar: AppBar(
          title: Text('LAMI'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<String>(
                future: streamingUrl,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  Widget child;
                  if(snapshot.hasData){
                    child = LbryVideoPlayer(streamingUrl: '${snapshot.data}');
                  }
                  else if (snapshot.hasError){
                    child = Text('${snapshot.error}');
                  }
                  else {
                    child = Center(child: CircularProgressIndicator());

                  }
                  return Align(
                    alignment: Alignment.topCenter,
                    child: child
                  );
                }),
            FutureBuilder(
              future: claimData,
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                Map data = snapshot.data![claimProps["permanent_url"]];

                // Do the error and null checking
                if (data["claim_id"] == null) {
                  return Expanded(child: Center(child: Text("Claim does not exist"),));
                }
                if (data["value"]["description"] == null) {
                  data["value"]["description"] = "No description provided...";
                  data["value"]["truncated_description"] = "No description provided...";
                } else {
                  // Make truncate description if the description was provided
                  data["value"]["truncated_description"] = data["value"]["description"].split(" ") // Split string to list by words
                                  .take(12) // Take first 12 words
                                  .join(" ") // Join it back to string
                                  +"..."; // Add "..." to indicate that truncation has happened
                }


                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 85,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: theme.colors["background5"],
                          child: Column(
                            children: [
                              Text(
                                data ["value"]["title"],
                                style: TextStyle(
                                  color: theme.colors["textColor"],
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ActionIcon(icon: Icons.favorite),
                                    ActionIcon(icon: Icons.share),
                                    ActionIcon(icon: Icons.repeat),
                                    ActionIcon(icon: Icons.money),
                                    ActionIcon(icon: Icons.download)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 48+16,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: theme.colors["background4"],
                          child: Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 48, 
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: data["signing_channel"]["value"]["thumbnail"]["url"]),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 250,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8, bottom: 2, top: 2),
                                      child: Text(
                                        data["signing_channel"]["value"]["title"],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: theme.colors["textColor"]
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8, bottom: 2, top: 2),
                                      child: Text(
                                        data["signing_channel"]["name"],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: theme.colors["accent"]
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              ActionIcon(
                                icon: Icons.favorite,
                                padding: EdgeInsets.only(right: 8),
                                size: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 50,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: theme.colors["background3"],
                          child: ExpandableTheme(
                            data: ExpandableThemeData(
                                iconColor: theme.colors["textColor"], 
                                animationDuration: const Duration(milliseconds: 300),
                                iconPadding: EdgeInsets.only(top:0,bottom: 4)
                            ),
                            child: ExpandablePanel(
                              header: Text("Description", style: TextStyle(color: theme.colors["textColor"]),),
                              collapsed: MarkdownPreset(
                                data: data["value"]["truncated_description"]
                                ),
                              expanded: MarkdownPreset(data: data["value"]["description"]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
    );
  }
}

class MarkdownPreset extends StatelessWidget {
  const MarkdownPreset({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
        data: data,
        styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 12, color: theme.colors["textColor"],),
            bodyText2: TextStyle(fontSize: 12, color: theme.colors["textColor"],),
            headline1: TextStyle(color: theme.colors["textColor"],),
            headline2: TextStyle(color: theme.colors["textColor"],),
            headline3: TextStyle(color: theme.colors["textColor"],),
            headline4: TextStyle(color: theme.colors["textColor"],),
            headline5: TextStyle(color: theme.colors["textColor"],fontSize: 14,),
            headline6: TextStyle(color: theme.colors["textColor"],fontSize: 13.5,),
            subtitle1: TextStyle(color: theme.colors["textColor"],fontSize: 13),
            subtitle2: TextStyle(color: theme.colors["textColor"],fontSize: 12.5,),
            button: TextStyle(color: theme.colors["accent"],),
          )
        )),
        onTapLink: (text, url, title){
            launch(url!);
        },
      );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final double size;

  const ActionIcon({
    Key? key,
    required this.icon,
    this.padding = EdgeInsets.zero,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Icon(icon,
        size: size,
        color: theme.colors["textColor"]
      ),
    );
  }
}
