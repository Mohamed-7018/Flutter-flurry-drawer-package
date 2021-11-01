library flutter_flurry_drawer;

import 'package:flutter/material.dart';

/// A beautiful and animated flurry Drawer navigation that paints a rounded shape
/// around its corner to provide a wonderful look.
///
/// Update [itemId] to change the selected page.
/// [itemId] is required and must not be null.



/*--------------------------------------------------------------------------*/
/*-----------------------  Flurry Drawer state  ----------------------------*/
/*--------------------------------------------------------------------------*/
enum MenuState {
  closed,
  opening,
  open,
  closing,
}

/*--------------------------------------------------------------------------*/
/*---------------------  Flurry Drawer Main Class  -------------------------*/
/*--------------------------------------------------------------------------*/
class FlurryDrawer extends StatefulWidget {
  // The content of the menu screen
  // Widget of data type MenuScreen
  // This widget consists of bottom section, bg (BackGround color) , menu List
  // which is the menu items components,
  /// The selected item in this menu itemId. Changing this property will change and animate
  /// the screen being selected. Defaults to zero.
  final Widget menuScreen;

  //The active Screen
  /// The selected item in the menu screen is a Screen widget . Changing this property will change and animate
  /// the screen being selected.
  final Screen contentScreen;

  // The Icon data of the icon the BottomLeft
  // The Expanded icon is a widget data type
  // in other words the expanded icon can be image or icon
  final Widget expandIcon;

  // The size of the icon on the BottomLeft
  ///  Default Icon size = ((MediaQuery.of(context).size.width *
  //           MediaQuery.of(context).size.height) /
  //           15420),
  final double? iconSize;

  // The Icon alignment of the icon in the scaffold
  // default alignment is bottom left
  final Alignment? alignment;

  // The curve of the screen (Double)
  //Default curveRadius =  (MediaQuery.of(context).size.width *
  //           MediaQuery.of(context).size.height) /
  //           4980,
  final double? curveRadius;

  FlurryDrawer({
    required this.menuScreen,
    required this.contentScreen,
    required this.expandIcon,
    this.iconSize,
    this.curveRadius,
    this.alignment,
  });

  @override
  _FlurryDrawerState createState() => new _FlurryDrawerState();
}

class _FlurryDrawerState extends State<FlurryDrawer>
    with TickerProviderStateMixin {
  MenuController? menuController;
  Curve scaleDownCurve = new Interval(0.0, 1.0, curve: Curves.linear);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.linear);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.elasticOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.ease);

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController!.dispose();
    super.dispose();
  }

/*--------------------------------------------------------------------------*/
/*---------------  Displaying Content screen Function  ---------------------*/
/*--------------------------------------------------------------------------*/
  createContentDisplay() {
    return zoomAndSlideContent(
      new Container(
        child: new Scaffold(
            body: Column(children: <Widget>[
          Expanded(
            child: widget.contentScreen.contentBuilder!(context),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: widget.expandIcon,
                onPressed: () {
                  menuController!.toggle();
                },
                alignment: widget.alignment == null
                    ? Alignment.bottomLeft
                    : widget.alignment!,
                padding: EdgeInsets.all(0),
                iconSize: widget.iconSize != null
                    ? widget.iconSize!
                    : ((MediaQuery.of(context).size.width *
                            MediaQuery.of(context).size.height) /
                        15420),
              )
            ],
          ),
        ])),
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    //slidePercent is not used right now but it may be used in future versions
    late var scalePercent;
    switch (menuController!.state) {
      case MenuState.closed:
        //slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        //slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        //slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController!.percentOpen);
        break;
      case MenuState.closing:
        //slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController!.percentOpen);
        break;
    }
    var contentScale;
    double cornerRadius = 0;
    return OrientationBuilder(builder: (context, orientation) {
      contentScale = 1.0 - (0.3 * scalePercent);
      cornerRadius = widget.curveRadius == null
          ? (MediaQuery.of(context).size.width *
                  MediaQuery.of(context).size.height) /
              4980 *
              menuController!.percentOpen
          : widget.curveRadius! * menuController!.percentOpen;

/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Transform animation -----------------------*/
/*--------------------------------------------------------------------------*/
      return new Transform(
        transform: new Matrix4.translationValues(0.0, 0.0, 0.0)
          ..scale(contentScale, contentScale),
        alignment: orientation == Orientation.portrait
            ? Alignment.topRight
            : Alignment.topRight,
        child: new ClipRRect(
            borderRadius: new BorderRadius.only(
                bottomLeft: Radius.circular(cornerRadius)),
            child: content),
      );
    });
  }

/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Return Function  -----------------------*/
/*--------------------------------------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    // The flurry drawer can be implemented as two screens above each other
    // when the main is screen is opened, the menu screens appears.
    // The way to implement two pages above each other in flutter take place
    // by using stack widget as shown below
    return Stack(
      children: [
/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Menu Screen  -----------------------*/
/*--------------------------------------------------------------------------*/
        // The menu Screen will be enterd by the user. The menu screen extends
        //from Menu Screen widget
        widget.menuScreen,
/*--------------------------------------------------------------------------*/
/*---------------  Flurry Drawer main(content) Screen  ---------------------*/
/*--------------------------------------------------------------------------*/
        //The active Screen
        /// The selected item in the menu screen is a Screen widget . Changing this property will change and animate
        /// the screen being selected.
        createContentDisplay(),
      ],
    );
  }
}


/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Menu Controller  ------------------------*/
/*--------------------------------------------------------------------------*/
//The active Screen
/// The selected item in the menu screen is a Screen widget . Changing this property will change and animate
/// the screen being selected.
class FlurryNavigationMenuController extends StatefulWidget {
  final FlurryNavigationBuilder? builder;

  FlurryNavigationMenuController({
    this.builder,
  });

  @override
  FlurryNavigationMenuControllerState createState() {
    return new FlurryNavigationMenuControllerState();
  }
}

class FlurryNavigationMenuControllerState
    extends State<FlurryNavigationMenuController> {
  MenuController? menuController;

  @override
  void initState() {
    super.initState();

    menuController = getMenuController(context);
    menuController!.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController!.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    final navigationState =
        context.findAncestorStateOfType<_FlurryDrawerState>()!;
    // context.findAncestorStateOfType()
    //context.ancestorStateOfType(new TypeMatcher<_FlurryNavigationState>())
    // as _FlurryDrawerState;
    return navigationState.menuController;
  }


  /// Updating the screen when the menu controller state is changed
  _onMenuControllerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder!(context, getMenuController(context));
  }
}


typedef Widget FlurryNavigationBuilder(
    BuildContext context, MenuController? menuController);



/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Screen class  ------------------------*/
/*--------------------------------------------------------------------------*/
// the pages of the flurry drawer is using screen widget
class Screen {
  // content builder
  final WidgetBuilder? contentBuilder;

  Screen({
    this.contentBuilder,
  });
}


/*--------------------------------------------------------------------------*/
/*-----------------  Flurry Drawer Menu Controller  ------------------------*/
/*--------------------------------------------------------------------------*/
// provider of the menu controller
class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    required this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 300)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }


  // open the drawer
  open() {
    _animationController.forward();
  }

  // close the drawer
  close() {
    _animationController.reverse();
  }


  // toggle the drawer
  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

