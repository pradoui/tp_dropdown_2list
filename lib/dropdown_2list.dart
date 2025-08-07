import 'package:flutter/material.dart';

class Dropdown2List extends StatefulWidget {
  final List<String> labels;
  final List<List<String>> idItemsLists;
  final List<List<String>> itemsLists;
  final String? initialValue;
  final String hintText;
  final Color backgroundColor;
  final Color dropdownBackgroundColor;
  final TextStyle textStyle;
  final Color labelColor;
  final IconData dropdownIcon;
  final double width;
  final double height;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Function(String id, String text)? onItemSelected;
  final Function(List<String> ids, List<String> texts)? onMultiItemSelected;
  final bool isMultiSelect;
  final Color? hoverColor;

  const Dropdown2List({
    super.key,
    required this.labels,
    required this.idItemsLists,
    required this.itemsLists,
    required this.backgroundColor,
    required this.dropdownBackgroundColor,
    required this.textStyle,
    required this.labelColor,
    required this.dropdownIcon,
    this.initialValue,
    required this.hintText,
    required this.width,
    required this.height,
    this.border,
    this.borderRadius,
    this.onItemSelected,
    this.onMultiItemSelected,
    this.isMultiSelect = false,
    this.hoverColor,
  });

  @override
  State<Dropdown2List> createState() => _Dropdown2ListState();
}

class _Dropdown2ListState extends State<Dropdown2List>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  OverlayEntry? _dropdownOverlay;
  final GlobalKey _containerKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;
  final ValueNotifier<int?> _hoveredIndexNotifier = ValueNotifier<int?>(null);
  String? _selectedValue;
  final Set<String> _selectedIds = <String>{};
  final Set<String> _selectedTexts = <String>{};

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _opacityAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _scaleAnim = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoveredIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: openDropdown,
        child: Container(
          key: _containerKey,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isHovered
                ? widget.backgroundColor.withValues(alpha: 0x99)
                : widget.backgroundColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
            border: widget.border,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: widget.textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(widget.dropdownIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDisplayText() {
    if (widget.isMultiSelect) {
      if (_selectedTexts.isEmpty) {
        return widget.hintText;
      }
      if (_selectedTexts.length == 1) {
        return _selectedTexts.first;
      }
      return '${_selectedTexts.length} itens selecionados';
    } else {
      return _selectedValue != null && _selectedValue!.isNotEmpty
          ? _selectedValue!
          : widget.hintText;
    }
  }

  void _selectItem(String id, String text) {
    if (widget.isMultiSelect) {
      setState(() {
        if (_selectedIds.contains(id)) {
          _selectedIds.remove(id);
          _selectedTexts.remove(text);
        } else {
          _selectedIds.add(id);
          _selectedTexts.add(text);
        }
      });
      widget.onMultiItemSelected?.call(
        _selectedIds.toList(),
        _selectedTexts.toList(),
      );
    } else {
      setState(() {
        _selectedValue = text;
      });
      widget.onItemSelected?.call(id, text);
      closeDropdown();
    }
  }

  bool _isItemSelected(String id) {
    return _selectedIds.contains(id);
  }

  void openDropdown() async {
    if (_dropdownOverlay != null) return;
    final RenderBox renderBox =
        _containerKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // Calcular se há espaço suficiente abaixo
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final spaceBelow = screenHeight - offset.dy - size.height;
    const dropdownHeight = 250.0; // Altura máxima do dropdown
    final shouldOpenUp = spaceBelow < dropdownHeight + 20; // 20px de margem

    // Calcular posição horizontal ideal
    double leftPosition = offset.dx;
    if (offset.dx + widget.width > screenWidth - 20) {
      // Se o dropdown vai estourar à direita, ajustar para a esquerda
      leftPosition = screenWidth - widget.width - 20;
    }
    if (leftPosition < 20) {
      // Se ainda estiver muito à esquerda, limitar a 20px da borda
      leftPosition = 20;
    }

    _controller.value = 0;
    _hoveredIndexNotifier.value = null;

    _dropdownOverlay = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: closeDropdown,
        child: Stack(
          children: [
            Positioned(
              left: leftPosition,
              top: shouldOpenUp
                  ? offset.dy - dropdownHeight - 8
                  : offset.dy + size.height + 8,
              width: widget.width,
              child: Material(
                elevation: 4,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  decoration: BoxDecoration(
                    color: widget.dropdownBackgroundColor,
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(12),
                    border: widget.border,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.labels.length +
                        widget.itemsLists
                            .fold(0, (prev, list) => prev + list.length),
                    itemBuilder: (context, index) {
                      int runningIndex = 0;
                      for (int listIdx = 0;
                          listIdx < widget.labels.length;
                          listIdx++) {
                        // Label
                        if (index == runningIndex) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Text(
                              widget.labels[listIdx],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: widget.labelColor,
                              ),
                            ),
                          );
                        }
                        runningIndex++;
                        // Itens
                        for (int itemIdx = 0;
                            itemIdx < widget.itemsLists[listIdx].length;
                            itemIdx++) {
                          if (index == runningIndex) {
                            final id = widget.idItemsLists[listIdx][itemIdx];
                            final text = widget.itemsLists[listIdx][itemIdx];
                            return AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _opacityAnim.value,
                                  child: Transform.scale(
                                    scale: _scaleAnim.value,
                                    child: ValueListenableBuilder<int?>(
                                      valueListenable: _hoveredIndexNotifier,
                                      builder: (context, hoveredIndex, child) {
                                        final bool isItemHovered =
                                            hoveredIndex == index;
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: isItemHovered
                                                ? (widget.hoverColor ??
                                                    Colors.blue.shade50)
                                                : Colors.transparent,
                                          ),
                                          child: MouseRegion(
                                            onEnter: (_) {
                                              _hoveredIndexNotifier.value =
                                                  index;
                                            },
                                            onExit: (_) {
                                              _hoveredIndexNotifier.value =
                                                  null;
                                            },
                                            child: ListTile(
                                              leading: widget.isMultiSelect
                                                  ? Checkbox(
                                                      value:
                                                          _isItemSelected(id),
                                                      onChanged: (_) =>
                                                          _selectItem(id, text),
                                                    )
                                                  : null,
                                              title: Text(
                                                text,
                                                style: widget.textStyle,
                                              ),
                                              onTap: () =>
                                                  _selectItem(id, text),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          runningIndex++;
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Overlay.of(context).insert(_dropdownOverlay!);
    await _controller.forward();
  }

  void closeDropdown() async {
    await _controller.reverse();
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    _hoveredIndexNotifier.value = null;
  }
}
