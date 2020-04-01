import '../model/CreditCard.dart';

class CardRepository {
  static final CardRepository _singleton = CardRepository._internal();

  CreditCard _card;

  factory CardRepository() {
    return _singleton;
  }

  CardRepository._internal();

  void saveCard(CreditCard card) {
    _card = card;
  }

  CreditCard getCard() {
    return _card;
  }
}