import 'dart:async';
import 'package:get/get.dart';
import 'package:my_flutter_basic/common/common.dart';

import 'index.dart';

class TetrisController extends GetxController {
  GameData gameData = GameData.get();

  String builderBody = 'builder_body';
  String builderBoxTetris = 'builder_box_tetris';
  String builderBoxNext = 'builder_box_next';
  String builderBoxLevel = 'builder_box_level';
  String builderBoxScore = 'builder_box_score';
  String builderTimerGame = 'builder_timer_game';
  String builderTimerPause = 'builder_timer_pause';

  bool isInitialized = false;

  int gameTime = 0;
  int pauseTime = 0;
  int score = 0;
  int gameLevel = 1;
  GameState gameState = GameState.start;

  Timer? downTimer;
  Timer? gameTimer;
  Timer? pauseTimer;

  Duration downDuration = const Duration(milliseconds: 1000);

  @override
  void onReady() async {
    showMyLoading();
    super.onReady();
    await Future.delayed(MyConfig.time.pageTransition);
    isInitialized = true;
    update([builderBody]);
    hideMyLoading();
  }

  @override
  void onClose() {
    downTimer?.cancel();
    gameTimer?.cancel();
    pauseTimer?.cancel();
    super.onClose();
  }

  void onStartGame() {
    // isPause = false;
    // isDisable = false;
    // isStart = false;
    gameState = GameState.gaming;
    update([builderBody]);

    pauseTimer?.cancel();
    pauseTime = 0;

    next();

    downTimerStart();
    gameTimerStart();
  }

  void onContinueGame() {
    gameState = GameState.gaming;
    update([builderBody]);

    pauseTimer?.cancel();
    pauseTime = 0;

    downTimerStart();
    gameTimerStart();
  }

  // 初始化
  Future<void> init() async {
    gameData = GameData.get();

    gameTime = 0;
    gameLevel = 1;
    score = 0;

    gameState = GameState.start;
  }

  // 暂停
  Future<void> onPauseGame() async {
    if (gameState == GameState.pause) return;
    gameState = GameState.pause;
    update([builderBody]);
    downTimer?.cancel();
    gameTimer?.cancel();
    pauseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      pauseTime++;
      update([builderTimerPause]);
    });
  }

  // 重置
  void onReset() {
    downTimer?.cancel();
    gameTimer?.cancel();
    init();
    onStartGame();
  }

  // 开始下落
  void downTimerStart() {
    if (downTimer == null || !downTimer!.isActive) {
      downTimer = Timer.periodic(downDuration, (timer) {
        onDownSlow();
      });
    }
  }

  // 开始游戏计时
  void gameTimerStart() {
    if (gameTimer == null || !gameTimer!.isActive) {
      gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        gameTime++;
        update([builderTimerGame]);
      });
    }
  }

  // 判断是否可以下降
  bool isCanDown() {
    BoxData data = gameData.current.getDownData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以左移
  bool isCanLeft() {
    BoxData data = gameData.current.getLeftData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以右移
  bool isCanRight() {
    BoxData data = gameData.current.getRightData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以旋转
  bool isCanRotate() {
    BoxData data = gameData.current.getRotateData();
    
    return (isValidData(data)) ? true : false;
  }

  // 下降
  void down() {
    clearData(gameData.current.boxData);
    gameData.current.down();
    setData(gameData.current.boxData);
  }

  // 单步下落
  Future<void> onDownSlow() async {
    if (isCanDown()) {
      down();
    } else {
      await land(gameData.current.boxData);
    }
  }

  // 左移
  void onLeft() {
    if (gameState != GameState.gaming) return;
    if (isCanLeft()) {
      clearData(gameData.current.boxData);
      gameData.current.left();
      setData(gameData.current.boxData);
    }
  }

  // 右移
  void onRight() {
    if (gameState != GameState.gaming) return;

    if (isCanRight()) {
      clearData(gameData.current.boxData);
      gameData.current.right();
      setData(gameData.current.boxData);
    }
  }

  // 旋转
  void onRotate() {
    if (gameState != GameState.gaming) return;

    if (isCanRotate()) {
      clearData(gameData.current.boxData);
      gameData.current.rotate();
      setData(gameData.current.boxData);
    }
  }

  // 一步到底
  Future<void> onDownFast() async {
    if (gameState != GameState.gaming) return;

    if (isCanDown()) {
      down();
      onDownFast();
    } else {
      await land(gameData.current.boxData);
    }
  }

  // 把当前数据设置到游戏数据中
  void setData(BoxData boxData) {
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] != 0) {
          gameData.data[y + boxData.origin.y][x + boxData.origin.x] = boxData.data[y][x];
          update([builderBody]);
        }
      }
    }
  }

  // 游戏结束的动画
  Future<void> gameOverAnimation() async {
    for (int y = gameData.data.length - 1; y >= 0; y--) {
      await Future.delayed(const Duration(milliseconds: 30), () {
          for (int x = 0; x < gameData.data[0].length; x++) {
            gameData.data[y][x] = 2;
          }

          if (y <= gameData.next.child.length - 1) {
            for (int x = 0; x < gameData.next.child[0].length; x++) {
              gameData.next.child[y][x] = 2;
            }
          }
        },
      );
      update([builderBoxTetris]);
    }
  }

  // 着陆
  Future<void> land(BoxData boxData) async {
    gameState = GameState.login;
    downTimer?.cancel();

    // 先渲染
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] != 0) {
          gameData.data[y + boxData.origin.y][x + boxData.origin.x] = 2;
          update([builderBody]);
        }
      }
    }

    // 然后判断游戏是否结束
    if (isGameOver()) {
      gameTimer?.cancel();
      await gameOverAnimation();
      gameState = GameState.gameOver;
      update([builderBody]);
    } else {
      await remove(gameData.current.boxData);
      await next();
    }
  }

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      var data = gameData.next.data;
      var angle = gameData.next.angle;
      gameData.current = Current(
        data: data,
        angle: angle,
        boxData: BoxData(data: data[angle], origin: Origin(x: 3, y: 0)),
      );
      update([builderBoxTetris]);
      gameData.next = gameData.getNext();
      update([builderBoxNext]);
      setData(gameData.current.boxData);
      gameState = GameState.gaming;
      downTimerStart();
      gameTimerStart();
    });
  }

  // 是否可以消除
  bool isCanRemove(List<int> data) {
    for (int x = 0; x < data.length; x++) {
      if (data[x] != 2) return false;
    }
    return true;
  }

  // 检查是否可以消除
  // 如何可以消除就会直接消除
  Future<void> remove(BoxData boxData) async {
    int count = 0;
    int y = gameData.data.length - 1;
    while (y >= boxData.origin.y) {
      if (isCanRemove(gameData.data[y])) {
        count++;
        // 为消行准备的一行空数据
        List<int> emptyLine = [];
        for (int x = 0; x < gameData.data[0].length; x++) {
          emptyLine.add(0);
        }
        await Future.delayed(const Duration(milliseconds: 100), () {
          gameData.data.removeAt(y);
          gameData.data.insert(0, emptyLine);
          update([builderBoxTetris]);
        });
      } else {
        y--;
      }
    }

    if (count > 0) addScore(count);
  }

  // 加分和更换游戏等级
  void addScore(int count) {
    score += count * count * 100;

    if (score < 1600) {
      gameLevel = 1;
    } else if (score < 3200) {
      gameLevel = 2;
    } else if (score < 6400) {
      gameLevel = 3;
    } else if (score < 12800) {
      gameLevel = 4;
    } else if (score < 25600) {
      gameLevel = 5;
    }


    downDuration = Duration(milliseconds: 1000 ~/ gameLevel);
    update([builderBoxScore, builderBoxLevel]);

  }

  // 判断游戏是否结束
  bool isGameOver() {
    for (int x = 0; x < gameData.data[0].length; x++) {
      if (gameData.data[0][x] == 2) {
        return true;
      }
    }
    return false;
  }

  // 判断点是否合法
  bool isValidPoint(Origin origin, int x, int y) {
    if (origin.x + x < 0) {
      return false;
    } else if (origin.x + x >= gameData.data[0].length) {
      return false;
    } else if (origin.y + y >= gameData.data.length) {
      return false;
    } else if (gameData.data[origin.y + y][origin.x + x] == 2) {
      return false;
    }
    return true;
  }

  // 判断数据的合法性
  bool isValidData(BoxData boxData) {
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] == 1 && !isValidPoint(boxData.origin, x, y)) {
          return false;
        }
      }
    }
    return true;
  }

  // 清空移动数据，为移动做准备
  void clearData(BoxData boxData) {
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] != 0) {
          gameData.data[y + boxData.origin.y][x + boxData.origin.x] = 0;
          update([builderBoxTetris]);
        }
      }
    }
  }
}



