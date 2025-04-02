import 'package:audioplayers/audioplayers.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';

class SoundPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> checkAndPlayClickSound() async {
    final isEnable = await Store.get(key: StoreKey.soundsEnable, defaultValue: false);
    if (isEnable) {
      await _player.play(AssetSource('sounds/click_1.mp3'));
    }
  }
}
