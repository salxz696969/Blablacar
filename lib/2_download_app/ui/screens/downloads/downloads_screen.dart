import 'package:blabcar/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import 'package:flutter/material.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widgets/download_controler.dart';

class DownloadsScreen extends StatelessWidget {
  // Create the list of fake ressources
  final ChangeColorService changeColorService;
  final List<Ressource> ressources;
  final List<DownloadController> controllers;

  DownloadsScreen({
    super.key,
    required this.changeColorService,
    required this.ressources,
    required this.controllers,
  }) {
    // Create a controllers for each ressource
    for (Ressource ressource in ressources) {
      controllers.add(DownloadController(ressource));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: changeColorService.currentThemeColor.backgroundColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Downloads",
            style: AppTextStyles.heading.copyWith(
              color: changeColorService.currentThemeColor.color,
            ),
          ),

          SizedBox(height: 50),

          // TODO - Add the Download tiles
          for (int i = 0; i < ressources.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DownloadTile(
                controller: controllers[i],
                title: ressources[i].name,
                fileSize: ressources[i].size,
              ),
            ),
        ],
      ),
    );
  }
}
