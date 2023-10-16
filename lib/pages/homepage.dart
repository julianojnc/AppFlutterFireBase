import 'package:flutter/material.dart';
import 'package:homepage/pages/SeachItens.dart';
import 'package:homepage/pages/carrinho.dart';
import 'package:homepage/util/itens.dart';
import 'package:homepage/pages/usuario.dart';
import 'package:homepage/util/listaItens.dart';

class telahomepage extends StatefulWidget {
  telahomepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<telahomepage> {
  @override
  Widget build(BuildContext context) {
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
                      // Titulo
                      Text(
                        'Line____',
                        style: TextStyle(
                          color: Color(0xffccb4ff),
                          fontSize: 30,
                        ),
                      ),
                      // Icones Carrinho de Compra e Perfil
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Icone Pesquisa
                          Container(
                            child: IconButton(
                              iconSize: 10,
                              icon: Icon(
                                Icons.search,
                                color: Color(0xffccb4ff),
                                size: 30,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SearchItens())),
                            ),
                          ),
                          // Icone Carrinho de Compra
                          Container(
                            child: IconButton(
                              iconSize: 10,
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Color(0xffccb4ff),
                                size: 30,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => telacarrinho())),
                            ),
                          ),
                          // Icone Perfil de Usuario
                          Container(
                            child: IconButton(
                              iconSize: 10,
                              icon: const Icon(
                                Icons.account_circle_rounded,
                                color: Color(0xffccb4ff),
                                size: 30,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => telausuario())),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  // Espaçamento
                  // SizedBox(
                  //   height: 25,
                  // ),

                  // Barra de Pesquisa
                  // Container(
                  //   child: TextFormField(
                  //     style: TextStyle(color: Color(0xffccb4ff)),
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Color(0xffccb4ff)),
                  //         borderRadius: BorderRadius.circular(50.0),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Color(0xffccb4ff)),
                  //         borderRadius: BorderRadius.circular(50.0),
                  //       ),
                  //       labelText: 'Procure',
                  //       labelStyle: TextStyle(color: Color(0xffccb4ff)),
                  //     ),
                  //   ),
                  // ),

                  // Espaçamento
                  SizedBox(
                    height: 25,
                  ),

                  // Classes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // classe camisa
                      Emojis(
                        emojisitens: '👕',
                      ),
                      // classe calça
                      Emojis(
                        emojisitens: '👖',
                      ),
                      // classe vestido
                      Emojis(
                        emojisitens: '👗',
                      ),
                      // classe sapato
                      Emojis(
                        emojisitens: '👟',
                      ),
                      // classe boné
                      Emojis(
                        emojisitens: '👒',
                      ),
                    ],
                  ),
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
                      // Text "Destaques"
                      Row(
                        children: [
                          Text(
                            'Destaques:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      // Espaçamento
                      SizedBox(
                        height: 20,
                      ),
                      // Texto "Dados:"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 95,
                            height: 150,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 95,
                            height: 150,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 95,
                            height: 150,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      listaitens(
                        item: 'Teste',
                        iteminfo: 'Testando',
                        itemvalue: 'valor',
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
  }
}
