import 'package:flutter/material.dart';

class EditPostDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () {}, child: Text("Validate")),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
