import 'package:flutter/material.dart';
import 'package:login_registration_clone/Resources/colors.dart';
import 'package:login_registration_clone/Utils/Routes/routes_name.dart';
import 'package:login_registration_clone/ViewModel/OrderViewModel/order_summary_view_model.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/OrderViewModel/order_view_model.dart';
import '../custom_widgets.dart';


class OrderListLayout extends StatefulWidget {
  const OrderListLayout({super.key});

  @override
  State<OrderListLayout> createState() => _OrderListLayoutState();
}

class _OrderListLayoutState extends State<OrderListLayout> {
  @override
  Widget build(BuildContext context) {
    final orderDetailsViewModel = Provider.of<OrderSummaryViewModel>(context, listen: false);
    return Consumer<OrderListViewModel>(
        builder: (_,orderViewModel,child){
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orderViewModel.filteredList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.searchBoxColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: ExpansionTile(
                          trailing: const Icon(Icons.arrow_drop_down_outlined, color: AppColor.propsColor, size: 40),
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          title: CustomWidgets.customText(text: orderViewModel.filteredList[index].customerName, fontWeight: FontWeight.bold, fontSize: 20),
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Bill No. ${orderViewModel.filteredList[index].id}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Mrp Amount:'),
                                    Text('${orderViewModel.filteredList[index].totalMrp}')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Discount:'),
                                    Text('${orderViewModel.filteredList[index].totalDiscount}')
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                    Text('${orderViewModel.filteredList[index].payAmount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    orderViewModel.customStatus(index),
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, RouteNames.orderSummaryRoute);
                                        orderDetailsViewModel.initializeValue(orderViewModel.filteredList[index]);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(AppColor.darkIndigo),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)),
                                          )
                                      ),
                                      child: const Text('Order Details'),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
    );

  }
}
