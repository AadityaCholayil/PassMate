import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:passmate/bloc/app_bloc/app_bloc_files.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/shared/custom_widgets.dart';
import 'package:passmate/shared/loading.dart';
import 'package:passmate/views/formpages/payment_card_form.dart';

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
  List<PaymentCard> completePaymentCardList = [];
  List<PaymentCard> paymentCardList = [];
  bool favourites = false;

  @override
  void initState() {
    super.initState();
    sortMethod = context.read<AppBloc>().userData.sortMethod ??
        SortMethod.recentlyAdded;
    sortLabel = sortMethodMessages[sortMethod.index];
    context.read<DatabaseBloc>().add(GetPaymentCards(
        sortMethod: sortMethod, paymentCardType: paymentCardType));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseBloc, DatabaseState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        print('widget rebuilt');
        if (state is PaymentCardList) {
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
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28.w, top: 13.w),
              child: Text(
                'Payment Cards',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            SizedBox(height: 13.w),
            _buildSearch(context),
            SizedBox(height: 15.w),
            completePaymentCardList.isNotEmpty
                ? _buildChipRow()
                : const SizedBox.shrink(),
            SizedBox(height: 5.w),
            completePaymentCardList.isNotEmpty
                ? _buildSortDropDownBox(context)
                : const SizedBox.shrink(),
            SizedBox(height: 5.w),
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
                              'Start adding your Cards',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'All your payment cards will be secure\nusing AES-256 encryption.',
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
              height: paymentCardList.length < 3
                  ? paymentCardList.isEmpty
                      ? 12.w
                      : 200.w
                  : 0,
            ),
          ],
        );
      },
    );
  }

  Padding _buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
    );
  }

  Widget _buildChipRow() {
    bool isDefault =
        paymentCardType == PaymentCardType.all && favourites == false;
    return SizedBox(
      height: 45.w,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20.w),
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
            label = PaymentCardType.values[index].toString().substring(16);
            category = PaymentCardType.values[index];
            if (index == 0) {
              label = 'Favourites';
              fav = true;
            }
          } else {
            selectedIndex = paymentCardType.index;
            if (selectedIndex == 0) {
              //favourites
              if (index != 0) {
                label = PaymentCardType.values[index].toString().substring(16);
                category = PaymentCardType.values[index];
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
                  label = PaymentCardType.values[index - 1]
                      .toString()
                      .substring(16);
                  category = PaymentCardType.values[index - 1];
                }
              } else {
                selected = true;
                label = paymentCardType.toString().substring(16);
                category = PaymentCardType.values[index];
              }
            }
          }
          if (selectedIndex != null) {
            if (selectedIndex + 1 == index && selectedIndex != 0) {
              return const SizedBox.shrink();
            }
          }
          switch (label) {
            case 'creditCard':
              label = 'Credit Card';
              break;
            case 'debitCard':
              label = 'Debit Card';
              break;
            default:
              break;
          }
          return Container(
            margin: EdgeInsets.only(right: 7.w),
            child: InkWell(
              onTap: () {
                print(category);
                context.read<DatabaseBloc>().add(GetPaymentCards(
                      search: searchLabel,
                      paymentCardType: category,
                      favourites: fav,
                      list: completePaymentCardList,
                    ));
              },
              child: Chip(
                side: selected
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2)
                    : null,
                avatar: Icon(
                  Icons.favorite_border_rounded,
                  size: 23.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
                // padding: EdgeInsets.fromLTRB(12.w, 7.w, 12.w, 7.w),
                labelPadding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                label: Text(
                  label.replaceRange(0, 1, label.substring(0, 1).toUpperCase()),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
                deleteIcon: Icon(
                  Icons.highlight_remove,
                  size: 25.w,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onDeleted: !selected
                    ? null
                    : () {
                        context.read<DatabaseBloc>().add(GetPaymentCards());
                      },
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
        left: 28.w,
      ),
      child: DropdownButton<SortMethod>(
        value: sortMethod,
        itemHeight: 55.w,
        items: <SortMethod>[
          SortMethod.values[0],
          SortMethod.values[1],
          SortMethod.values[2],
        ].map<DropdownMenuItem<SortMethod>>((value) {
          String label = sortMethodMessages[value.index];
          return DropdownMenuItem(
            value: value,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 7.w, 10.w, 7.w),
              child: Text(
                label,
                style: value == sortMethod
                    ? TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : TextStyle(
                        fontSize: 24,
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

  final List<PaymentCard> paymentCardList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: paymentCardList.length,
      itemBuilder: (context, index) {
        PaymentCard paymentCard = paymentCardList[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: PaymentCardTile(paymentCard: paymentCard),
        );
      },
    );
  }
}

class PaymentCardTile extends StatelessWidget {
  const PaymentCardTile({
    Key? key,
    required this.paymentCard,
  }) : super(key: key);

  final PaymentCard paymentCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13.w),
      height: 87.w,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.w),
        ),
        child: InkWell(
          onTap: () {
            if (!ZoomDrawer.of(context)!.isOpen()) {
              paymentCard.lastUsed = Timestamp.now();
              paymentCard.usage++;
              context
                  .read<DatabaseBloc>()
                  .add(UpdatePaymentCard(paymentCard, false, paymentCard.path));
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withOpacity(0.25),
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return PaymentCardDetailCard(paymentCard: paymentCard);
                },
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.w),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      paymentCard.bankName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      paymentCard.cardNo,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentCardDetailCard extends StatelessWidget {
  const PaymentCardDetailCard({
    Key? key,
    required this.paymentCard,
  }) : super(key: key);

  final PaymentCard paymentCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.w,
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      BlocProvider.of<DatabaseBloc>(context)
                          .add(DeletePaymentCard(paymentCard));
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Edit Payment Card'),
                    onPressed: () {
                      print(paymentCard.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaymentCardFormPage(paymentCard: paymentCard)),
                      ).then((value) {
                        BlocProvider.of<DatabaseBloc>(context)
                            .add(GetPaymentCards());
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
