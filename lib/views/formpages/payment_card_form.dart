import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/shared/custom_snackbar.dart';
import 'package:passmate/shared/custom_widgets.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FlipCardController _controller;

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
    _controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<DatabaseBloc, DatabaseState>(
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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.w),
                      const CustomBackButton(),
                      SizedBox(height: 12.w),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Add Card',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.w),
                      GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          int sensitivity = 8;

                          if (details.delta.dx > sensitivity) {
                            if(!_controller.state!.isFront){
                              _controller.toggleCard();
                            }
                          } else if (details.delta.dx < -sensitivity) {
                            if(_controller.state!.isFront){
                              _controller.toggleCard();
                            }
                          }
                        },
                        child: FlipCard(
                          controller: _controller,
                          flipOnTouch: false,
                          front: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.w)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              height: 200.w,
                              color: Colors.pinkAccent[100],
                            ),
                          ),
                          back: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.w)
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              height: 200.w,
                              color: Colors.purpleAccent[100],

                            ),
                          ),
                        ),
                      ),
                      _buildHeader(
                          'Bank Name', Icons.account_balance_rounded),
                      _buildBankName(context),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, IconData iconData) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 5.w),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 16.w,
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String? validateText(String? value) {
    if (value == null || value == '') {
      return 'This field cannot be empty!';
    }
    return null;
  }

  Widget _buildBankName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: TextFormField(
        initialValue: _bankName,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. Canara',
        ),
        onSaved: (value) {
          _bankName = value ?? '';
        },
        validator: validateText,
      ),
    );
  }



  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      style: 0,
      text: _isUpdate ? 'Update' : 'Submit',
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        setState(() {
          _formKey.currentState!.save();
        });
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
}