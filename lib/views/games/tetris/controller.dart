import 'dart:async';
import 'package:get/get.dart';

import 'index.dart';

class TetrisController extends GetxController {
  final state = TetrisState();
  Timer? downTimer;
  Timer? gameTimer;
  Timer? pauseTimer;

  Duration downDuration = const Duration(milliseconds: 1000);

  void onStartGame() {
    // state.isPause = false;
    // state.isDisable = false;
    // state.isStart = false;
    state.gameState = GameState.gaming;
    update([state.builderBody]);

    pauseTimer?.cancel();
    state.pauseTime = 0;

    next();

    downTimerStart();
    gameTimerStart();
  }

  void onContinueGame() {
    state.gameState = GameState.gaming;
    update([state.builderBody]);

    pauseTimer?.cancel();
    state.pauseTime = 0;

    downTimerStart();
    gameTimerStart();
  }

  // 初始化
  Future<void> init() async {
    state.gameData = GameData.get();

    state.gameTime = 0;
    state.gameLevel = 1;
    state.score = 0;

    state.gameState = GameState.start;
  }

  // 暂停
  Future<void> onPauseGame() async {
    if (state.gameState == GameState.pause) return;
    state.gameState = GameState.pause;
    update([state.builderBody]);
    downTimer?.cancel();
    gameTimer?.cancel();
    pauseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.pauseTime++;
      update([state.builderTimerPause]);
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
        state.gameTime++;
        update([state.builderTimerGame]);
      });
    }
  }

  // 判断是否可以下降
  bool isCanDown() {
    BoxData data = state.gameData.current.getDownData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以左移
  bool isCanLeft() {
    BoxData data = state.gameData.current.getLeftData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以右移
  bool isCanRight() {
    BoxData data = state.gameData.current.getRightData();
    
    return (isValidData(data)) ? true : false;
  }

  // 判断是否可以旋转
  bool isCanRotate() {
    BoxData data = state.gameData.current.getRotateData();
    
    return (isValidData(data)) ? true : false;
  }

  // 下降
  void down() {
    clearData(state.gameData.current.boxData);
    state.gameData.current.down();
    setData(state.gameData.current.boxData);
  }

  // 单步下落
  Future<void> onDownSlow() async {
    if (isCanDown()) {
      down();
    } else {
      await land(state.gameData.current.boxData);
    }
  }

  // 左移
  void onLeft() {
    if (state.gameState != GameState.gaming) return;
    if (isCanLeft()) {
      clearData(state.gameData.current.boxData);
      state.gameData.current.left();
      setData(state.gameData.current.boxData);
    }
  }

  // 右移
  void onRight() {
    if (state.gameState != GameState.gaming) return;

    if (isCanRight()) {
      clearData(state.gameData.current.boxData);
      state.gameData.current.right();
      setData(state.gameData.current.boxData);
    }
  }

  // 旋转
  void onRotate() {
    if (state.gameState != GameState.gaming) return;

    if (isCanRotate()) {
      clearData(state.gameData.current.boxData);
      state.gameData.current.rotate();
      setData(state.gameData.current.boxData);
    }
  }

  // 一步到底
  Future<void> onDownFast() async {
    if (state.gameState != GameState.gaming) return;

    if (isCanDown()) {
      down();
      onDownFast();
    } else {
      await land(state.gameData.current.boxData);
    }
  }

  // 把当前数据设置到游戏数据中
  void setData(BoxData boxData) {
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] != 0) {
          state.gameData.data[y + boxData.origin.y][x + boxData.origin.x] = boxData.data[y][x];
          update([state.builderBody]);
        }
      }
    }
  }

  // 游戏结束的动画
  Future<void> gameOverAnimation() async {
    for (int y = state.gameData.data.length - 1; y >= 0; y--) {
      await Future.delayed(const Duration(milliseconds: 30), () {
          for (int x = 0; x < state.gameData.data[0].length; x++) {
            state.gameData.data[y][x] = 2;
          }

          if (y <= state.gameData.next.child.length - 1) {
            for (int x = 0; x < state.gameData.next.child[0].length; x++) {
              state.gameData.next.child[y][x] = 2;
            }
          }
        },
      );
      update([state.builderBoxTetris]);
    }
  }

  // 着陆
  Future<void> land(BoxData boxData) async {
    state.gameState = GameState.login;
    downTimer?.cancel();

    // 先渲染
    for (int y = 0; y < boxData.data.length; y++) {
      for (int x = 0; x < boxData.data[0].length; x++) {
        if (boxData.data[y][x] != 0) {
          state.gameData.data[y + boxData.origin.y][x + boxData.origin.x] = 2;
          update([state.builderBody]);
        }
      }
    }

    // 然后判断游戏是否结束
    if (isGameOver()) {
      gameTimer?.cancel();
      await gameOverAnimation();
      state.gameState = GameState.gameOver;
      update([state.builderBody]);
    } else {
      await remove(state.gameData.current.boxData);
      await next();
    }
  }

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      var data = state.gameData.next.data;
      var angle = state.gameData.next.angle;
      state.gameData.current = Current(
        data: data,
        angle: angle,
        boxData: BoxData(data: data[angle], origin: Origin(x: 3, y: 0)),
      );
      update([state.builderBoxTetris]);
      state.gameData.next = state.gameData.getNext();
      update([state.builderBoxNext]);
      setData(state.gameData.current.boxData);
      state.gameState = GameState.gaming;
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
    int y = state.gameData.data.length - 1;
    while (y >= boxData.origin.y) {
      if (isCanRemove(state.gameData.data[y])) {
        count++;
        // 为消行准备的一行空数据
        List<int> emptyLine = [];
        for (int x = 0; x < state.gameData.data[0].length; x++) {
          emptyLine.add(0);
        }
        await Future.delayed(const Duration(milliseconds: 100), () {
          state.gameData.data.removeAt(y);
          state.gameData.data.insert(0, emptyLine);
          update([state.builderBoxTetris]);
        });
      } else {
        y--;
      }
    }

    if (count > 0) addScore(count);
  }

  // 加分和更换游戏等级
  void addScore(int count) {
    state.score += count * count * 100;

    if (state.score < 1600) {
      state.gameLevel = 1;
    } else if (state.score < 3200) {
      state.gameLevel = 2;
    } else if (state.score < 6400) {
      state.gameLevel = 3;
    } else if (state.score < 12800) {
      state.gameLevel = 4;
    } else if (state.score < 25600) {
      state.gameLevel = 5;
    }


    downDuration = Duration(milliseconds: 1000 ~/ state.gameLevel);
    update([state.builderBoxScore, state.builderBoxLevel]);

  }

  // 判断游戏是否结束
  bool isGameOver() {
    for (int x = 0; x < state.gameData.data[0].length; x++) {
      if (state.gameData.data[0][x] == 2) {
        return true;
      }
    }
    return false;
  }

  // 判断点是否合法
  bool isValidPoint(Origin origin, int x, int y) {
    if (origin.x + x < 0) {
      return false;
    } else if (origin.x + x >= state.gameData.data[0].length) {
      return false;
    } else if (origin.y + y >= state.gameData.data.length) {
      return false;
    } else if (state.gameData.data[origin.y + y][origin.x + x] == 2) {
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
          state.gameData.data[y + boxData.origin.y][x + boxData.origin.x] = 0;
          update([state.builderBoxTetris]);
        }
      }
    }
  }
}
