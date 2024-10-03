import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/api_service.dart';

class CustomerAdd extends StatefulWidget {
  @override
  _CustomerAddState createState() => _CustomerAddState();
}

class _CustomerAddState extends State<CustomerAdd> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _email;
  String? _address;

  void _addCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Customer newCustomer = Customer(
        id: '',
        name: _name!,
        phone: _phone!,
        email: _email!,
        address: _address!,
        createdAt: DateTime.now(),
      );

      try {
        await ApiService().addCustomer(newCustomer);
        Navigator.pop(context); // Quay lại màn hình danh sách
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed add cus: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm Khách Hàng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tên Khách Hàng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên khách hàng';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Số Điện Thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Vui lòng nhập email hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Địa Chỉ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
                onSaved: (value) => _address = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCustomer,
                child: Text('Thêm Khách Hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
