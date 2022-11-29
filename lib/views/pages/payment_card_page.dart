import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/model/old_payment_card.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/theme/theme.dart';
import 'package:passmate/views/formpages/payment_card_form.dart';
import 'package:passmate/shared/custom_animated_app_bar.dart';

class PaymentCardPage extends StatefulWidget {
  const PaymentCardPage({Key? key}) : super(key: key);

  @override
  _PaymentCardPageState createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  PaymentCardType paymentCardType = PaymentCardType.all;
  SortMethod sortMethod = SortMethod.recentlyAdded;
  String sortLabel = '';
  String? searchLabel;
  List<OldPaymentCard> completePaymentCardList = [];
  List<OldPaymentCard> paymentCardList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    print('initState1');
    SortMethod sortMethod =
        context.read<AppBloc>().userData.sortMethod ?? SortMethod.recentlyAdded;
    context.read<DatabaseBloc>().add(GetPaymentCards(sortMethod: sortMethod));
    print('initState2');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const CustomFAB(),
        body: CustomAnimatedAppBar(
          child: BlocBuilder<DatabaseBloc, DatabaseState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is PaymentCardPageState) {
                if (state.pageState == PageState.loading) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.error) {
                  return const FixedLoading();
                }
                if (state.pageState == PageState.success) {
                  paymentCardList = state.list;
                  paymentCardType = state.paymentCardType;
                  favourites = state.favourites;
                  sortMethod = state.sortMethod;
                  searchLabel = state.search;
                  sortLabel = sortMethodMessages[sortMethod.index];
                  if (paymentCardType == PaymentCardType.all && !favourites) {
                    completePaymentCardList = state.completeList;
                  }
                  if (state.completeList != state.list) {
                    completePaymentCardList = state.completeList;
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 32.w, top: 20.w),
                        child: Text(
                          'Payment Cards',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      SizedBox(height: 13.w),
                      completePaymentCardList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSearch(context),
                                SizedBox(height: 20.w),
                                _buildChipRow(),
                                // SizedBox(height: 10.w),
                                _buildSortDropDownBox(context),
                                SizedBox(height: 5.w),
                              ],
                            )
                          : const SizedBox.shrink(),
                      state is Fetching
                          ? Container(
                              height: 180.w,
                              alignment: Alignment.center,
                              child: const LoadingSmall(),
                            )
                          : completePaymentCardList.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 320.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Start Adding Cards',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'All your cards will be secure\nusing AES-256 encryption.',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              : Flexible(
                                  child: PaymentCardTileList(
                                      paymentCardList: paymentCardList),
                                ),
                      SizedBox(
                        height: paymentCardList.length < 2
                            ? paymentCardList.isEmpty
                                ? 140.h
                                : 50.h
                            : 0,
                      ),
                    ],
                  );
                }
              }
              return const FixedLoading();
            },
          ),
        ),
      ),
    );
  }

  Padding _buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomShadow(
        child: TextFormField(
          initialValue: searchLabel,
          decoration: customInputDecoration(
            context: context,
            labelText: 'Search',
            isSearch: true,
          ),
          style: formTextStyle(context),
          onChanged: (val) {
            context.read<DatabaseBloc>().add(GetPaymentCards(
                  search: val,
                  paymentCardType: paymentCardType,
                  list: completePaymentCardList,
                ));
          },
        ),
      ),
    );
  }

  Widget _buildChipRow() {
    bool isDefault =
        paymentCardType == PaymentCardType.all && favourites == false;
    return SizedBox(
      height: 54.w,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 24.w),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: (!isDefault && !favourites)
            ? PaymentCardType.values.length + 1
            : PaymentCardType.values.length,
        itemBuilder: (context, index) {
          bool selected = false;
          bool fav = false;
          String label = '';
          int? selectedIndex;
          PaymentCardType category = PaymentCardType.all;
          if (paymentCardType == PaymentCardType.all && !favourites) {
            category = PaymentCardType.values[index];
            label = getPaymentCardTypeStr(category);
            if (index == 0) {
              label = 'Favourites';
              fav = true;
            }
          } else {
            selectedIndex = paymentCardType.index;
            if (selectedIndex == 0) {
              //favourites
              if (index != 0) {
                category = PaymentCardType.values[index];
                label = getPaymentCardTypeStr(category);
              } else {
                selected = true;
                label = 'Favourites';
                fav = true;
              }
            } else {
              if (index != 0) {
                if (index == 1) {
                  label = 'Favourites';
                  fav = true;
                } else {
                  category = PaymentCardType.values[index - 1];
                  label = getPaymentCardTypeStr(category);
                }
              } else {
                selected = true;
                label = getPaymentCardTypeStr(paymentCardType);
                category = PaymentCardType.values[index];
              }
            }
          }
          if (selectedIndex != null) {
            if (selectedIndex + 1 == index && selectedIndex != 0) {
              return const SizedBox.shrink();
            }
          }
          return Container(
            margin: EdgeInsets.only(right: 15.w, bottom: 10.w),
            child: InkWell(
              onTap: () {
                print(category);
                context.read<DatabaseBloc>().add(GetPaymentCards(
                    search: searchLabel,
                    paymentCardType: category,
                    favourites: fav,
                    list: completePaymentCardList));
              },
              child: Container(
                height: 44.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: CustomTheme.cardShadow,
                      blurRadius: 8,
                      offset: Offset(4.w, 4.w),
                    ),
                  ],
                  border: Border.all(
                      color:
                          selected ? CustomTheme.secondary : Colors.transparent,
                      width: 2.w),
                  color: CustomTheme.card,
                  borderRadius: BorderRadius.circular(40.w),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Icon(
                      paymentCardCategoryIcon[label],
                      size: 24.w,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      label,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    selected
                        ? Padding(
                            padding: EdgeInsets.only(left: 6.w, right: 10.w),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<DatabaseBloc>()
                                    .add(GetPasswords());
                              },
                              child: Icon(
                                Icons.highlight_remove,
                                size: 25.w,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          )
                        : SizedBox(width: 22.w),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortDropDownBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.w,
      ),
      child: DropdownButton<SortMethod>(
        value: sortMethod,
        itemHeight: 50.w,
        items: <SortMethod>[
          SortMethod.values[0],
          SortMethod.values[1],
          SortMethod.values[2],
        ].map<DropdownMenuItem<SortMethod>>((value) {
          String label = sortMethodMessages[value.index];
          return DropdownMenuItem(
            value: value,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 2.w, 10.w, 2.w),
              child: Text(
                label,
                style: value == sortMethod
                    ? TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
              ),
            ),
          );
        }).toList(),
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        iconEnabledColor: Theme.of(context).primaryColor,
        iconSize: 30.w,
        onChanged: (val) {
          sortMethod = val ?? sortMethod;
          context
              .read<DatabaseBloc>()
              .add(GetPaymentCards(sortMethod: sortMethod));
        },
      ),
    );
  }
}

class PaymentCardTileList extends StatelessWidget {
  const PaymentCardTileList({
    Key? key,
    required this.paymentCardList,
  }) : super(key: key);

  final List<OldPaymentCard> paymentCardList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: paymentCardList.length,
      itemBuilder: (context, index) {
        OldPaymentCard paymentCard = paymentCardList[index];
        return PaymentCardTile(paymentCard: paymentCard);
      },
    );
  }
}

class PaymentCardTile extends StatelessWidget {
  const PaymentCardTile({
    Key? key,
    required this.paymentCard,
  }) : super(key: key);

  final OldPaymentCard paymentCard;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!ZoomDrawer.of(context)!.isOpen()) {
          paymentCard.lastUsed = Timestamp.now();
          paymentCard.usage++;
          dynamic res = await showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.25),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return PaymentCardDetailCard(paymentCard: paymentCard);
            },
          );
          if (res != 'Deleted' && res != 'Updated') {
            context
                .read<DatabaseBloc>()
                .add(UpdatePaymentCard(paymentCard, false, paymentCard.path));
          }
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 16.w),
        height: 202.w,
        margin: EdgeInsets.only(bottom: 20.w, left: 24.w, right: 24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.w),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/payment_card_bg.png')),
          boxShadow: [
            BoxShadow(
              color: CustomTheme.cardShadow,
              blurRadius: 2,
              offset: Offset(4.w, 4.w),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 39.w,
                  width: 39.w,
                  child: Image.asset('assets/card_asset1.png'),
                ),
                SizedBox(width: 15.w),
                Text(
                  paymentCard.bankName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Text(
                      paymentCard.cardNo.substring(i * 4, i * 4 + 4),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Text(
                  paymentCard.holderName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  paymentCard.expiryDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(width: .w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCardDetailCard extends StatefulWidget {
  const PaymentCardDetailCard({
    Key? key,
    required this.paymentCard,
  }) : super(key: key);

  final OldPaymentCard paymentCard;

  @override
  State<PaymentCardDetailCard> createState() => _PaymentCardDetailCardState();
}

class _PaymentCardDetailCardState extends State<PaymentCardDetailCard> {
  late OldPaymentCard paymentCard;
  bool showCVV = false;
  late String categoryText;
  late FlipCardController _controller;

  @override
  void initState() {
    super.initState();
    paymentCard = widget.paymentCard;
    categoryText = getPaymentCardTypeStr(paymentCard.cardType);
    _controller = FlipCardController();
    Future.delayed(const Duration(milliseconds: 700),
        () => _controller.hint(duration: const Duration(milliseconds: 800)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.w,
      child: Card(
        margin: EdgeInsets.all(10.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
        child: Column(
          children: [
            SizedBox(
              height: 325.w,
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFlipCard(),
                      SizedBox(height: 10.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel(context, 'Card Holder Name'),
                            Row(
                              children: [
                                _buildContent(context, paymentCard.holderName),
                                const Spacer(),
                                IconButton(
                                  constraints:
                                      BoxConstraints.tight(Size(30.w, 30.w)),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.copy, size: 25.w),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: paymentCard.holderName));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8.w),
                            _buildLabel(context, 'Card Number'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: _buildContent(
                                        context,
                                        paymentCard.cardNo
                                            .substring(i * 4, i * 4 + 4)),
                                  ),
                                const Spacer(),
                                IconButton(
                                  constraints:
                                      BoxConstraints.tight(Size(30.w, 30.w)),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.copy, size: 25.w),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: paymentCard.cardNo));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.w),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel(context, 'Valid Thru'),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 30.w,
                                            child: _buildContent(context,
                                                paymentCard.expiryDate),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel(context, 'CVV'),
                                      Row(
                                        children: [
                                          _buildContent(
                                              context,
                                              showCVV
                                                  ? paymentCard.cvv
                                                  : '•' *
                                                      paymentCard.cvv.length),
                                          const Spacer(),
                                          IconButton(
                                            constraints: BoxConstraints.tight(
                                                Size(30.w, 30.w)),
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                                showCVV
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 25.w),
                                            onPressed: () {
                                              setState(() {
                                                showCVV = !showCVV;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 3.w),
                                          IconButton(
                                            constraints: BoxConstraints.tight(
                                                Size(30.w, 30.w)),
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.copy, size: 25.w),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: paymentCard.cvv));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.w),
                            _buildLabel(context, 'Category'),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              child: Row(
                                children: [
                                  Icon(
                                    paymentCardCategoryIcon[
                                        getPaymentCardTypeStr(
                                            paymentCard.cardType)],
                                    size: 24.w,
                                  ),
                                  SizedBox(width: 20.w),
                                  _buildContent(context, categoryText),
                                ],
                              ),
                            ),
                            paymentCard.note != 'null'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.w),
                                      _buildLabel(context, 'Note'),
                                      _buildContent(context, paymentCard.note),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 20.w),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 55.w,
                      width: 55.w,
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: 31.w,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(DeletePaymentCard(widget.paymentCard));
                      Navigator.pop(context, 'Deleted');
                    },
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomElevatedButton(
                      style: 0,
                      text: 'Edit Payment Card',
                      onPressed: () {
                        print(widget.paymentCard.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentCardFormPage(
                                  paymentCard: widget.paymentCard)),
                        ).then((value) {
                          BlocProvider.of<DatabaseBloc>(context)
                              .add(GetPaymentCards());
                          Navigator.pop(context, 'Updated');
                        });
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

  Widget _buildFlipCard() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          if (!_controller.state!.isFront) {
            _controller.toggleCard();
          }
        } else if (details.delta.dx < -sensitivity) {
          if (_controller.state!.isFront) {
            _controller.toggleCard();
          }
        }
      },
      child: FlipCard(
        controller: _controller,
        front: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.w)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 16.w),
            height: 174.w,
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
                      height: 33.w,
                      width: 33.w,
                      child: Image.asset('assets/card_asset1.png'),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      paymentCard.bankName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Text(
                          paymentCard.cardNo.substring(i * 4, i * 4 + 4),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      paymentCard.holderName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      paymentCard.expiryDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // SizedBox(width: .w),
                  ],
                ),
              ],
            ),
          ),
        ),
        back: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.w)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
          child: Container(
            height: 174.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/payment_card_bg.png')),
            ),
            child: Column(
              children: [
                SizedBox(height: 17.w),
                Container(
                  color: Colors.black,
                  height: 45.w,
                ),
                SizedBox(height: 12.w),
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 60.w),
                  color: Colors.white,
                  height: 34.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            for (int i = 0; i < 7; i++)
                              Divider(
                                height: 4.5.w,
                                thickness: 2.w,
                                color: Colors.black12,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          paymentCard.cvv,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
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

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.secondaryVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
