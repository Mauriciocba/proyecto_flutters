import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8 * 3),
              Image(
                image: AssetImage("assets/user_id_not_found.png"),
                width: 500,
              ),
              SizedBox(height: 8 * 3),
              Text(
                'No se pudo verificar el código',
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
