import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BlueToothPage(),
    );
  }
}

class BlueToothPage extends StatefulWidget {
  const BlueToothPage({super.key});

  @override
  State<BlueToothPage> createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bluetoothPrint.scan(timeout: const Duration(seconds: 4));
    ValueNotifier<BluetoothDevice?> selectedDevice =
        ValueNotifier<BluetoothDevice?>(null);
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () async {
            await bluetoothPrint.startScan();
          },
          icon: const Icon(Icons.scanner_outlined)),
      body: Column(
        children: [
          FutureBuilder(
              future: bluetoothPrint.isAvailable,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data ?? false;
                  return Text('Availability?: ${data.toString()}');
                }
                if (snapshot.hasError) {
                  return const Text('HAS ERROR = AVAILABLE');
                }
                return const Text('Availability Checking...');
              }),
          FutureBuilder(
              future: bluetoothPrint.isOn,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data ?? false;
                  return Text('BLUETOOTH IS ON ${data.toString()}');
                }
                if (snapshot.hasError) {
                  return const Text('HAS ERROR = BLUETOOTH ON/OFF');
                }
                return const Text('BLUETOOTH Checking...');
              }),
          FutureBuilder(
              future: bluetoothPrint.isConnected,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data ?? false;
                  return Text('BLUETOOTH IS Connected ${data.toString()}');
                }
                if (snapshot.hasError) {
                  return const Text('HAS ERROR = BLUETOOTH ON/OFF');
                }
                return const Text('BLUETOOTH Checking...');
              }),
          FutureBuilder(
              future: bluetoothPrint.isConnected,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data ?? false;
                  return Text('BLUETOOTH IS Connected ${data.toString()}');
                }
                if (snapshot.hasError) {
                  return const Text('HAS ERROR = BLUETOOTH ON/OFF');
                }
                return const Text('BLUETOOTH Checking...');
              }),
          StreamBuilder(
              stream: bluetoothPrint.isScanning,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Bluetooth scanning failed');
                }
                return Text('Bluetooth Scanning? ${snapshot.data ?? false}');
              }),
          Expanded(
            child: StreamBuilder<List<BluetoothDevice>>(
              stream: bluetoothPrint.scanResults,
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data == null
                    ? []
                    : snapshot.data!
                        .map((d) => ListTile(
                              title: Text(d.name ?? ''),
                              subtitle: Text(d.address ?? ''),
                              onTap: () async {
                                selectedDevice.value = d;
                                bluetoothPrint.connect(d);
                              },
                              trailing: ValueListenableBuilder(
                                  valueListenable: selectedDevice,
                                  builder: (context, value, child) {
                                    return value != null &&
                                            value.address == d.address
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : const SizedBox();
                                  }),
                            ))
                        .toList(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> config = Map();
                List<LineText> list = [];
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'Star city cable network'.toUpperCase(),
                    fontZoom: 2,
                    weight: 1,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content:
                        'Shop No 15, RD Colony, Old Suraj Nagari, St No 8, Abohar, Punjab',
                    fontZoom: -1,
                    weight: 0,
                    height: 10,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'M: 9914964911',
                    weight: 1,
                    align: LineText.ALIGN_LEFT,
                    x: 0,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: '9582913997',
                    weight: 1,
                    align: LineText.ALIGN_RIGHT,
                    x: 250,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: '--------------------------------',
                    weight: 1,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: '20-Feb-2024',
                    weight: 1,
                    align: LineText.ALIGN_LEFT,
                    x: 0,
                    relativeX: 0,
                    linefeed: 0));

                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'Rpt No: 0000001',
                    weight: 1,
                    align: LineText.ALIGN_RIGHT,
                    x: 200,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: '08:55 PM',
                    weight: 1,
                    align: LineText.ALIGN_CENTER,
                    linefeed: 0));
                list.add(LineText(linefeed: 1));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'Name: ',
                    weight: 1,
                    x: 0,
                    align: LineText.ALIGN_LEFT,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'Abhishek Raheja',
                    weight: 1,
                    x: 200,
                    align: LineText.ALIGN_RIGHT,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(linefeed: 1));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: 'Code: ',
                    weight: 1,
                    x: 0,
                    align: LineText.ALIGN_LEFT,
                    relativeX: 0,
                    linefeed: 0));
                list.add(LineText(
                    type: LineText.TYPE_TEXT,
                    content: '000001',
                    weight: 1,
                    x: 310,
                    align: LineText.ALIGN_RIGHT,
                    relativeX: 0,
                    linefeed: 0));
                // list.add(LineText(
                //     type: LineText.TYPE_QRCODE,
                //     content:
                //         'LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM LOREM ',
                //     weight: 1,
                //     align: LineText.ALIGN_CENTER,
                //     width: 100,
                //     height: 100,
                //     linefeed: 1));
                await bluetoothPrint.printReceipt(config, list);
              },
              child: Text('Print'))
        ],
      ),
    );
  }
}
