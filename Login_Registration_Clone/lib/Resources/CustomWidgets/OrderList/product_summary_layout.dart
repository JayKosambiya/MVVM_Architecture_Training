import 'package:flutter/material.dart';
import 'package:login_registration_clone/ViewModel/OrderViewModel/order_summary_view_model.dart';
import 'package:provider/provider.dart';

class ProductSummary extends StatefulWidget {
  const ProductSummary({super.key});

  @override
  State<ProductSummary> createState() => _ProductSummaryState();
}

class _ProductSummaryState extends State<ProductSummary> {
  @override
  Widget build(BuildContext context) {
    final orderSummaryViewModel = Provider.of<OrderSummaryViewModel>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: orderSummaryViewModel.productSummary.length,
        itemBuilder: (context, index){
          //orderDetailsProvider.InitializeQuantity(productSummary[index].productQuantity);
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderSummaryViewModel.productSummary[index].productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF29376F)),),
                Selector<OrderSummaryViewModel, int>(
                  selector: (_, orderDetailsProvider) => orderDetailsProvider.productSummary[index].totalProductPrice,
                  builder: (context, value, child) => Text('Rs. $value', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF29376F)),),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<OrderSummaryViewModel, int>(
                    selector: (_, orderDetailsProvider) => orderDetailsProvider.productSummary[index].productQuantity,
                    builder: (context, value, child) => Text('Qty: $value')),
                Selector<OrderSummaryViewModel, bool>(
                  selector: (_, orderDetailsProvider) => orderDetailsProvider.showWidget,
                  builder: (context, value, child) {
                    return value ? Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              orderSummaryViewModel.increaseProduct(index);
                            },
                            icon: const Icon(Icons.arrow_circle_up, size: 24,),
                            color: const Color(0xFF29376F)),
                        IconButton(
                            onPressed: (){

                              orderSummaryViewModel.decreaseProduct(index);

                            },
                            icon: const Icon(Icons.arrow_circle_down, size: 24,), color: const Color(0xFF29376F)),
                        IconButton(
                          onPressed: (){
                            orderSummaryViewModel.toggleWidget();
                            orderSummaryViewModel.updateSummary(index);
                          },
                          icon: const Icon(Icons.check_circle_outline, size: 24,), color: Colors.green[900],),
                        IconButton(
                            onPressed: (){
                              orderSummaryViewModel.toggleWidget();
                              orderSummaryViewModel.goToDefault(index);
                            },
                            icon: const Icon(Icons.cancel_outlined), color: Colors.red[800])
                      ],
                    ): Container();
                  },),
              ],
            ) ,
          );
        });
  }
}