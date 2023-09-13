import 'package:flutter/material.dart';
import 'package:network_image_options/utils/utils.dart';

class NetworkImageOptions extends StatelessWidget {
  final Function? showColorPicker;
  const NetworkImageOptions({super.key, this.showColorPicker});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.white,
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(Icons.color_lens),
          color: Colors.white,
          onPressed: () {
            showColorPicker!();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(Icons.download),
          color: Colors.white,
          onPressed: () {
            Utils.convertWidgetToImage();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(Icons.picture_as_pdf_sharp),
          color: Colors.white,
          onPressed: () {
            Utils.savePDF();
          },
        ),
      ],
    );
  }
}
