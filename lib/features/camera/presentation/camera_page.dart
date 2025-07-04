import 'package:camera/camera.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/router/arguments/status_upload_page_arg.dart';
import 'package:beep/utils/router/router.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final bool fromchatScreen;
  const CameraPage(
      {super.key, required this.cameras, required this.fromchatScreen});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  int cmaeraoption = 0;
  @override
  void initState() {
    super.initState();

    controller =
        CameraController(widget.cameras[cmaeraoption], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      print("camera 0");
      // final player = await AudioPlayer();
      // await controller.setFlashMode(FlashMode.off);
      // // await controller.setFlashMode()
      // ref.read(CameraListProvider).shutterTaker();
      // await player.play(AssetSource('sound/shutter.mp3'));

      XFile picture = await controller.takePicture();
      print("camera 1");
      if (!widget.fromchatScreen) {
        print("camera 2");
        Navigator.pop(context, picture);
      } else {
        print("camera 3");
        Navigator.pushNamed(context, AppRoutes.statusuploadpage,
            arguments: StatusUploadPageArg(image: picture));
      }

      // ref.read(CameraListProvider).takepicture(picture);
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  // final player = AudioPlayer();

  void cameraswitch(optioms) {
    controller =
        CameraController(widget.cameras[optioms], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cmaeraoption = optioms;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: CameraPreview(
              controller,
            )),
        // Consumer(builder: (context, ref, index) {
        //   var shutter = ref.watch(CameraListProvider).shutter;
        //   return shutter
        //       ? Container(
        //           height: MediaQuery.sizeOf(context).height,
        //           color: Colors.black.withOpacity(0.5),
        //         )
        //       : const SizedBox.shrink();
        // }),
        SizedBox(
            height: 150,
            width: MediaQuery.sizeOf(context).width,
            child:
                // Consumer(builder: (context, ref, child) {
                //   return
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      // if (ref.watch(CameraListProvider).focus) {
                      //   controller.setFocusMode(FocusMode.auto);
                      // } else {
                      //   controller.setFocusMode(FocusMode.locked);
                      // }
                      // ref.read(CameraListProvider).focusSwitch();
                    },
                    icon: Icon(
                      // ref.watch(CameraListProvider).focus
                      //     ?
                      Icons.center_focus_strong_outlined,
                      // : Icons.center_focus_weak_outlined,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      // if (ref.watch(CameraListProvider).flash) {
                      //   controller.setFlashMode(FlashMode.off);
                      // } else {
                      //   controller.setFlashMode(FlashMode.torch);
                      // }
                      // ref.read(CameraListProvider).flashSwitch();
                    },
                    icon: Icon(
                      // ref.watch(CameraListProvider).flash
                      //     ?
                      Icons.flash_on,
                      // : Icons.flash_off,
                      color: Colors.white,
                    ))
              ],
            )
            // }),
            ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.75,
          bottom: 50,
          // left: MediaQuery.sizeOf(context).width / 2.5,
          // right: MediaQuery.sizeOf(context).width / 2.5,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                IconButton(
                    onPressed: () {
                      if (cmaeraoption == 1) {
                        cameraswitch(0);
                      } else {
                        cameraswitch(1);
                      }
                    },
                    icon: const Icon(
                      Icons.flip_camera_android_sharp,
                      size: 50,
                      color: Colors.white,
                    )),
                const Spacer(),
                // Consumer(builder: (context, ref, child) {
                //   return
                InkWell(
                  onTap: () async {
                    await takePicture();

                    // controller.startVideoRecording();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.transparent,
                        border: Border.all(color: yellowprimary, width: 10)),
                  ),
                ),
                // }),
                Spacer(),
                IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => PreviewPage(
                      //             controller: controller,
                      //             // picture: picture,
                      //           )),
                      // ).then((value) {
                      //   controller.resumePreview();
                      // });
                    },
                    icon: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.white,
                    )),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
