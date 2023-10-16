import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homepage/pages/produto.dart';

class SearchItens extends StatefulWidget {
  const SearchItens({Key? key}) : super(key: key);
  @override
  State<SearchItens> createState() => _SearchItensState();
}

class _SearchItensState extends State<SearchItens> {
  TextEditingController seachtf = TextEditingController();

  get _produtos => null;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('itens')
        .where(
          'nome',
          isEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xffccb4ff), //change your color here
        ),
        backgroundColor: Color(0xff363248),
        title: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            style: TextStyle(color: Color(0xffccb4ff)),
            decoration: InputDecoration(
              hintText: 'Pesquisa',
              hintStyle: TextStyle(color: Color(0xffccb4ff)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffccb4ff)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffccb4ff)),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            controller: seachtf,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TelaProduto(
                              snapshot.data!.docChanges[index].doc))),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                          snapshot.data!.docChanges[index].doc['img']),
                      title: Text(
                        snapshot.data!.docChanges[index].doc['nome'],
                      ),
                      subtitle: Text(
                        snapshot.data!.docChanges[index].doc['desc'],
                      ),
                      trailing: Text(
                        snapshot.data!.docChanges[index].doc['valor'],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
