import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class ApiService {
  final String baseUrl = 'https://66fe505b2b9aac9c997b5140.mockapi.io/api/customers/customers';

  Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((customer) => Customer.fromJson(customer)).toList();
    } else {
      throw Exception("failed fetch from data  ");
    }
  }

  Future<void> addCustomer(Customer customer) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed add cus');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${customer.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('failed update cus');
    }
  }

  Future<void> deleteCustomer(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed delete cus');
    }
  }
}
