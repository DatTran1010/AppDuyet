// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/logic/models/drop_down.dart';

class FilterDropdown extends StatefulWidget {
  FilterDropdown(this.list,
      {Key? key,
      this.title,
      this.onChange,
      this.resetValue = false,
      this.initValue})
      : super(key: key);
  final List<DropdownModel> list;
  String? title;
  void Function(DropdownModel? value)? onChange;
  bool resetValue;
  DropdownModel? initValue;
  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  void Function(DropdownModel? value)? get _call => widget.onChange;
  DropdownModel? _displayValue;
  bool get reset => widget.resetValue;
  @override
  void initState() {
    _displayValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: VietSoftColor.loginTextColor),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: DropdownButton<DropdownModel>(
        isExpanded: true,
        value: _displayValue,
        hint: Text(
          widget.title ?? widget.list[0].name,
        ),
        elevation: 0,
        onTap: () {
          setState(() {
            _displayValue = null;
          });
        },
        onChanged: (value) {
          _call!(value);
          setState(() {
            _displayValue = value;
          });
        },
        underline: const SizedBox(width: 1),
        items: widget.list.map<DropdownMenuItem<DropdownModel>>((element) {
          return DropdownMenuItem<DropdownModel>(
            value: element,
            child: Text(
              element.name ?? '',
              style: const TextStyle(color: VietSoftColor.loginTextColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
