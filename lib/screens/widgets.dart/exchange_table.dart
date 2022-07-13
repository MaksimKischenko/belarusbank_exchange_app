
import 'package:belarus_exchange_app/bloc/exchange_bloc.dart';
import 'package:belarus_exchange_app/data/data.dart';
import 'package:belarus_exchange_app/data/local_data/local_rep.dart';
import 'package:belarus_exchange_app/screens/widgets.dart/widget.dart';

import 'package:belarus_exchange_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeTable extends StatefulWidget {

  @override
  _ExchangeTableState createState() => _ExchangeTableState();
}

class _ExchangeTableState extends State<ExchangeTable> {

  final _searchFieldController = TextEditingController();
  final _focusNode =  FocusNode();


  int outIndex = 0;
  List<ExchangeInfo> items = [];
  String city = LocalRepositiry.selectedCity;
  Set<String> currencies = LocalRepositiry.selectedCurrencies; 



  @override
  void dispose() {
    _searchFieldController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<ExchangeBloc, ExchangeInfoState>(
        listener: (context, state) {
          if(state is ExchangeInfoSuccess) {
            items = state.infoTabs;
          }
        },
        builder: (context, state) {
          Widget body = Container(); 
          if(state is ExchangeInfoLoading) {
            body = const Center(child: LoadingIndicator());
          } else if (state is ExchangeInfoError) {
            body = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.maxFinite),
                const Text('Невозможно отобразить информацию'),
                const SizedBox(height: 8),
                CupertinoButton(
                  onPressed: () => context
                      .read<ExchangeBloc>()
                      .add(ExchangeInfoInit()),
                  child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                )
              ],
            );
          } else if(state is ExchangeInfoInitial) {

            var city = state.infoTabs.isEmpty? '': state.infoTabs.first.name ?? 'Неизвестно';
            items.addAll(state.infoTabs.toList());
            items.sort((a, b) => double.tryParse(b.eurIn!)!.compareTo(double.tryParse(a.eurIn!)!));
            body = items.isEmpty?  Center(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text('Данных нет'),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: ()=> context.read<ExchangeBloc>().add(ExchangeInfoInit()),
                  icon: const Icon(Icons.refresh, color: AppStyles.mainColor)
                )
              ],
            ))
            :SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(city, style: AppStyles.headerTextStyleLess)

                      //  SearchCityField(
                      //   controller: _searchFieldController,
                      //   focusNode: _focusNode,
                      //   keyboardType: TextInputType.name,
                      //   labelText: 'Город или населенный пункт',
                      //   onSaved: (value) {
                      //     value = _searchFieldController.text;
                      //     context.read<ExchangeBloc>().add(ExchangeInfoRun(city: value));
                      //   },
                      //   onChanged: (value) {
                      //     value = _searchFieldController.text;
                      //     if(city == value) {
                      //       context.read<ExchangeBloc>().add(ExchangeInfoRun(city: _searchFieldController.text));
                      //     }                         
                      //   },
                      // ),
                    ),          
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Dismissible(
                            key: Key(item.sapId ?? ''), 
                            onDismissed: (direction) {
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                            background: Container(color: AppStyles.mainColor),
                            child:
                              Card(
                                color: double.tryParse(item.eurIn!)!  == sortPositionMaxEur(items, index)?
                                AppStyles.mainColor: Colors.white,
                                shadowColor: AppStyles.mainColor,               
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   ListTile(
                                      leading: currencies.contains('Доллар США')? 
                                        const Icon(Icons.attach_money, color: AppStyles.mainColor):
                                        Icon(Icons.euro, color:  double.tryParse(item.eurIn!)!  != sortPositionMaxEur(items, index)? 
                                          null : Colors.white),
                                      title: SelectableText('${item.streetType} ${item.street} ${item.homeNumber}',
                                        style: TextStyle(color: double.tryParse(item.eurIn!)!  != sortPositionMaxEur(items, index)? 
                                        null : Colors.white)),
                                      subtitle: currencies.contains('Доллар США')? SelectableText('Покупка: ${item.usdIn} - Продажа: ${item.usdOut}', 
                                        style: TextStyle(color: double.tryParse(item.eurIn!)!  != sortPositionMaxEur(items, index)? 
                                        null : Colors.white)):
                                      SelectableText('Покупка: ${item.eurIn} - Продажа: ${item.eurOut}', 
                                        style: TextStyle(color: double.tryParse(item.eurIn!)!  != sortPositionMaxEur(items, index)? 
                                        null : Colors.white)),
                                   ),
                                  ],
                                ),
                              )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            );
          }
          return body;
        },
      ),
    );
  }

  double? sortPositionMaxEur (List<ExchangeInfo> items, int index) {
    double maxEurIn = 0;
    double maxUsdIn = 0;
    for (var item in items) {

     if(currencies.contains('Доллар США')) {
        if(double.tryParse(item.usdIn!)! > maxUsdIn) {
          maxUsdIn = double.tryParse(item.usdIn!)!;
        } 
        return maxUsdIn;
     } else {
       
      if(double.tryParse(item.eurIn!)! > maxEurIn) {
        maxEurIn = double.tryParse(item.eurIn!)!;
      }
      return maxEurIn;
     }
    }
    return null;
  }
}