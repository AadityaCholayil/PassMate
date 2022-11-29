// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) {
  return _PaymentCard.fromJson(json);
}

/// @nodoc
mixin _$PaymentCard {
  String get id => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String get cardNo => throw _privateConstructorUsedError;
  String get holderName => throw _privateConstructorUsedError;
  String get expiryDate => throw _privateConstructorUsedError;
  String get cvv => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  bool get favourite => throw _privateConstructorUsedError;
  int get usage => throw _privateConstructorUsedError;
  PaymentCardType get cardType => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastUsed => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timeAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCardCopyWith<PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCardCopyWith<$Res> {
  factory $PaymentCardCopyWith(
          PaymentCard value, $Res Function(PaymentCard) then) =
      _$PaymentCardCopyWithImpl<$Res, PaymentCard>;
  @useResult
  $Res call(
      {String id,
      String path,
      String bankName,
      String cardNo,
      String holderName,
      String expiryDate,
      String cvv,
      String note,
      String color,
      bool favourite,
      int usage,
      PaymentCardType cardType,
      @TimestampConverter() DateTime lastUsed,
      @TimestampConverter() DateTime timeAdded});
}

/// @nodoc
class _$PaymentCardCopyWithImpl<$Res, $Val extends PaymentCard>
    implements $PaymentCardCopyWith<$Res> {
  _$PaymentCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? bankName = null,
    Object? cardNo = null,
    Object? holderName = null,
    Object? expiryDate = null,
    Object? cvv = null,
    Object? note = null,
    Object? color = null,
    Object? favourite = null,
    Object? usage = null,
    Object? cardType = null,
    Object? lastUsed = null,
    Object? timeAdded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      cardNo: null == cardNo
          ? _value.cardNo
          : cardNo // ignore: cast_nullable_to_non_nullable
              as String,
      holderName: null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      cvv: null == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      favourite: null == favourite
          ? _value.favourite
          : favourite // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as int,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as PaymentCardType,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeAdded: null == timeAdded
          ? _value.timeAdded
          : timeAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentCardCopyWith<$Res>
    implements $PaymentCardCopyWith<$Res> {
  factory _$$_PaymentCardCopyWith(
          _$_PaymentCard value, $Res Function(_$_PaymentCard) then) =
      __$$_PaymentCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String path,
      String bankName,
      String cardNo,
      String holderName,
      String expiryDate,
      String cvv,
      String note,
      String color,
      bool favourite,
      int usage,
      PaymentCardType cardType,
      @TimestampConverter() DateTime lastUsed,
      @TimestampConverter() DateTime timeAdded});
}

/// @nodoc
class __$$_PaymentCardCopyWithImpl<$Res>
    extends _$PaymentCardCopyWithImpl<$Res, _$_PaymentCard>
    implements _$$_PaymentCardCopyWith<$Res> {
  __$$_PaymentCardCopyWithImpl(
      _$_PaymentCard _value, $Res Function(_$_PaymentCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? bankName = null,
    Object? cardNo = null,
    Object? holderName = null,
    Object? expiryDate = null,
    Object? cvv = null,
    Object? note = null,
    Object? color = null,
    Object? favourite = null,
    Object? usage = null,
    Object? cardType = null,
    Object? lastUsed = null,
    Object? timeAdded = null,
  }) {
    return _then(_$_PaymentCard(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      null == cardNo
          ? _value.cardNo
          : cardNo // ignore: cast_nullable_to_non_nullable
              as String,
      null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
      null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String,
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      null == favourite
          ? _value.favourite
          : favourite // ignore: cast_nullable_to_non_nullable
              as bool,
      null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as int,
      null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as PaymentCardType,
      null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == timeAdded
          ? _value.timeAdded
          : timeAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentCard extends _PaymentCard {
  const _$_PaymentCard(
      this.id,
      this.path,
      this.bankName,
      this.cardNo,
      this.holderName,
      this.expiryDate,
      this.cvv,
      this.note,
      this.color,
      this.favourite,
      this.usage,
      this.cardType,
      @TimestampConverter() this.lastUsed,
      @TimestampConverter() this.timeAdded)
      : super._();

  factory _$_PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentCardFromJson(json);

  @override
  final String id;
  @override
  final String path;
  @override
  final String bankName;
  @override
  final String cardNo;
  @override
  final String holderName;
  @override
  final String expiryDate;
  @override
  final String cvv;
  @override
  final String note;
  @override
  final String color;
  @override
  final bool favourite;
  @override
  final int usage;
  @override
  final PaymentCardType cardType;
  @override
  @TimestampConverter()
  final DateTime lastUsed;
  @override
  @TimestampConverter()
  final DateTime timeAdded;

  @override
  String toString() {
    return 'PaymentCard(id: $id, path: $path, bankName: $bankName, cardNo: $cardNo, holderName: $holderName, expiryDate: $expiryDate, cvv: $cvv, note: $note, color: $color, favourite: $favourite, usage: $usage, cardType: $cardType, lastUsed: $lastUsed, timeAdded: $timeAdded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.cardNo, cardNo) || other.cardNo == cardNo) &&
            (identical(other.holderName, holderName) ||
                other.holderName == holderName) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.cvv, cvv) || other.cvv == cvv) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.favourite, favourite) ||
                other.favourite == favourite) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.timeAdded, timeAdded) ||
                other.timeAdded == timeAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      path,
      bankName,
      cardNo,
      holderName,
      expiryDate,
      cvv,
      note,
      color,
      favourite,
      usage,
      cardType,
      lastUsed,
      timeAdded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentCardCopyWith<_$_PaymentCard> get copyWith =>
      __$$_PaymentCardCopyWithImpl<_$_PaymentCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentCardToJson(
      this,
    );
  }
}

abstract class _PaymentCard extends PaymentCard {
  const factory _PaymentCard(
      final String id,
      final String path,
      final String bankName,
      final String cardNo,
      final String holderName,
      final String expiryDate,
      final String cvv,
      final String note,
      final String color,
      final bool favourite,
      final int usage,
      final PaymentCardType cardType,
      @TimestampConverter() final DateTime lastUsed,
      @TimestampConverter() final DateTime timeAdded) = _$_PaymentCard;
  const _PaymentCard._() : super._();

  factory _PaymentCard.fromJson(Map<String, dynamic> json) =
      _$_PaymentCard.fromJson;

  @override
  String get id;
  @override
  String get path;
  @override
  String get bankName;
  @override
  String get cardNo;
  @override
  String get holderName;
  @override
  String get expiryDate;
  @override
  String get cvv;
  @override
  String get note;
  @override
  String get color;
  @override
  bool get favourite;
  @override
  int get usage;
  @override
  PaymentCardType get cardType;
  @override
  @TimestampConverter()
  DateTime get lastUsed;
  @override
  @TimestampConverter()
  DateTime get timeAdded;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentCardCopyWith<_$_PaymentCard> get copyWith =>
      throw _privateConstructorUsedError;
}
