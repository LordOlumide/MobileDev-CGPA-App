import 'package:flutter/material.dart';

class DeletePopup extends StatelessWidget {
  final String objectToDeleteName;
  const DeletePopup({Key? key, required this.objectToDeleteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                'Are you sure you want to delete $objectToDeleteName?',
                style: TextStyle(
                    fontSize: 14.5,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400),
              ),
            ),

            const Divider(height: 1),

            // actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel button
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Delete button
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
