import 'package:flutter/material.dart';

class BackLayer extends StatelessWidget {
  const BackLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _roatedBox(
          top: -100,
          left: -28,
        ),
        const _roatedBox(
          top: -100,
          left: 200,
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                        'data:image/png;base64,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'),
                  ),
                ),
                const SizedBox(height: 40),
                _backLayerButton(
                  title: 'Upload Prescription',
                  icon: Icons.upload,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ignore: camel_case_types
class _roatedBox extends StatelessWidget {
  final double top;
  final double left;
  const _roatedBox({
    required this.top,
    required this.left,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: -0.5,
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _backLayerButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const _backLayerButton({
    required this.title,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed, icon: Icon(icon), label: Text(title));
  }
}
