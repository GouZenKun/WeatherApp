import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == '/'
        ? ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/setting');
          },
          child: const Icon(Icons.settings),
        )
        : ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: const Icon(Icons.home),
        );
  }
}
