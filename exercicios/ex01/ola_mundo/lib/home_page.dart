import 'package:flutter/material.dart';
import 'package:ola_mundo/app_controller.dart';
import 'package:ola_mundo/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Mostra a opção menu ao lado esquerdo
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/images/user.png')),
                accountName: Text('André Luis'),
                accountEmail: Text('andre@gmail.com')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              subtitle: Text('Tela de início'),
              onTap: () {
                print('Menu Lateral');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              subtitle: Text('Finalizar Sessão'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
          title: const Text('Home Page'),
          actions: [CustomSwitch()],
          backgroundColor: Colors.blue),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          //ListView funciona como column mas cria um scroll
          // scrollDirection: Axis.horizontal fsz o scroll funcionar na horizontal
          mainAxisAlignment:
              MainAxisAlignment.center, //centraliza quando usa Column
          children: [
            Text(
              'Contador $counter',
              style: TextStyle(fontSize: 30),
            ),
            CustomSwitch(),
            Container(
              height: 30,
            ),
            MyRows(),
          ],
        ),
      ),
      // Container(
      //   height: 200,
      //   width: 200,
      //   color: Colors.black,
      //   child: Center(
      //     child: Container(
      //       height: 100,
      //       width: 100,
      //       color: Colors.green,
      //     ),
      //   ),
      // ),
      //     Center(
      //   child: GestureDetector(
      //     child: Text(
      //       'Contador: $counter',
      //       style: const TextStyle(fontSize: 30),
      //     ),
      //     onTap: () {
      //       setState(() {
      //         counter++;
      //       });
      //     },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}

class MyRows extends StatelessWidget {
  const MyRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
        )
      ],
    );
  }
}
