import 'package:MyAppHome/core/Model/User.dart';
import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:flutter/material.dart';

import 'core/Model/addUser.dart';
import 'pages/chatsPages/Chats.dart';
import 'pages/profilePage/ProfilePage.dart';
import 'pages/Payment/paymentPage.dart';
import 'core/PushNotifications/PushNotic.dart';
import 'pages/ScrolLent/Filling.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    addUser(widget.user.id, widget.user.email, '', widget.user.name, '', '', '',
        '', widget.user.numberPhone);
    checkForNotification();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      Filing(user: widget.user),
      const PaymentPage(),
      Chats(user: widget.user),
      ProfileePage(
        user: widget.user,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'Новости',
              // backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Оплата',
              // backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Чаты',
              // backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
              // backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
          ],
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          enableFeedback: true,
          // landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          type: BottomNavigationBarType.fixed,
          
          // showSelectedLabels: true,
          // showUnselectedLabels: true,
          selectedItemColor: purpleColor,
          unselectedItemColor: Colors.black.withOpacity(.4),
          backgroundColor: purpleColor.withOpacity(.05),
          elevation: 0,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
