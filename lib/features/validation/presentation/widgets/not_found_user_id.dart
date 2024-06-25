import 'package:flutter/material.dart';

class NotFoundUserId extends StatelessWidget {
  const NotFoundUserId({
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
                'No se pudo obtener el id del usuario',
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
