import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/api_service.dart';

class CustomerUpdate extends StatefulWidget {
  final Customer customer;

  CustomerUpdate({required this.customer});

  @override
  _CustomerUpdateState createState() => _CustomerUpdateState();
}

class _CustomerUpdateState extends State<CustomerUpdate> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;
  late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.customer.name;
    _phone = widget.customer.phone;
    _email = widget.customer.email;
    _address = widget.customer.address;
  }

  void _updateCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Customer updatedCustomer = Customer(
        id: widget.customer.id,
        name: _name,
        phone: _phone,
        email: _email,
        address: _address,
        createdAt: widget.customer.createdAt,
      );

      try {
        await ApiService().updateCustomer(updatedCustomer);
        Navigator.pop(context); // Quay lại màn hình danh sách
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed update cus: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chỉnh Sửa Khách Hàng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Tên Khách Hàng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên khách hàng';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Số Điện Thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Vui lòng nhập email hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Địa Chỉ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateCustomer,
                child: Text('Cập Nhật Khách Hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
