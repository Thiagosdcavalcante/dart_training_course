import 'dart:io';

void main() {
  Map<String,Pessoa> pacientes = Map();  
  int menuOption = 0;

  while(menuOption != 6){    
    print('\n\n|------------|\n|    MENU    |\n|------------|\n\n');
    print('|1- CADASTRO DE NOVO PACIENTE   |');
    print('\n|2- EDITAR INFORMAÇOES PACIENTE |');
    print('\n|3- TIRAR PACIENTE DA LISTA     |');
    print('\n|4- MOSTRAR PACIENTES EM ORDEM  |');
    print('\n|5- CHAMAR PRÓXIMO PACIENTE     |\n');
    print('\n|6- SAIR                        |');
    print('\n\n\nQUAL OPÇÃO VOCÊ DESEJA?\n');
    menuOption = int.parse(stdin.readLineSync()!);
    if(menuOption>= 1 && menuOption<=6){    
      switch(menuOption){
        case 1:
          cadastroPacientes(pacientes);
          print('Paciente cadastrado com sucesso!');
        break;
        case 2:
          print('QUAL PACIENTE VOCÊ DESEJA ALTERAR?(DIGITE O CPF)');
          String pacienteEditar = stdin.readLineSync()!;
          print('Novo nome do paciente:');
          String novoNome = stdin.readLineSync()!;
          print('Nova idade do paciente:');
          int novaIdade = int.parse(stdin.readLineSync()!);
          print('Nova gravidade do paciente (de 0 a 2):');
          int novaGravidade = int.parse(stdin.readLineSync()!);
          editarPaciente(pacientes, pacienteEditar, novoNome, novaIdade, novaGravidade);
           break;
          
        case 3:
          print('QUAL PACIENTE VOCÊ DESEJA REMOVER? (DIGITE O CPF)');
            String pacienteRemover = stdin.readLineSync()!;
            pacientes.remove(pacienteRemover);
            print('Paciente removido com sucesso!');          
          break;
          
        case 4:
          ordemChamada(pacientes);
          break;   
          
        case 5:
          if(pacientes.length == 0){
            print('NÃO EXISTEM MAIS PACIENTES PARA SEREM CHAMADOS!');
          }else{
          chamarProximoPaciente(pacientes);
          }
          break;
          
        };
      }else{
        print(Process.runSync("clear", [], runInShell: true).stdout);
        print('|----------------|\n| OPÇÃO INVÁLIDA |\n|----------------|\n');
      }
	

  }
}

class Pessoa{
  String nome;
  int idade;
  int gravidade;  

  Pessoa({required this.nome, required this.idade, required this.gravidade});  
}

void mostrarPacientes(pacientes, int i){
  
  print('${pacientes[i].nome}\n ${pacientes[i].idade}\n${pacientes[i].gravidade}');
}

void cadastroPacientes(Map<String,Pessoa> pacientes) {
  print('Qual o CPF do paciente?');
  String cpfPaciente = stdin.readLineSync()!;  
  print('Qual o nome do paciente?');
  String nome = stdin.readLineSync()!;
  print('Qual a idade do paciente?');
  int idade = int.parse(stdin.readLineSync()!);
  print('Qual a gravidade do paciente (de 0 a 2)?');
  int gravidade = int.parse(stdin.readLineSync()!);  
  
  pacientes[cpfPaciente] = Pessoa(nome: nome, idade: idade, gravidade: gravidade); 

  pacientes.forEach((cpfPaciente, Pessoa){
    print('CPF: $cpfPaciente');
    print('NOME: $nome');
    print('IDADE: $idade');
    print('GRAVIDADE: $gravidade');      

    retornarAoMenu();
  });

}

retornarAoMenu(){
  print('DESEJA RETORNAR AO MENU PRINCIPAL? (1- SIM OU 2- SAIR)');
  int itemMenu = int.parse(stdin.readLineSync()!);
  if(itemMenu == 1){
    print(Process.runSync("clear", [], runInShell: true).stdout);  
  }
}

void chamarProximoPaciente(Map<String, Pessoa> pacientes) {
  print('PRÓXIMO PACIÊNTE:');
  List<MapEntry<String, Pessoa>> ordemChamada = pacientes.entries.toList();
  ordemChamada.sort((a,b){
    if(a.value.gravidade > b.value.gravidade){
      return -1;
    }else if(a.value.gravidade < b.value.gravidade){
      return 1;
    }else{
      if(a.value.idade > b.value.idade){
        return -1;
      }else if(a.value.idade < b.value.idade){
        return 1;
      }else{
        return 0;
      }
    }
  });
  print('NOME: ${ordemChamada[0].value.nome}  GRAVIDADE ${ordemChamada[0].value.gravidade}');
  pacientes.remove(ordemChamada[0].key);
}

void ordemChamada(Map<String, Pessoa> pacientes) {
  print('ORDEM DE CHAMADA!');
  List<MapEntry<String, Pessoa>> ordemChamada = pacientes.entries.toList();
  ordemChamada.sort((a,b){
    if(a.value.gravidade > b.value.gravidade){
      return -1;
    }else if(a.value.gravidade < b.value.gravidade){
      return 1;
    }else{
      if(a.value.idade > b.value.idade){
        return -1;
      }else if(a.value.idade < b.value.idade){
        return 1;
      }else{
        return 0;
      }
    }
  });
  for(MapEntry<String, Pessoa> entry in ordemChamada){
    print('PRÓXIMO PACIÊNTE: \nNOME: ${entry.value.nome}  GRAVIDADE ${entry.value.gravidade}\n');
  }
}

void editarPaciente(Map<String, Pessoa> pacientes, String cpf, String novoNome, int novaIdade, int novaGravidade) {
  if (pacientes.containsKey(cpf)) {
    // obtém o objeto Pessoa correspondente ao cpf do paciente
    Pessoa p = pacientes[cpf]!;
    p.nome = novoNome; // atualiza o nome do paciente
    p.idade = novaIdade; // atualiza a idade do paciente
    p.gravidade = novaGravidade; // atualiza a gravidade do paciente
    print('Informações do paciente atualizadas com sucesso!');
  } else {
    print('Paciente não encontrado!');
  }
}