part of 'services.dart';

class PrinterServices {
  static Future<void> printAddress(String buyer, String address) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    DateTime timestamp = DateTime.now();

    // bytes += generator.text('Toko Rejeki',
    //     styles: PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //       align: PosAlign.center,
    //       bold: true,
    //     ));
    generator.row([
      PosColumn(text: timestamp.toString(),width: 3,styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: 'Toko Rejeki',width: 3,styles: PosStyles(align: PosAlign.right,bold: true)),
    ]);
    bytes += generator.text(timestamp.toString());
    bytes += generator.text(buyer,
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          align: PosAlign.center,
        ));
    bytes += generator.text(
      'Alamat ' + address,
      styles: PosStyles(align: PosAlign.center, underline: true),
    );

    bytes += generator.feed(2);
    bytes += generator.cut();
  }
}
