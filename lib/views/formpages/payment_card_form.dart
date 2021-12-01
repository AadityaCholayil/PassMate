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
import 'package:passmate/shared/temp_error.dart';
import 'package:passmate/views/formpages/password_form.dart';

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
  String _color = 'purple';
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
      initialNo = [
        _cardNo.substring(0, 4),
        _cardNo.substring(4, 8),
        _cardNo.substring(8, 12),
        _cardNo.substring(12, 16)
      ];
      _holderName = widget.paymentCard!.holderName;
      _expiryDate = widget.paymentCard!.expiryDate;
      _cvv = widget.paymentCard!.cvv;
      _note =
          widget.paymentCard!.note == 'null' ? '' : widget.paymentCard!.note;
      _cardType = widget.paymentCard!.cardType;
      _favourite = widget.paymentCard!.favourite;
      _usage = widget.paymentCard!.usage;
      _color = widget.paymentCard!.color;
      _timeAdded = widget.paymentCard!.timeAdded;
    }
    _controller = FlipCardController();
    Future.delayed(const Duration(seconds: 2),
        () => _controller.hint(duration: const Duration(milliseconds: 800)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
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
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive
              print('Layout Changed');
              if (constraints.maxHeight < 1.2 * constraints.maxWidth) {
                // LandScape
                return const TempError(pageName: 'Payment Card Form Screen');
              }
              return _buildPaymentCardFormPortrait(context);
            }
          ),
        );
      },
    );
  }

  Widget _buildPaymentCardFormPortrait(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.w),
                    _buildCard(),
                    SizedBox(height: 10.w),
                    _buildNav(context),
                    SizedBox(height: 5.w),
                  ],
                ),
              ),
              _buildCardForms(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildHeader('Path', Icons.folder_outlined),
                    _buildFolderPath(),
                    _buildHeader('Category', Icons.category_outlined),
                    _buildCategory(),
                    _buildHeader(
                        'Note (Optional)', Icons.sticky_note_2_outlined),
                    _buildNote(context),
                    SizedBox(height: 20.w),
                    _buildSubmitButton(),
                    SizedBox(height: 50.w),
                  ],
                ),
              ),
            ],
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
                duration: const Duration(milliseconds: 1200),
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
                duration: const Duration(milliseconds: 1200),
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
            padding: EdgeInsets.fromLTRB(22.w, 22.w, 10.w, 18.w),
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
                    ? Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Text(
                                initialNo[i],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
                                  decoration: index == 1
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                        ],
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
            maximumSize: Size(45.w, 45.w),
            minimumSize: Size(45.w, 45.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 7.w),
            child: Icon(
              Icons.arrow_back_ios,
              size: 23.w,
              color: Theme.of(context).colorScheme.onSecondary,
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
            maximumSize: Size(45.w, 45.w),
            minimumSize: Size(45.w, 45.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 23.w,
              color: Theme.of(context).colorScheme.onSecondary,
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

  Widget _buildCardForms(BuildContext context) {
    return ConstraintsTransformBox(
      // constraints: BoxConstraints(
      //   minHeight: 105.w,
      //   maxHeight: 140.w,
      // ),
      constraintsTransform: (BoxConstraints constraints) {
        // print(constraints);
        return constraints.tighten(height: 102.w);
      },
      child: PageView(
        controller: pageController,
        onPageChanged: (i) {
          setState(() {
            if ((index == 4 && i == 5) || (index == 5 && i == 4)) {
              // print('bruh');
              _controller.state!.toggleCard();
            }
            print('Page Changes to index $i');
            index = i;
          });
          FocusScope.of(context).unfocus();
        },
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader('Bank Name', Icons.account_balance_rounded,
                  extraPadding: true),
              _buildBankName(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader('Card No.', Icons.pin_outlined, extraPadding: true),
              _buildCardNo(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader('Holder Name', Icons.person_outlined,
                  extraPadding: true),
              _buildHolderName(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader('Expiry Date', Icons.calendar_today,
                  extraPadding: true),
              _buildExpiryDate(context),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader('CVV', Icons.password, extraPadding: true),
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

  Widget _buildHeader(String title, IconData iconData,
      {bool extraPadding = false}) {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: extraPadding ? 25.w : 5.w),
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

  String? validateNo(String? value) {
    // if(value)
  }

  List<String> initialNo = ['', '', '', ''];

  Widget _buildCardNo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              initialValue: initialNo[0],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  initialNo[0] = value;
                  _cardNo = value + initialNo[1] + initialNo[2] + initialNo[3];
                  if (value.length == 4) {
                    FocusScope.of(context).nextFocus();
                  }
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: initialNo[1],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  initialNo[1] = value;
                  _cardNo = initialNo[0] + value + initialNo[2] + initialNo[3];
                  if (value.length == 4) {
                    FocusScope.of(context).nextFocus();
                  }
                  if (value.isEmpty || value == '') {
                    FocusScope.of(context).previousFocus();
                  }
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: initialNo[2],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  initialNo[2] = value;
                  _cardNo = initialNo[0] + initialNo[1] + value + initialNo[3];
                  if (value.length == 4) {
                    FocusScope.of(context).nextFocus();
                  }
                  if (value.isEmpty || value == '') {
                    FocusScope.of(context).previousFocus();
                  }
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: initialNo[3],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'XXXX',
              ),
              onChanged: (value) {
                setState(() {
                  initialNo[3] = value;
                  _cardNo = initialNo[0] + initialNo[1] + initialNo[2] + value;
                  if (value.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                  if (value.isEmpty || value == '') {
                    FocusScope.of(context).previousFocus();
                  }
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
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

  List<String> initialDate = ['', ''];

  Widget _buildExpiryDate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 7.w, 20.w, 5.w),
      child: Row(
        children: [
          // const Spacer(),
          Flexible(
            child: TextFormField(
              initialValue: initialDate[0],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'MM',
              ),
              onChanged: (value) {
                setState(() {
                  if (value.length == 2) {
                    FocusScope.of(context).nextFocus();
                  }
                  initialDate[0] = value;
                  _expiryDate = value + '/' + initialDate[1];
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '/',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: TextFormField(
              initialValue: initialDate[1],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              style: formTextStyle2(context),
              decoration: customInputDecoration2(
                context: context,
                labelText: 'YY',
              ),
              onChanged: (value) {
                setState(() {
                  initialDate[1] = value;
                  _expiryDate = initialDate[0] + '/' + value;
                  if (value.length == 2) {
                    FocusScope.of(context).unfocus();
                  }
                  if (value.isEmpty || value == '') {
                    FocusScope.of(context).previousFocus();
                  }
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateNo,
            ),
          ),
          // const Spacer(),
        ],
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
            if (value.length <= 3) {
              _cvv = value;
            }
            if (value.length == 3) {
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

  Widget _buildFolderPath() {
    List<String> pathList = [];
    _path.split('/').forEach((path) {
      if (path == 'root') {
        pathList.add('My Folders');
      } else {
        pathList.add(path.replaceRange(0, 1, path[0].toUpperCase()));
      }
    });
    return Container(
      margin: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.w),
        onTap: () async {
          print('change path');
          var res = await showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.25),
            // backgroundColor: Colors.transparent,
            builder: (context) {
              return SelectFolderDialog(startPath: _path);
            },
          );
          if (res != null) {
            setState(() {
              _path = res;
            });
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 55.w,
          padding: EdgeInsets.only(left: 18.w, right: 7.w),
          // padding: EdgeInsets.fromLTRB(18.w, 11.w, 15.w, 11.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryVariant,
              width: 2.w,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: pathList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (pathList.length == index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    } else {
                      return Center(
                        child: Text(
                          pathList[index],
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.w,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5.w),
              const Icon(
                Icons.expand_more,
                size: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    String label = getPaymentCardTypeStr(_cardType);
    return Container(
      margin: EdgeInsets.only(top: 7.w, bottom: 5.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.w),
        onTap: () async {
          var res = await showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.25),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return _buildCategoryCard();
            },
          );
          if (res != null) {
            setState(() {
              _cardType = res;
            });
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 55.w,
          padding: EdgeInsets.only(left: 18.w, right: 7.w),
          // padding: EdgeInsets.fromLTRB(18.w, 11.w, 15.w, 11.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryVariant,
              width: 2.w,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Icon(
                paymentCardCategoryIcon[label],
                size: 23.w,
              ),
              SizedBox(width: 10.w),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              SizedBox(width: 5.w),
              const Icon(
                Icons.expand_more,
                size: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard() {
    return StatefulBuilder(
      builder: (context, setState) {
        PaymentCardType category = _cardType;
        return Card(
          margin: EdgeInsets.all(10.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                // Divider(thickness: 1,),
                SizedBox(height: 17.w),
                Wrap(
                  runSpacing: 8.w,
                  spacing: 8.w,
                  children: [
                    for (int index = 1;
                        index < PaymentCardType.values.length;
                        index++)
                      Builder(
                        builder: (context) {
                          String label = getPaymentCardTypeStr(
                              PaymentCardType.values[index]);
                          bool selected =
                              category == PaymentCardType.values[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                category = PaymentCardType.values[index];
                              });
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                Navigator.pop(context, category);
                              });
                            },
                            child: Chip(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 0.8),
                              avatar: Icon(
                                paymentCardCategoryIcon[label],
                                size: 23.w,
                                color: !selected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).cardColor,
                              ),
                              backgroundColor: selected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).cardColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.w, vertical: 7.w),
                              // padding: EdgeInsets.fromLTRB(12.w, 7.w, 12.w, 7.w),
                              labelPadding: EdgeInsets.fromLTRB(8.w, 0, 6.w, 0),
                              label: Text(
                                label,
                                style: TextStyle(
                                  color: !selected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).cardColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                SizedBox(height: 5.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.w, 7.w, 0.w, 5.w),
      child: TextFormField(
        initialValue: _note,
        style: formTextStyle2(context),
        decoration: customInputDecoration(
          context: context,
          labelText: 'Eg. Work Card',
        ),
        maxLines: 3,
        onChanged: (value) {
          setState(() {
            _note = value;
          });
        },
        validator: validateText,
      ),
    );
  }

  String validateAll() {
    if (_bankName == '') {
      return 'Bank name invalid!';
    }
    if (_cardNo == '' || int.tryParse(_cardNo) == null) {
      return 'Card number invalid!';
    }
    if (_holderName == '') {
      return 'Holder name invalid!';
    }
    if (_expiryDate == '' ||
        int.tryParse(_expiryDate.substring(0, 2)) == null ||
        int.tryParse(_expiryDate.substring(3, 5)) == null) {
      return 'Expiry date invalid!';
    }
    if (_cvv == '' || int.tryParse(_cvv) == null) {
      return 'CVV invalid!';
    }
    return 'success';
  }

  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      style: 0,
      text: _isUpdate ? 'Update' : 'Submit',
      onPressed: () {
        // if (!_formKey.currentState!.validate()) {
        //   return;
        // }
        String validationStatus = validateAll();
        if (validationStatus != 'success') {
          print(validationStatus);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showCustomSnackBar(context, validationStatus));
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
          note: _note == '' ? 'null' : _note,
          favourite: _favourite,
          usage: _usage,
          color: _color,
          lastUsed: Timestamp.now(),
          timeAdded: _timeAdded ?? Timestamp.now(),
        );
        print(paymentCard);
        if (!_isUpdate) {
          context.read<DatabaseBloc>().add(AddPaymentCard(paymentCard));
        } else {
          context.read<DatabaseBloc>().add(UpdatePaymentCard(
                paymentCard,
                true,
                widget.paymentCard!.path,
              ));
        }
      },
    );
  }
}
