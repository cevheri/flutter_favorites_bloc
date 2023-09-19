import 'package:flutter/material.dart';

/// [Loading] widget is used to show the common loading indicator in the app <br>
/// The [Loading] widget is a [StatelessWidget] because it does not need to change its state <br>
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
