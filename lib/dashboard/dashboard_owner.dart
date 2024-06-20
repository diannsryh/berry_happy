import 'package:berry_happy/components/customsearch.dart';
import 'package:berry_happy/cubit/cubit/auth_cubit.dart';
import 'package:berry_happy/dto/menu.dart';
import 'package:berry_happy/endpoints/endpoints.dart';
import 'package:berry_happy/menu/add_menu.dart';
import 'package:berry_happy/menu/edit_menu.dart'; // Import the EditMenu page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:berry_happy/services/data_service.dart';

class DashboardOwner extends StatefulWidget {
  const DashboardOwner({Key? key}) : super(key: key);

  @override
  State<DashboardOwner> createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  Future<List<Menu>>? _menu;
  late TextEditingController _searchController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchData(currentPage);
  }

  void _fetchData(int page) {
    setState(() {
      _menu = DataService.fetchMenu1(currentPage, _searchController.text);
    });
  }

  void _incrementPage() {
    setState(() {
      currentPage++;
      _fetchData(currentPage);
    });
  }

  void _decrementPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        _fetchData(currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 204, 229),
        title: Text('Berry Happy'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 204, 229),
              ),
              child: Text(
                'Berry Happy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                authCubit.logout();
                Navigator.pushReplacementNamed(context, '/login-screen');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 204, 229),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBox(
                    controller: _searchController,
                    onChanged: (value) => _fetchData(currentPage),
                    onClear: (value) => _fetchData(currentPage),
                    hintText: 'search'),
              ),

              const Divider(color: Colors.white),

              // Profile, Restaurant Name, and Rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/logo.png'), // Add your image asset here
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Berry Happy Cafe',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < 4 ? Colors.yellow : Colors.grey,
                                size: 20,
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 204, 229),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: FutureBuilder<List<Menu>>(
                  future: _menu,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.menuName}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: const Color.fromARGB(
                                                  255, 36, 31, 31),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Rp. ${item.menuPrice}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                  255, 36, 31, 31),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${item.descMenu}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color.fromARGB(
                                                  255, 36, 31, 31),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (item.imageUrl != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                Uri.parse(
                                                        '${Endpoints.baseUAS}/static/storages/${item.imageUrl!}')
                                                    .toString(),
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(Icons.error),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.blue),
                                                  onPressed: () {
                                                    _editMenu(item);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    // Handle delete action
                                                    _deleteMenu(item.idMenu);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              // Increment and Decrement Page Buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _decrementPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: Text(
                        "Previous Page",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _incrementPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: Text(
                        "Next Page",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMenu()),
          );
          if (result == true) {
            setState(() {
              _menu = DataService.fetchMenu();
            });
          }
        },
        backgroundColor: const Color.fromARGB(225, 223, 6, 112),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editMenu(Menu menu) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditMenu(menu: menu)),
    );
    if (result == true) {
      setState(() {
        _menu = DataService.fetchMenu();
      });
    }
  }

  void _deleteMenu(int menuId) async {
    final success = await DataService.deleteMenu(menuId);
    if (success) {
      setState(() {
        _menu = DataService.fetchMenu();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete menu')),
      );
    }
  }
}
