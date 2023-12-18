import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/views/screens/not_found_screen.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final photos = ModalRoute.of(context)?.settings.arguments;
    if (photos == null || photos is! List<PhotoModel>) {
      return NotFoundScreen();
    }
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              itemBuilder: (_, i) {
                return CachedNetworkImage(
                  imageUrl: photos[i].url,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (_, __, ___) => Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
            Positioned(
              top: mediaQuery.viewPadding.top + 10,
              left: 10,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.chevron_left),
                label: Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
