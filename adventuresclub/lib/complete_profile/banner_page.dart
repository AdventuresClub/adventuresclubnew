
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          const Image(image: ExactAssetImage('images/add-circle.png'),height: 20),
         const SizedBox(width: 5,),
          MyText(text: 'Add More',color: bluishColor,)
        ],),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration:  BoxDecoration(
                border: Border.all(color: blackTypeColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(12),
                color: lightGreyColor

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height:20),
                const Center(child: Image(image: ExactAssetImage('images/upload.png'),height: 45,
                
                ),),
                  const SizedBox(height: 20,),
              
                MyText(text: 'Tap to browse',color: greyColor,),
                const SizedBox(height: 20,),
                MyText(text: 'Add banner(image) to effectively adventure',color: greyColor,align: TextAlign.center,),
                

              ],),
              ),
              const SizedBox(height:20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration:  BoxDecoration(
                border: Border.all(color: blackTypeColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(12),
                color: lightGreyColor

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height:20),
                const Center(child: Image(image: ExactAssetImage('images/upload.png'),height: 45,
                
                ),),
                  const SizedBox(height: 20,),
              
                MyText(text: 'Tap to browse',color: greyColor,),
                const SizedBox(height: 20,),
                MyText(text: 'Add banner(image) to effectively adventure',color: greyColor,align: TextAlign.center,),
                

              ],),
              ),
            ],
          ),
        )
      ],
    );
  }
}