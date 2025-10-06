import 'package:cafe/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class InfoAboutDialog extends StatefulWidget {
  List extras = [];
  String note = '';
  InfoAboutDialog({super.key, required this.extras, required this.note});

  @override
  State<InfoAboutDialog> createState() => _InfoAboutDialogState();
}

class _InfoAboutDialogState extends State<InfoAboutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CColors.primary,
      title: Center(child: const Text("Weitere Informationen")),
      content: Container(
        width: 500,
        height: 500,
        child: Column(
          children: [
            // Text('Extras', style: Theme.of(context).textTheme.bodyLarge),
            // ...widget.extras.map(
            //   (extra) => Row(
            //     children: [
            //       Text('• ', style: Theme.of(context).textTheme.bodyMedium),
            //       Text(extra, style: Theme.of(context).textTheme.bodyMedium),
            //     ],
            //   ),
            // ),
            Column(
              children: [
                Text('Notes'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('• ', style: Theme.of(context).textTheme.bodyMedium),
                    Text(widget.note),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK", style: Theme.of(context).textTheme.headlineMedium),
        ),
      ],
    );
  }
}
