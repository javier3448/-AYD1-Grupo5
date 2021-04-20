import 'package:app_students/src/pages/admin_delete.dart';
import 'package:app_students/src/pages/admin_home.dart';
import 'package:app_students/src/pages/estudiantes.dart';
import 'package:flutter/material.dart';

class Admin_Tabs extends StatefulWidget {
  Admin_Tabs({Key key}) : super(key: key);

  @override
  _Admin_TabsState createState() => _Admin_TabsState();
}

class _Admin_TabsState extends State<Admin_Tabs> {
  int _index = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void SalirSesion(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("ADMINISTRADOR"),
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
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _index = index);
        },
        children: [Admin_page(), Estudiantes(), Delete_page()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //para cambiar de paginas usando el navbar
        onTap: (index) {
          setState(() {
            _index = index;
          });
          _controller.animateToPage(_index,
              duration: Duration(milliseconds: 150), curve: Curves.easeInCirc);
        },
        currentIndex: _index,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Color.fromRGBO(183, 188, 201, 1),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Estudiantes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined), label: "Cursos"),
        ],
      ),
    );
  }
}
