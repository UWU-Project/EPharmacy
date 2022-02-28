import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pill_pal/providers/base_model.dart';
import 'package:pill_pal/providers/image_provider.dart';
import 'package:pill_pal/providers/text_provider.dart';
import 'package:pill_pal/view/custom_widgets.dart/display_image.dart';
import 'package:pill_pal/view/custom_widgets.dart/upload_image_button.dart';
import 'package:pill_pal/view/result_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Reader'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25.0,
          ),
          Consumer<ImageViewModel>(
            builder: (_, imageProvider, __) =>
                (imageProvider.state == CurrentState.loading)
                    ? const Center(child: CircularProgressIndicator())
                    : (imageProvider.state == CurrentState.loaded)
                        ? Column(
                            children: [
                              DisplayImage(imageProvider.image.imagePath),
                              const SizedBox(
                                height: 15.0,
                              ),
                              CustomButton(
                                  text: 'Get another image',
                                  onTap: imageProvider.getImage)
                            ],
                          )
                        : CustomButton(
                            text: 'Upload Prescription',
                            onTap: imageProvider.getImage),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Consumer2<TextViewModel, ImageViewModel>(
            builder: (_, textProvider, imageProvider, __) => ElevatedButton(
              onPressed: (imageProvider.image == null)
                  ? null
                  : () {
                      textProvider.getText();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ResultPage()));
                    },
              child: const Text('Get OCR Text'),
            ),
          ),
        ],
      ),
    );
  }
}
