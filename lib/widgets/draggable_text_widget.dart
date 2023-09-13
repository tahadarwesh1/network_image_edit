import 'package:flutter/material.dart';

class DraggableTextWidget extends StatefulWidget {
  const DraggableTextWidget({super.key});

  @override
  _DraggableTextWidgetState createState() => _DraggableTextWidgetState();
}

class _DraggableTextWidgetState extends State<DraggableTextWidget> {
  Offset offset = Offset.zero;
  double angle = 0.0;
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // scale = scale + details.delta.dy / 100;
            offset = Offset(
                offset.dx + details.delta.dx, offset.dy + details.delta.dy);
            angle = angle + details.delta.dx / 100;
          });
        },
        child: SizedBox(
          width: 300,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Transform.rotate(
                angle: angle,
                child: Transform.scale(
                  // angle: angle,
                  scale: scale,
                  child: const Text(
                    "You Think You Are Funny But You Are Not",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
