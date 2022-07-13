part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeInfoEvent  extends Equatable {

  const ExchangeInfoEvent();

  @override
  List<Object?> get props => [];
}


class ExchangeInfoInit extends ExchangeInfoEvent {

}

class ExchangeInfoRun extends ExchangeInfoEvent {
  final String city;

  const ExchangeInfoRun({
    required this.city,
  });

  @override
  List<Object?> get props => [city];
}

