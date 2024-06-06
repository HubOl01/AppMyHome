import '../Models/expencesModel.dart';

var powerPriceDefault = 8.0;
var waterPriceDefault = 1.5;
var gasPriceDefault = 2.0;

List<ExpenceModel> expences = [
  ExpenceModel(
      id: 1,
      name: "Квитанция за март",
      power: 100,
      water: 50,
      gas: 20,
      powerPrice: 100 * powerPriceDefault,
      waterPrice: 50 * waterPriceDefault,
      gasPrice: 20 * gasPriceDefault,
      sumCost: 100 * powerPriceDefault + 50 * waterPriceDefault + 20 * gasPriceDefault,
      status: "Оплачено",
      dateTime: DateTime(2024, 3, 1)),
  ExpenceModel(
      id: 2,
      name: "Квитанция за апрель",
      power: 143,
      water: 52,
      gas: 23,
      powerPrice: 143 * powerPriceDefault,
      waterPrice: 52 * waterPriceDefault,
      gasPrice: 23 * gasPriceDefault,
      sumCost: 143 * powerPriceDefault + 52 * waterPriceDefault + 23 * gasPriceDefault,
      status: "Оплачено",
      dateTime: DateTime(2024, 4, 1)),
  ExpenceModel(
      id: 3,
      name: "Квитанция за май",
      power: 120,
      water: 54,
      gas: 27,
      powerPrice: 120 * powerPriceDefault,
      waterPrice: 54 * waterPriceDefault,
      gasPrice: 27 * gasPriceDefault,
      sumCost: 120 * powerPriceDefault + 54 * waterPriceDefault + 27 * gasPriceDefault,
      status: "Не оплачено",
      dateTime: DateTime(2024, 5, 1)),
  ExpenceModel(
      id: 4,
      name: "Квитанция за июнь",
      power: 130,
      water: 55,
      gas: 27,
      powerPrice: 130 * powerPriceDefault,
      waterPrice: 55 * waterPriceDefault,
      gasPrice: 27 * gasPriceDefault,
      sumCost: 130 * powerPriceDefault + 55 * waterPriceDefault + 27 * gasPriceDefault,
      status: "Ожидает оплаты",
      dateTime: DateTime(2024, 6, 1)),
];
