import 'dart:ffi';
import 'dart:io';

int R = 0;
int C = 0;
int N = 0;
int E = 0;
List<List<String>> terreno = [];

void main() {
  List<int> entradaInicial = entradasIniciais();
  R = entradaInicial[0];
  C = entradaInicial[1];
  N = entradaInicial[2];
  E = entradaInicial[3];
  terreno = lerTerreno(R, C);
  List<String> Xini = [];
  List<String> Yini = [];
  List<List<String>> movimentos = [];
  List<String> inpFinal = [];

  for(var linha in terreno){
    print(linha);
  }

  for(var i = 0; i < N; i ++){
    inpFinal = lerInputs();

    Xini.add(inpFinal[0]);
    Yini.add(inpFinal[1]);
    movimentos.add(inpFinal[2].split('').toList());
  }
  
  for(var i = 0; i < N; i ++){
    movimentaRobo(int.parse(Xini[i]), int.parse(Yini[i]), movimentos[i]);
  }

}

List<int> entradasIniciais(){
  String entradas = stdin.readLineSync()!;

  List<int> lstentradas = entradas.split(' ').map((char) => int.parse(char)).toList();

  return lstentradas;
}

List<List<String>> lerTerreno(int linha, int coluna){
  String terreno = "";
  List<String> lstTerreno = <String>[];
  List<List<String>> terrenoCompleto = [];

  while (linha > 0){
    terreno = stdin.readLineSync()!;

    if(terreno.length != coluna){ // Verifica se o usuario digitou o terreno corretamente
      print("O terreno possui $coluna colunas, digite novamente");
    }else{
      lstTerreno = terreno.split('').toList();
      terrenoCompleto.add(lstTerreno);
      linha--;
    }
  }
  
  return terrenoCompleto;
}

List<String> lerInputs(){
  String input = stdin.readLineSync()!;

  return input.split(' ').toList();
}

void movimentaRobo(int xini, int yini, List<String> moves){
  List<int> devolutiva = [];
  for(var i = 0; i < moves.length; i ++){

    if(E > 0){
      switch (moves[i]){
        case "N":
          devolutiva = andarNorte(xini, yini);
          xini = devolutiva[0];
          yini = devolutiva[1];
          break;
        case "S":
          devolutiva = andarSul(xini, yini);
          xini = devolutiva[0];
          yini = devolutiva[1];
          break;
        case "E":
          devolutiva = andarLeste(xini, yini);
          xini = devolutiva[0];
          yini = devolutiva[1];
          break;
        case "O":
          devolutiva = andarOeste(xini, yini);
          xini = devolutiva[0];
          yini = devolutiva[1];
          break;
      }
    }else{
      print("($xini, $yini)");
      break;
    }
  }
  print("($xini, $yini)");
}

List<int> andarNorte(int x, int y){
  if(verificaCaminho(x, y, 'N') == true){
    switch (terreno[x][y--]){
      case '.':
        E--;
        return [x, y--];
      case '@':
        if(E >= 2){
          E = E - 2;
          return [x, y--];
        }else{
          E = 0;
          return [x, y];
        }
    }
  }

  E = 0;
  return [x,y];
}

List<int> andarSul(int x, int y){
  if(verificaCaminho(x, y, 'S') == true){
    switch (terreno[x][y++]){
      case '.':
        E--;
        return [x, y++];
      case '@':
        if(E >= 2){
          E = E - 2;
          return [x, y++];
        }else{
          E = 0;
          return [x, y];
        }
    }
  }

  E = 0;
  return [x,y];
}

List<int> andarLeste(int x, int y){
  if(verificaCaminho(x, y, 'E') == true){
    switch (terreno[x++][y]){
      case '.':
        E--;
        return [x++, y];
      case '@':
        if(E >= 2){
          E = E - 2;
          return [x++, y];
        }else{
          E = 0;
          return [x, y];
        }
    }
  }

  E = 0;
  return [x,y];
}

List<int> andarOeste(int x, int y){
  if(verificaCaminho(x, y, 'O') == true){
    switch (terreno[x--][y]){
      case '.':
        E--;
        return [x--, y];
      case '@':
        if(E >= 2){
          E = E - 2;
          return [x--, y];
        }else{
          E = 0;
          return [x, y];
        }
    }
  }

  E = 0;
  return [x,y];
}

bool verificaCaminho(int x, int y, String caminho){

  switch (caminho){
    case 'N':
      if(y-- < 0){
        return false;
      }else{
        if(terreno[x][y--] == "#"){
          return false;
        }
      }
      break;
    case 'S':
      if(y++ > C){
        return false;
      }else{
        if(terreno[x][y++] == "#"){
          return false;
        }
      }
      break;
    case 'E':
      if(x++ > R){
        return false;
      }else{
        if(terreno[x++][y] == "#"){
          return false;
        }
      }
      break;
    case 'O':
      if(x-- < 0){
        return false;
      }else{
        if(terreno[x--][y] == "#"){
          return false;
        }
      }
      break;
  }
  return true;
}
