import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepage/pages/SeachItens.dart';
import 'package:homepage/pages/carrinho.dart';
import 'package:homepage/pages/usuario.dart';
import 'homepage.dart';

class TelaProduto extends StatefulWidget {
  var _produtos;
  TelaProduto(this._produtos);
  @override
  _TelaProdutoState createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto>
    with SingleTickerProviderStateMixin {
  // Função para a adição dos produtos no carrinho de compras
  Future addCarrinho() async {
    // Conexão com o arquivo FirebaseAuth responsavel pela conexão com o Banco
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('carrinho');
    return _collectionRef
        .doc(currentUser!.email)
        .collection("produtosCarrinho")
        .doc()
        .set({
      'nomecarrinho': widget._produtos['nome'],
      'desccarrinho': widget._produtos['desc'],
      'valorcarrinho': widget._produtos['valor'],
      'imgcarrinho': widget._produtos['img'],
    }).then((value) => print('Adicionado ao Carrinho'));
  }

  @override
  Widget build(BuildContext context) {
    final larg = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff363248),
      body: Stack(
        children: [
          Column(
            children: [
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Espaçamento
              SizedBox(
                height: 20,
              ),
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
                              widget._produtos['nome'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          // Editar Nome
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                widget._produtos['img'],
                                height: 250,
                                width: 300,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          // Área Email
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Valor:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                widget._produtos['valor'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Espaçamento
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Descrição:',
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
                        // Texto "Dados:"
                        Row(
                          children: [
                            Text(
                              widget._produtos['desc'],
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
          new Positioned(
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 60,
                      width: larg * 0.45,
                      child: ElevatedButton.icon(
                        onPressed: () => addCarrinho(),
                        icon: Icon(Icons.add), //icon data for elevated button
                        label: Text("Carrinho"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: larg * 0.45,
                      child: ElevatedButton.icon(
                        onPressed: () => addCarrinho(),
                        icon: Icon(
                            Icons.shopping_bag), //icon data for elevated button
                        label: Text("Comprar"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
