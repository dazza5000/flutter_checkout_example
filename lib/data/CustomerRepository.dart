import '../model/Customer.dart';

class CustomerRepository {
  static final CustomerRepository _singleton = CustomerRepository._internal();

  Customer _customer;

  factory CustomerRepository() {
    return _singleton;
  }

  CustomerRepository._internal();

  void saveCustomer(Customer customer) {
    _customer = customer;
  }

  Customer getCustomer() {
    return _customer;
  }
}