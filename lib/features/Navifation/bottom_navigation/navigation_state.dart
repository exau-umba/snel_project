part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();
}

final class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}

class HomeState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SettingsState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PaiementState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PrepayeState extends NavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

