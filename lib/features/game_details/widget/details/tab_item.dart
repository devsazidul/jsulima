import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TabItem extends StatelessWidget {
  final String label;
  final int index;
  final Function onTap;
  final RxInt selectedIndex;

  const TabItem({
    super.key,
    required this.label,
    required this.index,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: TextStyle(
                color:
                    selectedIndex.value == index
                        ? Color(0xFFCA0101)
                        : Color(0xFFABABAB),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            SizedBox(height: 6),
          ],
        );
      }),
    );
  }
}
