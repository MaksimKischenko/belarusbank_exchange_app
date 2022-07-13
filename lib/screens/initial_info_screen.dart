import 'package:belarus_exchange_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'widgets.dart/widget.dart';

class InitialInfoScreen extends StatefulWidget {
  const InitialInfoScreen({Key? key}) : super(key: key);

  @override
  InitialInfoScreenState createState() => InitialInfoScreenState();
}

class InitialInfoScreenState extends State<InitialInfoScreen> {
  int selectedBottomNavigationIndex = 0;

  static final List<Widget> _widgetOptions = [
    const StepsOfSearch(),
    const ExchangeTable(),
    const InformationBank()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.mainColor,
          centerTitle: true,
          title: const InitialTitle(),
          actions: [
            IconButton(icon: const Icon(Icons.logout), onPressed: () {}),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(38),
                        child: Image.asset('assets/avatar.jpg',
                            height: 80, width: 80, fit: BoxFit.cover)),
                    const SizedBox(height: 10),
                    const Text('Кищенко Максим',
                        style: TextStyle(color: Colors.white))
                  ],
                ),
                decoration: const BoxDecoration(
                  color: AppStyles.mainColor,
                ),
              ),
              ListTile(
                title: const Text('О пользователе'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Выход'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                late double width;
                if (sizingInformation.isMobile || sizingInformation.isTablet) {
                  width = sizingInformation.screenSize.width;
                }
                return SizedBox(
                  width: width,
                  child: Responsive(
                    runSpacing: 16,
                    children: [
                      Div(
                        colL: 12,
                        colM: 12,
                        child: Container(
                          child: _widgetOptions
                              .elementAt(selectedBottomNavigationIndex),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Выбор региона',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Обменные курсы',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Информация',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: selectedBottomNavigationIndex,
          selectedItemColor: AppStyles.mainColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedBottomNavigationIndex = index;
    });
  }
}
