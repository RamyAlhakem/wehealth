import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
// import 'package:pdfx/pdfx.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/more/user_manual/pdf_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/user_manual/youtube_video_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../../global/widgets/ios_close_appbar.dart';

class UserManualScreen extends StatefulWidget {
  const UserManualScreen({Key? key}) : super(key: key);

  @override
  State<UserManualScreen> createState() => _UserManualScreenState();
}

class _UserManualScreenState extends State<UserManualScreen> {
  List<String> videoIds = [
    "B0_5U3aQQIw",
    "eH3xpFUkdQI",
    "XxWbikmczaY",
    "8d43-6KplvU",
  ];

  List<String> videoTitles = [
    "CHIEF Smart Activity And Sleep Tracker Video Guide",
    "CHIEF 智能手环产品华语使用说明视频",
    "CHIEF Smart Body Fat Video Guide",
    "CHIEF 智能体重秤产品华语使用说明视频",
  ];

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "WeHealth Guide",
      appBarColor: Colors.blue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "QUICK STEPS TO A HEALTHIER YOU!",
                textAlign: TextAlign.center,
                style: TextStyles.extraLargeTextStyle(),
              ),
            ),
          ),
          Divider(color: Colors.grey.shade800, thickness: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: ElevatedButton(
              onPressed: () async {
                const path = "assets/pdfs/trackeruserguideenglish.pdf";
                final data = await rootBundle.load(path);
                final bytes = data.buffer.asUint8List();

                final res = await _storeFile(path, bytes);
                Get.to(
                  () => PdfScreen(
                    file: res,
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "CHIEF SMART ACTIVITY AND SLEEP TRACKER USER GUIDE",
                    textAlign: TextAlign.center,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: ElevatedButton(
              onPressed: () async {
                const path = "assets/pdfs/activitytrackeruserguidechinese.pdf";
                final data = await rootBundle.load(path);
                final bytes = data.buffer.asUint8List();

                final res = await _storeFile(path, bytes);
                Get.to(
                  () => PdfScreen(
                    file: res,
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "CHIEF E",
                    textAlign: TextAlign.center,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: ElevatedButton(
              onPressed: () async {
                const path = "assets/pdfs/fatuserguideenglish.pdf";
                final data = await rootBundle.load(path);
                final bytes = data.buffer.asUint8List();

                final res = await _storeFile(path, bytes);
                Get.to(
                  () => PdfScreen(
                    file: res,
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "CHIEF SMART BODY FAT USER GUIDE",
                    textAlign: TextAlign.center,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: ElevatedButton(
              onPressed: () async {
                const path = "assets/pdfs/fatuserguidechinese.pdf";
                final data = await rootBundle.load(path);
                final bytes = data.buffer.asUint8List();

                final res = await _storeFile(path, bytes);
                Get.to(
                  () => PdfScreen(
                    file: res,
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "CHIEF ",
                    textAlign: TextAlign.center,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Video Tutorial",
            style: TextStyles.normalTextStyle(),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: videoIds.length,
              itemBuilder: (context, index) => ClickableYoutubeItem(
                title: videoTitles[index],
                videoId: videoIds[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

class ClickableYoutubeItem extends StatelessWidget {
  const ClickableYoutubeItem({
    Key? key,
    required this.title,
    required this.videoId,
  }) : super(key: key);

  final String title;
  final String videoId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(height: 12),
          Expanded(
            flex: 8,
            child: InkWell(
              onTap: () {
                Get.to(() => YouTubeVideoScreen(
                      videoId: videoId,
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorResources.colorBlack,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset("assets/icons/youtubeicon.webp"),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyles.smallTextStyle()
                      .copyWith(color: Colors.black54),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 3,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
