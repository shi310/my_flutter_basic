import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_basic/common/common.dart';

import 'index.dart';

class TetrisView extends GetView<TetrisController> {
  const TetrisView({super.key});

  @override
  Widget build(BuildContext context) {
    // 方块之间的间距
    const paddingOutline = EdgeInsets.all(1);

    // 方块内部的间距
    const paddingInline = EdgeInsets.all(3);

    // 方块的大小
    final size = (Get.width * 0.5 - 10 - 1 * 2 - 6 * 2 - 1 * 9) / 10;

    // 默认的方块样式
    var defaultBox = Container(
      padding: paddingInline,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.dark.withValues(alpha: 0.1),
          width: 1,
        ),
        color: MyColors.light,
      ),
      child: Container(
        color: MyColors.dark.withValues(alpha: 0.1),
        width: size,
        height: size,
      ),
    );

    // 移动和着陆的样式
    var selectBox = Container(
      padding: paddingInline,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.error,
          width: 1,
        ),
        color: MyColors.light,
      ),
      child: Container(
        color: MyColors.error,
        width: size,
        height: size,
      ),
    );

    Widget buildNextBox() {
      List<Widget> children = controller.state
          .gameData.next.data[controller.state.gameData.next.angle]
          .map((e) => Row(
              children: e.map((i) => i == 0 ? defaultBox : selectBox).toList()))
          .toList();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: children,
          )
        ],
      );
    }

    var topLeft = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColors.inputHint,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: GetBuilder<TetrisController>(id: controller.state.builderBoxTetris, builder: (controller) {
        List<Widget> children = controller.state.gameData.data
            .map((e) => Row(
            children: e
                .map((e) => Container(
              padding: paddingOutline,
              child: e == 0 ? defaultBox : selectBox,
            ))
                .toList()))
            .toList();
        return Column(children: children);
      }),
    );

    var topRight = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          '游戏时间',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        GetBuilder<TetrisController>(id: controller.state.builderTimerGame, builder: (controller) {
          return Text(MyTimer.getDuration(controller.state.gameTime),
            style: Theme.of(context).textTheme.titleLarge,
          );
        }),
        const SizedBox(height: 20),
        Text(
          '游戏等级',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        GetBuilder<TetrisController>(id: controller.state.builderBoxLevel,builder: (controller) {
          return Text('${controller.state.gameLevel}',
            style: Theme.of(context).textTheme.titleLarge,
          );
        }),
        const SizedBox(height: 20),
        Text(
          '得分',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        GetBuilder<TetrisController>(id: controller.state.builderBoxScore,builder: (controller) {
          return Text('${controller.state.score}',
            style: Theme.of(context).textTheme.titleLarge,
          );
        }),
        const SizedBox(height: 20),
        Text(
          '下一个',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        GetBuilder<TetrisController>(id: controller.state.builderBoxNext, builder: (controller) => buildNextBox()),
        const SizedBox(height: 40),
        FilledButton(onPressed: controller.onPauseGame, child: const Text('暂停')),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => Get.back(),
          child: const Text('返回'),
        ),
      ],
    );

    var topBox = Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [topLeft, const SizedBox(width: 8), Expanded(child: FittedBox(child: topRight))],
      ),
    );

    var buttonLeft = MyButton.widget(
      onPressed: controller.onLeft,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.chevron_left, color: Colors.white),
      ),
    );

    var buttonRight = MyButton.widget(
      onPressed: controller.onRight,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue,
        ),
        child: const Icon(Icons.chevron_right, color: Colors.white),
      ),
    );

    var bottomLeftTop = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: buttonLeft),
        const SizedBox(width: 10),
        Expanded(child: buttonRight),
      ],
    );

    var bottomLeftBottom = MyButton.widget(
      onPressed: controller.onDownFast,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue,
        ),
        child: const Icon(Icons.expand_more, color: Colors.white),
      ),
    );

    var bottomLeft = Column(children: [
      Expanded(child: bottomLeftTop),
      const SizedBox(height: 10),
      Expanded(child: bottomLeftBottom),
    ]);

    var bottomRotate = MyButton.widget(
      onPressed: controller.onRotate,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blue,
        ),
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );

    var bottomBox = Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: Get.height,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Row(children: [
          Expanded(flex: 7, child: bottomLeft),
          const SizedBox(width: 10),
          Expanded(flex: 5, child: bottomRotate),
        ]),
      ),
    );

    var gameBody = Column(children: [
      SafeArea(bottom: false, child: topBox),
      Expanded(child: SafeArea(top: false, child: bottomBox)),
    ]);

    var startBody = Stack(
      children: [
        gameBody,
        Container(
          width: Get.width,
          height: Get.height,
          color: MyColors.dark.withValues(alpha: 0.6),
          child: SafeArea(child: Column(
            children: [
              const SizedBox(height: 60),
              Text('经典游戏 - 80后的回忆', style: TextStyle(color: MyColors.light, fontSize: 18)),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: controller.onStartGame,
                child: const Text('开始游戏'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Get.back(),
                child: const Text('返回上一页'),
              ),
            ],
          )),
        ),
      ],
    );

    var pauseBody = Stack(
      children: [
        gameBody,
        Container(
          width: Get.width,
          height: Get.height,
          color: MyColors.dark.withValues(alpha: 0.6),
          child: SafeArea(child: Column(
            children: [
              const SizedBox(height: 60),
              Text('游戏暂停中', style: TextStyle(color: MyColors.light, fontSize: 18)),
              const SizedBox(height: 20),
              GetBuilder<TetrisController>(id: controller.state.builderTimerPause, builder: (controller) {
                return Text(MyTimer.getDuration(controller.state.pauseTime),
                    style: TextStyle(color: MyColors.light, fontSize: 20)
                );
              }),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: controller.onContinueGame,
                child: const Text('继续游戏'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Get.back(),
                child: const Text('返回上一页'),
              ),
            ],
          )),
        ),
      ],
    );

    var gameOverBody = Stack(
      children: [
        gameBody,
        Container(
          width: Get.width,
          height: Get.height,
          color: MyColors.dark.withValues(alpha: 0.6),
          child: SafeArea(child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                '游戏结束',
                style: TextStyle(color: MyColors.light, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text('你的得分', style: TextStyle(color: MyColors.light, fontSize: 18)),
              const SizedBox(height: 10),
              GetBuilder<TetrisController>(id: controller.state.builderBoxScore, builder: (controller) {
                return Text('${controller.state.score}',
                  style: TextStyle(color: MyColors.light, fontSize: 20),
                );
              }),
              const SizedBox(height: 20),
              Text('你的等级', style: TextStyle(color: MyColors.light, fontSize: 18)),
              const SizedBox(height: 10),
              GetBuilder<TetrisController>(id: controller.state.builderBoxScore, builder: (controller) {
                return Text('${controller.state.gameLevel}',
                    style: TextStyle(color: MyColors.light, fontSize: 20)
                );
              }),
              const SizedBox(height: 20),
              Text('游戏时长', style: TextStyle(color: MyColors.light, fontSize: 18)),
              const SizedBox(height: 10),
              GetBuilder<TetrisController>(id: controller.state.builderTimerGame, builder: (controller) {
                return Text(MyTimer.getDuration(controller.state.gameTime),
                    style: TextStyle(color: MyColors.light, fontSize: 20)
                );
              }),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: controller.onReset,
                child: const Text('重新开始'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Get.back(),
                child: const Text('返回上一页'),
              ),
            ],
          )),
        ),
      ],
    );

    var body = GetBuilder<TetrisController>(id: controller.state.builderBody, builder: (controller) {
      return switch (controller.state.gameState) {
        GameState.start => startBody,
        GameState.pause => pauseBody,
        GameState.gameOver => gameOverBody,
        GameState.gaming || GameState.login => gameBody,
      };
    });

    return Scaffold(body: body);
  }
}
