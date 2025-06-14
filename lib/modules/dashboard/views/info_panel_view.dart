import 'package:flutter/material.dart';
import 'package:IPMaster/modules/auth/models/user_model.dart';
import 'package:IPMaster/modules/ranking/data/scores_database_helper.dart';

class UserInfoPanel extends StatefulWidget {
  final User user;

  const UserInfoPanel({Key? key, required this.user}) : super(key: key);

  @override
  State<UserInfoPanel> createState() => _UserInfoPanelState();
}

class _UserInfoPanelState extends State<UserInfoPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Text(
              "Olá, ${widget.user.displayName}!",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Bem vindo de volta."),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 10),
              child: Text("Dados Pessoais"),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: Colors.transparent),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nome",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.user.displayName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),

                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "E-mail",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.user.email),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text("As tuas pontuações"),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(color: Colors.transparent),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nível 1",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: ScoresDatabaseHelper()
                                .getUserScoreByDifficulty(0, widget.user.id!),
                            builder: (context, snapshot) {
                              final score = snapshot.data ?? 0;
                              return Text("$score pontos");
                            },
                          ),
                        ),
                      ],
                    ),

                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nível 2",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: ScoresDatabaseHelper()
                                .getUserScoreByDifficulty(1, widget.user.id!),
                            builder: (context, snapshot) {
                              final score = snapshot.data ?? 0;
                              return Text("$score pontos");
                            },
                          ),
                        ),
                      ],
                    ),

                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nível 3",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: ScoresDatabaseHelper()
                                .getUserScoreByDifficulty(2, widget.user.id!),
                            builder: (context, snapshot) {
                              final score = snapshot.data ?? 0;
                              return Text("$score pontos");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
