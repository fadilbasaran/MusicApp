import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/native/go_native.dart';
import 'package:phoenix/src/beginning/widgets/artwork_background.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import 'directories.dart';
import '../../../utilities/page_backend/file_exporer.dart';

Map folderData = {};

class Miscellaneous extends StatefulWidget {
  const Miscellaneous({Key? key}) : super(key: key);

  @override
  _MiscellaneousState createState() => _MiscellaneousState();
}

class _MiscellaneousState extends State<Miscellaneous> {
  bool darkModeOn = true;

  @override
  void initState() {
    rootCrossfadeState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rootCrossfadeState = Provider.of<Leprovider>(context);
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      orientedCar = true;
      deviceHeight = MediaQuery.of(context).size.width;
      deviceWidth = MediaQuery.of(context).size.height;
    } else {
      orientedCar = false;
      deviceHeight = MediaQuery.of(context).size.height;
      deviceWidth = MediaQuery.of(context).size.width;
    }

    return Consumer<Leprovider>(
      builder: (context, taste, _) {
        globaltaste = taste;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: darkModeOn ? Colors.white : kMaterialBlack,
            ),
            shadowColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Tercihler",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth! / 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Theme(
            data: themeOfApp,
            child: Stack(
              children: [
                // ignore: prefer_const_constructors
                BackArt(),
                Container(
                  padding: EdgeInsets.only(
                      top: kToolbarHeight + MediaQuery.of(context).padding.top),
                  child: ListView(
                    physics: musicBox.get("fluidAnimation") ?? true
                        ? const BouncingScrollPhysics()
                        : const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "30 saniyenin alt??nda m??zik g??sterme",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "30 Saniye Kural??",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("clutterFree") ?? false,
                          onChanged: (newValue) {
                            refresh = true;
                            setState(() {
                              musicBox.put("clutterFree", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "'<Bilinmeyen>' ????esini Sanat???? olarak g??sterme",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Bilinmeyen Sanat????",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("stopUnknown") ?? false,
                          onChanged: (newValue) {
                            refresh = true;
                            setState(() {
                              musicBox.put("stopUnknown", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "M??zik taramas?? i??in ??zel dizinler se??in",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "??zel Tarama",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          secondary: Visibility(
                            visible: musicBox.get("customScan") ?? false,
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  icon: const Icon(Icons.edit_rounded),
                                  color: darkModeOn
                                      ? Colors.white
                                      : Colors.grey[700],
                                  onPressed: () async {
                                    selectedFolders =
                                        musicBox.get("customLocations") ?? [];
                                    externalTopLevelDir =
                                        await getExternalDirectory() ?? "";
                                    if (externalTopLevelDir == "") {
                                      isHome = false;
                                      await iterationManager(topLevelDir);
                                    } else {
                                      await iterationManager("...");
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Directories(),
                                      ),
                                    );
                                    setState(() {});
                                  }),
                            ),
                          ),
                          value: musicBox.get("customScan") ?? false,
                          onChanged: (newValue) {
                            refresh = true;
                            setState(() {
                              musicBox.put("customScan", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor:
                              darkModeOn ? kMaterialBlack : Colors.white,
                          subtitle: Text(
                            "Resim, kilit ekran?? duvar ka????d?? olarak ayarland??",
                            style: TextStyle(
                              color:
                                  darkModeOn ? Colors.white38 : Colors.black38,
                            ),
                          ),
                          title: Text(
                            "Arka Plan (BETA)",
                            style: TextStyle(
                              color: darkModeOn ? Colors.white : Colors.black,
                            ),
                          ),
                          value: musicBox.get("wallpx") ?? false,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("wallpx", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
