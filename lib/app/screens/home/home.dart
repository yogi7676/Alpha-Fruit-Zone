import 'package:alphauser/app/constants/app_colors.dart';

import 'package:alphauser/app/helpers/network_manager.dart';
import 'package:alphauser/app/screens/home/widgets/drawer.dart';
import 'package:alphauser/app/screens/mycart/mycart.dart';
import 'package:alphauser/app/screens/home/widgets/products_widget.dart';
import 'package:alphauser/app/screens/no_internet/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NetworkManager manager = Get.find();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? searchText;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() async {
      if (searchController.text.isNotEmpty) {
        setState(() {
          searchText = searchController.text;
        });
      } else {
        setState(() {
          searchText = null;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkManager>(
        builder: (builder) => manager.connectionType == 0
            ? NoInternet()
            : Scaffold(
                key: _scaffoldKey,
                drawer: const MyDrawer(),
                appBar: AppBar(
                  title: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          hintText: 'Type here..',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppColors.white),
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () => Get.to(() => MyCart()),
                        icon: const Icon(Icons.favorite))
                  ],
                ),
                body: ProductWidget(
                  isSearching: searchText,
                )));
  }
}
