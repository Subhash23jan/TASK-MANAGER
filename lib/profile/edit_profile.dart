import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/shared%20pref/shared_pref.dart';
import 'package:todo/profile/profile_page.dart';

class UserProfileEditScreen extends StatefulWidget {
  UserProfileEditScreen({super.key});

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  late SharedPreferences preferences;
  bool isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialise();
  }

  initialise() async {
    preferences = await SharedPreferences.getInstance();
    _nameController.text = preferences.getString("NAME") ?? "";
    _emailController.text = preferences.getString("EMAIL") ?? "";
    await Future.delayed(const Duration(seconds: 1)); // Simulate a 2-second delay
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
        title: Text("Edit Profile",style: GoogleFonts.manrope(color: Colors.white,fontSize: 18),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back),color: Colors.white,),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),
      ) : Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlue],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextFormField(
                      controller: _nameController,
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextFormField(
                      controller: _emailController,
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      // Save changes action
                      UserPref.setUser(_nameController.text, _emailController.text,preferences.getString("PASSWORD")??"0", preferences.getString("NODE")??"0", preferences.getString("TOKEN")??"0");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Data Updated Successfully"),duration: Duration(milliseconds: 300),));
                      await Future.delayed(const Duration(seconds: 1));
                      if(context.mounted){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return UserProfileScreen();
                        },));
                      }
                      // Optionally show a success message or navigate to another screen
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      primary: Colors.orangeAccent,
                      onPrimary: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text(
                      "Save Changes",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
