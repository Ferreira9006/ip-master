import 'dart:math';
import 'package:IPMaster/modules/quiz/models/questions_model.dart';

final _random = Random();

/// Cria uma pergunta aleatória com base no nível de dificuldade (1 a 3)
///
/// Tipos:
/// - 0: Pergunta sobre Network ID
/// - 1: Pergunta sobre Broadcast
/// - 2: Pergunta sobre segmento de rede
Question generateQuestion(int level) {
  int type = _random.nextInt(3);
  switch (type) {
    case 0:
      return _questionNetworkID(level);
    case 1:
      return _questionBroadcast(level);
    case 2:
      return _questionSameSegment(level);
    default:
      throw Exception("Tipo de pergunta inválido");
  }
}

/// Cria uma pergunta sobre Network ID
Question _questionNetworkID(int level) {
  String ip = _generatePrivateIP();
  int cidr = _getRandomCIDR(level);
  String networkId = _calculateNetworkID(ip, cidr);

  return Question(
    questionText:
        "Qual é o Network ID do endereço IP $ip com máscara de sub-rede /$cidr? Resposta certa: $networkId",
    options: _generateOptionsIncludingCorrect(networkId),
    correctAnswer: networkId,
  );
}

/// Cria uma pergunta sobre Broadcast
Question _questionBroadcast(int level) {
  String ip = _generatePrivateIP();
  int cidr = _getRandomCIDR(level);
  String broadcast = _calculateBroadcast(ip, cidr);

  return Question(
    questionText:
        "Qual é o endereço de broadcast do IP $ip com máscara de sub-rede /$cidr? Resposta certa: $broadcast",
    options: _generateOptionsIncludingCorrect(broadcast),
    correctAnswer: broadcast,
  );
}

/// Cria uma pergunta sobre se dois IPs estão no mesmo segmento
Question _questionSameSegment(int level) {
  String ip1 = _generatePrivateIP();
  String ip2 = _generatePrivateIP();
  int cidr = _getRandomCIDR(level);

  String net1 = _calculateNetworkID(ip1, cidr);
  String net2 = _calculateNetworkID(ip2, cidr);
  String answer = (net1 == net2) ? "Sim" : "Não";

  return Question(
    questionText:
        "Os endereços IP $ip1 e $ip2 pertencem ao mesmo segmento com máscara /$cidr? Resposta certa: $answer",
    options: ["Sim", "Não"]..shuffle(),
    correctAnswer: answer,
  );
}

/// Cria um IP privado aleatório na faixa 192.168.x.x
String _generatePrivateIP() {
  return "192.168.${_random.nextInt(256)}.${_random.nextInt(256)}";
}

/// Retorna um valor CIDR aleatório com base no nível de dificuldade
///
/// Nível 1 → /8, /16, /24
/// Nível 2 → /25, /26, /27, /28
/// Nível 3 → /19, /20, /21, /22
int _getRandomCIDR(int level) {
  switch (level) {
    case 1:
      return [8, 16, 24][_random.nextInt(3)];
    case 2:
      return [25, 26, 27, 28][_random.nextInt(4)];
    case 3:
      return [19, 20, 21, 22][_random.nextInt(4)];
    default:
      return 24;
  }
}

/// Converte um valor CIDR numa máscara decimal (ex: /24 → [255,255,255,0])
List<int> _cidrToMask(int cidr) {
  var mask = [0, 0, 0, 0];
  for (var i = 0; i < cidr; i++) {
    mask[i ~/ 8] |= 1 << (7 - i % 8);
  }
  return mask;
}

/// Calcula o Network ID a partir do IP e do CIDR
String _calculateNetworkID(String ip, int cidr) {
  final parts = ip.split('.').map(int.parse).toList();
  final mask = _cidrToMask(cidr);
  final net = List.generate(4, (i) => parts[i] & mask[i]);
  return net.join('.');
}

/// Calcula o endereço de broadcast a partir do IP e do CIDR
String _calculateBroadcast(String ip, int cidr) {
  final parts = ip.split('.').map(int.parse).toList();
  final mask = _cidrToMask(cidr);
  final broadcast = List.generate(
    4,
    (i) => (parts[i] & mask[i]) | (~mask[i] & 0xFF),
  );
  return broadcast.join('.');
}

/// Cria 4 opções aleatórias incluindo a correta
List<String> _generateOptionsIncludingCorrect(String correct) {
  final options = <String>{correct};
  while (options.length < 4) {
    options.add(_generatePrivateIP()); // alternativas falsas
  }
  return options.toList()..shuffle();
}
