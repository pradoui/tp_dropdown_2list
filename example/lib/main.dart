import 'package:flutter/material.dart';
import 'package:tp_dropdown_2list/dropdown_2list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown 2List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Dropdown 2List Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Dropdown2List(
            width: 300,
            height: 50,
            labels: const ['Funil Padrão', 'Pós Venda'],
            idItemsLists: const [
              ['032141351313', '456313874613', '12357643521'],
              [
                '134341354421',
                '3643513254384',
                '03254385131354',
                '20245315135',
                '34431374813',
                '3435416531'
              ],
            ],
            itemsLists: const [
              ['Interesse Inicial', 'Interesse de Compra', 'Vendido'],
              [
                'Pós Venda',
                'Interesse de Recompra',
                'Pagamento',
                'Aguardando Envio',
                'Pagamento',
                'Sem Interesse'
              ],
            ],
            initialValue: '',
            hintText: 'Selecione uma etapa do funil',
            backgroundColor: Colors.blue.shade50,
            dropdownBackgroundColor: Colors.white,
            labelColor: Colors.lightBlueAccent,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            dropdownIcon: Icons.arrow_drop_down,
            hoverColor: Colors.blue.shade100,
            isMultiSelect: false,
            onItemSelected: (String id, String text) {
              print('ID selecionado: $id');
              print('Texto selecionado: $text');
            },
            onMultiItemSelected: (List<String> ids, List<String> texts) {
              print('IDs selecionados: $ids');
              print('Textos selecionados: $texts');
            },
          ),
        ),
      ),
    );
  }
}
