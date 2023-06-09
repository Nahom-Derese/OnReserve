import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class HomeController extends GetxController {
  var categories = [];
  List popularEvents = [];
  int currentPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Event> events = [
    Event(
        title: "My Generation",
        subtitle: "Rophnans My Generation Concert Lorem Ipsum Odor",
        types: ["VIP", "VVIP"],
        imageURL: 'Rophnan.png'),
    Event(
        title: "Event NEW",
        subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        types: ["VIP", "Regular"],
        imageURL: 'Welcome_BG.png'),
    Event(
        title: "Check Event",
        subtitle: "Lorem Ipsum Generation ",
        types: ["Regular", "VVIP"],
        imageURL: 'Intro slider screen.png'),
  ];

  late Timer timer;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startTimer();
    getCategories();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void stopTimer() {
    timer.cancel();
  }

  void changePage(int index) {
    currentPageIndex = index;
    update();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentPageIndex == events.length - 1) {
        currentPageIndex = 0;
      } else {
        currentPageIndex++;
      }
      if (pageController.hasClients)
        pageController.animateToPage(
          currentPageIndex,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
    });
  }

  Future<void> getTopProduct() async {}

  Future<List> getCategories() async {
    var response = await NetworkHandler.get(endpoint: 'categories/');
    if (response[1] == 200) {
      try {
        categories = response[0];
      } catch (e) {
        logger(HomeController).e("Error: $e");
      }
    } else {}
    return categories;
  }

  Future<List> getPopularEvents() async {
    var response = await NetworkHandler.get(endpoint: 'events/popular');
    if (response[1] == 200) {
      try {
        print(response[0]);
        popularEvents = response[0];
      } catch (e) {
        logger(HomeController).e("Error: $e");
      }
    } else {}
    try {
      var res = popularEvents
          .map((e) => Event(
                title: e['title'],
                subtitle: e['desc'],
                types: ['VIP', 'Regular'],
                imageURL: e['galleries'].length > 0
                    ? e['galleries'][0]['eventPhoto']
                    : 'Rophnan.png',
              ))
          .toList();
      if (events.length > 2) {
        events = res.sublist(0, 3);
      }
    } catch (e) {
      logger(HomeController).e("Error: $e");
    }

    update();
    return popularEvents;
  }
}

class Event {
  final String title;
  final String subtitle;
  final List<String> types;
  final String imageURL;

  Event({
    required this.title,
    required this.subtitle,
    required this.types,
    required this.imageURL,
  });
}
