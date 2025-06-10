import 'dart:math';
import 'package:IPMaster/models/questions_model.dart';

// Gera uma pergunta de um dos três tipos, a partir do nível
Question createQuestion(int level) {
  int type = Random().nextInt(3);
  switch (type) {
    case 0:
      return questionNetworkID(level);
    case 1:
      return questionBroadcast(level);
    case 2:
      return questionSameSegment(level);
    default:
      throw Exception("Tipo inválido");
  }
}

// 1) Network ID
Question questionNetworkID(int level) {
  String ip = _createIP();
  int cidr = _getCIDR(level);
  String netID = _calculateNetworkID(ip, cidr);

  return Question(
    questionText:
        "Qual é o Network ID do endereço IP $ip com máscara de sub-rede /$cidr?",
    options: _gerarOpcoesCom(netID),
    correctAnswer: netID,
  );
}

// 2) Broadcast
Question questionBroadcast(int level) {
  String ip = _createIP();
  int cidr = _getCIDR(level);
  String broadcast = _calcularBroadcast(ip, cidr);

  return Question(
    questionText:
        "Qual é o Broadcast do endereço IP $ip com máscara de sub-rede /$cidr?",
    options: _gerarOpcoesCom(broadcast),
    correctAnswer: broadcast,
  );
}

// 3) Mesmo segmento
Question questionSameSegment(int level) {
  String ip1 = _createIP();
  String ip2 = _createIP();
  int cidr = _getCIDR(level);

  String net1 = _calculateNetworkID(ip1, cidr);
  String net2 = _calculateNetworkID(ip2, cidr);
  String answer = (net1 == net2) ? "Sim" : "Não";

  return Question(
    questionText:
        "Os endereços IP $ip1 e $ip2 estão no mesmo segmento com máscara /$cidr?",
    options: ["Sim", "Não"],
    correctAnswer: answer,
  );
}

// —————— Funções auxiliares ——————

final _rand = Random();

// Gera um IP privado no padrão 192.168.x.x
String _createIP() {
  return "192.168.${_rand.nextInt(256)}.${_rand.nextInt(256)}";
}

// Escolhe a máscara de acordo com o nível
int _getCIDR(int level) {
  switch (level) {
    case 1:
      return [8, 16, 24][_rand.nextInt(3)];
    case 2:
      return [25, 26, 27, 28][_rand.nextInt(4)];
    case 3:
      return [19, 20, 21, 22][_rand.nextInt(4)]; // super-redes
    default:
      return 24;
  }
}

// Converte CIDR em máscara e faz AND bit-a-bit
String _calculateNetworkID(String ip, int cidr) {
  final parts = ip.split('.').map(int.parse).toList();
  final mask = _cidrParaMascara(cidr);
  final net = List.generate(4, (i) => parts[i] & mask[i]);
  return net.join('.');
}

String _calcularBroadcast(String ip, int cidr) {
  final parts = ip.split('.').map(int.parse).toList();
  final mask = _cidrParaMascara(cidr);
  final bcast = List.generate(
    4,
    (i) => (parts[i] & mask[i]) | (~mask[i] & 0xFF),
  );
  return bcast.join('.');
}

List<int> _cidrParaMascara(int cidr) {
  var mask = [0, 0, 0, 0];
  for (var i = 0; i < cidr; i++) {
    mask[i ~/ 8] |= 1 << (7 - i % 8);
  }
  return mask;
}

// Gera 4 opções (1 certa + 3 falsas)
List<String> _gerarOpcoesCom(String certa) {
  final opts = <String>{certa};
  while (opts.length < 4) {
    opts.add(_createIP()); // opções falsas
  }
  return opts.toList()..shuffle();
}
