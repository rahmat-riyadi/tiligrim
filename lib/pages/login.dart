import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tiligrim/bloc/authentication/authentication_bloc.dart';
import 'package:tiligrim/utils/pallete.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          
          if(state is AuthenticationFailure){
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: const Text('Gagal'),
                content: Text(state.message),
              ),
            );
          }

          if(state is AuthenticationSuccess){
            Navigator.pushReplacementNamed(context, '/home');
          }

        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 150),
              Transform.scale(
                scale: 1.5,
                child: Lottie.asset(
                  'assets/logo_anim.json',
                ),
              ),
              const Text(
                'Talagram',
                style: TextStyle(
                  color: Pallete.primary,
                  fontSize: 31,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 60),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 100,
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 10),
                  ),
                  items: const [
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Chat gaul asik, kekinian, dan seru. Hiburannya dalam genggamanmu! 🐒',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.6
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Kecilkan jarak, chat gaul, jalin hubungan tanpa batas! 👋',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.6
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Ayo Selingkuh dengan aman di platform kami! 🫶🏻',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.6
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: (){
                  context.read<AuthenticationBloc>().add(AuthenticationSubmit());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.primary,
                  elevation: 0,
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 48),
                ), 
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 21
                  ),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Rahmat Riyadi Syam'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          )
        ),
      ),
    );
  }
}
