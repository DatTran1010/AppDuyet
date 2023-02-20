// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/colors.dart';

import '../../repositories/login_repository.dart';

class FilterDropdownTest extends StatefulWidget {
  FilterDropdownTest(Key? key, this.list, this.ref) : super(key: key);
  List<String>? list;
  WidgetRef ref;
  @override
  State<FilterDropdownTest> createState() => _FilterDropdownTest();
}

// List<Map> _myData = [
//   {'id': 1, 'name': 'Đã duyệt'},
//   {'id': 0, 'name': 'Chưa duyệt'},
// ];

class _FilterDropdownTest extends State<FilterDropdownTest> {
  var _selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selected = widget.ref.watch(LoginNotifier.provider).nameDatabase;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: VietSoftColor.loginTextColor),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        hint: const Text('Chọn Database'),
        items: widget.list?.map<DropdownMenuItem<String>>((element) {
          return DropdownMenuItem<String>(
            value: element,
            child: Text(element,
                style: const TextStyle(color: VietSoftColor.loginTextColor)),
          );
        }).toList(),
        onChanged: (newValue) {
          widget.ref
              .read(LoginNotifier.provider.notifier)
              .setNameDataBase(newValue);
          setState(() {
            _selected = newValue;
          });
        },
        value: _selected,
        underline: const SizedBox(),
        isExpanded: true,
      ),
    );
  }
}
