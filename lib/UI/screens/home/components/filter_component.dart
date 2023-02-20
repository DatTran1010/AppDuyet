import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/components/drop_down_button.dart';
import 'package:viet_soft/UI/components/vietsoft_divider.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/screens/home/components/date_field.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/home_repository.dart';

class FilterComponent extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  FilterComponent(this.user);
  final User user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(HomeNotifier.provider(user));

    final documentType = ref.watch(documentTypeProvider(user));
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: DateField(
                title: ResString.fromDate,
                date: provider.dateFrom ??
                    DateTime.now().add(const Duration(days: -60)),
                onTap: () {
                  ref.read(RequestNotifier.provider(user).notifier).isLoading =
                      true;
                  DatePicker.showDatePicker(context,
                      currentTime: provider.dateFrom,
                      maxTime: provider.dateTo ?? DateTime.now(),
                      onConfirm: (time) {
                    ref
                        .read(HomeNotifier.provider(user).notifier)
                        .setDateFrom(time);
                  });
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: DateField(
                    title: ResString.toDate,
                    date: provider.dateTo ?? DateTime.now(),
                    onTap: () {
                      ref
                          .read(RequestNotifier.provider(user).notifier)
                          .isLoading = true;
                      DatePicker.showDatePicker(context,
                          minTime: provider.dateFrom,
                          maxTime: DateTime.now(),
                          currentTime: provider.dateTo, onConfirm: (time) {
                        ref
                            .read(HomeNotifier.provider(user).notifier)
                            .setDateTo(time);
                      });
                    }))
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: VietSoftDivider(),
        ),
        //const VietSoftTextField(hintText: ResString.inputDocType)
        documentType.when(
          data: (data) => FilterDropdown(
            data,
            initValue: provider.dtlId,
            onChange: (value) {
              ref.read(RequestNotifier.provider(user).notifier).isLoading =
                  true;
              ref.read(HomeNotifier.provider(user).notifier).setDtlId(value!);
            },
          ),
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        )
      ],
    );
  }
}
