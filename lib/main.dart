import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  var parallax = ParallaxGame();
  runApp(GameWidget(game: parallax));
}

class ParallaxGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    final layerInfo = {
      '11.png': 0.5,
      '10.png': 0.75,
      '9.png': 1.0,
      '8.png': 1.25,
      '7.png': 1.5,
      '6.png': 1.75,
      '5.png': 2.0,
      '4.png': 2.25,
      '3.png': 2.5,
      '2.png': 2.75,
      '1.png': 3.0,
      '0.png': 3.25,
    };

    final layers = layerInfo.entries.map(
      (entry) => loadParallaxLayer(
        ParallaxImageData(entry.key),
        velocityMultiplier: Vector2(entry.value, 0.0),
      ),
    );

    final parallax = ParallaxComponent(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(5, 0),
      ),
    );
    add(parallax);

    add(SpriteAnimationComponent(
        animation: await loadSpriteAnimation(
      'run.png',
      SpriteAnimationData.sequenced(
        texturePosition: Vector2(0, 0),
        amount: 6,
        textureSize: Vector2(50, 37),
        stepTime: 0.1,
        loop: true,
      ),
    ))
      ..position = Vector2(200, 310)
      ..size = Vector2(50, 37) * 2);
  }
}
