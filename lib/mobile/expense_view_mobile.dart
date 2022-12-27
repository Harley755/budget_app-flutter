import 'dart:html';

import 'package:budget_app_starting/components.dart';
import 'package:budget_app_starting/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double deviceWidth = MediaQuery.of(context).size.width;

    int totalExpense = 0;
    int totalIncome = 0;

    void calculate() {
      for (int i = 0; i < viewModelProvider.expensesAmount.length; i++) {
        totalExpense =
            totalExpense + int.parse(viewModelProvider.expensesAmount[i]);
      }
      for (var i = 0; i < viewModelProvider.incomesAmount.length; i++) {
        totalIncome =
            totalIncome + int.parse(viewModelProvider.incomesAmount[i]);
      }
    }

    calculate();

    int budgetLeft = totalIncome - totalExpense;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 180.0,
                    backgroundColor: Colors.white,
                    child: Image(
                      height: 100.0,
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                onPressed: () {
                  viewModelProvider.logout();
                },
                child: OpenSans(
                  text: "Logout",
                  size: 20.0,
                  color: Colors.white,
                ),
                color: Colors.black,
                height: 50.0,
                minWidth: 200.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 20.0,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UrlLaunch(
                    url: 'https://www.instagram.com/',
                    iconSvg: 'assets/instagram.svg',
                  ),
                  UrlLaunch(
                    url: 'https://twitter.com/bg_dev2',
                    iconSvg: 'assets/twitter.svg',
                  ),
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 30.0),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Poppins(text: "Dashboard", color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
