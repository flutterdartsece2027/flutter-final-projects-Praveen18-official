import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';

class OrdersHistoryScreen extends StatelessWidget {
  static const routeName = '/orders-history';
  
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).orders;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
        backgroundColor: Colors.green[800],
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your orders will appear here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: orders.length,
              itemBuilder: (ctx, i) => OrderCard(order: orders[i]),
            ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${order.amount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          'Order #${order.id.substring(order.id.length - 5)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${order.products.length} item${order.products.length > 1 ? 's' : ''} • ${DateFormat('MMM dd, yyyy - hh:mm a').format(order.dateTime)}',
        ),
        trailing: Chip(
          label: Text(
            order.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: order.status == 'Processing' ? Colors.orange : Colors.green,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...order.products.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.quantity}x ${item.name}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
                const Divider(),
                const Text(
                  'Delivery Address:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(order.address),
                const SizedBox(height: 8),
                Text('Payment Method: ${order.paymentMethod}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
