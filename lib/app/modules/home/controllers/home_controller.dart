import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<StreamController> streamController = StreamController().obs;
  Rx<Stream> stream = const Stream.empty().obs;
  Rx<StreamSubscription> streamSubscription =
      StreamController.broadcast().stream.listen((event) {}).obs;
  RxList<dynamic> list = [].obs;

  Rx<ScrollController> scrollController = ScrollController().obs;

  RxBool valueupdate = false.obs;

  @override
  void onInit() {
    list = [
      for (int i = 0; i < 10; i++)
        (DateTime.now().add(const Duration(hours: 1))).toString()
    ].obs;
    streamController.value = StreamController.broadcast();
    stream.value = streamController.value.stream;
    streamSubscription.value = stream.value.listen((event) async {
      list.add(event);
      if (list.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.value.animateTo(
            scrollController.value.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
    log(list.toString());

    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.value.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    streamSubscription.value.cancel();
    super.dispose();
  }
}
