import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/buttons/secondery_button.dart';
import '../../../components/price_range_and_food_type.dart';
import '../../../components/rating_with_counter.dart';

import '../../../constants.dart';
import '../../../models/restaurant_model.dart';
import '../../../size_config.dart';

class RestaurantInfo extends StatelessWidget {
  final int index;

  const RestaurantInfo({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Restaurant.allRestaurantsList[index].name,
            style: kH2TextStyle,
            maxLines: 1,
          ),
          VerticalSpacing(of: 10),
          PriceRangeAndFoodtype(
            foodType: ["Chinese", "American", "Deshi food"],
          ),
          VerticalSpacing(of: 10),
          RatingWithCounter(rating: "4.3", numOfRating: 200),
          VerticalSpacing(),
          Row(
            children: [
              buildDeliveryInfo(
                iconSrc: "assets/icons/delivery.svg",
                text: "Free",
                subText: "Delivery",
              ),
              HorizontalSpacing(),
              buildDeliveryInfo(
                iconSrc: "assets/icons/clock.svg",
                text: "25",
                subText: "Minutes",
              ),
              Spacer(),
              SizedBox(
                width: getProportionateScreenWidth(115),
                child: SeconderyButton(
                  child: Text(
                    "Take away".toUpperCase(),
                    style: kCaptionTextStyle.copyWith(color: kActiveColor),
                  ),
                  press: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildDeliveryInfo({@required String iconSrc, text, subText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconSrc,
          height: getProportionateScreenWidth(20),
          width: getProportionateScreenWidth(20),
          color: kActiveColor,
        ),
        HorizontalSpacing(of: 10),
        Text.rich(
          TextSpan(
            text: "$text\n",
            style: kSecondaryBodyTextStyle,
            children: [
              TextSpan(
                text: subText,
                style:
                    kCaptionTextStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ],
    );
  }
}
