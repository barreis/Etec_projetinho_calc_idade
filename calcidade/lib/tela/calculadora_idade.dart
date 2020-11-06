import 'dart:ffi';

import 'package:flutter/material.dart';
class CalculadoraIdade extends StatefulWidget {
  @override
  _CalculadoraIdadeState createState() => _CalculadoraIdadeState();
}

class _CalculadoraIdadeState extends State<CalculadoraIdade> {

  TextEditingController ano_nascController = TextEditingController();
  TextEditingController ano_atualController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Sua Idade";


  Void _resetFields(){  //para resetar o digitado
    ano_nascController.text = " ";
    ano_atualController.text = " ";
    setState(() {
      _infoText = "Sua Idade";
    });
  }

  void _calcular() {
    setState(() {
      int ano_nasc = int.parse(ano_nascController.text);
      int ano_atual = int.parse(ano_atualController.text);
      int result = ano_atual - ano_nasc;

      if (ano_nasc < ano_atual) {
        if (ano_atual != 2020 || ano_nasc <1900) {
          _infoText = "Digite dados validos, de 1900 em diante e menor que 2020";
        }else{
        _infoText =
        "Sua idade eh: (${result}) \n Tolerancia estatistica: 1 ano para mais ou para menos!";
        }
      } else {
        _infoText = "Seu ano de nascimento não pode ser maior que o ano atual";
      }
    });
  }


      @override
      Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(221, 160, 221, 1.0),
            appBar: AppBar(
              title: Text("Calculadora de Idade"), //fica em cima
              centerTitle: true,
              backgroundColor: Color.fromRGBO(186, 85, 211, 1.0),
              actions: <Widget>[
                IconButton( //coloca icone do lado direito
                  icon: Icon(Icons.delete),
                  onPressed: _resetFields,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //centraliza o icone
                  children: <Widget>[
                    Icon(Icons.person_pin, size: 120.0, color: Colors.black38),
                    TextFormField(keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Ano de seu nascimento XXXX: ",
                          labelStyle: TextStyle(color: Colors.black54)
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurple, fontSize: 22.0),
                      controller: ano_nascController,
                      validator: (value){
                        if (value.isEmpty){
                          return "Insira seu ano de nascimento";
                        }
                      }
                    ), //para pegar os dados do user na forma de numero

                    TextFormField(keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Em que ano estamos? XXXX: ",
                          labelStyle: TextStyle(color: Colors.black54)
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurple, fontSize: 22.0),
                      controller: ano_atualController, //seta o valor para dentro da variavel
                        validator: (value){
                          if (value.isEmpty){
                            return "Insira o ano atual";
                          }
                        }
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
                      child: Container(
                        height: 40.0,
                        child: RaisedButton(
                          child: Text("Calcular",
                            style: TextStyle(color: Colors.white,
                                fontSize: 22.0),
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              _calcular();
                            }
                          },
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Text(_infoText, textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 17.0),),
                  ]
              ),
              )
            )
        );
      }
    }

