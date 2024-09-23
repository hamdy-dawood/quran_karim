import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller.dart';
import 'states.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  final NavBarController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  NavBarCubit(this.controller, this.scaffoldKey) : super(NavBarInitialState());

  static NavBarCubit get(BuildContext context) =>
      BlocProvider.of<NavBarCubit>(context);

  selectItem(index) {
    controller.selectedItem = index;
    emit(SelectItemState());
  }
}
