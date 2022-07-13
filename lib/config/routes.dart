import 'package:auto_route/annotations.dart';
import 'package:belarus_exchange_app/screens/screens.dart';


@MaterialAutoRouter(     
  replaceInRouteName: 'Route,Route',         
  routes: <AutoRoute>[        
    AutoRoute(page: InitialInfoScreen, initial: true),           
  ],        
)        

class $Routes {}        