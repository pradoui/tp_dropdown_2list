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
      title: 'Dropdown2List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dropdown2List Example'),
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
  String? selectedId;
  String? selectedText;
  List<String> selectedIds = [];
  List<String> selectedTexts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Single Selection Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Dropdown2List(
              width: 300,
              height: 50,
              labelFirstList: 'Funil Padrão',
              labelSecondList: 'Pós Venda',
              idItemsFirstList: const [
                '032141351313',
                '456313874613',
                '12357643521'
              ],
              idItemsSecondList: const [
                '134341354421',
                '3643513254384',
                '03254385131354',
                '20245315135',
                '34431374813',
                '3435416531',
              ],
              itemsFirstList: const [
                'Interesse Inicial',
                'Interesse de Compra',
                'Vendido',
              ],
              itemsSecondList: const [
                'Pós Venda',
                'Interesse de Recompra',
                'Pagamento',
                'Aguardando Envio',
                'Pagamento',
                'Sem Interesse',
              ],
              hintText: 'Selecione uma etapa do funil',
              backgroundColor: Colors.blue.shade50,
              dropdownBackgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              dropdownIcon: Icons.arrow_drop_down,
              hoverColor: Colors.blue.shade100,
              onItemSelected: (id, text) {
                setState(() {
                  selectedId = id;
                  selectedText = text;
                });
                // ignore: avoid_print
                print('Single Selection - ID: $id, Text: $text');
              },
            ),
            const SizedBox(height: 20),
            if (selectedId != null)
              Text('Selected: $selectedText (ID: $selectedId)'),
            const SizedBox(height: 40),
            const Text(
              'Multi-Selection Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Dropdown2List(
              width: 300,
              height: 50,
              labelFirstList: 'Categorias',
              labelSecondList: 'Subcategorias',
              idItemsFirstList: const ['cat1', 'cat2', 'cat3'],
              idItemsSecondList: const ['sub1', 'sub2', 'sub3', 'sub4'],
              itemsFirstList: const [
                'Eletrônicos',
                'Roupas',
                'Livros',
              ],
              itemsSecondList: const [
                'Smartphones',
                'Notebooks',
                'Camisetas',
                'Calças',
              ],
              hintText: 'Selecione múltiplas opções',
              backgroundColor: Colors.green.shade50,
              dropdownBackgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              dropdownIcon: Icons.arrow_drop_down,
              hoverColor: Colors.green.shade100,
              isMultiSelect: true,
              onMultiItemSelected: (ids, texts) {
                setState(() {
                  selectedIds = ids;
                  selectedTexts = texts;
                });
                // ignore: avoid_print
                print('Multi Selection - IDs: $ids, Texts: $texts');
              },
            ),
            const SizedBox(height: 20),
            if (selectedIds.isNotEmpty)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Items:'),
                ],
              ),
            if (selectedIds.isNotEmpty)
              ...selectedTexts.map((text) => Text('• $text')),
          ],
        ),
      ),
    );
  }
}
