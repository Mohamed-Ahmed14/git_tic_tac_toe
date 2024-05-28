import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/view/intro/screens/mode_screen.dart';
import 'package:tic_tac_toe/view_model/cubit/cubit.dart';
import 'package:tic_tac_toe/view_model/utils/colors.dart';
import 'package:tic_tac_toe/view/widgets/custom_elevated_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Play Audio
    GameCubit.get(context).audioModel.playGameMusic();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueGreyLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RichText(text: TextSpan(
            text: "TIC  ",style: TextStyle(color: AppColor.red,fontSize: 35.sp,
          fontStyle: FontStyle.italic),
              children: const <TextSpan> [
              TextSpan(text: "TAC  ",style: TextStyle(color: AppColor.orangeAccent)),
            TextSpan(text: "TOE",style: TextStyle(color: AppColor.white)),
          ]
          ),),
          Lottie.asset("assets/images/Animation_X_O.json"),
          CustomElevatedButton(
            onPressed:(){
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) =>const ModeScreen(),),
                        (route) => false);
          },
            backgroundColor: AppColor.indigo,
              child: Text("Let's Start",style: TextStyle(
                color: AppColor.orangeAccent,
                fontSize: 20.sp,
                fontStyle: FontStyle.italic
              ),),),


        ],
      ),
    );
  }
}
