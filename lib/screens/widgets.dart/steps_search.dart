
import 'package:belarus_exchange_app/bloc/exchange_bloc.dart';
import 'package:belarus_exchange_app/data/local_data/local_rep.dart';
import 'package:belarus_exchange_app/screens/screens.dart';
import 'package:belarus_exchange_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class StepsOfSearch extends StatefulWidget {

  @override
  _StepsOfSearchState createState() => _StepsOfSearchState();
}

class _StepsOfSearchState extends State<StepsOfSearch> {

  int index = 0;
  //Remove 
  List<String> cities = ['Брест', 'Минск','Гродно','Могилев','Гомель','Витебск','Несвиж','Борисов'];
  String selectedCity  = '';

  List<String> currency = ['Доллар США', 'Евро'];
  Set<String> selectedCurrency = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Theme(
            data: ThemeData(colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppStyles.mainColor)),
            child: Stepper(
              controlsBuilder: (context, details) {
                if(index == 0) {
                  return TextButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Далее'),
                  );
                } else {
                  return TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Назад'),
                    );
                 }
              },
              currentStep: index,
              onStepCancel: () {
                if (index > 0) {
                  setState(() {
                    index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (index <= 0) {
                  setState(() {
                    index += 1;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Выберите город'), 
                  content: SizedBox(
                    width: 300,
                    height: 300,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      children: cities.map((e) => ChoiceChip(
                        selected: selectedCity == e,
                        selectedColor: AppStyles.mainColor,
                        onSelected: (value) {
                          if(value) {
                            selectedCity = e;
                            //selectedCities.add(e);
                          } else {
                            //selectedCities.remove(e);
                            selectedCity = 'Брест';
                          }
                          setState(() {
                            
                          });
                        },
                        backgroundColor: Colors.transparent,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selectedCity == e)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                            Text(e, style: TextStyle(color: selectedCity == e? Colors.white:null)),
                          ],
                        ),
                      )).toList(),     
                    ),
                  )
                ),
                Step(
                  title: const Text('Выберите валюту'), 
                  content: Container(
                    width: 200,
                    height: 100,
                    alignment: Alignment.center,
                    child: DropdownButtonFormField<String>(
                      items: currency.map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Row(
                          children: [
                            Text(e),
                            const SizedBox(width: 10),
                            e == 'Доллар США'? const Icon(Icons.attach_money, color: AppStyles.mainColor):
                             const Icon(Icons.euro, color: AppStyles.mainColor),
                          ],
                        ) ,
                      )).toList(),
                      onChanged: (value) {
                        if(!selectedCurrency.contains(value)) {
                          selectedCurrency.clear();
                          selectedCurrency.add(value ?? '');
                        }
                        setState(() {
                          
                        });
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        isDense: true,
                        labelText: 'Валюта',
                        labelStyle: const TextStyle(
                          color: AppStyles.mainTextColor
                        ),
                        // helperText: hintText,
                        hintStyle: const TextStyle(
                          color: AppStyles.mainTextColor
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          const SizedBox(height: 200), 
          if(selectedCity.isNotEmpty & selectedCurrency.isNotEmpty)
          CupertinoButton(
            color: AppStyles.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: const Text('Обновить информацию'), 
            onPressed: () {
              setState(() {
                LocalRepositiry.selectedCity = selectedCity;
                LocalRepositiry.selectedCurrencies.addAll(selectedCurrency);
                context.read<ExchangeBloc>().add(ExchangeInfoRun(city: selectedCity));
              });
              context.findAncestorStateOfType<InitialInfoScreenState>()?.selectedBottomNavigationIndex = 1;
              context.findAncestorStateOfType<InitialInfoScreenState>()?.setState(() {
                
              });
            }
          )
        ],
      ),
    );
  }
}