import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ProfileCom/components/lineCharts.dart';
import '../../ProfileCom/data/month.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SizedBox(
          height: context.height * 0.9001,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Column(children: [
                Text(
                  "Статистика",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                LineCharts(),
                SizedBox(height: 150, child: TotalMonth()),
                SizedBox(
                  height: 10,
                ),
              ]))),
    );
  }
}

class TotalMonth extends StatelessWidget {
  const TotalMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              "Итого за месяц",
              style: TextStyle(fontSize: 25),
            )),
        Spacer(),
        const _dropButton()
      ]),
      SizedBox(
        height: 10,
      ),
      Table(
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FixedColumnWidth(100),
        },
        children: [
          TableRow(children: [
            SizedBox(
              child: Text("Кол-во жителей оплатили квитанцию:",
                  style: TextStyle(fontSize: 20)),
            ),
            Text(
              "0",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ]),
          TableRow(children: [
            SizedBox(
              child: Text("Общая сумма за текущий месяц:",
                  style: TextStyle(fontSize: 20)),
            ),
            Text(
              "0",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ]),
        ],
      )
    ]);
  }
}

int countTasksComplete() {
  int count = 0;
  return count;
}

int countTasksDone() {
  int count = 0;
  return count;
}

String category = month.first;

class _dropButton extends StatefulWidget {
  const _dropButton();

  @override
  State<_dropButton> createState() => _dropButtonState();
}

class _dropButtonState extends State<_dropButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(fontSize: 20, color: purpleColor),
      underline: SizedBox(),
      alignment: Alignment.centerRight,
      value: category,
      elevation: 16,
      onChanged: (String? value) {
        setState(() {
          category = value!;
        });
      },
      items: month.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}
