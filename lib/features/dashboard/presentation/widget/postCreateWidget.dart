import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/router/arguments/camera_page_argument.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

// class MediaPickerScreen extends StatelessWidget {
//   const MediaPickerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: primaryBackground,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 35.0),
//         child: Column(
//           children: [
//             /// 🔹 Top Bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               child: Row(
//                 children: [
//                   const Icon(Icons.close, color: Colors.white),
//                   const Spacer(),
//                   Row(
//                     children: const [
//                       Text(
//                         'recents',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.keyboard_arrow_down, color: Colors.white),
//                     ],
//                   ),
//                   const Spacer(),
//                   const Icon(Icons.arrow_forward, color: Colors.yellow),
//                 ],
//               ),
//             ),

//             /// 🔹 Selected Image Preview
//             AspectRatio(
//               aspectRatio: 1,
//               child: Image.network(
//                 'https://picsum.photos/600/600',
//                 fit: BoxFit.cover,
//               ),
//             ),

//             /// 🔹 Select Multiple Row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white54),
//                     ),
//                     child:
//                         const Icon(Icons.loop, color: Colors.white, size: 16),
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade900,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(Icons.grid_view, color: Colors.white, size: 16),
//                         SizedBox(width: 6),
//                         Text(
//                           'SELECT MULTIPLE',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             /// 🔹 Image Grid
//             Expanded(
//               child: GridView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: 20,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 1,
//                   crossAxisSpacing: 1,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Image.network(
//                     'https://picsum.photos/300/300?random=$index',
//                     fit: BoxFit.cover,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:beep/utils/constants/color_constants.dart';

class MediaPickerScreen extends StatefulWidget {
  const MediaPickerScreen({super.key});

  @override
  State<MediaPickerScreen> createState() => _MediaPickerScreenState();
}

class _MediaPickerScreenState extends State<MediaPickerScreen> {
  List<AssetEntity> images = [];
  List<AssetEntity> selectedImages = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  /// 🔐 Permission + Fetch Images
  Future<void> loadImages() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (!result.hasAccess) {
      await PhotoManager.openSetting();
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    if (albums.isEmpty) return;

    images = await albums.first.getAssetListPaged(
      page: 0,
      size: 200,
    );

    if (images.isNotEmpty) {
      selectedImages.add(images.first);
    }

    setState(() {});
  }

  /// 🖼️ Select / Unselect Image
  void onImageTap(AssetEntity asset) {
    setState(() {
      if (selectedImages.contains(asset)) {
        selectedImages.remove(asset);
      } else {
        selectedImages.add(asset);
      }
    });
  }

  /// 📸 Open Camera
  Future<void> openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    Navigator.pushNamed(
      context,
      AppRoutes.cameraScreen,
      arguments: CameraPageArgument(
        cameras: cameras,
        fromchatScreen: true,
      ),
    );
    // TODO: Replace with your camera screen
    // Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()));
    debugPrint('Open Camera');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackground,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            /// 🔹 Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: yellowprimary),
                  ),
                  const Spacer(),
                  Text(
                    'Pick Image',
                    style: TextStyleHelper.mediumStyle(
                      color: primaryTextColor,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color:
                        selectedImages.isNotEmpty ? Colors.yellow : Colors.grey,
                  ),
                ],
              ),
            ),

            /// 🔹 Selected Image Preview
            AspectRatio(
              aspectRatio: 1,
              child: selectedImages.isEmpty
                  ? const ColoredBox(color: Colors.black12)
                  : AssetEntityImage(
                      selectedImages.last,
                      thumbnailSize: const ThumbnailSize(600, 600),
                      fit: BoxFit.cover,
                    ),
            ),

            /// 🔹 Select Multiple Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54),
                    ),
                    child:
                        const Icon(Icons.loop, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.grid_view, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'SELECT MULTIPLE',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Gallery Grid + Camera Tile
            Expanded(
              child: images.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: images.length + 1, // +1 for camera
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) {
                        /// 📸 CAMERA TILE (FIRST)
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () => openCamera(context),
                            child: Container(
                              color: Colors.black,
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          );
                        }

                        /// 🖼️ GALLERY IMAGES
                        final asset = images[index - 1];
                        final isSelected = selectedImages.contains(asset);
                        final selectedIndex = selectedImages.indexOf(asset);

                        return GestureDetector(
                          onTap: () => onImageTap(asset),
                          child: Stack(
                            children: [
                              /// Image
                              SizedBox.expand(
                                child: AssetEntityImage(
                                  asset,
                                  thumbnailSize: const ThumbnailSize(300, 300),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              /// Yellow Border
                              if (isSelected)
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.yellow,
                                      width: 3,
                                    ),
                                  ),
                                ),

                              /// Selection Number
                              if (isSelected)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${selectedIndex + 1}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
