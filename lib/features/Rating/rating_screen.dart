import 'package:final_project/features/Rating/widget/rating.dart';
import 'package:final_project/features/Rating/widget/review_card.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  final List<dynamic> reviews;
  final double rating;
  const RatingScreen({super.key, required this.reviews, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Reviews",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: Row(
                children: [
                  Text(
                    "Overall Rating",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),
                  Rating(rating: rating),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Customer Reviews",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ReviewCard(
                    name: reviews[index].reviewerName,
                    email: reviews[index].reviewerEmail,
                    date: reviews[index].date,
                    comment: reviews[index].comment,
                    rating: reviews[index].rating,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
