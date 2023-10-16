import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      // Criando as Credenciais de Usuário e Autentificação com o Email e Senha inseridos
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();

      // É preciso inserir o codigo "request.auth != null;" na área de regras do Cloud Firestore
      // Entrada da informação de dados no Banco de Dados do FireBase
      FirebaseFirestore.instance
          // Criada o nome da "Tabela"
          .collection("usuarios")
          // Criada "Tabela" apartir do email de autentificação
          .doc(userCredential.user!.email)
          // Inserindo a informação na "Tabela"
          .set({
        // Inserindo coluna "Nome" com a informação vinda do Email, basicamente será ignorado o trecho "@email.com"
        // Assim será mantida a informação antes desse trecho e inseerida no Banc
        'Nome': email.split('@')[0],
        // Inserindo coluna "Bio" com a informação escrita "Nada por aqui..."
        'Bio': 'Nada por aqui...'
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já foi cadastrado');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não cadastrado!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta!');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
