import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Views/Home_Screen.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String? newImage,
      newDate,
      description,
      sources,
      newTitle,
      content,
      author;

  const NewsDetailsScreen(
      {super.key,
      required this.newImage,
      required this.newDate,
      required this.description,
      required this.sources,
      required this.newTitle,
       this.content,
      this.author
      });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format = DateFormat('MMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final dateTime = DateTime.parse(widget.newDate!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: height * .45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: widget.newImage.toString(),
                  fit: BoxFit.cover,
                  placeholder:(context, url) => Container(
                    child:  Spinkit2,
                  ),
                  errorWidget: (context,url,error) => Icon(Icons.error_outline,color: Colors.red,),
                ),
              ),
            ),
          ),
          Container(
            height: height * .5,
            margin: EdgeInsets.only(top:height * .45),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView(
              children: [
                Text(widget.newTitle!,
                  style:GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  )
                ),
                SizedBox(
                  height: height * .02,
                ),
                Column(
                  children: [
                    Text(widget.description!,
                      textAlign: TextAlign.justify,
                      maxLines: 20,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: height *0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.sources!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        Text(format.format(dateTime),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ]
            ),
          ),

        ],
      ),
    );
  }
}
