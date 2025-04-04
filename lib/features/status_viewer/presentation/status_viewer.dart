import 'dart:async';

import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class StatusViewer extends StatefulWidget {
  final List<Status> statusList;
  int index;
  // final String image;
  StatusViewer(
      {super.key,
      // required this.image,
      required this.index,
      required this.statusList});

  @override
  State<StatusViewer> createState() => _StatusViewerState();
}

class _StatusViewerState extends State<StatusViewer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (widget.statusList[widget.index].statusImage == null) {
      isimageType.value = false;
    } else {
      isimageType.value = true;
    }
    progresscontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..forward();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        if (widget.index < widget.statusList.length - 1) {
          widget.index = widget.index + 1;
          progresscontroller.reset();
          if (widget.statusList[widget.index].statusImage == null) {
            isimageType.value = false;
          } else {
            isimageType.value = true;
          }
          controller.animateToPage(widget.index + 1,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInToLinear);
          progresscontroller.forward();
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  // Offset offset = Offset.zero;

  // ValueNotifier<Offset> offset = ValueNotifier(Offset.zero);
  final PageController controller = PageController();
  late AnimationController progresscontroller;
  ValueNotifier<bool> isimageType = ValueNotifier(false);

  @override
  void dispose() {
    progresscontroller.stop();
    progresscontroller.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isimageType,
        builder: (context, typevalue, _) {
          return Scaffold(
            backgroundColor: !typevalue ? yellowprimary : primaryBackground,
            body: Builder(builder: (context) {
              return PageView.builder(
                itemCount: widget.statusList.length,
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {},
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      widget.index = widget.index - 1;
                      controller.animateToPage(widget.index,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInToLinear);

                      progresscontroller.reset();
                      progresscontroller.forward();
                    },
                    onTap: () {
                      if (widget.index + 1 != widget.statusList.length) {
                        widget.index = widget.index + 1;
                        progresscontroller.reset();

                        controller.animateToPage(widget.index,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInToLinear);
                        progresscontroller.forward();
                      }
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          child: SafeArea(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: yellowprimary, width: 1),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                widget.statusList[widget.index]
                                                        .userPhotos ??
                                                    "",
                                              ),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.statusList[widget.index]
                                              .username ??
                                          "",
                                      style: TextStyleHelper.boldStyle(
                                          color: primaryTextColor,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AnimatedBuilder(
                                  animation: progresscontroller,
                                  builder: (context, child) {
                                    return LinearProgressIndicator(
                                      value: progresscontroller.value,
                                      backgroundColor: Colors.white,
                                      color: !typevalue
                                          ? primaryBackground
                                          : yellowprimary, // WhatsApp theme
                                      minHeight: 4,
                                    );
                                  },
                                ),
                                // Container(
                                //   width: MediaQuery.sizeOf(context).width,
                                //   height: 3,
                                //   color: yellowprimary,
                                // )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        SafeArea(
                          child: widget.statusList[widget.index].statusImage !=
                                  null
                              ? Image.network(
                                  widget.statusList[widget.index].statusImage ??
                                      "",
                                  fit: BoxFit.fill,
                                )
                              : Center(
                                  child: Text(
                                    widget
                                        .statusList[widget.index].stausMessage!,
                                    textAlign: TextAlign.center,
                                    style: TextStyleHelper.boldStyle(
                                        fontSize: 50, color: primaryTextColor),
                                  ),
                                ),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                },
                // children:
              );
            }),
          );
        });
  }
}
