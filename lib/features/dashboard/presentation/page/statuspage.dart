import 'package:beep/features/dashboard/data/model/status_reponse.dart';
import 'package:beep/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:beep/features/dashboard/presentation/data.dart';
import 'package:beep/utils/constants/color_constants.dart';
import 'package:beep/utils/constants/text_constants.dart';
import 'package:beep/utils/helpers/bottomsheethelper.dart';
import 'package:beep/utils/router/arguments/camera_page_argument.dart';
import 'package:beep/utils/router/arguments/status_preview_argument.dart';
import 'package:beep/utils/router/arguments/status_upload_page_arg.dart';
import 'package:beep/utils/router/router.dart';
import 'package:beep/utils/theme/text_theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(DashboardCallEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            width: 150,
            height: 5,
            decoration: BoxDecoration(
                color: chatlistdashcolor,
                borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardCallState) {
                  if (state.statusData.length == 0) {
                    return Center(
                      child: Text("No Status Avaiable"),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.statusData.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return CallTile(
                        statusdata: state.statusData,
                        index: index,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 100,
          )
          // ChatWidget(profile: widget.profile),
        ],
      ),
    );
  }
}

class CallTile extends StatelessWidget {
  const CallTile({super.key, required this.statusdata, required this.index});

  final List<Status> statusdata;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.statusPreviewScreen,
            arguments:
                StatusPreviewArgument(index: index, statusList: statusdata));
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              width: 59,
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: yellowprimary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  // width: 69,
                  // height: 69,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: primaryBackground,
                          strokeAlign: BorderSide.strokeAlignInside,
                          width: 1),
                      // color: yellowprimary,
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          statusdata[index].userPhotos ?? emptyImage,
                        ),
                      )),
                  // child: Image.network(image),
                ),
              ),
            ),
            // Container(
            //   width: 59,
            //   height: 59,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       image: DecorationImage(
            //           image: NetworkImage(
            //             statusdata.userPhotos ?? "",
            //           ),
            //           fit: BoxFit.fitHeight)),
            // ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    statusdata[index].username ?? "",
                    style: TextStyleHelper.boldStyle(fontSize: 15)
                        .copyWith(letterSpacing: -1),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    DateFormat('dd MMM, hh:mm a')
                        .format(statusdata[index].timestamp ?? DateTime.now()),
                    style: TextStyleHelper.mediumStyle(fontSize: 15)
                        .copyWith(letterSpacing: -1),
                  )
                  // Row(
                  //   children: [
                  //     Icon(
                  //       profile[index]['call_type'] == "missing"
                  //           ? Icons.call_missed
                  //           : profile[index]['call_type'] == "outgoing"
                  //               ? Icons.call_made
                  //               : Icons.call_received,
                  //       color: profile[index]['call_type'] == "missing"
                  //           ? Colors.red
                  //           : Colors.black,
                  //     ),
                  //     Text(profile[index]['call_time'],
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //         softWrap: false,
                  //         style: TextStyleHelper.mediumStyle(
                  //             fontSize: 14, color: subtextColors)),
                  //   ],
                  // ),
                ],
              ),
            ),
            // Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call,
                  size: 17,
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CallTitleWidget extends StatefulWidget {
  const CallTitleWidget({super.key});

  @override
  State<CallTitleWidget> createState() => _CallTitleWidgetState();
}

class _CallTitleWidgetState extends State<CallTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status",
                  style: TextStyleHelper.boldStyle(
                          color: primaryTextColor, fontSize: 30)
                      .copyWith(letterSpacing: -1),
                ),
                IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: primaryTextColor,
                    )),
              ],
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardCallState) {
                  return InkWell(
                    onTap: state.selfStatus == null
                        ? null
                        : () {
                            Navigator.pushNamed(
                                context, AppRoutes.statusPreviewScreen,
                                arguments: StatusPreviewArgument(
                                    index: 0, statusList: [state.selfStatus!]));
                          },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: yellowprimary, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 3,
                                      color: (state.selfStatus == null)
                                          ? Colors.white
                                          : yellowprimary),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          state.photo ?? emptyImage),
                                      fit: BoxFit.fill)),
                              child: state.selfStatus != null
                                  ? SizedBox.shrink()
                                  : Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.add_circle,
                                        color: primaryTextColor,
                                        size: 20,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.username,
                                  style: TextStyleHelper.mediumStyle(
                                      color: primaryTextColor, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  // onTap: () => showAddOptions(context),
                                  child: Text(
                                    state.selfStatus == null
                                        ? "Create Status"
                                        : DateFormat('dd MMM, hh:mm a').format(
                                            state.selfStatus!.timestamp!),
                                    style: TextStyleHelper.mediumStyle(
                                        color: yellowprimary, fontSize: 15),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: yellowprimary,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatusOption extends StatelessWidget {
  const StatusOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.image,
                color: secondaryTextColor,
              ),
              title: Text(
                "Image",
                style: TextStyleHelper.mediumStyle(color: secondaryTextColor),
              ),
              onTap: () async {
                final cameras = await availableCameras();
                Navigator.pushNamed(
                  context,
                  AppRoutes.cameraScreen,
                  arguments: CameraPageArgument(
                    cameras: cameras,
                    fromchatScreen: true,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.text_fields,
                color: secondaryTextColor,
              ),
              title: Text(
                "Text",
                style: TextStyleHelper.mediumStyle(color: secondaryTextColor),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.statusuploadpage,
                  arguments: StatusUploadPageArg(),
                );
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}
