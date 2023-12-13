import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/screens/dashboard/body_temperature/manual_body_temp_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:collection/collection.dart';

class BodyTempTimelineTab extends StatelessWidget {
  const BodyTempTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.amber.shade700;
    return GetBuilder<BodyTemperatureController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Column(
          children: [
            HorizontalIconedDataTileAdd(
              baseColor: baseColor,
              data:
                  "${controller.tempDataSortedByDate.lastOrNull?.pursedTempC.toStringAsFixed(1) ?? 0.0}",
              unit: "Celsisus",
              iconPath: "assets/images/mnu_bt_l.webp",
              seconderyWidget: Image.asset(
                "assets/icons/devices/bluetooth_glucose_disconnect.webp",
              ),
              onAddClick: () {
                Get.to(() => const ManualBodyTempWidget());
              },
            ),
          ],
        ),
      );
    });
  }
}
