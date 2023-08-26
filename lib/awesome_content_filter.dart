import 'package:flutter/material.dart';

/// [T] must implement [toString] in a proper way to show the filter
///
/// if initial filter is null, it resorts to all indicating no filter is applied
///
/// if onChanged produces null it indicates that no filter is applied
class ListFilteringTile<T extends Enum> extends StatefulWidget {
  const ListFilteringTile({
    super.key,
    required this.onChanged,
    this.initialFilter,
    this.allLabel = "All",
  });

  final void Function(T? type) onChanged;
  final T? initialFilter;
  final String allLabel;

  @override
  State<ListFilteringTile> createState() => _ListFilteringTileState<T>();
}

class _ListFilteringTileState<T extends Enum>
    extends State<ListFilteringTile<T>> with AutomaticKeepAliveClientMixin {
  late T? selectedType = widget.initialFilter;

  final _controller = ScrollController();

  @override
  void initState() {
    _scrollWhenLoaded();
    super.initState();
  }

  _scrollWhenLoaded() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollIntoSelectedView(selectedType);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 48,
      // width: 100,
      child: ListView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
              const SizedBox(
                width: 12,
                height: 12,
              ),
              _buildFilter(selectedType == null, null),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: VerticalDivider(
                  width: 2,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ] +
            (T as dynamic)
                .values
                .map((e) => _buildFilter(selectedType == e, e))
                .toList() +
            [
              const SizedBox(
                width: 12,
                height: 12,
              )
            ],
      ),
    );
  }

  Widget _buildFilter(bool selected, T? l) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ChoiceChip(
        key: Key(l?.name ?? widget.allLabel.toLowerCase()),
        label: Text(l?.toString() ?? widget.allLabel),
        selected: selected,
        onSelected: (s) {
          setState(() => selectedType = l);
          widget.onChanged(selectedType);
          _scrollIntoSelectedView(l);
        },
      ),
    );
  }

  void _scrollIntoSelectedView(T? l) {
    final max =
        !_controller.hasClients ? 0.0 : _controller.position.maxScrollExtent;
    double thisOffset = l == null || !_controller.hasClients
        ? 0
        : ((((T as dynamic).values).indexOf(l) + 1) /
                (T as dynamic).values.length) *
            (max + 50);
    if (thisOffset > max) thisOffset = max;
    _controller.animateTo(thisOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
