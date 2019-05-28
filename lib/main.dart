import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cripto/cripto_cesar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher César',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale("pt"),
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Criptografia de César'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'Criptografar';

  final chaveController = TextEditingController();
  final textoController = TextEditingController();
  final textoCifraController = TextEditingController();

  final chaveFocus = FocusNode();
  final textoFocus = FocusNode();
  final textoCifraFocus = FocusNode();

  _run() {
    int key = int.tryParse(chaveController.text) ?? 3;
    final cipher_cesar = CriptoCesar();
    if (dropdownValue == 'Criptografar') {
      textoCifraController.text =
          cipher_cesar.encrypt(text: textoController.text, key: key);
    } else {
      textoCifraController.text =
          cipher_cesar.decrypt(text: textoController.text, key: key);
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _resetFields() {
    setState(() {
      dropdownValue = "Criptografar";
      chaveController.clear();
      textoController.clear();
      textoCifraController.clear();
      _fieldFocusChange(context, textoCifraFocus, chaveFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              style: TextStyle(color: Colors.blue, fontSize: 20),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Criptografar', 'Descriptografar']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: chaveController,
              focusNode: chaveFocus,
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 20),
              maxLength: 2,
              decoration: InputDecoration(
                  labelText: "Informe a chave da cifra",
                  labelStyle: TextStyle(color: Colors.blue),
                  counterText: ""),
              onSubmitted: (term) {
                _fieldFocusChange(context, chaveFocus, textoFocus);
              },
            ),
            TextField(
              controller: textoController,
              focusNode: textoFocus,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 20),
              autocorrect: true,
              textCapitalization: TextCapitalization.characters,
              minLines: 2,
              maxLines: 10,
              decoration: InputDecoration(
                  labelText: "Informe o texto para cifrar",
                  labelStyle: TextStyle(color: Colors.blue),
                  counterText: ""),
              onSubmitted: (term) {
                _fieldFocusChange(context, textoFocus, textoCifraFocus);
              },
            ),
            TextField(
              controller: textoCifraController,
              focusNode: textoCifraFocus,
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 20),
              autocorrect: true,
              textCapitalization: TextCapitalization.characters,
              minLines: 2,
              maxLines: 10,
              decoration: InputDecoration(
                  labelText: "Resultado",
                  labelStyle: TextStyle(color: Colors.blue),
                  counterText: ""),
              onSubmitted: (term) {
                _fieldFocusChange(context, textoCifraFocus, chaveFocus);
              },
            ),
            Divider(),
            RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Compartilhar texto",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.share, color: Colors.white,)
                ],
              ),
              onPressed: (){
                Share.share(textoCifraController.text);
              },
              color: Colors.blue,
            ),
            Divider(),
            Text(
              "Para Renata 😉",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.pink),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _run,
        tooltip: 'Processar',
        child: Icon(Icons.translate, color: Colors.white,),
      ), // This trailing// comma makes auto-formatting nicer for build methods.
    );
  }
}
