import 'package:belarus_exchange_app/bloc/exchange_bloc.dart';
import 'package:belarus_exchange_app/data/data.dart';
import 'package:belarus_exchange_app/data/local_data/local_rep.dart';
import 'package:belarus_exchange_app/screens/widgets.dart/widget.dart';
import 'package:belarus_exchange_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationBank extends StatefulWidget {

  @override
  _InformationBankState createState() => _InformationBankState();
}

class _InformationBankState extends State<InformationBank> {

  int outIndex = 0;
  List<ExchangeInfo> itemsInfoBank = [];
  Set<String> currencies = LocalRepositiry.selectedCurrencies; 
 
  @override
  Widget build(BuildContext context) {
        return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<ExchangeBloc, ExchangeInfoState>(
        listener: (context, state) {
          if(state is ExchangeInfoSuccess) {
            itemsInfoBank = state.infoTabs;
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
            itemsInfoBank.addAll(state.infoTabs.toList()); 

            if(currencies.contains('Доллар США')) {
              itemsInfoBank.sort((a, b) => double.tryParse(b.usdIn!)!.compareTo(double.tryParse(a.usdIn!)!));
              double maxUsdIn = 0;
              for (var item in itemsInfoBank) {
                if(double.tryParse(item.usdIn!)! > maxUsdIn) {
                  maxUsdIn = double.tryParse(item.usdIn!)!;
                }    
              }
              itemsInfoBank.removeWhere((element) => (double.tryParse(element.usdIn!)! != maxUsdIn));
            } else {
              itemsInfoBank.sort((a, b) => double.tryParse(b.eurIn!)!.compareTo(double.tryParse(a.eurIn!)!));
              double maxEurIn = 0;
              for (var item in itemsInfoBank) {
                if(double.tryParse(item.eurIn!)! > maxEurIn) {
                  maxEurIn = double.tryParse(item.eurIn!)!;
                }    
              }
              itemsInfoBank.removeWhere((element) => (double.tryParse(element.eurIn!)! != maxEurIn));
            }

            body = itemsInfoBank.isEmpty?  Center(child:Column(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: itemsInfoBank.length,
                        itemBuilder: (context, index) {
                          final item = itemsInfoBank[index];
                          return Dismissible(
                            key: Key(item.sapId ?? ''), 
                            onDismissed: (direction) {
                              setState(() {
                                itemsInfoBank.removeAt(index);
                              });
                            },
                            background: Container(color: AppStyles.mainColor),
                            child:
                              Card(
                                shadowColor: AppStyles.mainColor,               
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   ListTile(
                                      leading: const Icon(Icons.info_sharp, color: AppStyles.mainColor),
                                      title: SelectableText('Подразделения банка: ${item.filialId} | ${item.filialsText}'),
                                      subtitle:  SelectableText('Режим работы банка: ${item.infoWorkTime}'),
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
}