import 'package:app_students/src/pages/calendar.dart';
import 'package:app_students/src/pages/home.dart';
import 'package:app_students/src/pages/profile.dart';
import 'package:flutter/material.dart';

class Controller_page extends StatefulWidget {
  Controller_page({Key key}) : super(key: key);

  @override
  _Controller_pageState createState() => _Controller_pageState();
}

class _Controller_pageState extends State<Controller_page> {
  int _index = 0;
  PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //instanciamos nuestro controlador
    _controller = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //liberamos nuestros recuersos, en este caso el controlador
    _controller.dispose();
  }

  void SalirSesion(BuildContext context) {
    Navigator.of(context).pushNamed("login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Universidad"),
        actions: [
          Padding(
              padding: EdgeInsets.all(5.0),
              child: PopupMenuButton(
                onSelected: (result) {
                  if (result == 0) {
                    SalirSesion(context);
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Acerca de"),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cerrar Sesion"),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
      body: PageView(
        //aqui definimos nuestro _controler
        controller: _controller,
        //bloqueamos el swipe horizontal
        physics: NeverScrollableScrollPhysics(),
        //para cambiar nuestra pagina
        onPageChanged: (index) {
          setState(() => _index = index);
        },
        children: [Profile_page(), Home_page(), Calendar_page()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //para cambiar de paginas usando el navbar
        onTap: (index) {
          setState(() {
            _index = index;
          });
          _controller.animateToPage(_index,
              duration: Duration(milliseconds: 250), curve: Curves.easeInCirc);
        },
        currentIndex: _index,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Color.fromRGBO(183, 188, 201, 1),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin), label: "Perfil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar), label: "Horario"),
        ],
      ),
    );
  }
}
