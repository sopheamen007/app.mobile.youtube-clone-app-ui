import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_ui/json/home_video.dart';
import 'package:youtube_ui/theme/colors.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  String thumbnail;
  String title;
  String viewCount;
  String dayAgo;
  String username;
  String profile;
  String subscribeCount;
  String likeCount;
  String unlikeCount;
  String videoUrl;

  VideoDetailPage(
      {Key key,
      this.thumbnail,
      this.title,
      this.viewCount,
      this.dayAgo,
      this.username,
      this.profile,
      this.subscribeCount,
      this.likeCount,
      this.unlikeCount,
      this.videoUrl})
      : super(key: key);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  bool isSwitched = true;

  // for video player
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  int _playBackTime;
  //The values that are passed when changing quality
  Duration newCurrentPosition;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b1c1e),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          _controller.value.initialized
              ? Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? null
                                : Icons.play_arrow,
                            size: 60,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.thumbnail),
                          fit: BoxFit.contain)),
                ),
          Expanded(
              child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: size.width - 80,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  LineIcons.angle_down,
                                  color: white.withOpacity(0.7),
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              widget.viewCount + " views - " + widget.dayAgo,
                              style: TextStyle(
                                  color: white.withOpacity(0.4), fontSize: 13),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.thumbs_up,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.likeCount.toString(),
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.thumbs_down,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.unlikeCount.toString(),
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.share,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.download,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.plus,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: white.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.profile),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 180),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.username,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        widget.subscribeCount.toString() +
                                            " Subscribers",
                                        style: TextStyle(
                                          color: white.withOpacity(0.4),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "SUBSCRIBE",
                          style: TextStyle(
                              color: red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: white.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Up next",
                          style: TextStyle(
                              fontSize: 14,
                              color: white.withOpacity(0.4),
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Autoplay",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: white.withOpacity(0.4),
                                  fontWeight: FontWeight.w500),
                            ),
                            Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                            List.generate(home_video_detail.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              _startPlay(home_video_detail[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            50) /
                                        2,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                home_video_detail[index]
                                                    ['thumnail_img']),
                                            fit: BoxFit.cover)),
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          bottom: 10,
                                          right: 12,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                home_video_detail[index]
                                                    ['video_duration'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        white.withOpacity(0.4)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  130) /
                                              2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                home_video_detail[index]
                                                    ['title'],
                                                style: TextStyle(
                                                    color:
                                                        white.withOpacity(0.9),
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    fontSize: 14),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                home_video_detail[index]
                                                    ['username'],
                                                style: TextStyle(
                                                    color:
                                                        white.withOpacity(0.4),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    home_video_detail[index]
                                                        ['view_count'],
                                                    style: TextStyle(
                                                        color: white
                                                            .withOpacity(0.4),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          LineIcons.ellipsis_v,
                                          color: white.withOpacity(0.4),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _startPlay(videoItem) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoItem['video_url']);
      });
    });

    // new state of video object
    setState(() {
      widget.title = videoItem['title'];
      widget.viewCount = videoItem['view_count'];
      widget.dayAgo = videoItem['day_ago'];
      widget.username = videoItem['username'];
      widget.profile = videoItem['profile_img'];
      widget.subscribeCount = videoItem['subscriber_count'];
      widget.likeCount = videoItem['like_count'];
      widget.unlikeCount = videoItem['unlike_count'];
    });
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.asset(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }
}
