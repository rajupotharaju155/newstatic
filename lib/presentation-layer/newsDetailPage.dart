import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newstatic/businesss-layer/single-news/single_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsDetailPage extends StatelessWidget {
  static const Route = 'news-detail-page';
  static NewsModel newsModel;
  
  void _launchUrl(String urlString) async {
    if(await canLaunch(urlString)){
      print("Can launch");
      launch(urlString);
    }else{
      Fluttertoast.showToast(msg: "Cannot launch this news");
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SingleNewsCubit, SingleNewsState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        if(state is SingleNewsLoaded){
          newsModel = state.newsModel;
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, 200),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: newsModel.urlToImage ??
                      "https://cdn4.iconfinder.com/data/icons/ui-beast-4/32/Ui-12-512.png",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                              ColorFilter.mode(Colors.black38, BlendMode.darken)),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: Icon(Icons.image, size: 40)),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                  fadeInDuration: Duration(seconds: 1),
                ),
                SafeArea(
                  child: Container(
                    // padding: EdgeInsets.only(bottom: ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: ()=> Navigator.of(context).pop(), 
                          icon: Icon(Icons.arrow_back_ios_new, color: kSecondaryLight,)
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(newsModel.title,
                          style: TextStyle(
                            color: kSecondaryLight
                          )
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(newsModel.source,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryDark
                ),
                ),
                SizedBox(height: 5,),
                Text(newsModel.timeAgo,
                style: TextStyle(
                  fontSize: 10,
                  color: kPrimaryDark
                ),
                ),
                Expanded(
                  child: Text(newsModel.content??"No content found",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: kPrimaryDark
                  ),
                  ),
                ),
                GestureDetector(
                  onTap: ()=> _launchUrl(newsModel.url),
                  child: Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("See full story",
                        style: TextStyle(
                          color: kPrimaryLight 
                        ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15, color: kPrimaryLight )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
