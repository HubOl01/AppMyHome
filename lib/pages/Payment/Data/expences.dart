import '../Models/expencesModel.dart';

double powerPriceDefault = 5.7;
double waterPriceDefault = 45.4;
var gasPriceDefault = 0.0;

List<ExpenceModel> expences = [
  ExpenceModel(
      id: 1,
      name: "Квитанция за март",
      power: 578,
      water: 660,
      gas: 0,
      powerPrice: 229 * powerPriceDefault,
      waterPrice: 13 * waterPriceDefault,
      gasPrice: 0,
      sumCost: 229 * powerPriceDefault + 13 * waterPriceDefault,
      status: "Оплачено",
      dateTime: DateTime(2024, 3, 1)),
  ExpenceModel(
      id: 2,
      name: "Квитанция за апрель",
      power: 700,
      water: 682,
      gas: 0,
      powerPrice: 122 * powerPriceDefault,
      waterPrice: 9 * waterPriceDefault,
      gasPrice: 0,
      sumCost: 122 * powerPriceDefault + 9 * waterPriceDefault,
      status: "Оплачено",
      dateTime: DateTime(2024, 4, 1)),
  ExpenceModel(
      id: 3,
      name: "Квитанция за май",
      power: 812,
      water: 691,
      gas: 0,
      powerPrice: 112 * powerPriceDefault,
      waterPrice: 9 * waterPriceDefault,
      gasPrice: 0,
      sumCost: 112 * powerPriceDefault + 9 * waterPriceDefault,
      status: "Не оплачено",
      dateTime: DateTime(2024, 5, 1)),
  ExpenceModel(
      id: 4,
      name: "Квитанция за июнь",
      power: 944,
      water: 701,
      gas: 0,
      powerPrice: 132 * powerPriceDefault,
      waterPrice: 10 * waterPriceDefault,
      gasPrice: 0,
      sumCost: 132 * powerPriceDefault + 10 * waterPriceDefault,
      status: "Ожидает оплаты",
      dateTime: DateTime(2024, 6, 1)),
];
