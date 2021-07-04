import 'package:assosnation_app/utils/imports/commons.dart';

class GamificationBadge extends StatelessWidget {
  final int likeNumber;
  final Color color;
  final int numberToReach;
  final IconData icon;
  final String title;
  final String content;

  GamificationBadge(this.likeNumber, this.color, this.numberToReach, this.icon,
      this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon:
            Icon(icon, color: likeNumber > numberToReach ? color : Colors.grey),
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(title,
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor)),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        Icon(
                          Icons.thumb_up_sharp,
                          color:
                              likeNumber > numberToReach ? color : Colors.grey,
                        ),
                        Text(content,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                )));
  }
}
