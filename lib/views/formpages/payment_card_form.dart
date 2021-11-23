import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
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
  int index = 0;
  PageController pageController = PageController(initialPage: 0);

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
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.w),
                          _buildCard(),
                          SizedBox(height: 13.w),
                          _buildNav(context),
                        ],
                      ),
                    ),
                    _buildCardForms(context),
                    SizedBox(height: 10.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildSubmitButton(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          if (!_controller.state!.isFront) {
            _controller.toggleCard();
            setState(() {
              index = 0;
            });
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.ease);
            FocusScope.of(context).unfocus();
          }
        } else if (details.delta.dx < -sensitivity) {
          if (_controller.state!.isFront) {
            _controller.toggleCard();
            setState(() {
              index = 4;
            });
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.ease);
            FocusScope.of(context).unfocus();
          }
        }
      },
      child: FlipCard(
        controller: _controller,
        flipOnTouch: false,
        front: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.w)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            padding: EdgeInsets.fromLTRB(22.w, 22.w, 22.w, 18.w),
            height: 186.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/payment_card_bg.png')),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 36.w,
                      width: 36.w,
                      child: Image.asset('assets/card_asset1.png'),
                    ),
                    SizedBox(width: 16.w),
                    _bankName != ''
                        ? Text(
                            _bankName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              decoration: index == 0
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          )
                        : Text(
                            'Bank name',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.white60,
                              decoration: index == 0
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                  ],
                ),
                const Spacer(),
                _cardNo != ''
                    ? Text(
                        _cardNo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          decoration: index == 1
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      )
                    : Text(
                        '4393 1754 6712 5980',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                          decoration: index == 1
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                Row(
                  children: [
                    _holderName != ''
                        ? Text(
                            _holderName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: index == 2
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          )
                        : Text(
                            'Holder Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                              decoration: index == 2
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                    const Spacer(),
                    _expiryDate != ''
                        ? Text(
                            _expiryDate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: index == 3
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          )
                        : Text(
                            '03/23',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                              decoration: index == 3
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                    SizedBox(width: 30.w),
                  ],
                ),
              ],
            ),
          ),
        ),
        back: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.w)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            // padding: EdgeInsets.symmetric(22.w),
            height: 186.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/payment_card_bg.png')),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.w),
                Container(
                  color: Colors.black,
                  height: 48.w,
                ),
                SizedBox(height: 12.w),
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 60.w),
                  color: Colors.white,
                  height: 37.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 0; i < 7; i++)
                              Divider(
                                height: 5.w,
                                thickness: 2.w,
                                color: Colors.black12,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: _cvv != ''
                            ? Text(
                                _cvv,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : const Text(
                                'CVV',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black26,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNav(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.w),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            alignment: Alignment.center,
            height: 55.w,
            width: 55.w,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.arrow_back_ios,
                size: 27.w,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          onPressed: index <= 0
              ? null
              : () {
                  setState(() {
                    if (index > 0) {
                      index--;
                      if (index == 3) {
                        _controller.toggleCard();
                      }
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.ease);
                      FocusScope.of(context).unfocus();
                    }
                  });
                },
        ),
        const Spacer(),
        for (int i = 0; i < 5; i++)
          Container(
            margin: EdgeInsets.all(4.w),
            height: index == i ? 12.w : 7.w,
            width: index == i ? 12.w : 7.w,
            decoration: BoxDecoration(
              color: index == i
                  ? Theme.of(context).colorScheme.secondaryVariant
                  : Colors.grey[400],
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.w),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            alignment: Alignment.center,
            height: 55.w,
            width: 55.w,
            child: Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 27.w,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          onPressed: index > 3
              ? null
              : () {
                  setState(() {
                    if (index < 4) {
                      index++;
                      if (index == 4) {
                        _controller.toggleCard();
                      }
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.ease);
                      FocusScope.of(context).unfocus();
                    }
                  });
                },
        ),
      ],
    );
  }

  SizedBox _buildCardForms(BuildContext context) {
    return SizedBox(
      height: 110.w,
      child: PageView(
        controller: pageController,
        onPageChanged: (i) {
          setState(() {
            print('Page Changes to index $i');
            index = i;
          });
          FocusScope.of(context).unfocus();
        },
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Bank Name', Icons.account_balance_rounded),
              _buildBankName(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Card No.', Icons.pin_outlined),
              _buildCardNo(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Holder Name', Icons.person_outlined),
              _buildHolderName(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Expiry Date', Icons.calendar_today),
              _buildBankName(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('CVV', Icons.password),
              _buildCVV(context),
            ],
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

  Widget _buildHeader(String title, IconData iconData) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 25.w),
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

  Widget _buildBankName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: TextFormField(
        initialValue: _bankName,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. Canara',
        ),
        onChanged: (value) {
          setState(() {
            _bankName = value;
          });
        },
        validator: validateText,
      ),
    );
  }

  Widget _buildCardNo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              initialValue: _cardNo,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  _cardNo = value;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid!';
                }
                if (int.tryParse(value) == null) {
                  return "Invalid!";
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: _cardNo,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  _cardNo = value;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid!';
                }
                if (int.tryParse(value) == null) {
                  return "Invalid!";
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: _cardNo,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  _cardNo = value;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid!';
                }
                if (int.tryParse(value) == null) {
                  return "Invalid!";
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: _cardNo,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  _cardNo = value;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid!';
                }
                if (int.tryParse(value) == null) {
                  return "Invalid!";
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolderName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: TextFormField(
        initialValue: _holderName,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. John Smith',
        ),
        onChanged: (value) {
          setState(() {
            _holderName = value;
          });
        },
        validator: validateText,
      ),
    );
  }

  Widget _buildCVV(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: TextFormField(
        initialValue: _cvv,
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. 439',
        ),
        onChanged: (value) {
          setState(() {
            if (value.length<=3) {
              _cvv = value;
            }
            if(value.length==3){
              FocusScope.of(context).unfocus();
            }
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Invalid!';
          }
          if (int.tryParse(value) == null) {
            return "Invalid!";
          }
          if (int.tryParse(value)! > 999) {
            return "Invalid!";
          }
        },
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
