import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';

class HorizontalPictureCameraSearchBar extends StatefulWidget {
  const HorizontalPictureCameraSearchBar({
    Key? key,
    required this.searchController,
    required this.photoClick,
    required this.cameraClick,
  }) : super(key: key);
  final ValueChanged<String?> searchController;
  final VoidCallback photoClick;
  final VoidCallback cameraClick;
  @override
  State<HorizontalPictureCameraSearchBar> createState() =>
      _HorizontalPictureCameraSearchBarState();
}

class _HorizontalPictureCameraSearchBarState
    extends State<HorizontalPictureCameraSearchBar> {
  bool isTextField = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: AnimatedCrossFade(
                      crossFadeState: isTextField
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 500),
                      firstChild: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextField = true;
                            });
                          },
                          iconSize: 48,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                      secondChild: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          onSubmitted: widget.searchController,
                          textInputAction: TextInputAction.search,
                          decoration: decoration.copyWith(
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  isTextField = false;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: widget.photoClick,
                      padding: EdgeInsets.zero,
                      iconSize: 48,
                      icon: const Icon(Icons.image_sharp),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: widget.cameraClick,
                      padding: EdgeInsets.zero,
                      iconSize: 48,
                      icon: const Icon(Icons.photo_camera),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 0,
          ),
        ],
      ),
    );
  }
}
