

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tic_tac_toe/model/audio_model/audio_model.dart';
import 'package:tic_tac_toe/model/game_mode.dart';
import 'package:tic_tac_toe/model/game_status.dart';
import 'package:tic_tac_toe/view_model/cubit/state.dart';
import 'package:tic_tac_toe/view_model/utils/colors.dart';

import '../../model/square_model.dart';

class GameCubit extends Cubit<GameState>{
  GameCubit():super(GameInitState());

  static GameCubit get(context)=>BlocProvider.of<GameCubit>(context);

  //Two Players Mode
  TextEditingController player1nameController = TextEditingController();
  TextEditingController player2nameController = TextEditingController();
  GlobalKey<FormState> twoPlayerFormKey = GlobalKey<FormState>();

  GameMode gameMode = GameMode.twoPlayersMode;
  bool isPlayer1Turn = true;
  GameStatus gameStatus = GameStatus.gameNotEnd;

  //Game Result
  String title = "";
  String description = "";
  String imagePath = "";

  //Audio
  AudioModel audioModel = AudioModel();

  String? playerNameValidator(String? value) {
    if((value ?? "").isEmpty)
      {
        return "Enter Player Name";
      }
    return null;
}

  List<List<SquareModel?>> board = [];
  void initialBoard(){

     board= List.generate(3, (index) => List.generate(3,(index) => null,));

    for (int i=0;i<3;i++){
      for(int j=0;j<3;j++){
        board[i][j] =
            SquareModel(shape: null,shapeColor: null,isOccupied: false);
      }
    }

  }


  //This function return true if the pressed square is not occupied
  //and return false if it is occupied
  bool isSquareEmpty(int row,int col){
   if(board[row][col]!.isOccupied == true)
     {
       return false;
     }
   return true;
  }


  //This function calculate if the game is end or not
  //if the game is end it return the status of game which player is win
  //or it is draw
  GameStatus calculateBoardStatus() {
    GameStatus status = GameStatus.draw;
    String? shape= isPlayer1Turn? 'X':'O';
    int i =0; //for rows
    int j= 0; //for columns

    //Calculate if the game is not end
    for(i=0;i<3;i++){
      for(j=0;j<3;j++){
        if(board[i][j]!.isOccupied == false)
        {
          status = GameStatus.gameNotEnd;
        }
      }
    }

    //check if the player is win by checks rows and columns
    //calculate Rows
    for(i=0;i<3;i++){
      for(j=0;j<3;j++){
        if(board[i][j]!.shape != shape)
          {
            break;
          }
      }
      if(j == 3) {
        // print("row");
        // isPlayer1Turn?print("Player 1 win"):print("Player 2 win");
        status = isPlayer1Turn?GameStatus.player1Win:GameStatus.player2Win;
      }
      }
    //calculate Columns
    for(i=0;i<3;i++){
      for(j=0;j<3;j++){
        if(board[j][i]!.shape != shape)
        {
          break;
        }
      }
      if(j == 3) {
        //print("Col");
        //isPlayer1Turn?print("Player 1 win"):print("Player 2 win");
        status = isPlayer1Turn?GameStatus.player1Win:GameStatus.player2Win;
      }
    }
    //Calculate Diagonals
    bool rightDiagonal = true;
    bool leftDiagonal = true;
    for(i=0;i<3;i++){
      for(j=0;j<3;j++){
        if(i == j && board[i][j]!.shape != shape){
          leftDiagonal=false;
        }
        if(i==(2-j) && board[i][j]!.shape != shape){
          rightDiagonal=false;
        }
      }
    }
    if(rightDiagonal == true || leftDiagonal == true)
      {
        //print("Diagonal");
        //isPlayer1Turn?print("Player 1 win"):print("Player 2 win");
        status = isPlayer1Turn?GameStatus.player1Win:GameStatus.player2Win;
      }


    return status;
  }

  void calculateGameStatus() async{
    gameStatus = calculateBoardStatus();
    if(gameStatus == GameStatus.gameNotEnd)
    {
        isPlayer1Turn = !isPlayer1Turn;
    }else{
      if(gameStatus == GameStatus.player1Win){
        gameResults("Congratulations",
            "${player1nameController.text} win",
            "assets/images/congrats.json");
        audioModel.playWinMusic();
      }else if(gameStatus == GameStatus.player2Win){
        if(gameMode == GameMode.twoPlayersMode)
          {
            gameResults("Congratulations",
                "${player2nameController.text} win",
                "assets/images/congrats.json");
            audioModel.playWinMusic();
          }else{
          gameResults("Game Over",
              "You lose",
              "assets/images/lose_image.png");
           audioModel.playLoseMusic();
        }

      }else if(gameStatus == GameStatus.draw){
        gameResults("Draw", "No Winner", "assets/images/catty.json");
        audioModel.playDrawMusic();
        //print("Draw");
      }
      await Future.delayed(const Duration(milliseconds: 400));
      emit(GameEndState());
      await Future.delayed(const Duration(seconds: 1),() => resetGame(),);

    }
  }

  void gameResults(String title,String description,String imagePath){
    this.title = title;
    this.description = description;
    this.imagePath = imagePath;
  }

  void resetGame(){
    initialBoard();
    isPlayer1Turn=true;
    emit(ResetGameState());
  }

  void endGame(){
    player1nameController.clear();
    player2nameController.clear();
    resetGame();
  }

  //This function is an entry point of game
  //it determine which mode is it
  //and based on it invoke functions that responsible for the mode
  void play(int row,int col){
    switch(gameMode){
      case GameMode.twoPlayersMode:
        player2Mode(row, col);

      case GameMode.easyMode:
        playEasyMode(row, col);

      case GameMode.hardMode:
        playHardMode(row,col);
    }
  }

  //This function is responsible for draw shape on board
  void drawShape(int row,int col){
      //draw shape with it's color
        if(isPlayer1Turn)
          {
            board[row][col]!.shape = "X";
            board[row][col]!.shapeColor = AppColor.xColor;
          }else{
          board[row][col]!.shape = "O";
          board[row][col]!.shapeColor = AppColor.oColor;
        }

      //set the pressed square is occupied
        board[row][col]!.isOccupied = true;
        audioModel.playTicMusic();
        emit(GameDrawShapeState());
  }


  //This function represent  Human PLay
  void humanPlay(int row,int col){
    //check if the pressed square in the board is occupied or not
    if(isSquareEmpty(row,col) == false)
    {
      Fluttertoast.showToast(
          msg: "Invalid Square",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: AppColor.white,
          textColor: AppColor.black,
          fontSize: 14.0.sp
      );
      return;
    }
    //If the pressed square is not occupied draw shape
    drawShape(row, col);
    //Calculate if Game End or not
    calculateGameStatus();
  }

  //This function is responsible to call draw shape function
  //it first check if the pressed square in the board is occupied or not
  //and to calculate if game end or not
  //and change player
  void player2Mode(int row,int col){
    //Call function humanPlay to draw represent human action
    humanPlay(row,col);
    emit(TwoPlayersModeState());
  }

  //This function is responsible to initialize board for 2 players mode
  void initialTwoPlayersMode(){
    gameMode = GameMode.twoPlayersMode;
  }


  final random = Random();
  //This Function is responsible to apply random algorithm to play
  //is draw the square as player pressed if the square is not empty
  //then calculate if game end (Win / Draw) or not
  //then apply computer algorithm
  //then calculate if game end (Win / Draw) or not
  void playEasyMode(int row,int col) async{
    //Call function humanPlay to draw represent human action
    humanPlay(row,col);
    //if game is end return exit function
    if(gameStatus != GameStatus.gameNotEnd){
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    bool isDraw = false;
    int randomNumber = random.nextInt(9); //generated random number
    int r = 0; // r for row
    int c = 0; // c for column
    while (!isDraw) {
      r = randomNumber ~/ 3;
      c = randomNumber % 3;
      if (isSquareEmpty(r, c) == false) {
        randomNumber = random.nextInt(9);
      }
      else {
        drawShape(r, c);
        isDraw = true;
      }
    }
    calculateGameStatus();
    emit(EasyModePlayState());
  }
  void initialEasyMode(){
    gameMode = GameMode.easyMode;
    player1nameController.text = "You";
    player2nameController.text = "Computer";
  }

  int minI= 0;
  int minJ =0;
  void initialHardMode(){
    gameMode = GameMode.hardMode;
    isPlayer1Turn = true;
    player1nameController.text = "You";
    player2nameController.text = "Computer";
    minI = 0;
    minJ = 0;

  }
  void playHardMode(int row,int col) async{
    //Call function humanPlay to draw represent human action
    humanPlay(row,col);
    //if game is end return exit function
    if(gameStatus != GameStatus.gameNotEnd){
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    miniMax(10, false);
    isPlayer1Turn = false;
    drawShape(minI, minJ);
    calculateGameStatus();
    emit(HardModePlayState());
  }

  int miniMax(int depth,bool isMax,{bool firstTime = true}){
    //Get Board Status if player is win or draw or game not end
    GameStatus boardStatus = calculateBoardStatus();
    //describe board Status with numbers (draw -> 0) (notEnd -> 1)
    // (player1win -> 2) (player2win -> -2)
    int finalBoardScore;
    switch(boardStatus){
      case GameStatus.player1Win:
        finalBoardScore = 2;
      case GameStatus.player2Win:
        finalBoardScore = -2;
      case GameStatus.draw:
        finalBoardScore = 0;
      case GameStatus.gameNotEnd:
        finalBoardScore = 1;
    }
    //if depth == 0 or game is end(win / draw)
    //exit function and return status
    if((depth == 0) || (finalBoardScore != 1)){
      return finalBoardScore;
    }
    //If game not end
    //check Maximizer
    if(isMax){
       int finalMaxScore = -10;
      for(int i =0;i<3;i++){
        for(int j=0;j<3;j++){
          //put 'X' on square and get max result
          if(isSquareEmpty(i, j))
            {
              board[i][j]?.shape = 'X';
              board[i][j]?.isOccupied = true;
              //Recursion to until  depth=0 or game end
              isPlayer1Turn = true;
              int max = miniMax(depth-1,false,firstTime: false);
              //After finish recursion declare 'X'
              board[i][j]?.shape = null;
              board[i][j]?.isOccupied = false;
              //Take best choice for X (Maximizer)
              if(max > finalMaxScore )
                {
                  finalMaxScore = max;
                }

            }
        }
      }
      //after finish empty square in board return final result
      return finalMaxScore;
    }
    else{
      int finalMinScore = 10;
      for(int i =0;i<3;i++){
        for(int j=0;j<3;j++){
          //put 'O' on square and get min result
          if(isSquareEmpty(i, j))
          {
            board[i][j]?.shape = 'O';
            board[i][j]?.isOccupied = true;
            isPlayer1Turn = false;
            //Recursion to until  depth=0 or game end
            int min  = miniMax(depth-1,true,firstTime: false);
            //After finish recursion declare 'X'
            board[i][j]?.shape = null;
            board[i][j]?.isOccupied = false;
            //Take best choice for X (Maximizer)
            if(min < finalMinScore)
            {
              finalMinScore = min;
              if(firstTime)
              {
                minI = i;
                minJ = j;
              }
            }
          }
        }
      }
      //after finish empty square in board return final result
      return finalMinScore;
    }
  }



}
