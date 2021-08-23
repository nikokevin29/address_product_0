part of 'widgets.dart';

class TransactionDialog extends StatefulWidget {
  final ProductAddressModel? transaction;
  final Function(String name, int amount) onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      nameController.text = transaction.productName;
      amountController.text = transaction.qty.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildAmount(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Nama Product',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Masukkan Produk' : null,
  );

  Widget buildAmount() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Masukan Jumlah',
    ),
    keyboardType: TextInputType.number,
    validator: (amount) => amount != null && int.tryParse(amount) == null
        ? 'Masukkan Jumlah yang valid'
        : null,
    controller: amountController,
  );



  Widget buildCancelButton(BuildContext context) => TextButton(
    child: Text('Batal'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Simpan' : 'Tambah';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final productName = nameController.text;
          final qty = int.tryParse(amountController.text) ?? 0;

          widget.onClickedDone(productName, qty);

          Navigator.of(context).pop();
        }
      },
    );
  }
}