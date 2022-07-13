import 'package:belarus_exchange_app/config.dart';
import 'package:belarus_exchange_app/injection_component.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_observer.dart';
import 'bloc/exchange_bloc.dart';
import 'config/routes.gr.dart';
import 'services/exchange_service.dart';
import 'styles.dart';

void main() {
  InjectionComponent.run();

  BlocOverrides.runZoned(
      () => runApp(MultiBlocProvider(providers: [
            BlocProvider<ExchangeBloc>(
                create: (context) => ExchangeBloc(
                    exchangeService:
                        InjectionComponent.getDependency<ExchangeService>())
                  ..add(ExchangeInfoInit())),
          ], child: ExchangeApp())),
      blocObserver: SimpleBlocObserver(),
      eventTransformer: sequential<dynamic>());
}

class ExchangeApp extends StatelessWidget {
  static const primary = MaterialColor(4283157653, {
    50: Color(0xffebf9f3),
    100: Color(0xffd7f4e8),
    200: Color(0xffb0e8d0),
    300: Color(0xff88ddb9),
    400: Color(0xff60d2a1),
    500: Color(0xff38c78a),
    600: Color(0xff2d9f6e),
    700: Color(0xff227753),
    800: Color(0xff174f37),
    900: Color(0xff0b281c)
  });

  final _appRouter = Routes();

  ExchangeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: AppConfig.appName,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppStyles.scaffoldColor,
        appBarTheme: AppBarTheme(
          color: AppStyles.scaffoldColor,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          elevation: 0,
          iconTheme: Theme.of(context)
              .primaryIconTheme
              .copyWith(color: AppStyles.mainTextColor),
        ),
        secondaryHeaderColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppStyles.mainTextColor,
            ),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              bodyColor: AppStyles.mainTextColor,
            ),
        primaryColor: AppStyles.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
