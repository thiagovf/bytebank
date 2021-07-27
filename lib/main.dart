import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferência'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
              controlador: _controladorCampoNumeroConta,
              labelText: 'Número da conta',
              hintText: '0000'),
          Editor(
              controlador: _controladorCampoValor,
              labelText: 'Valor',
              hintText: '0.00',
              icone: Icons.monetization_on),
          ElevatedButton(
            onPressed: () => _criaTransferencia(context),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$transferenciaCriada'),
          action: SnackBarAction(
            label: 'Action',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? labelText;
  final String? hintText;
  final IconData? icone;

  Editor({this.controlador, this.labelText, this.hintText, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          icon: icone == null ? null : Icon(icone),
          labelText: labelText,
          hintText: hintText,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(
            Transferencia(100.0, 1000),
          ),
          ItemTransferencia(
            Transferencia(200.0, 1000),
          ),
          ItemTransferencia(
            Transferencia(300.0, 1000),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push<Transferencia>(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );
          future.then((transferenciaRecebida) {
            debugPrint('$transferenciaRecebida');
          });
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
