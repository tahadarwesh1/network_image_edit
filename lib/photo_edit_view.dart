import 'package:flutter/material.dart';
import 'package:network_image_options/draggable_text_widget.dart';
import 'package:photo_view/photo_view.dart';

import 'color_picker_widget.dart';

import 'network_image_options.dart';
import 'utils.dart';

class PhotoEditView extends StatefulWidget {
  const PhotoEditView({super.key});

  @override
  State<PhotoEditView> createState() => _PhotoEditViewState();
}

class _PhotoEditViewState extends State<PhotoEditView> {
  bool isShowColorPicker = false;
  showColorPicker() {
    setState(() {
      isShowColorPicker = !isShowColorPicker;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  RepaintBoundary(
                    key: Utils.globalKey,
                    child: Stack(
                      children: [
                        Container(
                          constraints: const BoxConstraints.expand(),
                          child: ValueListenableBuilder(
                            valueListenable: shadedColor,
                            builder: ((context, value, child) => ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    shadedColor.value,
                                    BlendMode.color,
                                  ),
                                  child: PhotoView(
                                    imageProvider: const NetworkImage(
                                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const DraggableTextWidget(),
                      ],
                    ),
                  ),
                  NetworkImageOptions(
                    showColorPicker: showColorPicker,
                  ),
                ],
              ),
            ),
            if (isShowColorPicker)
              CustomColorPicker(
                MediaQuery.of(context).size.width,
              ),
          ],
        ),
      ),
    );
  }
}
