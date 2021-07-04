import 'package:assosnation_app/components/scaffolds/user_scaffold.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
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
            "Nous vous souhaitons la bienvenue sur le nouveau réseau social du domaine associatif",
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
        title: "Bienvenue sur AssosNation !",
        maxLineTitle: 2,
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        backgroundColor: Colors.teal,
      ),
    );
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
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserScaffold()),
    );
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
      colorDot: Color(0x33FFA8B0),
      colorActiveDot: Colors.white,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
