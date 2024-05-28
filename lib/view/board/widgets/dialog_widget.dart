import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/model/game_mode.dart';
import 'package:tic_tac_toe/model/game_status.dart';
import 'package:tic_tac_toe/view_model/cubit/cubit.dart';

import '../../../view_model/utils/colors.dart';
import '../../widgets/custom_elevated_button.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Visibility(
        visible: GameCubit.get(context).gameMode != GameMode.twoPlayersMode &&
            GameCubit.get(context).gameStatus == GameStatus.player2Win,
        replacement: Center(
          child: Lottie.asset(GameCubit.get(context).imagePath ?? "",
              height: 140.h,width: 140.w,fit: BoxFit.fill),
        ),
        child: Image.asset(GameCubit.get(context).imagePath ?? "",
            height: 120.h,width: 120.w,fit: BoxFit.contain)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(GameCubit.get(context).title,style: TextStyle(
            color: Colors.pink,
            fontSize: 30.sp,
          ),),
          Text(GameCubit.get(context).description,style: TextStyle(
            color: Colors.black,
            fontSize: 30.sp,
          ),),
          SizedBox(height: 0.02.sh,),
          CustomElevatedButton(
              backgroundColor: AppColor.indigo,
              onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok",style: TextStyle(
              color: AppColor.orangeAccent,
              fontSize: 18.sp
          ),))

        ],
      ),
    );
  }
}
