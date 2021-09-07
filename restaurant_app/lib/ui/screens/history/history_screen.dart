import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TextEditingController queryController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _searchBar(),

          _header(),

          Expanded(
            child: CupertinoScrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 30,
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return _historyItem();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: Colors.black54, width: 1.0))
      ),
      child: TextField(
        controller: queryController,
        maxLines: 1,
        cursorColor: CustomColors().primary,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: 'Search',
          contentPadding: EdgeInsets.symmetric(horizontal: 18.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            color: CustomColors().primary,
            onPressed: _search,
          ),
        ),
      ),
    );
  }

  _search() {
    print('Search Pressed');
  }

  Widget _historyItem() {
    return InkWell(
      onTap: () => {print('History Item Pressed')},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        margin: EdgeInsets.only(top: 4.0),
        color: CustomColors().greyWhite,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                '1111',
                textAlign: TextAlign.start,
              ),
            ),

            Spacer(flex: 1,),

            Expanded(
              flex: 5,
              child: Text(
                'BX45JJ',
                textAlign: TextAlign.start,
              ),
            ),

            Spacer(flex: 1,),

            Expanded(
              flex: 10,
              child: Text(
                'Amanpreet Singh Gujral',
                textAlign: TextAlign.start,
              ),
            ),

            Spacer(flex: 1,),

            Expanded(
              flex: 8,
              child: Text(
                'April 13, 2021 \n 6:07 PM',
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      margin: EdgeInsets.only(top: 20.0, bottom: 4.0),
      color: CustomColors().primaryLight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'SNo.',
              textAlign: TextAlign.start,
            ),
          ),

          Spacer(flex: 1,),

          Expanded(
            flex: 5,
            child: Text(
              'Order ID',
              textAlign: TextAlign.start,
            ),
          ),

          Spacer(flex: 1,),

          Expanded(
            flex: 10,
            child: Text(
              'Customer Name',
              textAlign: TextAlign.start,
            ),
          ),

          Spacer(flex: 1,),

          Expanded(
            flex: 8,
            child: Text(
              'Date/Time',
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
