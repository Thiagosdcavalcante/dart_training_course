import 'dart:io';

void main() {
  List<String> todosUsuarios = [];
  ;
  
  int opcaoMenu = 0;
  while(opcaoMenu != 5){
    print('____________________\n| MENU PRINCIPAL:  |\n|__________________|');
    print('\n 1- NOVO USUÁRIO  \n 2- MOSTRAR TODOS \n 3- EDITAR USUÁRIO \n 4- DELETAR USUÁRIO \n 5- SAIR \n\nDIGITE A OPÇÃO DESEJADA: ');
    opcaoMenu = int.parse(stdin.readLineSync()!);
    if(opcaoMenu >= 1 && opcaoMenu <= 5){
    switch(opcaoMenu){
      case 1:
        print('Qual o novo nome de usuário?');
        String novoNome = stdin.readLineSync()!;
        todosUsuarios.add(novoNome);
        print(Process.runSync("clear", [], runInShell: true).stdout);
        print('Novo usuário adicionado');
        break;
      case 2:
        print(Process.runSync("clear", [], runInShell: true).stdout);
        print('Lista com todos os usuários:');
        int i = 0;
        while(i >= 0 && i < todosUsuarios.length){
          print('${todosUsuarios[i]}');
          i++;
        }  
        break;
      case 3:
        print(Process.runSync("clear", [], runInShell: true).stdout);
        print('Qual nome você quer editar?');
        String nomeEditar = stdin.readLineSync()!;
        int index = todosUsuarios.indexOf(nomeEditar);
        if(index != -1){
          print('Qual o novo nome de usuário?');
          String nomeEditado = stdin.readLineSync()!;
          todosUsuarios[index] = nomeEditado;
          print('Alteração efetuada com sucesso!');
        }else{
          print('Esse nome não consta em nosso cadastro!');
        }  
        break;
      case 4:
        print(Process.runSync("clear", [], runInShell: true).stdout);
        print('Qual nome você quer deletar?');
        String nomeDeletar = stdin.readLineSync()!;
        int index = todosUsuarios.indexOf(nomeDeletar);
        if(index != -1){
          todosUsuarios.removeAt(index);
          print('USUÁRIO $nomeDeletar DELETADO COM SUCESSO!');
        }else{
          print('Esse usuário não está cadastrado!');
        }  
        break;          
    }
    }else{
      print('OPÇÃO INVÁLIDA!');
    }
  
};

}




