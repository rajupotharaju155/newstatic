import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/single-news/single_news_cubit.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/presentation-layer/newsDetailPage.dart';
import '../../const.dart';

class NewsTile extends StatelessWidget {
 final NewsModel newsModel;
 final int index;
 NewsTile({this.newsModel, this.index});

 
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: (){
        BlocProvider.of<SingleNewsCubit>(context).setSingleNews(newsModel);
        Navigator.of(context).pushNamed(NewsDetailPage.Route);
      },
      child: Container(
        height: 130,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kSecondaryDark,
              spreadRadius: 2,
              blurRadius: 2
            )
          ]
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
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
                    Flexible(
                      child: Text(newsModel.title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[800]
                      ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(newsModel.timeAgo,
                    style: TextStyle(
                      fontSize: 10,
                      color: kPrimaryDark
                    ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: newsModel.urlToImage??"https://cdn4.iconfinder.com/data/icons/ui-beast-4/32/Ui-12-512.png",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
                  ),
                ),
                placeholder: (context, url) => Icon(Icons.image, size: 70, color: Colors.grey[400],),
                errorWidget: (context, url, error) => Icon(Icons.error, size: 70, color: Colors.grey[400],),
                fadeInDuration: Duration(seconds: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}