

# Dropdown2List

A customizable dropdown widget for Flutter that now supports multiple content lists, allowing users to pass as many lists as they want, with single or multi-select options.



## Main Features

- **Multiple List Support**: Pass as many lists as you want, each with its own label, IDs, and texts
- **Single or Multi-Select**: Switch between single selection or multi-select with checkboxes
- **Smooth Animations**: Fade-in/fade-out and scale when opening/closing
- **Hover Effect**: Visual feedback when hovering over items
- **Full Customization**: Colors, borders, text styles, and dimensions
- **ID-Text Mapping**: Each item displays text and has an internal ID
- **Responsive Design**: Adapts to different screen sizes


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tp_dropdown_2list: ^1.0.3
```

## Usage



### Example usage with multiple lists

```dart
import 'package:tp_dropdown_2list/dropdown_2list.dart';

Dropdown2List(
  labels: const ['Main Funnel', 'After Sales', 'Finance'],
  idItemsLists: const [
    ['032141351313', '456313874613', '12357643521'],
    ['134341354421', '3643513254384'],
    ['id_fin_1', 'id_fin_2'],
  ],
  itemsLists: const [
    ['Initial Interest', 'Purchase Interest', 'Sold'],
    ['After Sales', 'Repurchase Interest'],
    ['Invoice', 'Charge'],
  ],
  hintText: 'Select a stage',
  backgroundColor: Colors.blue.shade50,
  dropdownBackgroundColor: Colors.white,
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  ),
  width: 300,
  height: 50,
  labelColor: Colors.lightBlueAccent,
  onItemSelected: (id, text) => print('Selected: $id - $text'),
)
```


### Multi-select mode

```dart
Dropdown2List(
  labels: const ['Funnel', 'Finance'],
  idItemsLists: const [
    ['id1', 'id2'],
    ['id3'],
  ],
  itemsLists: const [
    ['Item 1', 'Item 2'],
    ['Item 3'],
  ],
  labelColor: Colors.lightBlueAccent,
  isMultiSelect: true,
  onMultiItemSelected: (ids, texts) => print('Selected IDs: $ids'),
  // ... other parameters
)
```

## Parameters



| Parameter               | Type                              | Required    | Description |
|-------------------------|-----------------------------------|-------------|-------------|
| `labels`                | List<String>                      | Yes         | List of labels for each item group |
| `idItemsLists`          | List<List<String>>                | Yes         | List of ID lists for each group |
| `itemsLists`            | List<List<String>>                | Yes         | List of text lists for each group |
| `hintText`              | String                            | Yes         | Placeholder text when nothing is selected |
| `backgroundColor`       | Color                             | Yes         | Background color of the main container |
| `dropdownBackgroundColor`| Color                            | Yes         | Background color of the dropdown menu |
| `textStyle`             | TextStyle                         | Yes         | Text style for the selected value |
| `width`                 | double                            | Yes         | Dropdown width |
| `height`                | double                            | Yes         | Dropdown height |
| `labelColor`            | Color                             | Yes         | Color of the group label text |
| `isMultiSelect`         | bool                              | No          | Enables multi-select mode (default: false) |
| `onItemSelected`        | Function(String, String)?         | No          | Callback for single selection |
| `onMultiItemSelected`   | Function(List<String>, List<String>)? | No     | Callback for multi-selection |
| `border`                | BoxBorder?                        | No          | Custom border styling |
| `borderRadius`          | BorderRadius?                     | No          | Border radius for the container |
| `dropdownIcon`          | IconData                          | No          | Custom dropdown arrow icon |
| `hoverColor`            | Color?                            | No          | Custom color for item hover effect |


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

The dropdown displays item groups in the order of the provided lists:
1. **Group label** (e.g., "Main Funnel")
2. **Group items** (with checkbox if multi-select)
3. ... (repeats for each group)



## Full Example

```dart
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
            labels: const ['Main Funnel', 'After Sales'],
            idItemsLists: const [
              ['032141351313', '456313874613', '12357643521'],
              ['134341354421', '3643513254384', '03254385131354', '20245315135', '34431374813', '3435416531'],
            ],
            itemsLists: const [
              ['Initial Interest', 'Purchase Interest', 'Sold'],
              ['After Sales', 'Repurchase Interest', 'Payment', 'Awaiting Shipment', 'Payment', 'No Interest'],
            ],
            hintText: 'Select a stage',
            backgroundColor: Colors.blue.shade50,
            dropdownBackgroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            width: 300,
            height: 50,
            labelColor: Colors.lightBlueAccent,
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
