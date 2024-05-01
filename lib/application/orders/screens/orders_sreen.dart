import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productive_families_admin/application/orders/models/orders_model.dart';
import 'package:productive_families_admin/application/orders/screens/order_information.dart';
import 'package:productive_families_admin/application/orders/widgets/orders_container_widget.dart';
import 'package:productive_families_admin/application/storage/firebase_storage.dart';
import 'package:productive_families_admin/core/colors.dart';
import 'package:productive_families_admin/core/data/local_data/shared_pref.dart';

late List<OrderModel> orders;

class OrdersTabScreen extends StatefulWidget {
  const OrdersTabScreen({Key? key}) : super(key: key);

  @override
  State<OrdersTabScreen> createState() => _OrdersTabScreenState();
}

class _OrdersTabScreenState extends State<OrdersTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          getOrdersByStoreId(getStringAsync("STOREID"));
        },
        child: FutureBuilder(
            future: getOrdersByStoreId(getStringAsync("STOREID")),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                orders =
                    snapshot.data!.map((e) => OrderModel.fromJson(e)).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    orders.isNotEmpty
                        ? Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: SlidableAutoCloseBehavior(
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 20,
                                      ),
                                      itemCount: orders.length,
                                      itemBuilder: (context, index) {
                                        return Tooltip(
                                          message: 'Slide For Actions',
                                          triggerMode: TooltipTriggerMode.tap,
                                          child: Slidable(
                                            key: UniqueKey(),
                                            startActionPane: ActionPane(
                                              key: UniqueKey(),
                                              dragDismissible: false,
                                              extentRatio: 0.35,
                                              motion: const ScrollMotion(),
                                              children: [
                                                Container(
                                                  height: 125,
                                                  decoration:
                                                      const BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(
                                                              72, 74, 195, 130),
                                                          Color.fromARGB(
                                                              72, 74, 195, 130),
                                                        ],
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      OrderInformationScreen(
                                                                          orderModel:
                                                                              orders[index]),
                                                                ));
                                                          },
                                                          child:
                                                              const CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF4AC382),
                                                            child: Icon(
                                                              Icons.info,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            EasyLoading.show(
                                                                status:
                                                                    'deleting order');
                                                            await deleteOrderByOrderId(
                                                                    orders[index]
                                                                            .orderId ??
                                                                        "")
                                                                .then((value) {
                                                              EasyLoading
                                                                  .dismiss();
                                                              EasyLoading.showToast(
                                                                  'Order Deleted');
                                                              setState(() {});
                                                            });
                                                          },
                                                          child:
                                                              const CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF4AC382),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: OrdersContainerWidget(
                                                ordersModel: orders[index],
                                                // state.reservations![index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: Image.asset(
                                      'assets/images/new_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    "dont Have Any Orders",
                                    style: TextStyle(
                                      color: AppColors.appColor,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

void showCancelDialog(BuildContext context, int reservationId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Text(
          'areYouSureYouWantToCancelThisReservation',
          style: TextStyle(
            fontFamily: "Montserrat-M",
            fontSize: 18,
            color: AppColors.appColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "cancel",
              style: TextStyle(
                fontFamily: "Montserrat-M",
                fontSize: 18,
                color: AppColors.appColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // BlocProvider.of<CategoryBloc>(context).add(
              //     DoCancelReservationEvent(reservationId: reservationId));
              Navigator.pop(context);
            },
            child: Text(
              'ok',
              style: TextStyle(
                fontFamily: "Montserrat-M",
                fontSize: 18,
                color: AppColors.appColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
