import 'dart:async';
import 'dart:developer';
import 'dart:io';

//import 'package:command_flutter/Payment/ex.dart';
import 'package:MyAppHome/pages/Payment/Data/expences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/Styles/Colors.dart';
import 'Models/expencesModel.dart';
import 'package:qr_code_scan_pay/qr_code_scan_pay.dart';
import 'package:sbp/data/c2bmembers_data.dart';
import 'package:sbp/models/c2bmembers_model.dart';
import 'package:sbp/sbp.dart';

final url = 'https://sub.nspk.ru/BD100028ULC1S2R999G8I68UESGG5EAQ';
final samUrl =
    'https://invoicenpd.nalog.ru/?inn=370264753602&uuid=d5bb455b-b17e-46d2-a404-63fd875d5a56';

String code = '';

class PaymentDetalPage extends StatefulWidget {
  final ExpenceModel expence;
  final url =
      'https://qr.nspk.ru/AS10003P3RH0LJ2A9ROO038L6NT5RU1M?type=01&bank=000000000001&crc=F3D0'; // здесь нужно поменять qr-code как на примере: https://qr.nspk.ru/AS10003P3RH0LJ2A9ROO038L6NT5RU1M?type=01&bank=000000000001&sum=10000&cur=RUB&crc=F3D0
  const PaymentDetalPage({required this.expence});

  @override
  State<PaymentDetalPage> createState() => _PaymentDetalPageState();
}

class _PaymentDetalPageState extends State<PaymentDetalPage> {
  @override
  void initState() {
    super.initState();
    getInstalledBanks();
  }

  List<C2bmemberModel> informations = [];

  /// Получаем установленные банки
  Future<void> getInstalledBanks() async {
    try {
      informations.addAll(await Sbp.getInstalledBanks(
        C2bmembersModel.fromJson(c2bmembersData),
        useAndroidLocalIcons: false,
        useAndroidLocalNames: false,
      ));
    } on Exception catch (e) {
      throw Exception(e);
    }
    setState(() {});
  }

  bool isExpanded1 = true;
  bool isExpanded2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expence.name),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Квитанция для оплаты коммунальных услуг',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          if (index == 1) {
                            isExpanded1 = !isExpanded;
                          } else {
                            isExpanded2 = !isExpanded;
                          }
                        });
                      },
                      elevation: 0,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      children: [
                        ExpansionPanel(
                          isExpanded: isExpanded1,
                          canTapOnHeader: true,
                          backgroundColor: Colors.white,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text("Электроэнергия"),
                              trailing: Text(
                                  "${widget.expence.powerPrice.toStringAsFixed(2).toString()} руб."),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Количество: "),
                                    Spacer(),
                                    Text("${widget.expence.power} кВтч"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Цена за единицу: "),
                                    Spacer(),
                                    Text("${powerPriceDefault.toStringAsFixed(2).toString()} руб."),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ExpansionPanel(
                          isExpanded: isExpanded2,
                          canTapOnHeader: true,
                          backgroundColor: Colors.white,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text("Вода"),
                              trailing: Text(
                                  "${widget.expence.waterPrice.toStringAsFixed(2).toString()} руб."),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Количество: "),
                                    Spacer(),
                                    Text("${widget.expence.water} кВтч"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Цена за единицу: "),
                                    Spacer(),
                                    Text("${waterPriceDefault.toStringAsFixed(2).toString()} руб."),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: 20),
                  Text(
                      'Сумма к оплате: ${widget.expence.sumCost.toStringAsFixed(2)} руб.',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.expence.status.contains("Оплачено")
                              ? Colors.green
                              : purpleColor,
                      disabledBackgroundColor: Colors.green,
                      disabledForegroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      )),
                  onPressed: widget.expence.status.contains("Оплачено")
                      ? null
                      : () => showModalBottomSheet(
                            context: context,
                            // isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            builder: (ctx) => SbpModalBottomSheetWidget(
                                informations, widget.url),
                          ),
                  child: Text(
                    widget.expence.status.contains("Оплачено")
                        ? "Оплачено"
                        : "Оплатить",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   height: 40,
              //   child: TextButton(
              //       onPressed: widget.expence.status.contains("Оплачено")
              //           ? null
              //           : () {
              //               Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => const QRViewExample(),
              //               ));
              //             },
              //       style: ElevatedButton.styleFrom(
              //         // backgroundColor: purpleColor,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(20),
              //           ),
              //         ),
              //       ),
              //       child: Text(
              //         "Оплата по QR-коду",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(color: purpleColor),
              //       )),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
///////////////////////////////////////////////

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    bool clicked = false;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            if (result != null)
              Column(
                children: [
                  Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          result = null;
                        });
                      },
                      child: Text("Вернуться"))
                ],
              )
            else
              Expanded(
                child: Stack(
                  children: [
                    _buildQrView(context),
                    Positioned(
                      child: IconButton(
                        icon: Icon(
                          clicked == false ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() async {
                            if (clicked == false) {
                              print("Нажато");
                              clicked = true;
                            } else {
                              clicked = false;
                              print("опущено");
                            }
                          });
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    bool clicked = false;
    return Stack(
      children: [
        Center(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 0,
                borderLength: 10,
                borderWidth: 5,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

///////////////////////////////////////////////
class SbpHeaderModalSheet extends StatelessWidget {
  const SbpHeaderModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 5,
          width: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/sbp.png',
          // width: 100,
          height: 80,
        ),
        const SizedBox(height: 10),
        const Text('Выберите банк для оплаты по СБП'),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SbpModalBottomSheetEmptyListBankWidget extends StatelessWidget {
  const SbpModalBottomSheetEmptyListBankWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SbpHeaderModalSheet(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text('У вас нет банков для оплаты по СБП'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

/// Модальное окно с банками
class SbpModalBottomSheetWidget extends StatelessWidget {
  final List<C2bmemberModel> informations;
  final String url;

  const SbpModalBottomSheetWidget(this.informations, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// если есть информация о банках, то отображаем их
    if (informations.isNotEmpty) {
      return Column(
        children: [
          const SbpHeaderModalSheet(),
          Expanded(
            child: ListView.separated(
              itemCount: informations.length,
              itemBuilder: (ctx, index) {
                final information = informations[index];
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => openBank(url, information),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: /* information.bitmap != nul */
                                // ? Image.memory(
                                //     information.bitmap!,
                                //   )
                                // : information.icon.isNotEmpty
                                //     ? Image.asset(
                                //         information.icon,
                                //       )
                                //     :
                                Image.network(
                              information.logoURL,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Center(
                          child: Text(information.bankName),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    } else {
      return const SbpModalBottomSheetEmptyListBankWidget();
    }
  }

  /// передается scheme
  FutureOr<void> openBank(String url, C2bmemberModel c2bmemberModel) async =>
      await Sbp.openBank(url, c2bmemberModel);
}
