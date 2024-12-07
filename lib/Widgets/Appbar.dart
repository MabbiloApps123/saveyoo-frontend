import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  Appbar({
    super.key,
    required this.mText,
    required this.mUserImage,
    required this.mFrom,
    required this.onMenuPressed,
    required this.onPressedLogout,
  });
  final String mText;
  String mUserImage = "";
  int mFrom = 0;
  final VoidCallback onMenuPressed;
  final VoidCallback onPressedLogout;
//mobile_ic_appicon
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 6, left: 10, right: 10),
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onMenuPressed,
                          child: Text("re"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("re"),
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Text("re"),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.pushReplacementNamed(
                            //     context, profileRoute);
                          },
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: const ExactAssetImage(
                                'assets/avathar.png',
                                scale: 20),
                            child: ClipOval(
                              child: Image.asset('assets/avathar.png',
                                  width: 35, height: 35, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )),
      ],
    ));

    //   PreferredSize(
    //   preferredSize: Size.fromHeight(120), // Set this height
    //   child: Container(
    //     color: Colors.orange,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('One'),
    //         Text('Two'),
    //         Text('Three'),
    //         Text('Four'),
    //       ],
    //     ),
    //   ),
    // )
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
