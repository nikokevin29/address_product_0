part of 'services.dart';

class Printer {
  Future<void> printPaper(String buyer, String address) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.text('Toko Rejeki',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          align: PosAlign.center,
          bold: true,
        ));
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
  }
}
