
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
