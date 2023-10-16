import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class telacarrinho extends StatefulWidget {
  @override
  _telacarrinhoState createState() => _telacarrinhoState();
}

class _telacarrinhoState extends State<telacarrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xffccb4ff), //change your color here
          ),
          backgroundColor: Color(0xff363248),
          title: Text(
            'Seu Carrinho',
            style: TextStyle(
              color: Color(0xffccb4ff),
            ),
          ),
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("carrinho")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('produtosCarrinho')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Ocorreu um pronlema..."));
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, Index) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[Index];
                      return ListTile(
                        leading:
                            Image.network(_documentSnapshot['imgcarrinho']),
                        title: Text(_documentSnapshot['nomecarrinho']),
                        subtitle: Text(_documentSnapshot['desccarrinho']),
                        trailing: GestureDetector(
                          child: Icon(Icons.remove),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("carrinho")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection('produtosCarrinho')
                              .doc(_documentSnapshot.id)
                              .delete();
                        },
                      );
                    });
              }),
        ));
  }
}
