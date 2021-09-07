import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screens/details/details_screen.dart';
import 'package:client_app/screens/featured/featurred_screen.dart';

import '../../../components/cards/big/restaurant_info_big_card.dart';
import '../../../constants.dart';
import '../../../components/section_title.dart';
import '../../../models/restaurant_model.dart';
import '../../../screens/home/components/promotion_banner.dart';
import '../../../components/cards/big/big_card_image_slide.dart';
import '../../../demoData.dart';
import '../../../size_config.dart';
import 'medium_card_list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SafeArea(
        child: Card(
          elevation: 40.0,
          shadowColor: Color(0xFF454545),
          margin: EdgeInsets.only(top: 4.0, left: 0, right: 0, bottom: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(of: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BigCardImageSlide(images: [
                      Restaurant.allRestaurantsList[0].imageUrl,
                      Restaurant.allRestaurantsList[0].imageUrl
                    ]),
                  ),
                  VerticalSpacing(of: 25),
                  SectionTitle(
                    title: "Featured Partners",
                    press: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeaturedScreen(),
                          ),
                        ),
                  ),
                  VerticalSpacing(of: 15),
                  MediumCardList(),
                  VerticalSpacing(of: 25),
                  // Banner
                  PromotionBanner(),
                  VerticalSpacing(of: 25),
                  SectionTitle(
                    title: "Best Pick",
                    press: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeaturedScreen(),
                          ),
                        ),
                  ),
                  VerticalSpacing(of: 15),
                  MediumCardList(),
                  VerticalSpacing(of: 25),
                  SectionTitle(title: "All Restaurants", press: () {}),
                  VerticalSpacing(of: 15),

                  // Demo list of Big Cards
                  ...List.generate(
                    // For demo we use 4 items
                    Restaurant.allRestaurantsList.length,
                        (index) =>
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                          child: RestaurantInfoBigCard(
                            // Images are List<String>
                            images: [
                              Restaurant.allRestaurantsList[index].imageUrl,
                              Restaurant.allRestaurantsList[0].imageUrl
                            ],
                            name: Restaurant.allRestaurantsList[index].name,
                            rating: Restaurant.allRestaurantsList[index].rating,
                            numOfRating: 200,
                            deliveryTime: 25,
                            foodType: ["Chinese", "American", "Deshi food"],
                            press: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(index: index),
                                  ),
                                ),
                          ),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
