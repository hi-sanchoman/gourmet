import 'package:cached_network_image/cached_network_image.dart';
import 'package:esentai/models/catalog/category.dart';
import 'package:esentai/ui/category/category.dart';
import 'package:esentai/ui/subcategory/subcategory.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onCategoryPressed(context);
      },
      child: Container(
        width: 147,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                    width: 147,
                    height: 147,
                    child: CachedNetworkImage(
                        imageUrl: "${category.image}",
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/images/nophoto.png',
                            fit: BoxFit.cover),
                        fit: BoxFit.cover))),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
              child: Text(
                '${category.name}',
                textAlign: TextAlign.left,
                style: DefaultAppTheme.title3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onCategoryPressed(BuildContext context) {
    pushNewScreen(context,
        screen: CategoryScreen(
          category: category,
        ),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }
}
