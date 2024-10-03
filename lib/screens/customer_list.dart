import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../services/api_service.dart';
import 'customer_add.dart';
import 'customer_update.dart'; // Thêm import

class CustomerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Khách Hàng')),
      body: FutureBuilder<List<Customer>>(
        future: ApiService().fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Customer> customers = snapshot.data!;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(customers[index].name),
                subtitle: Text(customers[index].email),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle delete
                    ApiService().deleteCustomer(customers[index].id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerUpdate(customer: customers[index]), // Điều hướng đến màn hình chỉnh sửa
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerAdd()), // Điều hướng đến màn hình thêm khách hàng
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
