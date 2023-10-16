import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/pages/homepage.dart';

class telausuario extends StatefulWidget {
  const telausuario({super.key});

  @override
  State<telausuario> createState() => _telausuarioState();
}

class _telausuarioState extends State<telausuario> {
  // Usuario
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Todos usuarios tabela
  final userTabela = FirebaseFirestore.instance.collection("usuarios");
  // Editar informações
  Future<void> telaEditar(String field) async {
    String editarCampo = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Editar $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Editar $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            editarCampo = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              "Salvar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(editarCampo),
          ),
        ],
      ),
    );

    if (editarCampo.trim().length > 0) {
      await userTabela.doc(currentUser.email).update({field: editarCampo});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff363248),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // verificar qual usuario está logado
              final usuarioLogado =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Scaffold(
                backgroundColor: Color(0xff363248),
                body: SafeArea(
                  child: Column(
                    children: [
                      // Cabeçalho da pagina com Titulo e Icones, carrinho de compra e Perfil do Usuario
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icones Carrinho de Compra e Perfil
                                IconButton(
                                  padding: EdgeInsets.only(top: 20),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => telahomepage())),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color(0xffccb4ff),
                                  ),
                                ),

                                // Espaçamento
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                            // Barra de Pesquisa
                            Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Bem Vindo\n${usuarioLogado['Nome']}\na sua Área',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125,
                                            color: Color(0xffccb4ff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                            CupertinoIcons.profile_circled,
                                            color: Color(0xffccb4ff),
                                            size: 100),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Espaçamento
                            SizedBox(
                              height: 25,
                            ),

                            // Classes
                          ],
                        ),
                      ),
                      // espaçamento
                      SizedBox(
                        height: 20,
                      ),
                      // Área dos produtos
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(25),
                          child: Center(
                            child: Column(
                              children: [
                                // Texto "Dados:"
                                Row(
                                  children: [
                                    Text(
                                      'Dados:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                // Espaçamento
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  // Editar Nome
                                  child: Row(
                                    children: [
                                      Text(
                                        usuarioLogado['Nome'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => telaEditar('Nome'),
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  // Área Email
                                  child: Row(
                                    children: [
                                      Text(
                                        currentUser.email!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Espaçamento
                                SizedBox(
                                  height: 20,
                                ),
                                // Texto "Sobre"
                                Row(
                                  children: [
                                    Text(
                                      'Sobre:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => telaEditar('Bio'),
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                                // Espaçamento
                                SizedBox(
                                  height: 20,
                                ),
                                // Caixa de texto
                                Container(
                                  padding: EdgeInsets.only(left: 15, top: 5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        // Texto "Dados:"
                                        Row(
                                          children: [
                                            Text(
                                              usuarioLogado['Bio'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      // Deslogar do usuario
    );
  }
}
