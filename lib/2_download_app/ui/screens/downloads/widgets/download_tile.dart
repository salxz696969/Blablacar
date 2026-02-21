import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  final String title;
  final int fileSize;
  final DownloadController controller;

  const DownloadTile({
    super.key,
    required this.controller,
    required this.title,
    required this.fileSize,
  });
  // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final progress = double.parse(controller.progress.toStringAsFixed(2));
        final Map<DownloadStatus, IconData> icon = {
          DownloadStatus.downloaded: Icons.folder,
          DownloadStatus.downloading: Icons.downloading,
          DownloadStatus.notDownloaded: Icons.download,
        };
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(title),
            subtitle: Text(
              "${progress * 100}% completed ${fileSize * progress} of $fileSize MB",
            ),
            trailing: InkWell(
              onTap: () {
                controller.startDownload();
              },
              child: Icon(icon[controller.status]),
            ),
          ),
        );
      },
    );
  }
}
