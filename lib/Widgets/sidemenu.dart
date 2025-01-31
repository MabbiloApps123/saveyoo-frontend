import 'package:flutter/material.dart';
import 'package:saveyoo/Localization/language/languages.dart';
import 'package:saveyoo/Network/di.dart';
import 'package:saveyoo/Utils/MyColor.dart';
import 'package:saveyoo/Utils/StorageServiceConstant.dart';
import 'package:saveyoo/Utils/pref_manager.dart';
import 'package:saveyoo/Widgets/primary_button.dart';

// MFrom 1-> dashboard  6->startupschool 8-> Startup deals  9-> Pitch room list 10->Captable
class SideMenu extends StatelessWidget {
  int mFrom = 0;
  SideMenu({
    super.key,
    required this.mFrom,
  });

  Future<void> onLoad() async {
    mClickPich = await sl<StorageService>()
            .getString(StorageServiceConstant.MCLICKPITCH) ??
        false;
  }

  bool mClickPich = false;
  double sidemenubtnheight = 40;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlack,
      margin: const EdgeInsets.only(top: 0, left: 0, right: 2),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 1 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 1
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_dashboardwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_dashboard.png')), //ic_dashboardwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .appName,
                                                  textColor: mFrom == 1
                                                      ? Colors.white
                                                      : kBlack)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 2 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 2
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_communityfeedwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_communityfeed.png')), //ic_communityfeedwhite.png
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .mCommunityFeed,
                                                  textColor: mFrom == 2
                                                      ? mWhiteColor
                                                      : mBlackColor)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 8 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            true);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 8
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_startupdeals_white.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_startupdeals.png')),
                                          Expanded(
                                              flex: 8,
                                              child: Row(
                                                children: [
                                                  SidemenuText(
                                                      menuname:
                                                          Languages.of(context)!
                                                              .appName,
                                                      textColor: mFrom == 8
                                                          ? Colors.white
                                                          : kBlack),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      size: 0),
                                                ],
                                              )),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 3 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            true);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          const Expanded(
                                              flex: 2,
                                              child: sidemenuImage(
                                                  menuicon:
                                                      'assets/ic_pitchcraft.png')),
                                          Expanded(
                                              flex: 8,
                                              child: Row(
                                                children: [
                                                  SidemenuText(
                                                      menuname:
                                                          Languages.of(context)!
                                                              .appName,
                                                      textColor: mFrom == 3
                                                          ? Colors.white
                                                          : kBlack),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      size: 0),
                                                ],
                                              )),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: true,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: sidemenubtnheight,
                                        decoration: BoxDecoration(
                                          color: mFrom == 4
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                            color: mStatusbar,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 5, 0),
                                          child: InkWell(
                                            onTap: () {
                                              sl<StorageService>().setBool(
                                                  StorageServiceConstant
                                                      .MCLICKPITCH,
                                                  true);
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(children: [
                                                const Expanded(
                                                  flex: 3,
                                                  child: Text(""),
                                                ),
                                                Expanded(
                                                    flex: 7,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: SidemenuText(
                                                              menuname:
                                                                  Languages.of(
                                                                          context)!
                                                                      .appName,
                                                              textColor:
                                                                  mFrom == 4
                                                                      ? Colors
                                                                          .white
                                                                      : kBlack),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                      ],
                                                    )),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: sidemenubtnheight,
                                        decoration: BoxDecoration(
                                          color: mFrom == 5
                                              ? Colors.black
                                              : Colors.white,
                                          border: Border.all(
                                            color: mStatusbar,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 5, 0),
                                          child: InkWell(
                                            onTap: () {
                                              sl<StorageService>().setBool(
                                                  StorageServiceConstant
                                                      .MCLICKPITCH,
                                                  true);
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(children: [
                                                const Expanded(
                                                  flex: 3,
                                                  child: Text(""),
                                                ),
                                                Expanded(
                                                    flex: 7,
                                                    child: SidemenuText(
                                                        menuname: Languages.of(
                                                                context)!
                                                            .appName,
                                                        textColor: mFrom == 5
                                                            ? Colors.white
                                                            : kBlack)),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 6 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 6
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_schoolwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_school.png')), //ic_schoolwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .appName,
                                                  textColor: mFrom == 6
                                                      ? Colors.white
                                                      : kBlack)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 7 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 7
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_bookanexpertwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_bookanexpert.png')),
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .appName,
                                                  textColor: mFrom == 7
                                                      ? Colors.white
                                                      : kBlack)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 9 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 9
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_pitchroomwhite.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_pitchroom.png')), //ic_schoolwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .appName,
                                                  textColor: mFrom == 9
                                                      ? Colors.white
                                                      : kBlack)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: sidemenubtnheight,
                                decoration: BoxDecoration(
                                  color:
                                      mFrom == 10 ? Colors.black : Colors.white,
                                  border: Border.all(
                                    color: mStatusbar,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        sl<StorageService>().setBool(
                                            StorageServiceConstant.MCLICKPITCH,
                                            false);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Expanded(
                                              flex: 2,
                                              child: mFrom == 10
                                                  ? const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_captable_white.png')
                                                  : const sidemenuImage(
                                                      menuicon:
                                                          'assets/ic_captable.png')), //ic_schoolwhite
                                          Expanded(
                                              flex: 8,
                                              child: SidemenuText(
                                                  menuname:
                                                      Languages.of(context)!
                                                          .appName,
                                                  textColor: mFrom == 10
                                                      ? Colors.white
                                                      : kBlack)),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "",
                            // Languages.of(context)!.mHireourteam,
                            style: TextStyle(
                                fontFamily: 'OpenSansBold',
                                fontSize: 22.0,
                                color: kBlack),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 150,
                              child: PrimaryButton(
                                  mButtonname: Languages.of(context)!.appName,
                                  onpressed: () {},
                                  mSelectcolor: kBlack,
                                  mTextColor: Colors.white,
                                  mFontSize: 16,
                                  mHeigth: 40)),
                        ),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}

class sidemenuImage extends StatelessWidget {
  const sidemenuImage({
    super.key,
    required this.menuicon,
  });
  final String menuicon;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      menuicon,
      height: 20,
    );
  }
}

class SidemenuText extends StatelessWidget {
  const SidemenuText({
    super.key,
    required this.menuname,
    required this.textColor,
  });

  final String menuname;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Text(menuname,
          style: TextStyle(
              fontFamily: 'ManropeBold', fontSize: 18, color: textColor)),
    );
  }
}
