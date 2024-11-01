part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigateToHome extends NavigationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NavigateToSettings extends NavigationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NavigateToPaiement extends NavigationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NavigateToPrepaye extends NavigationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
