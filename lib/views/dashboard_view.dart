import 'package:flutter/material.dart';
import 'package:IPMaster/models/user_model.dart';
import 'package:IPMaster/views/login_view.dart';
import 'package:IPMaster/views/top5rank_view.dart';

class DashboardView extends StatefulWidget {
  final User user;

  const DashboardView({super.key, required this.user});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildRow("Nome", widget.user.displayName),
                _buildRow("E-mail", widget.user.email),
                _buildRow("Pontuação", widget.user.totalScore.toString()),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Top5Rank(user: widget.user),
                  ),
                );
              },
              child: const Text("Ranking Top 5"),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(value)),
      ],
    );
  }
}
