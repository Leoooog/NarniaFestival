import 'package:narnia_festival_app/redux/pages/tab_action.dart';
import 'package:narnia_festival_app/redux/pages/tab_state.dart';

TabState tabReducer(TabState state, dynamic action) {
  if (action is ChangeTabAction) {
    return state.copyWith(currentIndex: action.index);
  } else {
    return state;
  }
}
