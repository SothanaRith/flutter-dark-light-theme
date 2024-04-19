import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:themeform/controller/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

// change stateless to stateful for use share preference
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // call theme and image controller for use around this app
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call Preferences to remember the theme
    themeController.loadThemeFromPreferences();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Theme Demo',
      // apply themeController to main screen
      theme: themeController.theme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeLogic) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: themeController.theme.primaryColor,
          title: Text(themeLogic.darkTheme == true ? 'Dark Theme' : "light Theme", style: TextStyle(color: themeController.theme.secondaryHeaderColor),),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(themeLogic.imageAsset,), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                themeLogic.imageAsset,
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  themeLogic.darkTheme = true;
                  themeLogic.toggleTheme();
                },
                child: const Text('dark Theme'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeLogic.darkTheme = false;
                  themeLogic.toggleTheme();
                },
                child: const Text('light Theme'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
