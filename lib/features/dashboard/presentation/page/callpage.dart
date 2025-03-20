import 'package:chat_app/features/dashboard/presentation/data.dart';
import 'package:chat_app/utils/constants/color_constants.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key});

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
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
            child: ListView.separated(
              itemCount: profile.length,
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
                if (index == profile)
                  return CallTile(
                    profile: profile,
                    index: index,
                  );
              },
            ),
          )
          // ChatWidget(profile: widget.profile),
        ],
      ),
    );
  }
}

class CallTile extends StatelessWidget {
  const CallTile({super.key, required this.profile, required this.index});

  final List profile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, AppRoutes.chatScreen);
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
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(
                        profile[index]["image"],
                      ),
                      fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profile[index]['name'],
                    style: TextStyleHelper.boldStyle(fontSize: 15)
                        .copyWith(letterSpacing: -1),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        profile[index]['call_type'] == "missing"
                            ? Icons.call_missed
                            : profile[index]['call_type'] == "outgoing"
                                ? Icons.call_made
                                : Icons.call_received,
                        color: profile[index]['call_type'] == "missing"
                            ? Colors.red
                            : Colors.black,
                      ),
                      Text(profile[index]['call_time'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyleHelper.mediumStyle(
                              fontSize: 14, color: subtextColors)),
                    ],
                  ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Calls",
              style: TextStyleHelper.boldStyle(
                      color: primaryTextColor, fontSize: 30)
                  .copyWith(letterSpacing: -1),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: primaryTextColor,
                )),
          ],
        ),
      ),
    );
  }
}
