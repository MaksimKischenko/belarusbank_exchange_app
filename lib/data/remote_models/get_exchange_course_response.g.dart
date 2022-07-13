// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exchange_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeInfo _$ExchangeInfoFromJson(Map<String, dynamic> json) => ExchangeInfo(
      usdIn: json['USD_in'] as String?,
      usdOut: json['USD_out'] as String?,
      eurIn: json['EUR_in'] as String?,
      eurOut: json['EUR_out'] as String?,
      rubIn: json['RUB_in'] as String?,
      rubOut: json['RUB_out'] as String?,
      gbpIn: json['GBP_in'] as String?,
      gbpOut: json['GBP_out'] as String?,
      plnIn: json['PLN_in'] as String?,
      plnOut: json['PLN_out'] as String?,
      uahIn: json['UAH_in'] as String?,
      uahOut: json['UAH_out'] as String?,
      usdEurIn: json['USD_EUR_in'] as String?,
      usdEurOut: json['USD_EUR_out'] as String?,
      rubEurIn: json['RUB_EUR_in'] as String?,
      rubEurOut: json['RUB_EUR_out'] as String?,
      filialId: json['filial_id'] as String?,
      sapId: json['sap_id'] as String?,
      infoWorkTime: json['info_worktime'] as String?,
      streetType: json['street_type'] as String?,
      street: json['street'] as String?,
      filialsText: json['filials_text'] as String?,
      homeNumber: json['home_number'] as String?,
      name: json['name'] as String?,
      nameType: json['name_type'] as String?,
    );

Map<String, dynamic> _$ExchangeInfoToJson(ExchangeInfo instance) =>
    <String, dynamic>{
      'USD_in': instance.usdIn,
      'USD_out': instance.usdOut,
      'EUR_in': instance.eurIn,
      'EUR_out': instance.eurOut,
      'RUB_in': instance.rubIn,
      'RUB_out': instance.rubOut,
      'GBP_in': instance.gbpIn,
      'GBP_out': instance.gbpOut,
      'PLN_in': instance.plnIn,
      'PLN_out': instance.plnOut,
      'UAH_in': instance.uahIn,
      'UAH_out': instance.uahOut,
      'USD_EUR_in': instance.usdEurIn,
      'USD_EUR_out': instance.usdEurOut,
      'RUB_EUR_in': instance.rubEurIn,
      'RUB_EUR_out': instance.rubEurOut,
      'filial_id': instance.filialId,
      'sap_id': instance.sapId,
      'info_worktime': instance.infoWorkTime,
      'street_type': instance.streetType,
      'street': instance.street,
      'filials_text': instance.filialsText,
      'home_number': instance.homeNumber,
      'name': instance.name,
      'name_type': instance.nameType,
    };
