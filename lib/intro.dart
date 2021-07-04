import 'package:assosnation_app/components/scaffolds/association_scaffold.dart';
import 'package:assosnation_app/components/scaffolds/user_scaffold.dart';
import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  final scaffoldType;
  IntroScreen(this.scaffoldType, {Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Bienvenue sur AssosNation !",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Nous vous souhaitons la bienvenue sur le nouveau réseau social consacrée au domaine associatif ! ",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        centerWidget: Image.asset(
          Constants.fullLogoPath,
          height: 200,
        ),
        backgroundColor: Colors.teal[300],
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        title: "Entraidons nous ! ",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "AssosNation permet de découvrir des associations près de chez soi, et de pouvoir suivre leur actualité en toute simplicité.",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        centerWidget: Image.asset(
          "assets/help.png",
          height: 200,
        ),
        backgroundColor: Colors.teal[300],
      ),
    );
    slides.add(
      new Slide(
        title: "Créons le contact !",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Avec notre application, vous pouvez contacter directement nos associations partenaires via notre messagerie intégrée ! ",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        centerWidget: Image.asset(
          "assets/smartphone.png",
          height: 200,
        ),
        backgroundColor: Colors.teal[300],
      ),
    );
    slides.add(
      new Slide(
        title: "Place à l'inscription !",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Inscrivez vous et rejoignez notre communauté ! Vous verrez, c'est facile ! ",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        centerWidget: Image.asset(
          "assets/community.png",
          height: 200,
        ),
        backgroundColor: Colors.teal[300],
      ),
    );
  }

  void onDonePress() {
    if (widget.scaffoldType == "UserScaffold") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserScaffold()),
      );
    } else if (widget.scaffoldType == "AssociationScaffold") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AssociationScaffold()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Image.asset(
                      Constants.fullHorizontalLogoPath,
                      fit: BoxFit.cover,
                      scale: Constants.appBarLogoScale,
                    ),
                  ),
                  body: Center(child: Authentication()),
                )),
      );
    }
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.teal,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.teal,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.teal,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.all<Color>(Colors.tealAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Colors.grey,
      colorActiveDot: Colors.white,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: false,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
