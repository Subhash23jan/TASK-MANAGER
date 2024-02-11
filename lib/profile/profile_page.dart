import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/profile/edit_profile.dart';
import 'package:todo/view/splash/splash_screen.dart';

import '../data/shared pref/shared_pref.dart';
import '../view/home/home.dart';
import '../view_model/controller/home_controller.dart';
import '../view_model/controller/new_task_controller.dart';

class UserProfileScreen extends StatefulWidget {
   UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late SharedPreferences preferences;
  RxMap userData = {}.obs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialise();
  }

  initialise() async {
    preferences = await SharedPreferences.getInstance();
   // userData.value = await UserPref.getUser();
    await Future.delayed(const Duration(seconds: 2)); // Simulate a 2-second delay
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Profile Page",style: GoogleFonts.manrope(color: Colors.white,fontSize: 18),),
        leading: IconButton(onPressed: (){
          final homeController=Get.put(HomeController());
          final newTaskController=Get.put(NewTaskController());
          homeController.getTasks();
          Get.to(HomePage());Get.to(HomePage());
        }, icon:const Icon(Icons.arrow_back),color: Colors.white,),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),
      ) :Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlue],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/image.png'), // Replace with actual user image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width*0.8,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20), // Rounded corners example
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child:Text(
                    preferences.getString("NAME")??"loading....",
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      color: Colors.white,
                      // Custom font example
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.sizeOf(context).width*0.8,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20), // Rounded corners example
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    preferences.getString("EMAIL")??"loading....",
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      color: Colors.white,
                       // Custom font example
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Perform logout action
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return UserProfileEditScreen();
                    },));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300,60),
                    primary: Colors.orangeAccent,
                    onPrimary: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      // Custom font example
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Perform logout action
                    preferences.clear();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SplashView();
                    },));
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300,60),
                    primary: Colors.orangeAccent,
                    onPrimary: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    "Logout",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      // Custom font example
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
