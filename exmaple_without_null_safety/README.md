# flutter_flurry_drawer


![Pub](https://img.shields.io/pub/v/flutter_flurry_drawer) <a href="https://github.com/Solido/awesome-flutter">
    <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>
![Widget Tests](https://github.com/pedromassango/bottom_navy_bar/workflows/Widget%20Tests/badge.svg?branch=master)

[![Latest compatibility result for Stable channel](https://img.shields.io/endpoint?url=https://pub.green/packages/bottom_navy_bar/badge?channel=stable)](https://pub.green/packages/bottom_navy_bar)
[![Latest compatibility result for Beta channel](https://img.shields.io/endpoint?url=https://pub.green/packages/bottom_navy_bar/badge?channel=beta)](https://pub.green/packages/bottom_navy_bar)
[![Latest compatibility result for Dev channel](https://img.shields.io/endpoint?url=https://pub.green/packages/bottom_navy_bar/badge?channel=dev)](https://pub.green/packages/bottom_navy_bar)


<!-- <a href="https://flutter.dev/docs/development/packages-and-plugins/favorites">
<img height="128" src="https://github.com/pedromassango/bottom_navy_bar/blob/master/images/flutter_favorite_badge.png">
</a>
<br><br> -->

# flutter_flurry_drawer

The package is solving a problem with package flurry_navigation as it's old and the owner didn't update it. The drawer is very beautiful and many people likes it so much. For these reasons I build this package for public to help them to add this beautful drawer to their projets. I wish this will help you.

The package is very easy to use, with adjustable colors, shapes, and navigation logic.


https://user-images.githubusercontent.com/80456446/139630864-e74933b0-32ba-4cc4-a926-5ee18a88d83e.mp4


Hint: The package is suppring null safety
![1_GjeLhjfdpqhmGc3PjRf-BQ](https://user-images.githubusercontent.com/80456446/139783129-f561cb1f-8ff6-47e8-8eab-7ca5876b1dff.png)


## Getting Started
First of all, Depend on the package.
```yaml
dependencies:
  ...
  flurry_navigation: ^0.0.1 #Add the latest version
```

Then import the package in your dart file
``` dart
import 'package:flutter_flurry_drawer/flutter_flurry_drawer.dart';
import 'package:flutter_flurry_drawer/flurry_menu.dart';
```

### Build your Screens
for example, let's build the first screen which consists of some text
```dart
import 'package:flutter_flurry_drawer/flutter_flurry_drawer.dart';
import 'package:flutter/material.dart';

final Screen firstscreen = new Screen(
    contentBuilder: (BuildContext context) {
      return new Center(
        child: new Container(
          height:100.0,
          child: new Padding(
            padding: const EdgeInsets.all(25.0),
            child: new Column(
              children: [
                new Expanded(
                    child: new Center(
                        child: new Text('Welcome to your home')
                    )
                )
              ],
            ),
          ),
        ),

      );
    }
);
```
Add your code inside this variable below in every screen you want to navigate.

hint : the pages of the flurry drawer is using screen widget


### Changes in the main file
First You should declare a variable called activeScreen.


```dart
var activeScreen;
```
Now add a Widget builder class that returns new FlurryDrawer.
```dart
Widget build(BuildContext context) {
  return new FlurryDrawer(

  );
}
```
Add values to these attributes to FlurryDrawer.
```dart
Widget build(BuildContext context) {
  new FlurryDrawer(
    // The Icon data of the icon the BottomLeft
    expandIcon: Image.asset("Put your path here"),

    // The content of the screen. leave it as it is
    contentScreen: activeScreen,
   )
}
```

Now add the menuScreen attribute FlurryDrawer and set it to the value below.
```dart
Widget build(BuildContext context) {
  new FlurryDrawer(
    ...
    menuScreen: new MenuScreen(

    )
  );
}
```

Now add the menu attribute to MenuScreen and set it to the below value
```dart
Widget build(BuildContext context) {
  return new FlurryDrawer(
    ...
    menuScreen: new MenuScreen(
      ...
      menu: new Menu(

      )
    )
  )
}
```

Then add the "items" attribute to "Menu" and set it to the list of items you want in the menu "which usually matches the no. of screens", with "new MenuItem" like the example below.
```dart
Widget build(BuildContext context) {
  return new FlurryDrawer(
    ...
    menuScreen: new MenuScreen(
       menu: new Menu(
         items: [
            //You can add as many items as you want, it's scrollable!!
            new MenuItem(
              id:
              'hom', //You can set this to whatever you want but dont duplicate it
              icon:
              'assets/hom.png', //Set this to the data for the icon of the button
              isSelected: true,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
              // btnShape: BoxShape.rectangle
            ),
            new MenuItem(
              id: 'sta',
              icon: 'assets/sta.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
              //btnShape: BoxShape.rectangle
            ),
            new MenuItem(
              id: 'doc',
              icon: 'assets/doc.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
            ),
            new MenuItem(
              id: 'set',
              icon: 'assets/set.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
            ),
         ]
       )
    )
  )
}
```
Now add the onMenuItemSelected attribute to "MenuScreen" to specify the logic for the navigation.
```dart
Widget build(BuildContext context) {
  new FlurryDrawer(
    ...
    menuScreen: new MenuScreen(
      ...
      //this is the logic behind the navigation. tailor the code below to fit your needs. If you want any help message me.
        onMenuItemSelected: (String itemId) {
          if (itemId == 'hom') {
            setState(() => activeScreen = firstscreen);
          } else if (itemId == 'sta') {
            setState(() => activeScreen = secondscreen);
          } else if (itemId == 'doc') {
            setState(() => activeScreen = thirdscreen);
          } else if (itemId == 'loc') {
            setState(() => activeScreen = fourthscreen);
          } else if (itemId == 'set') {
            setState(() => activeScreen = fifthscreen);
          }
        },
    ),
  );
}
```

## Customization (Optional)

### FlurryDrawer widget

- 'iconSize' : icon size can be customized,
Default Icon size is
 ((MediaQuery.of(context).size.width *
             MediaQuery.of(context).size.height) /
            15420),

- 'curveRadius' : page cure radius can be customized
Default curve radius is
 (MediaQuery.of(context).size.width *
            MediaQuery.of(context).size.height) /
            4980,

 - 'alignment' : The icon alignment can be customized as well
 default alignment is bpttom left

 ### MenuScreen widget

 - 'bgColor' : The menu screen background color can be customized, the default background color is the scaffold background color

 - 'bottomSection' : when the content page animated, a space appears below the content screen, so we can use this screen to add some widgets his widget is known as bottomSection. The default bottom section widget is the container\

## MenuItem widget
- 'selectedBtnColor' : The color of the selected menu item can be customized. The default color is Color.fromRGBO(38, 198, 218, 1),

- 'disabledBtnColor' : The color of the disabled menu item can be customized. The default color is transparent color

- 'selectedShadowColor' : adding shadows to the selected menu item. The default color is blue grey

- 'disabledShadowColor' : adding shadows to the disabled menu item. The default color is transparent

- 'btnShape' : editing the shape of the menu item container. The default shape is circular shape

### Exapmle
```dart

import 'package:flutter/material.dart';
import 'package:flutter_flurry_drawer/flutter_flurry_drawer.dart';
import 'package:flutter_flurry_drawer/flurry_menu.dart';


import 'bottom_section/bottom_section.dart';
import 'drawer_pages/fifth_screen.dart';
import 'drawer_pages/first_screen.dart';
import 'drawer_pages/fourth_screen.dart';
import 'drawer_pages/second_screen.dart';
import 'drawer_pages/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  //Decalre active screen var with the the default screen somewhere accesible to the contentScreen attributes
  var activeScreen = firstscreen;
  Widget build(BuildContext context) {
    return new FlurryDrawer(
      // The curve of the screen (Double)
      curveRadius: (MediaQuery.of(context).size.width *
          MediaQuery.of(context).size.height) /
          4980,
      // The Icon data of the icon the BottomLeft
      expandIcon: Image.asset("assets/expan1.png"),
      // The size of the icon on the BottomLeft
      iconSize: ((MediaQuery.of(context).size.width *
          MediaQuery.of(context).size.height) /
          15420),
      // The content of the screen
      contentScreen: activeScreen,
      menuScreen: new MenuScreen(
        bottomSection: BottomSection(),
        bgColor: Color.fromRGBO(121, 134, 203, 1),
        menu: new Menu(
          items: [
            new MenuItem(
              id:
              'hom', //You can set this to whatever you want but dont duplicate it
              icon:
              'assets/hom.png', //Set this to the data for the icon of the button
              isSelected: true,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
              // btnShape: BoxShape.rectangle
            ),
            new MenuItem(
              id: 'sta',
              icon: 'assets/sta.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
              //btnShape: BoxShape.rectangle
            ),
            new MenuItem(
              id: 'doc',
              icon: 'assets/doc.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
            ),
            new MenuItem(
              id: 'set',
              icon: 'assets/set.png',
              isSelected: false,
              selectedBtnColor: Color.fromRGBO(38, 198, 218, 1),
            ),
          ],
        ),
        onMenuItemSelected: (String itemId) {
          if (itemId == 'hom') {
            setState(() => activeScreen = firstscreen);
          } else if (itemId == 'sta') {
            setState(() => activeScreen = secondscreen);
          } else if (itemId == 'doc') {
            setState(() => activeScreen = thirdscreen);
          } else if (itemId == 'loc') {
            setState(() => activeScreen = fourthscreen);
          } else if (itemId == 'set') {
            setState(() => activeScreen = fifthscreen);
          }
        },
      ),
    );
  }
}
```

## License & Accesability
* This is the first version of my package  so if you see any problems you're free to open an issue.

![1200px-Public_Domain_Mark_button svg](https://user-images.githubusercontent.com/80456446/134284403-2e2f001c-0a9e-46f1-8ab4-fb6618c126fc.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
