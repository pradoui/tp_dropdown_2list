import 'package:flutter/material.dart';

class Dropdown2List extends StatefulWidget {
  final String labelFirstList;
  final String labelSecondList;
  final List<String> idItemsFirstList;
  final List<String> idItemsSecondList;
  final List<String> itemsFirstList;
  final List<String> itemsSecondList;
  final String? initialValue;
  final String hintText;
  final Color backgroundColor;
  final Color dropdownBackgroundColor;
  final TextStyle textStyle;
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
    required this.labelFirstList,
    required this.labelSecondList,
    required this.idItemsFirstList,
    required this.idItemsSecondList,
    required this.itemsFirstList,
    required this.itemsSecondList,
    required this.backgroundColor,
    required this.dropdownBackgroundColor,
    required this.textStyle,
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
    final spaceRight = screenWidth - offset.dx;
    final dropdownHeight = 250.0; // Altura máxima do dropdown
    final shouldOpenUp = spaceBelow < dropdownHeight + 20; // 20px de margem
    final shouldOpenLeft = spaceRight < widget.width + 20; // 20px de margem

    _controller.value = 0;
    _hoveredIndexNotifier.value = null;

    _dropdownOverlay = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: closeDropdown,
        child: Stack(
          children: [
            Positioned(
              left: shouldOpenLeft
                  ? offset.dx + size.width - widget.width
                  : offset.dx,
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
                    itemCount: 2 +
                        widget.itemsFirstList.length +
                        widget.itemsSecondList.length,
                    itemBuilder: (context, index) {
                      // Primeiro label
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            widget.labelFirstList,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      // Itens da primeira lista
                      if (index <= widget.itemsFirstList.length) {
                        final itemIndex = index - 1;
                        final id = widget.idItemsFirstList[itemIndex];
                        final text = widget.itemsFirstList[itemIndex];
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
                                          _hoveredIndexNotifier.value = index;
                                        },
                                        onExit: (_) {
                                          _hoveredIndexNotifier.value = null;
                                        },
                                        child: ListTile(
                                          leading: widget.isMultiSelect
                                              ? Checkbox(
                                                  value: _isItemSelected(id),
                                                  onChanged: (_) =>
                                                      _selectItem(id, text),
                                                )
                                              : null,
                                          title: Text(
                                            text,
                                            style: widget.textStyle,
                                          ),
                                          onTap: () => _selectItem(id, text),
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

                      // Label da segunda lista
                      if (index == widget.itemsFirstList.length + 1) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            widget.labelSecondList,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      // Itens da segunda lista
                      final secondItemIndex =
                          index - (widget.itemsFirstList.length + 2);
                      final id = widget.idItemsSecondList[secondItemIndex];
                      final text = widget.itemsSecondList[secondItemIndex];
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
                                        _hoveredIndexNotifier.value = index;
                                      },
                                      onExit: (_) {
                                        _hoveredIndexNotifier.value = null;
                                      },
                                      child: ListTile(
                                        leading: widget.isMultiSelect
                                            ? Checkbox(
                                                value: _isItemSelected(id),
                                                onChanged: (_) =>
                                                    _selectItem(id, text),
                                              )
                                            : null,
                                        title: Text(
                                          text,
                                          style: widget.textStyle,
                                        ),
                                        onTap: () => _selectItem(id, text),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
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
