// DeleteConfirmationDialog.dart
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Confirmation"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Handle delete action
            // You can add your delete logic here

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}
