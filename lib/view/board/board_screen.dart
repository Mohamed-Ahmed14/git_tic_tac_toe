import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tic_tac_toe/view/board/widgets/board_widget.dart';
import 'package:tic_tac_toe/view/board/widgets/dialog_widget.dart';
import 'package:tic_tac_toe/view_model/cubit/cubit.dart';
import 'package:tic_tac_toe/view/widgets/custom_elevated_button.dart';

import '../../view_model/cubit/state.dart';
import '../../view_model/utils/colors.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    GameCubit.get(context).audioModel.pauseGameMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueGreyLight,
      body: BlocConsumer<GameCubit,GameState>(
        listener: (context, state) {
          if(state is GameEndState)
            {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return const DialogWidget();
                },
              );
            }
        },
        builder: (context, state) {
          var cubit = GameCubit.get(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 0.01.sh,),
              RichText(text: TextSpan(
                  text:"Turn: " ,
                  style:TextStyle(
                      color: AppColor.black,fontSize: 20.sp,fontWeight: FontWeight.w600) ,
                  children:[
                    TextSpan(text:cubit.isPlayer1Turn?
                    cubit.player1nameController.text:cubit.player2nameController.text,
                        style: TextStyle(
                        color:cubit.isPlayer1Turn? AppColor.xColor:AppColor.oColor,
                            fontSize: 20.sp,fontWeight: FontWeight.w600)),
                  ]
              )),
              SizedBox(height: 0.05.sh,),
              const BoardWidget(),
              SizedBox(height: 0.1.sh,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   CustomElevatedButton(
                       onPressed:(){
                     cubit.resetGame();
                   },
                       backgroundColor: AppColor.indigo,
                   child: Text("Reset Game",style: TextStyle(
                     color: AppColor.orangeAccent,fontSize: 16.sp,
                   ),)),
                  CustomElevatedButton(
                      onPressed:(){
                        cubit.endGame();
                        cubit.audioModel.playGameMusic();
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) =>const ModeScreen(),));
                      },
                      backgroundColor: AppColor.red,
                      child: Text("End Game",style: TextStyle(
                        color: AppColor.orangeAccent,fontSize: 16.sp,
                      ),)),

                ],
              ),

            ],
          );
        },
        buildWhen: (previous, current)=>current is GameDrawShapeState || current is ResetGameState,

      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    GameCubit.get(context).endGame();
    GameCubit.get(context).audioModel.playGameMusic();
    super.deactivate();
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   GameCubit.get(context).audioModel.playGameMusic();
  //   super.dispose();
  // }
}
