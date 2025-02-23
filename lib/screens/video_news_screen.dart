import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/bloc/news_event.dart';
import 'package:newsapp/bloc/news_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/screens/video_player_screen.dart';

class VideoNewsScreen extends StatefulWidget {
  const VideoNewsScreen({Key? key}) : super(key: key);

  @override
  State<VideoNewsScreen> createState() => _VideoNewsScreenState();
}

class _VideoNewsScreenState extends State<VideoNewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(const FetchVideoNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is VideoNewsLoading) {
            return Center(
              child: SpinKitCircle(
                size: 50,
                color: Color(0xFF9D8DDE),
              ),
            );
          } else if (state is VideoNewsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else if (state is VideoNewsLoaded) {
            if (state.videos.articles == null || state.videos.articles!.isEmpty) {
              return Center(
                child: Text('No videos available'),
              );
            }

            return ListView.builder(
              itemCount: state.videos.articles!.length,
              itemBuilder: (context, index) {
                var article = state.videos.articles![index];
                if (article.urlToImage == null) return Container();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      String? videoUrl = article.url;
                      if (videoUrl != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              videoUrl: videoUrl,
                              title: article.title ?? '',
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: article.urlToImage!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF9D8DDE),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      article.publishedAt?.substring(0, 10) ?? '',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      article.source?.name ?? '',
                                      style: TextStyle(
                                        color: Color(0xFF9D8DDE),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
