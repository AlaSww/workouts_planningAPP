import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer player = AudioPlayer();

  // Play audio from assets
  Future<void> playAudioFromAssets(String assetPath) async {
    try {
      await player.setSource(AssetSource(assetPath)); // Load file from assets
      await player.play(player.source!); // Play the loaded source
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Stop audio
  Future<void> stopAudio() async {
    try {
      await player.stop();
    } catch (e) {
      print("Error stopping audio: $e");
    }
  }

  // Dispose the player when not needed
  void dispose() {
    player.dispose();
  }
}