import 'package:final_project/core/resources/app_button.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/cart/widgets/cart_item.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(color: AppColors.secondColor),
        ),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const CartItem();
                },
                separatorBuilder: (context, index) => SizedBox(height: 14),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-total",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text(
                      "\$ 5,870",
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VAT (%)",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text(
                      "\$ 0.00",
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.mainColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping fee",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text(
                      "\$ 80",
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Color(0xFFE6E6E6), thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$ 5,950",
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppButton(
              onPressed: () {},
              color: AppColors.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Go To Checkout",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward,color: Colors.white,size: 24,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
