part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeInfoState extends Equatable {
  
  const ExchangeInfoState();
  
  @override
  List<Object?> get props => [];

}

class ExchangeInfoInitial extends ExchangeInfoState {
  final List<ExchangeInfo> infoTabs;

  const ExchangeInfoInitial({
    required this.infoTabs,

  });

  @override
  List<Object?> get props => [infoTabs];
}

class ExchangeInfoLoading extends ExchangeInfoState {}


class ExchangeInfoError extends ExchangeInfoState {
  final Object error;

  const ExchangeInfoError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class ExchangeInfoSuccess extends ExchangeInfoState {
  final List<ExchangeInfo> infoTabs;

  const ExchangeInfoSuccess({
    required this.infoTabs
  });

  @override
  List<Object?> get props => [infoTabs];
}

