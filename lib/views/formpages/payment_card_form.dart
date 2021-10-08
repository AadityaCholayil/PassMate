import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/shared/custom_snackbar.dart';

class PaymentCardFormPage extends StatefulWidget {
  final PaymentCard? paymentCard;

  const PaymentCardFormPage({Key? key, this.paymentCard}) : super(key: key);

  @override
  _PaymentCardFormPageState createState() => _PaymentCardFormPageState();
}

class _PaymentCardFormPageState extends State<PaymentCardFormPage> {
  String _id = '';
  String _path = 'root/default';
  String _bankName = '';
  String _cardNo = '';
  String _holderName = '';
  String _expiryDate = '';
  String _cvv = '';
  String _note = '';
  PaymentCardType _cardType = PaymentCardType.others;
  bool _favourite = false;
  int _usage = 0;
  String _color = '';
  Timestamp? _timeAdded;

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.paymentCard != null) {
      _isUpdate = true;
      _id = widget.paymentCard!.id;
      _path = widget.paymentCard!.path;
      _bankName = widget.paymentCard!.bankName;
      _cardNo = widget.paymentCard!.cardNo;
      _holderName = widget.paymentCard!.holderName;
      _expiryDate = widget.paymentCard!.expiryDate;
      _cvv = widget.paymentCard!.cvv;
      _note = widget.paymentCard!.note;
      _cardType = widget.paymentCard!.cardType;
      _favourite = widget.paymentCard!.favourite;
      _usage = widget.paymentCard!.usage;
      _color = widget.paymentCard!.color;
      _timeAdded = widget.paymentCard!.timeAdded;
    }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: Text(
        _isUpdate ? 'Update' : 'Submit',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: () {
        PaymentCard paymentCard = PaymentCard(
          id: _id,
          path: _path,
          bankName: _bankName,
          cardNo: _cardNo,
          holderName: _holderName,
          expiryDate: _expiryDate,
          cvv: _cvv,
          cardType: _cardType,
          note: _note,
          favourite: _favourite,
          usage: _usage,
          color: _color,
          lastUsed: Timestamp.now(),
          timeAdded: _timeAdded,
        );
        PaymentCard paymentCard2 = PaymentCard(
          id: widget.paymentCard?.id ?? '',
          path: 'root/default',
          bankName: 'Canara',
          cardNo: '222211110000',
          holderName: 'Aaditya Cholayil',
          expiryDate: '05/23',
          cvv: '420',
          cardType: PaymentCardType.creditCard,
          note: 'Bruh',
          favourite: false,
          usage: 0,
          color: 'purple',
          lastUsed: Timestamp.now(),
          timeAdded: Timestamp.now(),
        );
        if (!_isUpdate) {
          context.read<DatabaseBloc>().add(AddPaymentCard(paymentCard2));
        } else {
          context.read<DatabaseBloc>().add(UpdatePaymentCard(
                paymentCard2,
                true,
                widget.paymentCard!.path,
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DatabaseBloc, DatabaseState>(
          listener: (context, state) async {
            if (state is PaymentCardFormState) {
              if (state == PaymentCardFormState.success) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await Future.delayed(const Duration(milliseconds: 300));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(showCustomSnackBar(context, state.message));
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const Text(
                  'Add Payment Card',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                _buildSubmitButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
