import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:just_audio/just_audio.dart';

class SoundPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> checkAndPlayClickSound() async {
    final isEnable = await Store.get(key: StoreKey.soundsEnable, defaultValue: false);
    if (isEnable) {
      await _player.setAudioSource(AudioSource.asset('assets/sounds/click_1.mp3'));
      await _player.play();
    }
  }
}
