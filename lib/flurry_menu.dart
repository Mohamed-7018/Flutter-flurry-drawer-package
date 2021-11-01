/// A beautiful and animated flurry Drawer navigation that paints a rounded shape
/// around its corner to provide a wonderful look.
///
/// Update [itemId] to change the selected page.
/// [itemId] is required and must not be null.

library flutter_flurry_drawer;

import 'package:flutter/material.dart';
import 'flutter_flurry_drawer.dart';

final menuScreenKey = GlobalKey(debugLabel: 'MenuScreen');

/*--------------------------------------------------------------------------*/
/*-----------------------  Flurry Drawer Menu Screen  ----------------------------*/
/*--------------------------------------------------------------------------*/
class MenuScreen extends StatefulWidget {
  // The content of the menu screen
  // Widget of data type MenuScreen
  // This widget consists of bottom section, bg (BackGround color) , menu List
  // which is the menu items components,
  /// The selected item in this menu itemId. Changing this property will change and animate
  /// the screen being selected. Defaults to zero.
  final Menu menu;

  /// The selected item in this menu itemId. Changing this property will
  /// do a custom function, for example change and animate
  /// the screen being selected.
  /// => function to be done when the menu item selected
  final Function(String) onMenuItemSelected;

  /// Back Ground color
  /// The back ground color of the menu screen

  // The default background color is the theme scaffold background color
  final Color? bgColor;

  // bottom section
  // when the content page animated, a space appears below the
  // content screen, so we can use this screen to add some widgets
  // this widget is known as bottomSection

  /// The default bottom section widget is the container
  final Widget? bottomSection;

  MenuScreen({
    required this.menu,
    required this.onMenuItemSelected,
    this.bgColor,
    this.bottomSection,
  }) : super(key: menuScreenKey);

  @override
  createState() {
    return CustomRadioState();
  }
}


/*--------------------------------------------------------------------------*/
/*-----------------------  Custom Radio State  ----------------------------*/
/*--------------------------------------------------------------------------*/
class CustomRadioState extends State<MenuScreen> {
  // ignore: deprecated_member_use
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.menu.items!.length; ++i) {
      sampleData.add(RadioModel(
        widget.menu.items![i].isSelected,
        widget.menu.items![i].icon,
        widget.menu.items![i].id,
        widget.menu.items![i].selectedBtnColor,
        widget.menu.items![i].disabledBtnColor,
        widget.menu.items![i].selectedShadowColor,
        widget.menu.items![i].disabledShadowColor,
        widget.menu.items![i].btnShape,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlurryNavigationMenuController(
        builder : (BuildContext context, MenuController? menuController) {
      return Scaffold(
/*--------------------------------------------------------------------------*/
/*-----------------  menu screen background color  -------------------------*/
/*--------------------------------------------------------------------------*/
      // The background color is determined from the user,
      // if the user didn't inject any color, the
      // background color will be the scaffold background color
      backgroundColor: widget.bgColor == null
            ? Theme.of(context).scaffoldBackgroundColor
            : widget.bgColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
/*--------------------------------------------------------------------------*/
/*-----------------  menu screen list of items  -------------------------*/
/*--------------------------------------------------------------------------*/
            // The list of the item of the menu
            Expanded(
              flex: 14,
              child: FlurryNavigationMenuController(
                builder: (BuildContext context, MenuController? menuController) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 50),
                          itemCount: sampleData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                widget.onMenuItemSelected(sampleData[index].id);
                                setState(() {
                                  sampleData.forEach(
                                      (element) => element.isSelected = false);
                                  sampleData[index].isSelected = true;
                                });
                                menuController?.close();
                              },
                              child: new RadioItem(sampleData[index]),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 14,
                      )
                    ],
                  );
                },
              ),
            ),
/*--------------------------------------------------------------------------*/
/*-----------------  menu screen bottom section  -------------------------*/
/*--------------------------------------------------------------------------*/
            // bottom section
            // when the content page animated, a space appears below the
            // content screen, so we can use this screen to add some widgets
            // this widget is known as bottomSection

            /// The default bottom section widget is the container
            Expanded(
              child: widget.bottomSection == null
                  ? Container()
                  : widget.bottomSection!,
              flex: 6,
            ),
          ],
        ),
      );
    });
  }
}


/*--------------------------------------------------------------------------*/
/*-----------------------  Radio Item Class ----------------------------*/
/*--------------------------------------------------------------------------*/
class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 60.0,
          width: 60.0,
          child: FractionallySizedBox(
            // height factor of the list
            heightFactor: 0.7,
            // width factor of the list
            widthFactor: 0.7,
            // child
            child: Image.asset(_item.icon),
            /*IconButton(
              icon: Image.asset(_item.icon),
            ),*/
          ),
          decoration: BoxDecoration(
            // decorating the radio item
            color: _item.isSelected
                ? _item.selectedBtnColor
                : _item.disabledBtnColor,
            // adding some border
            border: Border.all(width: 1.0, color: Colors.transparent),
            // shape of the btn
            shape: _item.btnShape,
            // adding some shadows
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: _item.isSelected
                      ? _item.selectedShadowColor
                      : _item.disabledShadowColor,
                  offset: Offset(0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 1),
            ],
          ),
        ),
      ),
    );
  }
}

/*--------------------------------------------------------------------------*/
/*-----------------------  Mnu item  ----------------------------*/
/*--------------------------------------------------------------------------*/
// the menu screen contains some menu items
class MenuItem {
  // Parameter to indicate whether the menu item is selected or not
  /// The selected item in this menu itemId. Changing this property will change and animate
  /// the screen being selected.
  final bool isSelected;

  // The menu item icon
  // the icon is a string data type
  // the icon is an image path
  // add image path so that it will be displayed in the menu item
  final String icon;

  // every menu item has a unique id and it doesn't equal any othe
  // menu item id (in the same project)
  /// The selected item in this menu itemId. Changing this property will change and animate
  /// the screen being selected.
  final String id;

  // selected btn color
  //The color of the selected menu item
  // the default color is Color.fromRGBO(38, 198, 218, 1),
  final Color selectedBtnColor;

  // disabled btn color
  // The color of the disabled menu item
  // the default color is transparent color
  Color disabledBtnColor;

  // adding shadows to the selected menu item
  // the selected shadow color
  // the default color is blue grey
  Color selectedShadowColor;

  // adding shadows to the disabled menu item
  // the disabled shadow color
  // the default color is transparent
  Color disabledShadowColor;

  // editing the shape of the menu item container
  // the default shape is circular shape
  BoxShape btnShape;

  MenuItem(
      {required this.icon,
      required this.id,
      required this.isSelected,
      this.selectedBtnColor = const Color.fromRGBO(38, 198, 218, 1),
      this.disabledBtnColor = Colors.transparent,
      this.selectedShadowColor = Colors.blueGrey,
      this.disabledShadowColor = Colors.transparent,
      this.btnShape = BoxShape.circle});
}


/*--------------------------------------------------------------------------*/
/*-----------------------  radio model  ----------------------------*/
/*--------------------------------------------------------------------------*/
class RadioModel {
  bool isSelected;
  final String icon;
  final String id;
  final Color selectedBtnColor;
  final Color disabledBtnColor;
  final Color selectedShadowColor;
  final Color disabledShadowColor;
  final BoxShape btnShape;

  RadioModel(
      this.isSelected,
      this.icon,
      this.id,
      this.selectedBtnColor,
      this.disabledBtnColor,
      this.selectedShadowColor,
      this.disabledShadowColor,
      this.btnShape);
}

class Menu {
  final List<MenuItem>? items;

  Menu({
    this.items,
  });
}
