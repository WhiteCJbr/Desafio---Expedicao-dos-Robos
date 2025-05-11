import 'dart:ffi';
import 'dart:io';

void main() {
  List<int> entradaInicial = entradasIniciais();
  int R = entradaInicial[0];
  int C = entradaInicial[1];
  int N = entradaInicial[2];
  int E = entradaInicial[3];
  List<List<String>> terreno = lerTerreno(R, C);

  for(var linha in terreno){
    print(linha);
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
      print("O terreno possui ${coluna} colunas, digite novamente");
    }else{
      lstTerreno = terreno.split('').toList();
      terrenoCompleto.add(lstTerreno);
      linha--;
    }
  }
  
  return terrenoCompleto;
}
