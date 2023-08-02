import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiligrim/utils/pallete.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Hero(
                  tag: 'logo', 
                  child: Image.asset('assets/telegram.png')
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ayo Daftar di Tiligrim',
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 110),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '+62',
                            fillColor: const Color.fromARGB(255, 243, 243, 243),
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 10),
                              color: Pallete.primary,
                              child: const Icon(
                                Icons.phone_outlined, 
                                color: Colors.white
                              )
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Kata Sandi',
                            isDense: true,
                            fillColor: const Color.fromARGB(255, 243, 243, 243),
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 10),
                              color: Pallete.primary,
                              child: const Icon(
                                Icons.lock_outline_rounded, 
                                color: Colors.white,
                                size: 23,
                              )
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/login'), 
                            child: const Text('Masuk'),
                          ),
                          ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.primary,
                              fixedSize: const Size(120, 40)
                            ), 
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/wave.svg',
                  height: 180, 
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}