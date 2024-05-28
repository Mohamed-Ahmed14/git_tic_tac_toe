
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/view/board/board_screen.dart';
import 'package:tic_tac_toe/view/widgets/custom_elevated_button.dart';
import 'package:tic_tac_toe/view/widgets/custom_text_form_field.dart';
import 'package:tic_tac_toe/view_model/cubit/cubit.dart';
import 'package:tic_tac_toe/view_model/utils/colors.dart';


class TwoPlayersScreen extends StatelessWidget {
  const TwoPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //on tap anywhere dismiss keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.blueGreyLight,
        appBar:  AppBar(
          backgroundColor:AppColor.blueGreyLight,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_backspace_rounded,color: Colors.blue,size: 30.r,),
          ),
          centerTitle: true,
          title: RichText(text: TextSpan(
              text: "TIC  ",style: TextStyle(color: AppColor.red,fontSize: 35.sp,
              fontStyle: FontStyle.italic),
              children:const<TextSpan>[
                TextSpan(text: "TAC  ",style: TextStyle(color: AppColor.orangeAccent)),
                TextSpan(text: "TOE",style: TextStyle(color: AppColor.white)),
              ]
          ),),
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.all(15.w),
          child: Form(
            key: GameCubit.get(context).twoPlayerFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 0.05.sh,),
                  Text("Player 1 Name",style: TextStyle(
                    color: AppColor.xColor,
                    fontSize: 18.sp,
                  ),),
                  SizedBox(height: 0.01.sh,),
                  CustomTextFormField(
                    controller: GameCubit.get(context).player1nameController,
                    validator: GameCubit.get(context).playerNameValidator,
                    borderRadius: 12.r,
                    contentPadding: 5.w,
                    prefixIconColor: AppColor.xColor,
                    hintText: "Ex, Ahmed",
                  ),
                  Center(
                    child: Image.asset("assets/images/friends_top.png",
                      width: 200.w,height: 240.h,fit: BoxFit.contain,),
                  ),

                  Text("Player 2 Name",style: TextStyle(
                    color: AppColor.oColor,
                    fontSize: 18.sp,
                  ),),
                  SizedBox(height: 0.01.sh,),
                  CustomTextFormField(
                    controller: GameCubit.get(context).player2nameController,
                    validator: GameCubit.get(context).playerNameValidator,
                    borderRadius: 12.r,
                    contentPadding: 5.w,
                    prefixIconColor: AppColor.oColor,
                    hintText: "Ex, Mohamed",
                  ),
                  SizedBox(height: 0.08.sh,),
                  Center(
                    child: SizedBox(
                      height: 50.h,width: 180.w,
                      child: CustomElevatedButton(
                          onPressed: (){
                            if(GameCubit.get(context).twoPlayerFormKey.currentState!.validate()){
                              FocusScope.of(context).unfocus();
                              GameCubit.get(context).initialTwoPlayersMode();
                             Navigator.push(context, MaterialPageRoute(builder: (context) =>const BoardScreen(),));
                            }
                          },
                          backgroundColor: Colors.indigo
                          ,
                          child: Text("Start Game",style: TextStyle(
                              color: AppColor.orangeAccent,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700
                          ),)),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
