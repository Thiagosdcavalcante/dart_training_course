import 'dart:io';

Map<String,atletaAcademia> todosAtletas = Map();

void main() {
  
  int menuOptions = 0;

while(menuOptions!=6){
  menuDisplay();
  menuOptions = int.parse(stdin.readLineSync()!);
  if(menuOptions >= 1 && menuOptions <=6){
    funcionalidadeMenu(menuOptions);
  }else{
    print("OPÇÃO INVÁLIDA!");
    }
  }
  
}

class atletaAcademia{
  String nome;
  double altura;
  int peso;
  int idade;
  List<atividade> treinos;
  
  atletaAcademia({required this.nome,required this.altura,required this.peso,required this.idade,required this.treinos});
}

class atividade{
  String nomeAtividade;
  int grauIntensidade;

  atividade({required this.nomeAtividade, required this.grauIntensidade});
}

void menuDisplay(){
  print('\n\n|-----------------------------|');
  print('|   MENU ACADEMIA DO FUTURO   |');
  print('|-----------------------------|\n\n');
  print('|-----------------------------|');
  print('|1- ADICIONAR UM NOVO ATLETA  |');
  print('|2- EDITAR UM ATLETA EXISTENTE|');
  print('|3- MOSTRAR TODOS OS ATLETAS  |');
  print('|4- ACHAR UM ATLETA EXISTENTE |');
  print('|5- EXCLUIR ATLETA EXISTENTE  |\n');  
  print('|6- SAIR                      |');
  print('|-----------------------------|\n\n');
}

void funcionalidadeMenu(int optionFunc){
  switch(optionFunc){
      case 1:
      adicionarAtleta();
        break;
      case 2: 
      print('Insira o cpf do atleta:');
        String cpfAtleta = stdin.readLineSync()!;
        editarAtleta(cpfAtleta);
        break;
      case 3:
        mostrarTodosAtletas();
        break;
      case 4:
      print('Insira o cpf do atleta:');
        String cpfAtleta = stdin.readLineSync()!;
        acharAtleta(cpfAtleta);
        break;
      case 5:
      removerAtleta();
        break;
      case 6:
      print('OBRIGADO POR USAR O PROGRAMA!');
        break;       
    }
}

void adicionarAtleta() {
  
  print('Qual o CPF do atleta?');
  String cpfAtleta = stdin.readLineSync()!;
  print('Insira o nome do atleta:');
  String nome = stdin.readLineSync()!;
  print('Insira a altura do atleta:');
  double altura = double.parse(stdin.readLineSync()!);
  print('Insira o peso do atleta:');
  int peso = int.parse(stdin.readLineSync()!);
  print('Insira a idade do atleta:');
  int idade = int.parse(stdin.readLineSync()!);

  List<atividade> treinos = [];
  bool adicionarMaisTreinos = true;
  while (adicionarMaisTreinos) {
    print('Insira o nome do treino:');
    String nomeAtividade = stdin.readLineSync()!;
    print('Insira o grau de intensidade do treino:');
    int grauIntensidade = int.parse(stdin.readLineSync()!);
    treinos.add(atividade(nomeAtividade: nomeAtividade, grauIntensidade: grauIntensidade));
    
    print('Deseja adicionar mais treinos? (s/n)');
    String escolha = stdin.readLineSync()!;
    if (escolha == 'n' || escolha == 'N') {
      adicionarMaisTreinos = false;
    }
  }
  
  atletaAcademia novoAtleta = atletaAcademia(nome: nome, altura: altura, peso: peso, idade: idade, treinos: treinos);
  
  todosAtletas[cpfAtleta] = novoAtleta;
}

void acharAtleta(String cpfAtleta) {
  if (todosAtletas.containsKey(cpfAtleta)) {
    atletaAcademia atleta = todosAtletas[cpfAtleta]!;
    print('Nome: ${atleta.nome}');
    print('Altura: ${atleta.altura}');
    print('Peso: ${atleta.peso}');
    print('Idade: ${atleta.idade}');
    print('Treinos:');
    for (atividade treino in atleta.treinos) {
      print('- ${treino.nomeAtividade} (${treino.grauIntensidade})');
    }
  } else {
    print('Atleta não encontrado!');
  }
}

void editarAtleta(String cpfAtleta){
  acharAtleta(cpfAtleta);
  print('DESEJA EDITAR ESTE ATLETA? (S/N)');
  String opcaoEditarAtleta = stdin.readLineSync()!;
  if(opcaoEditarAtleta == 's' || opcaoEditarAtleta =='S'){
    print('QUAL O NOVO PESO DO ATLETA?');
    int peso = int.parse(stdin.readLineSync()!);
    print('DESEJA EDITAR ALGUM TREINO? (S/N)');
    String opcaoEditarTreino = stdin.readLineSync()!;
    if(opcaoEditarTreino == 's' || opcaoEditarTreino == "S"){
      
      if (todosAtletas.containsKey(cpfAtleta)) {
      atletaAcademia atleta = todosAtletas[cpfAtleta]!;
      print('Treinos atuais:');
      for (int i = 0; i < atleta.treinos.length; i++) {
        atividade treino = atleta.treinos[i];
        print('${i+1} - ${treino.nomeAtividade} (${treino.grauIntensidade})');
      }
      bool editarMaisTreinos = true;
      while (editarMaisTreinos) {
        print('O que você deseja fazer?');
        print('1 - Adicionar treino');
        print('2 - Remover treino');        
        int opcao = int.parse(stdin.readLineSync()!);      
          if(opcao == 1){
            print('Insira o nome do novo treino:');
            String nomeAtividade = stdin.readLineSync()!;
            print('Insira o grau de intensidade do novo treino:');
            int grauIntensidade = int.parse(stdin.readLineSync()!);
            atleta.treinos.add(atividade(nomeAtividade: nomeAtividade, grauIntensidade: grauIntensidade));
          }else if(opcao == 2){
            print('Qual treino você deseja remover?');
            int indice = int.parse(stdin.readLineSync()!);
            atleta.treinos.removeAt(indice - 1);                   
        }
        print('Deseja editar mais treinos? (s/n)');
        String escolha = stdin.readLineSync()!;
        if (escolha == 'n') {
          editarMaisTreinos = false;
        }
      }
      }else {
      print('Atleta não encontrado');
    }
  }
    
    
  }else{
    print('OPERAÇÃO CANCELADA');
  }
  
}
void mostrarTodosAtletas() {
  for (String cpfAtleta in todosAtletas.keys) {
    atletaAcademia atleta = todosAtletas[cpfAtleta]!;
    print('Nome: ${atleta.nome}');
    print('Altura: ${atleta.altura}');
    print('Peso: ${atleta.peso}');
    print('Idade: ${atleta.idade}');
    print('Treinos:');
    for (atividade treino in atleta.treinos) {
      print('- ${treino.nomeAtividade} (${treino.grauIntensidade})');
    }
  }
}

void removerAtleta(){
  print('Qual o cpf do atleta?');
  String cpfAtleta = stdin.readLineSync()!;
  if(todosAtletas.containsKey(cpfAtleta)){
    atletaAcademia atleta = todosAtletas[cpfAtleta]!;
    print('Nome: ${atleta.nome}');
    print('Altura: ${atleta.altura}');
    print('Peso: ${atleta.peso}');
    print('Idade: ${atleta.idade}');
    print('Treinos:');
    for (atividade treino in atleta.treinos) {
      print('- ${treino.nomeAtividade} (${treino.grauIntensidade})');
    }
    print('TEM CERTEZA QUE DESEJA DELETAR ESTE ATLETA? (S/N)');
    String resposta = stdin.readLineSync()!;
    if(resposta == 's' || resposta =='S'){
      todosAtletas.remove(cpfAtleta);
      print('ATLETA REMOVIDO COM SUCESSO!');
    }else if(resposta == 'n' || resposta =='N'){
      print('OPERAÇÃO CANCELADA');
    }else{
      print('OPÇÃO INVÁLIDA. OPERAÇÃO CANCELADA!');
    }
  } else {
    print('Atleta não encontrado!');
  }
  }
  
