import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiligrim/bloc/authentication/authentication_bloc.dart';
import 'package:tiligrim/utils/pallete.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {

        state as AuthenticationSuccess;
        
        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(state.user.displayName), 
                accountEmail: Text(state.user.email),
                currentAccountPicture: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70
                  ),
                  child: Image.network(
                    state.user.photoUrl,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      size: 28,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded, 
                  color:Pallete.primary,
                  size: 26,
                ),
                title: const Text('Keluar'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false).then((value){
                    context.read<AuthenticationBloc>().add(AuthenicationSignOut());
                  });
                },
              ),
            ],
          ),
        );


      },
    );
  }
}
