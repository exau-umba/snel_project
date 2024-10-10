part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();
}

final class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {
  @override
  List<Object?> get props => [];
}


class MobilePaymentsLoaded extends PaymentState {
  final List<PaymentMobile> payments;

  MobilePaymentsLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

final class AjoutMobilePaymentsSucces extends PaymentState {
  final String message;
  AjoutMobilePaymentsSucces(this.message);

  @override
  List<Object> get props => [message];
}

final class AjoutCardPaymentsSucces extends PaymentState {
  final String message;
  AjoutCardPaymentsSucces(this.message);

  @override
  List<Object> get props => [message];
}

final class AjoutCardPaymentsError extends PaymentState {
  final String error;
  AjoutCardPaymentsError(this.error);

  @override
  List<Object> get props => [error];
}

final class AjoutMobilePaymentsError extends PaymentState {
  final String error;
  AjoutMobilePaymentsError(this.error);

  @override
  List<Object> get props => [error];
}

class CardPaymentsLoaded extends PaymentState {
  final List<PaymentCard> payments;

  CardPaymentsLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentsMethodeLoadedSucces extends PaymentState {
  final List<Map<String, dynamic>> items;

  PaymentsMethodeLoadedSucces(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}


class RandomListShuffled extends PaymentState {
  final List<Map<String, dynamic>> items;

  RandomListShuffled(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}

class RandomListShuffledError extends PaymentState {
  final String message;

  RandomListShuffledError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
