import 'package:flutter/material.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';
import 'package:IPMaster/modules/auth/views/login_view.dart';
import 'package:IPMaster/modules/ranking/views/top5rank_view.dart';
import 'package:IPMaster/modules/dashboard/views/info_panel_view.dart';

class DashboardView extends StatefulWidget {
  final User user;

  const DashboardView({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      UserInfoPanel(user: widget.user),
      Center(child: Text("Jogar")),
      CombinedTop5RankView(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginView()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Jogar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.toc_sharp),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
      ),
    );
  }
}
