import 'package:belarus_exchange_app/data/data.dart';
import 'package:belarus_exchange_app/services/exchange_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeInfoEvent, ExchangeInfoState> {
  final ExchangeService exchangeService;

  ExchangeBloc({
    required this.exchangeService
  }) : super(ExchangeInfoLoading()) {
    on<ExchangeInfoEvent>(_onEvent);


  }

  void _onEvent(
    ExchangeInfoEvent event,
    Emitter<ExchangeInfoState> emit
  ) {
    if (event is ExchangeInfoInit) return _onExchangeInfoInit(event, emit);
    if (event is ExchangeInfoRun) return _onExchangeInfoRun(event, emit);
  }

  void _onExchangeInfoInit(
    ExchangeInfoInit event,
    Emitter<ExchangeInfoState> emit
  ) async {

    emit(ExchangeInfoLoading());
    try {
     final infoTab = await exchangeService.getExchangeInfo('');


     emit(ExchangeInfoInitial(
        infoTabs: infoTab
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(ExchangeInfoError(
        error: error
      ));
    }
  }

  void _onExchangeInfoRun(
    ExchangeInfoRun event,
    Emitter<ExchangeInfoState> emit
  ) async {

    emit(ExchangeInfoLoading());

    try {
     final infoTab = await exchangeService.getExchangeInfo(event.city);

     emit(ExchangeInfoInitial(
        infoTabs: infoTab
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(ExchangeInfoError(
        error: error
      ));
    }
  }
}
