import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


import '../models/categories_news_model.dart';
import '../view_model/news_view_model.dart';
import 'news_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel(); // object of the API's feteched
  String categoryName = 'general';
  int item =1;
  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Categories ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,

                  itemBuilder: (context, item) {

                    return InkWell(
                      onTap: () {
                        categoryName = categoryList[item];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: categoryName == categoryList[item]
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                                  categoryList[item].toString(),
                                  style: TextStyle(color:Colors.white),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<CategoryModel>(
                  future: newsViewModel.fetchNewsCategoriesApi(categoryName),
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
                                child: Row(
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
                                                snapshot.data!.articles![index].title
                                                    .toString(),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Spacer(),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!.articles![index].source!.name
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                  Text(format.format(dateTime),

                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w300),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}