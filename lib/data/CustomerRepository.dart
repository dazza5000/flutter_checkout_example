import '../model/SubscriptionRequest.dart';

class CustomerRepository {
  static final CustomerRepository _singleton = CustomerRepository._internal();

  SubscriptionRequest _customer;

  factory CustomerRepository() {
    return _singleton;
  }

  CustomerRepository._internal();

  void saveCustomer(SubscriptionRequest customer) {
    _customer = customer;
  }

  SubscriptionRequest getCustomer() {
    return _customer;
  }
}