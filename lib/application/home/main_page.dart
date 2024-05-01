import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/home/home_screen.dart';
import 'package:productive_families_admin/application/orders/screens/orders_sreen.dart';
import 'package:productive_families_admin/application/other/other_screen.dart';
import 'package:productive_families_admin/application/stores/screens/store.dart';
import 'package:productive_families_admin/application/widgets/app_bar_widget.dart';
import 'package:productive_families_admin/core/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List screens = [
    const HomeScreen(),
    const StoreScreen(),
    // const OrdersTabScreen()
    const OtherScreen()
  ];
  int _page = 0;

  @override
  void initState() {
    // initPusher(context);
    // BlocProvider.of<NotificationsBloc>(context)
    //     .add(GetNotificationsCountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => NotificationsScreen(),
        //             ));
        //       },
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.white,
        //       ))
        // ],
        actions: [
          Visibility(
            visible: true,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersTabScreen(),
                      ));

                  // Navigator.of(context, rootNavigator: true).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const NotificationsScreen(),
                  //   ),
                  // );
                },
                child:
                    // BlocBuilder<NotificationsBloc, NotificationsState>(
                    //   builder: (context, state) {
                    //     return
                    const Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    // Visibility(
                    //   // visible: (state.notificationsCount != null &&
                    //   //     state.notificationsCount! > 0),
                    //   child: Positioned(
                    //       top: 2,
                    //       right: 5,
                    //       child: Center(
                    //         child: Container(
                    //           decoration: const BoxDecoration(
                    //               shape: BoxShape.circle, color: Colors.red),
                    //           child: const Padding(
                    //             padding: EdgeInsets.all(4.0),
                    //             child: Center(
                    //               child: Text(
                    //                 '2',
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    // ),
                  ],
                )
                //   },
                // ),
                ),
          ),
        ],
        title: (_page == 0)
            ? const Text("Home")
            : (_page == 1)
                ? const Text("Stores")
                : const Text("Orders"),
        backgroundColor: AppColors.appColor,
      ),
      extendBody: true,
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: 55,
        items: [
          (_page != 0)
              ? const Icon(Icons.home_outlined, size: 30, color: Colors.white)
              : Icon(Icons.home, size: 30, color: AppColors.appColor),
          (_page != 1)
              ? const Icon(
                  Icons.store_mall_directory_outlined,
                  size: 30,
                  color: Colors.white,
                )
              : Icon(Icons.store_mall_directory,
                  size: 30, color: AppColors.appColor),
          (_page != 2)
              ? const Icon(Icons.settings_applications,
                  size: 30, color: Colors.white)
              : Icon(Icons.settings_applications_outlined,
                  size: 30, color: AppColors.appColor),
        ],
        color: AppColors.appColor,
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      // child: Container(
      //   padding: EdgeInsets.all(12),
      //   margin: EdgeInsets.symmetric(horizontal: 24),
      //   decoration: BoxDecoration(
      //       color: Colors.grey.shade300,
      //       borderRadius: BorderRadius.all(Radius.circular(24))),
      // ),
    );
  }
}
