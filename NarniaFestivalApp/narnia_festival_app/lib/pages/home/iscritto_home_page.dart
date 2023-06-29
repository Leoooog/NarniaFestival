import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/pages/buoni_pasto/buoni_pasto_page.dart';
import 'package:narnia_festival_app/pages/eventi/eventi_page.dart';
import 'package:narnia_festival_app/pages/ristoranti/ristoranti_page.dart';
import 'package:narnia_festival_app/pages/utente/utente_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/pages/tab_action.dart';
import 'package:redux/redux.dart';

class IscrittoHomePage extends StatelessWidget {
  const IscrittoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      onInit: (Store<AppState> store) =>
          store.dispatch(const ChangeTabAction(index: 0)),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (context) {
                switch (vm.currentIndex) {
                  case 0:
                    return const Text("Eventi");
                  case 1:
                    return const Text("Ristoranti");
                  case 2:
                    return const Text("Buoni pasto");
                  case 3:
                    return const Text("Utente");
                }
                return const Text("");
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              switch (vm.currentIndex) {
                case 0:
                  return EventiPage();
                case 1:
                  return RistorantiPage();
                case 2:
                  return BuoniPastoPage();
                case 3:
                  return UtentePage();
                default:
                  return Container();
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: vm.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: vm.buildItems(),
            onTap: vm.changeTab,
            elevation: 40,
          ),
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final int currentIndex;
  final Function(int) changeTab;

  const _ViewModel({
    required this.currentIndex,
    required this.changeTab,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        currentIndex: store.state.tabState.currentIndex,
        changeTab: (index) => store.dispatch(ChangeTabAction(index: index)));
  }

  List<BottomNavigationBarItem> buildItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.event,
          color: currentIndex == 0 ? Colors.blue : Colors.grey,
        ),
        label: "Eventi",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.restaurant,
          color: currentIndex == 1 ? Colors.blue : Colors.grey,
        ),
        label: "Ristoranti",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.fastfood_sharp,
          color: currentIndex == 2 ? Colors.blue : Colors.grey,
        ),
        label: "Buoni Pasto",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: currentIndex == 3 ? Colors.blue : Colors.grey,
        ),
        label: "Profilo",
      ),
    ];
  }

  @override
  List<Object?> get props => [currentIndex];
}
