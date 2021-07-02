class PaymentCard {
  String bankName = '';
  String cardNo = '';
  String holderName = '';
  String expiryDate = '';
  String cvv = '';
  CardType cardType = CardType.CreditCard;

  PaymentCard(
      {this.bankName = '',
      this.cardNo = '',
      this.holderName = '',
      this.expiryDate = '',
      this.cvv = '',
      this.cardType = CardType.CreditCard});
}

enum CardType{
  All,
  CreditCard,
  DebitCard,
  Others
}
