
import 'package:injector/injector.dart';


import 'services/exchange_service.dart';

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