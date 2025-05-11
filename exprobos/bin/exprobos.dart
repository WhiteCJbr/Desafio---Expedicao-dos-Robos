import 'dart:io';
import 'dart:math';

void main() {
  // Leitura dos dados de entrada
  List<int> firstLine = stdin.readLineSync()!.split(' ').map(int.parse).toList();
  int R = firstLine[0]; // Linhas
  int C = firstLine[1]; // Colunas
  int N = firstLine[2]; // Número de robôs
  int E = firstLine[3]; // Energia inicial dos robôs

  // Leitura do terreno
  List<List<String>> terreno = [];
  for (int i = 0; i < R; i++) {
    terreno.add(stdin.readLineSync()!.split(''));
  }

  // Leitura dos robôs
  List<List<dynamic>> robos = [];
  for (int i = 0; i < N; i++) {
    List<String> roboData = stdin.readLineSync()!.split(' ');
    int x = int.parse(roboData[0]);
    int y = int.parse(roboData[1]);
    String movimentos = roboData[2];
    robos.add([x, y, movimentos]);
  }

  // Movimentos possíveis: N, S, L, O (Norte, Sul, Leste, Oeste)
  Map<String, List<int>> direcoes = {
    'N': [-1, 0], // Norte: move uma linha para cima
    'S': [1, 0],  // Sul: move uma linha para baixo
    'E': [0, 1],  // Leste: move uma coluna para a direita
    'O': [0, -1]  // Oeste: move uma coluna para a esquerda
  };

  // Processamento dos robôs
  for (var robo in robos) {
    int x = robo[0];
    int y = robo[1];
    String movimentos = robo[2];
    int energia = E;

    for (var movimento in movimentos.split('')) {
      if (energia <= 0) break;

      // Calcula a nova posição
      int dx = direcoes[movimento]![0];
      int dy = direcoes[movimento]![1];
      int nx = x + dx;
      int ny = y + dy;

      // Verifica se a nova posição está dentro dos limites
      if (nx < 0 || ny < 0 || nx >= R || ny >= C) {
        break; // Se o movimento for fora dos limites, o robô para
      }

      // Verifica o tipo de terreno
      String terrenoAtual = terreno[nx][ny];

      // Se houver um obstáculo, o robô não pode se mover
      if (terrenoAtual == '#') {
        break; // O robô para
      }

      // Se o terreno for lama, o movimento custa 2 de energia
      if (terrenoAtual == '@') {
        energia -= 2;
      } else {
        energia -= 1;
      }

      // Se o robô ficar sem energia, ele para
      if (energia <= 0) {
        break;
      }

      // Se o terreno for um teletransportador (*), o robô é teletransportado
      if (terrenoAtual == '*') {
        List<List<int>> teletransportadores = [];
        // Busca todos os teletransportadores no mapa
        for (int i = 0; i < R; i++) {
          for (int j = 0; j < C; j++) {
            if (terreno[i][j] == '*') {
              teletransportadores.add([i, j]);
            }
          }
        }

        // Se houver teletransportadores disponíveis, o robô é movido aleatoriamente
        if (teletransportadores.isNotEmpty) {
          Random random = Random();
          var destino = teletransportadores[random.nextInt(teletransportadores.length)];
          nx = destino[0];
          ny = destino[1];
        }
      }

      // Atualiza a posição do robô
      x = nx;
      y = ny;
    }

    // Saída: posição final do robô
    print('($x, $y)');
  }
}
