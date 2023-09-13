import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Utils {
  static final GlobalKey globalKey = GlobalKey();

  static Future<Uint8List> imageAsUint8list() async {
    RenderRepaintBoundary? repaintBoundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    return uint8list;
  }

  static void convertWidgetToImage() async {
    final result = await ImageGallerySaver.saveImage(await imageAsUint8list(),
        quality: 100);
    if (result['isSuccess'] == true) {
      ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Saved to Gallery'),
        ),
      );
      Navigator.pop(globalKey.currentContext!);
    }
  }

  static Future<void> savePDF() async {
    final image = pw.MemoryImage(await imageAsUint8list());
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(image));
        }));
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(await pdf.save());
      log("file path ${file.path}");
      ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Saved to Gallery'),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
