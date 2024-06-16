import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/views/categories_screen.dart';
import 'package:news_app/views/news_detail_screen.dart';

import '../models/categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilteredList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel(); // object of the API's feteched
  FilteredList? selectedMenu;
  String name = 'bbc-news';

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              height: height * 0.03,
            ),
            //  iconSize: 2,
          ),
          title: const Center(
            child: Text(
              "Today's News",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              )
    ),
          ),
          actions: [
            PopupMenuButton<FilteredList>(
                initialValue: selectedMenu,
                onSelected: (FilteredList item) {
                  if (FilteredList.bbcNews.name == item.name) {
                    name = 'bbc-news';
                  }
                  if (FilteredList.alJazeera.name == item.name) {
                    name = 'al-jazeera-english';
                  }

                  if (FilteredList.aryNews.name == item.name) {
                    name = 'ary-news';
                  }

                  setState(() {
                    selectedMenu = item;
                  });
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<FilteredList>>[
                  const PopupMenuItem<FilteredList>(
                    value: FilteredList.bbcNews,
                    child: Text('BBc News'),
                  ),
                  const PopupMenuItem<FilteredList>(
                    value: FilteredList.aryNews,
                    child: Text('Ary News'),
                  ),
                  const PopupMenuItem<FilteredList>(
                    value: FilteredList.alJazeera,
                    child: Text('Al Jazira'),
                  ),
                ]),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCircle(
                            color: Colors.black,
                            size: 40,
                          ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());

                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailsScreen(
                                    newsTitle: snapshot
                                        .data!.articles![index].title
                                        .toString(),
                                    newsImg: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    newsDate: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    author: snapshot
                                        .data!.articles![index].author
                                        .toString(),
                                    description: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                    content:snapshot
                                        .data!.articles![index].content
                                        .toString(), source:snapshot
                                    .data!.articles![index].source!.name
                                    .toString())));
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.6,
                                      width: width * 0.9,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.02,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: ((context, url) =>
                                          const SpinKitCircle(
                                            color: Colors.black,
                                            size: 40,
                                          )),
                                          errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height * 0.22,
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:
                                                     const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.05,
                                                    ),
                                                    Text(
                                                      format.format(dateTime),
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style:
                                                      const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            FutureBuilder<CategoryModel>(
                future: newsViewModel.fetchNewsCategoriesApi('General'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 40,
                        ));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());

                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailsScreen(
                                  newsTitle: snapshot
                                      .data!.articles![index].title
                                      .toString(),
                                  newsImg: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  newsDate: snapshot
                                      .data!.articles![index].publishedAt
                                      .toString(),
                                  author: snapshot
                                      .data!.articles![index].author
                                      .toString(),
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  content:snapshot
                                      .data!.articles![index].content
                                      .toString(), source:snapshot
                                  .data!.articles![index].source!.name
                                  .toString())));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child:
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * 0.3,
                                        placeholder: ((context, url) =>
                                        const SpinKitCircle(
                                          color: Colors.black,
                                          size: 40,
                                        )),
                                        errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                          height: height * .18,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Spacer(),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!.articles![index]
                                                        .source!.name
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight
                                                            .w300),
                                                  ),
                                                  Text(format.format(dateTime),

                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight
                                                            .w300),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          );
                            }
    );
                  }
                }),
          ],
        ));
  }
}