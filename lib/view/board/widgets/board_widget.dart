import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/view_model/cubit/state.dart';

import '../../../view_model/cubit/cubit.dart';
import '../../../view_model/utils/colors.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit,GameState>(
      builder: (context, state) {
        var cubit = GameCubit.get(context);
        return Container(
          width: double.infinity,
          decoration:const BoxDecoration(
            color: AppColor.black,
          ),
          child: GridView.builder(
            padding: EdgeInsetsDirectional.all(8.w),
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,crossAxisSpacing: 8,mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              int row = index~/3;
              int col = index%3;

              return InkWell(
                onTap: (){
                  if(state is! GameDrawShapeState)
                    {
                      cubit.play(row,col);
                    }

                },
                child: Container(
                  decoration:const  BoxDecoration(
                    color: AppColor.blueGreyDark,
                  ),
                  child:  Center(child:  Text(cubit.board[row][col]?.shape ?? "",style: TextStyle(
                    fontSize: 60.sp,fontWeight: FontWeight.w400,
                    color:cubit.board[row][col]?.shapeColor,
                  ),),),
                ),
              );
            },),
        );
      },
    );
  }
}
