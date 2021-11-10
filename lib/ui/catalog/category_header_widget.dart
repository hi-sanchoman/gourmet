import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';
import 'package:esentai/ui/catalog/subcategory_header_widget.dart';
import 'package:esentai/ui/category/category.dart';
import 'package:esentai/ui/subcategory/subcategory.dart';
import 'package:esentai/utils/routes/routes.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryHeaderWidget extends StatefulWidget {
  CategoryHeaderWidget(
      {Key? key,
      required this.category,
      required this.title,
      this.subcategoryList,
      required this.onHeaderTap,
      required this.onAllItemsPressed})
      : super(key: key);

  final Category category;
  final String title;
  SubcategoryList? subcategoryList;
  Function() onHeaderTap;
  Function() onAllItemsPressed;

  @override
  _CategoryHeaderWidgetState createState() => _CategoryHeaderWidgetState();
}

class _CategoryHeaderWidgetState extends State<CategoryHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: widget.onHeaderTap,
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: DefaultAppTheme.title2.override(
                      fontFamily: 'Gilroy',
                      color: DefaultAppTheme.grayDark,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4, right: 16.0),
                child: TextButton(
                  onPressed: widget.onAllItemsPressed,
                  child: Text('Все товары'),
                  style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle:
                          TextStyle(color: DefaultAppTheme.primaryColor)),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 16.0,
                ),
                for (var subcategory in widget.subcategoryList!.items!)
                  _buildListItem(subcategory),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(Subcategory subcategory) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: SubcategoryHeaderWidget(
        title: '${subcategory.name}',
        image: '${subcategory.image}',
        onTap: () {
          pushNewScreen(context,
              screen: SubcategoryScreen(
                  subcategory: subcategory, category: widget.category),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.fade);
        },
      ),
    );
  }
}
