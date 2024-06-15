import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/Styles/Colors.dart';
import 'Data/expences.dart';
import 'paymentDetalPage.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    setState(() {
      expenses.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor.withOpacity(.015),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentDetalPage(
                          expense: expenses[index],
                          service: expenses[index].list)));
            },
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expenses[index].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            expenses[index].sumCost.toStringAsFixed(2) +
                                " руб.",
                            style: TextStyle(
                              fontSize: 18,
                            ))
                      ],
                    ),
                  ),
                  // SizedBox(height: 8,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              color: expenses[index].status.contains("Оплачено")
                                  ? Colors.green
                                  : expenses[index]
                                          .status
                                          .contains("Не оплачено")
                                      ? Colors.red
                                      : Colors.orange,
                              child: Text(expenses[index].status,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14))),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(DateFormat('dd.MM.yyyy')
                              .format(expenses[index].dateTime)
                              .toString()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
