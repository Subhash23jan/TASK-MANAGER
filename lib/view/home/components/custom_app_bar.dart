
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/view_model/controller/home_controller.dart';
import '../../../res/constants.dart';
import '../../../view_model/responsive.dart';

class CustomAppBar extends StatefulWidget {
   CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
   final controller=Get.put(HomeController());
   late SharedPreferences sharedPreferences;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          if(Responsive.isTablet(context)) const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 2,
                  fontSize: 18
              ),),
              Obx(() => Text(sharedPreferences.getString("NAME")??controller.name.value,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 0,
                  fontSize: 25
              ),),)
            ],
          ),
           const Spacer(flex: 10,),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkAccentBlue,
                boxShadow: const [
                  BoxShadow(
                      color: lightAccentBlue,
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )
                ]
            ),
            child: const Icon(Icons.account_circle_outlined,color: Colors.white,),
          ),
          if(Responsive.isTablet(context)) const Spacer(),
        ],
      ),
    );
  }

  Future<void> initialise() async {
     sharedPreferences=await SharedPreferences.getInstance();
  }
}
