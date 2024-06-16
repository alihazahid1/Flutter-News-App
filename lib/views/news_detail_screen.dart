import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  String newsImg,newsTitle,newsDate,author,description,content,source;
   NewsDetailsScreen({Key?key ,
  required this.newsTitle,
    required this.newsImg,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }):super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    DateTime dateTime=DateTime.parse(widget.newsDate);
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
),
      body: Stack(
children: [
  Container(
    child: Container(
      height: height*.45,

      child: ClipRRect(
        borderRadius :const BorderRadius.only(topLeft: Radius.circular(30),
        topRight: Radius.circular(40)),
        child: CachedNetworkImage(imageUrl: widget.newsImg,
        fit: BoxFit.cover,),
      ),
    ),
  ),
  Container(
    height: height*.6,
    margin: EdgeInsets.only(top: height*.4),
    padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
    decoration: const BoxDecoration(color: Colors.white,
      borderRadius :BorderRadius.only(topLeft: Radius.circular(30),
          topRight: Radius.circular(40)),),
    child: ListView(
      children: [
        Text(widget.newsTitle,style: const TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w700),),
        SizedBox(height: height*.02,),
        Row(
          children: [
            Expanded(child: Text(widget.source,style: const TextStyle(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w600))),
            Text(format.format(dateTime),style: const TextStyle(fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(height: height*.02,),
        Text(widget.description,style: const TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500)),
      ],
    )
  )
],
      ),
    );
  }
}
