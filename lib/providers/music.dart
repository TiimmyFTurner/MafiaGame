import 'package:flutter/foundation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Music extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer;
  Future initPlayer() async {
    assetsAudioPlayer = AssetsAudioPlayer();
    await assetsAudioPlayer.open(Audio("asset/audios/kaisa.mp3"));
    assetsAudioPlayer.playOrPause();
  }

  void toggle() async {
    await assetsAudioPlayer.seek(Duration(seconds: 0));
    await assetsAudioPlayer.playOrPause();
    notifyListeners();
  }

  void stop() async {
    await assetsAudioPlayer.stop();
    notifyListeners();
  }

  bool get isPlaying => assetsAudioPlayer.isPlaying.value;
}
