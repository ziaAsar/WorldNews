import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/categoriesScreen_controller.dart';
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Views/Home_Screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final CategoriesController _categoriesController = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
              ()=> Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoriesController.categoriesList.length,
                    itemBuilder: (context, index) {
                      return  InkWell(
                        onTap: (){
                          // setState(() {
                          _categoriesController.categoriesName.value = _categoriesController.categoriesList[index];
                          // });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _categoriesController.categoriesName.value == _categoriesController.categoriesList[index] ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(child: Text(_categoriesController.categoriesList[index].toString())),
                            ),
                          ),
                        ),
                      );

                    }
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
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

                                                Text(_categoriesController.format.format(dateTime),
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
                  }, future: _categoriesController.fetchCategoriesNewsApis(_categoriesController.categoriesName.value),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
