import 'package:audioplayers/audioplayers.dart';

class AudioModel{

   AudioPlayer player = AudioPlayer();
   AudioPlayer tic = AudioPlayer();
   AudioPlayer losePlayer = AudioPlayer();
   AudioPlayer drawPlayer = AudioPlayer();
   AudioPlayer winPlayer = AudioPlayer();

   AudioModel();

  void playGameMusic(){
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.loop);
    player.play(AssetSource("game_music.mp3"),);
  }
  void pauseGameMusic(){
    player.stop();
  }

  void playTicMusic(){
    // Set the release mode to keep the source after playback has completed.
    tic.setReleaseMode(ReleaseMode.stop);
    tic.play(AssetSource("tic_music.mp3"),);
  }
  void pauseTicMusic(){
    tic.pause();
  }

  void playLoseMusic() async{
    await Future.delayed(const Duration(seconds: 1));
    // Set the release mode to keep the source after playback has completed.
    losePlayer.setReleaseMode(ReleaseMode.stop);
    losePlayer.play(AssetSource("lose_music.mp3"),);
  }
  void pauseLoseMusic(){
    losePlayer.pause();
  }

  void playWinMusic() async{
    await Future.delayed(const Duration(milliseconds: 500));
    // Set the release mode to keep the source after playback has completed.
    winPlayer.setReleaseMode(ReleaseMode.stop);
    winPlayer.play(AssetSource("win_music.mp3"),);
  }
  void pauseWinMusic(){
    winPlayer.pause();
  }

  void playDrawMusic() async{
    await Future.delayed(const Duration(milliseconds: 500));
    // Set the release mode to keep the source after playback has completed.
    drawPlayer.setReleaseMode(ReleaseMode.stop);
    drawPlayer.play(AssetSource("draw_music.mp3"),);
  }
  void pauseDrawMusic(){
    drawPlayer.pause();
  }
}