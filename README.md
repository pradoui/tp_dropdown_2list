# Dropdown2List

A customizable dropdown widget for Flutter that supports dual-category item selection with both single and multi-select capabilities.

## Features

- **Dual Category Support**: Display items from two separate categories with custom labels
- **Flexible Selection Modes**: Toggle between single selection and multi-select with checkboxes
- **Smooth Animations**: Elegant fade-in/fade-out and scale animations for opening/closing
- **Interactive Hover Effects**: Visual feedback when hovering over items
- **Customizable Styling**: Fully customizable colors, borders, text styles, and dimensions
- **ID-Text Mapping**: Each displayed item maps to an internal ID for data management
- **Responsive Design**: Adapts to different screen sizes with overflow handling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tp_dropdown_2list: ^1.0.3
```

## Usage

### Basic Single Selection

```dart
import 'package:tp_dropdown_2list/dropdown_2list.dart';

Dropdown2List(
  labelFirstList: 'Category A',
  labelSecondList: 'Category B',
  idItemsFirstList: ['id1', 'id2', 'id3'],
  idItemsSecondList: ['id4', 'id5', 'id6'],
  itemsFirstList: ['Item 1', 'Item 2', 'Item 3'],
  itemsSecondList: ['Item 4', 'Item 5', 'Item 6'],
  hintText: 'Select an option',
  backgroundColor: Colors.blue.shade50,
  dropdownBackgroundColor: Colors.white,
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  ),
  width: 300,
  height: 50,
  onItemSelected: (id, text) => print('Selected: $id - $text'),
)
```

### Multi-Select Mode

```dart
Dropdown2List(
  isMultiSelect: true,
  onMultiItemSelected: (ids, texts) => print('Selected IDs: $ids'),
  // ... other parameters
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `labelFirstList` | String | Yes | Label for the first category |
| `labelSecondList` | String | Yes | Label for the second category |
| `idItemsFirstList` | List<String> | Yes | IDs for first category items |
| `idItemsSecondList` | List<String> | Yes | IDs for second category items |
| `itemsFirstList` | List<String> | Yes | Display text for first category |
| `itemsSecondList` | List<String> | Yes | Display text for second category |
| `hintText` | String | Yes | Placeholder text when nothing is selected |
| `backgroundColor` | Color | Yes | Background color of the main container |
| `dropdownBackgroundColor` | Color | Yes | Background color of the dropdown menu |
| `textStyle` | TextStyle | Yes | Text styling for the selected value |
| `width` | double | Yes | Width of the dropdown |
| `height` | double | Yes | Height of the dropdown |
| `isMultiSelect` | bool | No | Enable multi-select mode (default: false) |
| `onItemSelected` | Function(String, String)? | No | Callback for single selection |
| `onMultiItemSelected` | Function(List<String>, List<String>)? | No | Callback for multi-selection |
| `border` | BoxBorder? | No | Custom border styling |
| `borderRadius` | BorderRadius? | No | Border radius for the container |
| `dropdownIcon` | IconData | No | Custom dropdown arrow icon |
| `hoverColor` | Color? | No | Custom color for item hover effect |

## Callbacks

### Single Selection
```dart
onItemSelected: (String id, String text) {
  // id: The internal ID of the selected item
  // text: The display text of the selected item
}
```

### Multi-Selection
```dart
onMultiItemSelected: (List<String> ids, List<String> texts) {
  // ids: List of selected item IDs
  // texts: List of selected item display texts
}
```

## Visual Structure

The dropdown displays items in the following order:
1. **First Category Label** (e.g., "Category A")
2. **First Category Items** (with optional checkboxes in multi-select mode)
3. **Second Category Label** (e.g., "Category B")
4. **Second Category Items** (with optional checkboxes in multi-select mode)

## Example

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dropdown2List Example')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Dropdown2List(
            labelFirstList: 'Funil Padrão',
            labelSecondList: 'Pós Venda',
            idItemsFirstList: ['032141351313', '456313874613', '12357643521'],
            idItemsSecondList: [
              '134341354421',
              '3643513254384',
              '03254385131354',
              '20245315135',
              '34431374813',
              '3435416531',
            ],
            itemsFirstList: [
              'Interesse Inicial',
              'Interesse de Compra',
              'Vendido',
            ],
            itemsSecondList: [
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
            width: 300,
            height: 50,
            hoverColor: Colors.blue.shade100,
            onItemSelected: (id, text) {
              print('Selected: $id - $text');
            },
          ),
        ),
      ),
    );
  }
}
```

## Dependencies

- Flutter SDK
- No additional external dependencies required

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

If you find any issues, please report them on the [GitHub repository](https://github.com/pradoui/tp_dropdown_2list/issues).
