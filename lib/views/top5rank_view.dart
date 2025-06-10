import 'package:flutter/material.dart';
import 'package:IPMaster/helpers/users_database_helper.dart';
import 'package:IPMaster/models/user_model.dart';
import 'package:IPMaster/views/dashboard_view.dart';

class Top5Rank extends StatelessWidget {
  final User user;
  const Top5Rank({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking Top 5'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardView(user: user)),
            );
          },
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: DatabaseHelper.instance.getRankTopFive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Ainda não há scores registados.'));
          }
          final topFive = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: topFive.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final u = topFive[index];
              return ListTile(
                leading: Text('${index + 1}.'),
                title: Text(u.displayName),
                trailing: Text(u.totalScore.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
