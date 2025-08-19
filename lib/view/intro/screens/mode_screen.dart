import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/view/intro/screens/single_player_screen.dart';
import 'package:tic_tac_toe/view/intro/screens/two_players_screen.dart';
import 'package:tic_tac_toe/view_model/utils/colors.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueGreyLight,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:  EdgeInsetsDirectional.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(text: TextSpan(
                  text: "TIC  ",style: TextStyle(color: AppColor.red,fontSize: 35.sp,
                  fontStyle: FontStyle.italic),
                  children:const<TextSpan>[
                     TextSpan(text: "TAC  ",style: TextStyle(color: AppColor.orangeAccent)),
                     TextSpan(text: "TOE",style: TextStyle(color: AppColor.white)),
                  ]
              ),),
              Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SinglePlayerScreen(),));
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.all(10.w),
                    // margin: EdgeInsetsDirectional.symmetric(horizontal:15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(
                      //   color: Colors.red[700]!,
                      //   width: 2.w
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Play with Computer",style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                        Image.asset(
                          "assets/images/bot_image.png",
                          height: 120.h,width: 120.w,fit: BoxFit.cover,),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>const TwoPlayersScreen(),));
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.all(10.w),
                    // margin: EdgeInsetsDirectional.all(15.w),
                    decoration: BoxDecoration(
                      //color: Colors.purple,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(
                      //     color: Colors.purple[700]!,
                      //     width: 2.w
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Play with Friend",style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Image.asset(
                          "assets/images/friends_update.png",
                          height: 120.h,width: 120.w,fit: BoxFit.cover,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
