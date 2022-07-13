## Guidelines
Run the example of connecting to OpenFin and creating applications

1. Clone this repository

2. If pubspec.yaml file drops error with pockets compatibility try write a command: dart pub upgrade --null-safety 

3. Go to release directory and start void main (run)

4. You can navigate between them and catch GET requests from BelarusBank api https://belarusbank.by/api/kursExchange

5. In App you can work with API in way of 
    #### find belarusbank filials for exchange currencies 
    #### find the best exchange currencies values 
    #### change cities and currencies (USD/EUR)
    #### see info and location of belarusbank filials 

## Source Code Review

Source code for the example is located in /lib/. 
Start point of app is main.dart

We use Bloc core as main statemanagment instrument in all app

1. To begin with, we will initialize our injectionComponent. It is important part of initializing app.  

```dart
void main() {

InjectionComponent.run();

 BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ExchangeBloc>(
          create: (context) => ExchangeBloc(
            exchangeService: InjectionComponent.getDependency<ExchangeService>()
          )..add(ExchangeInfoInit())
        ),
      ], child: ExchangeApp())),
    blocObserver: SimpleBlocObserver(),
    eventTransformer: sequential<dynamic>()
  );
}

class InjectionComponent {
  static final InjectionComponent _singleton = InjectionComponent._internal();
  // Use this static instance
  static final Injector injector = Injector.appInstance;

  factory InjectionComponent() => _singleton;

  InjectionComponent._internal();

  static Future<void> run() async {
    //Inject all
    injector
    .registerSingleton<ExchangeService>(() {
      return ExchangeService();
    });
  
  }

  static T getDependency<T>() => injector.get<T>();
}
```

2. Then we create ExchangeService to make GET req for unloading information from api

```dart
class ExchangeService { 

  Future<List<ExchangeInfo>> getExchangeInfo(String? city) async {
    final url = Uri.parse('$_baseUrl?city=$city');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List tabs = json.decode(response.body);
      return tabs.map((json) => ExchangeInfo.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
```

3. To make Json Serialization helps json_annotation lib
```dart

import 'package:json_annotation/json_annotation.dart';


part 'get_exchange_course_response.g.dart';

@JsonSerializable()
class ExchangeInfo {

  @JsonKey(name: 'USD_in')
  final String? usdIn;

  @JsonKey(name: 'USD_out')
  final String? usdOut;

  @JsonKey(name: 'EUR_in')
  final String? eurIn;

  @JsonKey(name: 'EUR_out')
  final String? eurOut;

  @JsonKey(name: 'RUB_in')
  final String? rubIn;

  @JsonKey(name: 'RUB_out')
  final String? rubOut;

  @JsonKey(name: 'GBP_in')
  final String? gbpIn;

  @JsonKey(name: 'GBP_out')
  final String? gbpOut;

  @JsonKey(name: 'PLN_in')
  final String? plnIn;

  @JsonKey(name: 'PLN_out')
  final String? plnOut;

  @JsonKey(name: 'UAH_in')
  final String? uahIn;

  @JsonKey(name: 'UAH_out')
  final String? uahOut;

  @JsonKey(name: 'USD_EUR_in')
  final String? usdEurIn;

  @JsonKey(name: 'USD_EUR_out')
  final String? usdEurOut;

  @JsonKey(name: 'RUB_EUR_in')
  final String? rubEurIn;

  @JsonKey(name: 'RUB_EUR_out')
  final String? rubEurOut;

  @JsonKey(name: 'filial_id')
  final String? filialId;

  @JsonKey(name: 'sap_id')
  final String? sapId;

  @JsonKey(name: 'info_worktime')
  final String? infoWorkTime;

  @JsonKey(name: 'street_type')
  final String? streetType;

  @JsonKey(name: 'street')
  final String? street;

  @JsonKey(name: 'filials_text')
  final String? filialsText;

  @JsonKey(name: 'home_number')
  final String? homeNumber;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'name_type')
  final String? nameType;

  ExchangeInfo({
    this.usdIn,
    this.usdOut,
    this.eurIn,
    this.eurOut,
    this.rubIn,
    this.rubOut,
    this.gbpIn,
    this.gbpOut,
    this.plnIn,
    this.plnOut,
    this.uahIn,
    this.uahOut,
    this.usdEurIn,
    this.usdEurOut,
    this.rubEurIn,
    this.rubEurOut,
    this.filialId,
    this.sapId,
    this.infoWorkTime,
    this.streetType,
    this.street,
    this.filialsText,
    this.homeNumber,
    this.name,
    this.nameType,
  });

  factory ExchangeInfo.fromJson(Map<String, dynamic> json) => _$ExchangeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeInfoToJson(this);
}
``` 

4. In ExchangeBloc we works with ExchangeService 

```dart
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
```


## More Info
More information and documentation can be found at:

#### https://pub.dev/packages/flutter_bloc
#### https://pub.dev/packages/injector
#### https://pub.dev/packages/json_serializable







