import 'package:curso_basico_flutter/BottomNavigation.dart';
import 'package:curso_basico_flutter/background.dart';
import 'package:curso_basico_flutter/dashboard.dart';
import 'package:curso_basico_flutter/targetas.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  void _onPressedDashboard(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const Dashboard();
      },
    ));
  }

  void _onPressedHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const Home();
      },
    ));
  }

  void _onPressedBackground(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const BackgroundPage();
      },
    ));
  }

  void _onPressedTarjetas(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const Tarjetas();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  BottomNavigation(), appBar: AppBar(
        title: const Center(
          child: Text(
            "Curso de Flutter",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.white,
        actions: const [
          Icon(Icons.person, color: Colors.black12),
          Icon(
            Icons.settings,
            color: Colors.amber,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _onPressedDashboard(context);
                },
                child: Container(
                  width: 250.0,
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: const Center(
                    child: Text(
                      "Hola mundo",
                      style: TextStyle(color: Colors.white, fontSize: 28.0),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "En este curso, estamos aprendiendo Flutter, con los estudiantes de la carrera de software," +
                      "y estudiantes apasionados con la programación y el desarrollo de aplicaciones",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      _onPressedDashboard(context);
                    },
                    child: const Text("Dahsboard"),
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10.0),
                  MaterialButton(
                    onPressed: () {
                      _onPressedBackground(context);
                    },
                    child: const Text("Background"),
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10.0),
                  MaterialButton(
                    onPressed: () {
                      _onPressedTarjetas(context);
                    },
                    child: const Text("Tarjetas"),
                    color: Colors.amber,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
