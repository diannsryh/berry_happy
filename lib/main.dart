import 'package:berry_happy/cart/cart_screen.dart';
import 'package:berry_happy/cubit/cart/cart_cubit.dart';
import 'package:berry_happy/cubit/cubit/auth_cubit.dart';
// import 'package:berry_happy/cart/payment_screen.dart';
import 'package:berry_happy/dashboard/dashboard_consumer.dart';
import 'package:berry_happy/dashboard/dashboard_owner.dart';
import 'package:berry_happy/launch/launch_screen.dart';
import 'package:berry_happy/login/login_screen.dart';
import 'package:berry_happy/login/main_login.dart';
import 'package:berry_happy/menu/add_menu.dart';
import 'package:berry_happy/menu/edit_menu.dart';
import 'package:berry_happy/navigation/navigation.dart';
import 'package:berry_happy/profile/profile_consumer.dart';
import 'package:berry_happy/setting/setting_screen.dart';
import 'package:berry_happy/sign up/signup_screen.dart';
import 'package:berry_happy/utils/auth_wrapper.dart';
import 'package:berry_happy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:berry_happy/cart/payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LaunchScreen(),
        routes: {
          '/login-screen': (context) => const LoginScreen(),
          '/cart': (context) => CartScreen(),
          '/main-login': (context) => const MainLogin(),
          '/signup-screen': (context) => const SignUp(),
          '/my-homepage': (context) => const MyHomePage(),
          '/payment': (context) => const PaymentWidget(),
          '/add-menu': (context) => const AddMenu(),
          '/dashboard-consumer': (context) =>
              AuthWrapper(child: DashboardConsumer()),
          '/dashboard-owner': (context) => AuthWrapper(child: DashboardOwner()),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  final List<Widget> screens = [
    //a list of widget objects that represent the various screens available in the application.
    const DashboardConsumer(),
    const ConsumerProfile(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 250, 143, 195),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 204, 229),
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const SizedBox(width: 20),
                  Text('BERRY HAPPY',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(width: 95),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Stack(children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.shopping_cart, color: Colors.black),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )),
        body: screens[activeIndex], //body will display the current active index
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Constants.scaffoldBackgroundColor,
            buttonBackgroundColor: Constants.primaryColor,
            color: const Color.fromARGB(255, 255, 204, 229),
            items: [
              Icon(
                Icons.home,
                size: 30.0,
                color: activeIndex == 0 ? Colors.white : Constants.activeMenu,
              ),
              Icon(
                Icons.person,
                size: 30.0,
                color: activeIndex == 1 ? Colors.white : Constants.activeMenu,
              ),
              Icon(
                Icons.settings,
                size: 30.0,
                color: activeIndex == 2 ? Colors.white : Constants.activeMenu,
              ),
            ],
            onTap: (index) {
              setState(() {
                activeIndex = index;
              });
            }),
        drawer: Drawer(
            child: ListView(
          //is used to display a list of items in order, either vertically or horizontally.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 126, 188),
              ),
              child: Text(
                'Berry Happy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              //combination with list view to make items organized
              title: const Text('API'),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => NewsScreen()));
              },
            ),
            ListTile(
              //combination with list view to make items organized
              title: const Text('Payment Screen'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentWidget()));
              },
            ),
          ],
        )));
  }
}
