import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/categoriesScreen_controller.dart';
import 'package:news_app/Controllers/homeScreen_controller.dart';
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channel_headlines_models.dart';
import 'package:news_app/Views/categories_screen.dart';
import 'package:news_app/Views/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _homeController = Get.put(HomeScreenController());
  final CategoriesController _categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Obx(
        ()=> Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {
           Get.to(CategoriesScreen());
            },
                icon: Image.asset("assets/images/category_icon.png",
                  height: 25,
                  width: 25,
                )

            ),
            title: Center(
              child: Text("News", style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700
              ),),
            ),
            actions: [
              PopupMenuButton<String>(
                  initialValue: _homeController.selectedMenu.value,
                    onSelected: (String item){
                      switch (item) {
                        case 'thetimesofindia':
                          _homeController.name.value = 'the-times-of-india';
                          break;
                        case 'bbcNews':
                          _homeController.name.value= 'bbc-news';
                          break;
                        case 'thehindu':
                          _homeController.name.value= 'the-hindu';
                          break;
                        case 'cnn':
                          _homeController.name.value = 'cnn';
                          break;
                        case 'bbcsport':
                          _homeController.name.value = 'bbc-sport';
                          break;
                        case 'nationalgeographic':
                         _homeController. name.value= 'national-geographic';
                          break;

                      }
                      _homeController.selectedMenu.value=item;
                          _homeController.fetchNewsChannelHeadlinesApi(_homeController.name.value);
                          print('News:${ _homeController.selectedMenu.value}');

                        // _homeController.selectedMenu.value=item;
                        // _homeController.fetchNewsChannelHeadlinesApi(_homeController.name.value);
                      // _homeController.fetchNewsChannelHeadlinesApi(_homeController.name.value);

                     // setState(() {
                     //   _homeController.selectedMenu.value=item;
                     //   _homeController.fetchNewsChannelHeadlinesApi(_homeController.name.value);
                     //   // print('News:${selectedMenu!.name}');
                     // });
                    },

                    itemBuilder: (context)=><PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                          value: 'thetimesofindia',
                          child: Text("Times of India")
                      ),
                      PopupMenuItem<String>(
                        value: 'bbcNews',
                          child: Text("BBC News")
                      ),
                      PopupMenuItem<String>(
                          value: 'thehindu',
                          child: Text("The Hindu")
                      ),

                      PopupMenuItem<String>(
                          value: 'cnn',
                          child: Text("CNN")
                      ),
                      PopupMenuItem<String>(
                          value: 'bbcsport',
                          child: Text("BBC-Sport")
                      ),
                      PopupMenuItem<String>(
                          value: 'nationalgeographic',
                          child: Text("National-Geographic")
                      ),
                    ]
                ),

            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: height * .55,
                    child:FutureBuilder<NewsChannelHeadlinesModels>(
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: SpinKitCircle(
                              color: Colors.blue,
                              size: 50,
                            ),
                          );
                        }
                        else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.articles!.length,
                              itemBuilder: (context,index){
                                DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                              return InkWell(
                                onTap: (){
                                  Get.to(NewsDetailsScreen(
                                      newImage: snapshot.data!.articles![index].urlToImage!.toString(),
                                      newDate: snapshot.data!.articles![index].publishedAt!.toString(),
                                      description: snapshot.data!.articles![index].description!.toString(),
                                      sources: snapshot.data!.articles![index].source!.name.toString(),
                                      newTitle: snapshot.data!.articles![index].title!.toString(),
                                      // content: snapshot.data!.articles![index].content!.toString(),
                                      // author: snapshot.data!.articles![index].author!.toString()
                                  ));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height : height * 0.6,
                                        width: width * 0.8,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: height * .01,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.articles![index].urlToImage!.toString(),
                                            fit: BoxFit.cover,
                                            placeholder:(context, url) => Container(
                                              child:  Spinkit2,
                                            ),
                                            errorWidget: (context,url,error) => Icon(Icons.error_outline,color: Colors.red,),

                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(23)
                                          ),
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height:height*.22,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width *.7,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(snapshot.data!.articles![index].title.toString(),
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style:GoogleFonts.poppins(
                                                        fontSize: 17,
                                                          fontWeight: FontWeight.w700,
                                                    ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: width *.7,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                                          style:GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(_homeController.format.format(dateTime),
                                                          style:GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),///some error check asar
                                              ],
                                            ),
                                          ),

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                              }
                          );
                        }
                      }, future: _homeController.fetchNewsChannelHeadlinesApi(_homeController.name.value),

                )
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder<CategoriesNewsModel>(
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitCircle(
                            color: Colors.blue,
                            size: 50,
                          ),
                        );
                      }
                      else {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(), // Prevent scroll conflict
                            shrinkWrap: true,
                            itemCount: snapshot.data!.articles!.length,
                            itemBuilder: (context,index){
                              DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        height : height *.18,
                                        width : width *.3,
                                        placeholder:(context, url) => Container(
                                          child:  Spinkit2,
                                        ),
                                        errorWidget: (context,url,error) => Icon(Icons.error_outline,color: Colors.red,),

                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          height: height *.18,
                                          child: Column(
                                            children: [
                                              Text(snapshot.data!.articles![index].title.toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style:GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.21,
                                                    child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style:GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),

                                                  Text(_homeController.format.format(dateTime),
                                                    style:GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      }
                    }, future: _categoriesController.fetchCategoriesNewsApis("General"),

                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

const Spinkit2 = SpinKitFadingCircle(
  color: Colors.yellow,
  size: 50,
);
