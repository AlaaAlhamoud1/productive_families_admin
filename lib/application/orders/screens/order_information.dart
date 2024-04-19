// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:productive_families_admin/application/orders/models/orders_model.dart';
import 'package:productive_families_admin/application/products/widgets/products_card.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';

class OrderInformationScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderInformationScreen({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<OrderInformationScreen> createState() => _OrderInformationScreenState();
}

List<String> status = [
  'pending',
  'Delivery in progress',
  'Delivered',
  'Underway',
  'Implemented'
];
String? selctedItem = 'pending';
bool? visible;

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  @override
  void initState() {
    visible = false;
    selctedItem = widget.orderModel.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: const Text(
            "Order Details",
          ),
          backgroundColor: Colors.green),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "date:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: Text(widget.orderModel.date!.substring(0, 10)))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "time:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 2,
                    child: Text(widget.orderModel.date!.substring(11, 16)))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "Order Status:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(flex: 2, child: Text(widget.orderModel.status ?? ""))
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(
                child: Text(
                  "change status",
                  style: TextStyle(
                      color: Color(0xFF4AC382), fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: DropdownButton<String>(
                  value: selctedItem,
                  items: status
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                          )))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      selctedItem = item;
                      visible = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: visible ?? false,
          child: Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    changeOrderStatus(
                      orderId: widget.orderModel.orderId ?? "",
                      newStatus: selctedItem ?? "",
                    );
                  },
                  icon: const Icon(Icons.check_sharp))
            ],
          )),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: false,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductWidget(
                  product: widget.orderModel.products![index],
                ),
              ),
              itemCount: widget.orderModel.products!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
