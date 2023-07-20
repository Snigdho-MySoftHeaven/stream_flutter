import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: Get.height * .3,
              child: Obx(() => ListView.builder(
                    controller: controller.scrollController.value,
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      controller
                          .scrollController.value.position.maxScrollExtent;
                      return ListTile(
                        trailing: Text(index.toString()),
                        title: Text(controller.list[index]),
                      );
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                controller.streamController.value
                    .add(DateTime.now().toString());
                controller.valueupdate(true);
              },
              child: const Text('Add'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: controller.stream.value,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else {
                          return const Text('No data');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
