import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:phoenix/src/beginning/pages/settings/settings_pages/glass_effect.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/widgets/artwork_background.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Interface extends StatefulWidget {
  const Interface({Key? key}) : super(key: key);

  @override
  _InterfaceState createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
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
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            shadowColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              "Arayüz",
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
                    padding: const EdgeInsets.all(0),
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          title: const Text(
                            "Cam Etkisi",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: const Text(
                            "Cam temasının bulanıklığını ve rengini ayarlayın.",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                maintainState: false,
                                builder: (context) =>
                                    ChangeNotifierProvider<Leprovider>(
                                        create: (_) => Leprovider(),
                                        child: const GlassEffect()),
                              ),
                            );
                          },
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          title: const Text(
                            "Varsayılan Eserler",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: const Text(
                            "Özel resmi varsayılan resim olarak ayarlayın.",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          leading: Card(
                            elevation: 3,
                            color: Colors.transparent,
                            child: ConstrainedBox(
                              constraints: musicBox.get("squareArt") ?? true
                                  ? kSqrConstraint
                                  : kRectConstraint,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(defaultNone!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                          ),
                          onLongPress: () async {
                            ByteData bytes =
                                await rootBundle.load('assets/res/default.jpg');
                            setState(() {
                              defaultNone = bytes.buffer.asUint8List();
                            });
                            await File(
                                    "${applicationFileDirectory.path}/artworks/null.jpeg")
                                .writeAsBytes(defaultNone!,
                                    mode: FileMode.write);
                            Flushbar(
                              messageText: const Text(
                                  "Varsayılan resim sıfırlandı",
                                  style: TextStyle(
                                      fontFamily: "Futura",
                                      color: Colors.white)),
                              icon: const Icon(
                                Icons.restore_rounded,
                                size: 28.0,
                                color: Colors.white,
                              ),
                              shouldIconPulse: true,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                              duration: const Duration(seconds: 3),
                              borderColor: Colors.white.withOpacity(0.04),
                              borderWidth: 1,
                              backgroundColor: glassOpacity!,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              isDismissible: true,
                              barBlur: musicBox.get("glassBlur") ?? 18,
                              margin: const EdgeInsets.only(
                                  bottom: 20, left: 8, right: 8),
                              borderRadius: BorderRadius.circular(15),
                            ).show(context);
                            musicBox.put("dominantDefault", null);
                            refresh = true;
                          },
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile image = (await _picker.pickImage(
                                source: ImageSource.gallery))!;
                            Uint8List bytes = await image.readAsBytes();
                            setState(() {
                              defaultNone = bytes;
                            });
                            await File(
                                    "${applicationFileDirectory.path}/artworks/null.jpeg")
                                .writeAsBytes(bytes, mode: FileMode.write);
                            musicBox.put("dominantDefault", null);
                            refresh = true;
                          },
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor: kMaterialBlack,
                          subtitle: const Text(
                            "Kaydırma sırasında akıcı bir zıplama animasyonu",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          title: const Text(
                            "Akışkanlık",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: musicBox.get("fluidAnimation") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("fluidAnimation", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor: kMaterialBlack,
                          subtitle: const Text(
                            "Albüm resmini arka plan olarak kullan",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          title: const Text(
                            "Dinamik Arka Plan",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: musicBox.get("dynamicArtDB") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("dynamicArtDB", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor: kMaterialBlack,
                          subtitle: const Text(
                            "Listelerde kare şeklindeki eserler",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          title: const Text(
                            "Kare Eserler",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: musicBox.get("squareArt") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("squareArt", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor: kMaterialBlack,
                          subtitle: const Text(
                            "Sürücünün rahatlığı için konum simgeleri",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          title: const Text(
                            "Sol Taraf",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: musicBox.get("androidAutoLefty") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("androidAutoLefty", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: CheckboxListTile(
                          activeColor: kCorrect,
                          checkColor: kMaterialBlack,
                          subtitle: const Text(
                            "Şu anda çalmakta olan ek şarkı verilerini göster.",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                          title: const Text(
                            "Odyofil Verileri",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: musicBox.get("audiophileData") ?? true,
                          onChanged: (newValue) {
                            setState(() {
                              musicBox.put("audiophileData", newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      // Material(
                      //   color: Colors.transparent,
                      //   child: CheckboxListTile(
                      //     activeColor: kCorrect,
                      //     checkColor:
                      //         darkModeOn ? kMaterialBlack : Colors.white,
                      //     subtitle: Text(
                      //       "Use regular mini-player design.",
                      //       style: TextStyle(
                      //         color:
                      //             darkModeOn ? Colors.white38 : Colors.black38,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       "Classix Mini-Player",
                      //       style: TextStyle(
                      //         color: darkModeOn ? Colors.white : Colors.black,
                      //       ),
                      //     ),
                      //     value: musicBox.get("classix") ?? true,
                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         musicBox.put("classix", newValue);
                      //       });
                      //     },
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //   ),
                      // ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                            subtitle: const Text(
                              "Mini oynatıcıda ilerlemeyi göster.",
                              style: TextStyle(
                                color: Colors.white38,
                              ),
                            ),
                            title: const Text(
                              "Mini-Oynatıcı İlerlemesi",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: DropdownButton<String>(
                              value:
                                  musicBox.get("miniPlayerProgress") ?? "Top",
                              icon: const Icon(Icons.arrow_drop_down_rounded,
                                  color: Colors.white70),
                              elevation: 25,
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(kRounded / 2),
                              dropdownColor: kMaterialBlack.withOpacity(0.8),
                              underline: Container(
                                height: 2,
                                color: kCorrect,
                              ),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? newValue) async {
                                await musicBox.put(
                                    "miniPlayerProgress", newValue);
                                setState(() {});
                              },
                              items: <String>[
                                'Top',
                                'Button',
                                'Hidden',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ),
                    ],
                    physics: musicBox.get("fluidAnimation") ?? true
                        ? const BouncingScrollPhysics()
                        : const ClampingScrollPhysics(),
                    shrinkWrap: true,
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
