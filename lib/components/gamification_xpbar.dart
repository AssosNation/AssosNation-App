import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/imports/commons.dart';

class GamificationXpBar extends StatelessWidget {
  const GamificationXpBar({Key? key, required this.exp, required this.level})
      : super(key: key);

  final int exp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      LinearProgressIndicator(
        value: (exp % Constants.xpToLevelMultiplier) /
            Constants.xpToLevelMultiplier,
        backgroundColor: Colors.teal[100],
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        minHeight: 20,
        color: Colors.teal[200],
      ),
      Align(
          alignment: Alignment.center,
          child:
              Text("$exp exp", style: Theme.of(context).textTheme.subtitle1)),
    ]);
  }
}
