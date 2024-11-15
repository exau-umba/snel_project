import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snel_project/features/authentication/compte_snel/screens/abonnement.dart';
import 'package:snel_project/features/paiement/screens/paiement.dart';
import 'package:snel_project/pages/Dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:snel_project/utils/components/components.dart';
import '../../../utils/constate.dart';
import '../../settings/screens/setting.dart';
import '../bottom_navigation/navigation_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is HomeState) {
            return DashboardScreen();
          } else if (state is PaiementState) {
            return Center(child: Paiement());
          } else if (state is SettingsState) {
            return Center(child: Setting());
          } else if(state is PrepayeState){
           return Center(child: Abonnement(),);
          }
          return DashboardScreen(); // État par défaut
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 16.sp,
        unselectedItemColor: t12_text_secondary,
        elevation: 0.sp,
        type: BottomNavigationBarType.shifting,
        enableFeedback: false,
        showUnselectedLabels: true,
        selectedItemColor: KcolorPrimary,
        backgroundColor: KColorWhite,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Paiement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Prépayé',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Setting',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Met à jour l'index sélectionné
          });
          switch (index) {
            case 0:
              context.read<NavigationBloc>().add(NavigateToHome());
              break;
            case 1:
              context.read<NavigationBloc>().add(NavigateToPaiement());
              break;
            case 2:
              context.read<NavigationBloc>().add(NavigateToPrepaye());
            case 3:
              context.read<NavigationBloc>().add(NavigateToSettings());
              break;
          }
        },
      ),
    );
  }
}