import 'package:esentai/models/catalog/subcategory.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BsSubcategoryFilterWidget extends StatefulWidget {
  BsSubcategoryFilterWidget({Key? key, required this.subcategories})
      : super(key: key);

  SubcategoryList subcategories;

  @override
  _BsSubcategoryFilterWidgetState createState() =>
      _BsSubcategoryFilterWidgetState();
}

class _BsSubcategoryFilterWidgetState extends State<BsSubcategoryFilterWidget> {
  late CatalogStore _catalogStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _catalogStore = Provider.of<CatalogStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return _catalogStore.filter != null
          ? Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xFF404143),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 300,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Подкатегории',
                                style: DefaultAppTheme.title2,
                              ),
                              TextButton(
                                  child: Text('Очистить'),
                                  onPressed: _onClearAllPressed),
                            ],
                          )),
                      for (Subcategory subcategory
                          in widget.subcategories.items!)
                        CheckboxListTile(
                          value:
                              _catalogStore.filter!.contains(subcategory.id!),
                          onChanged: (newValue) => setState(() {
                            // if (_filter)

                            if (_catalogStore.filter!.contains(subcategory.id!))
                              _catalogStore.filter!.remove(subcategory.id!);
                            else
                              _catalogStore.filter!.add(subcategory.id!);

                            _catalogStore.filter =
                                _catalogStore.filter!.map((f) => f).toList();

                            print(newValue);
                          }),
                          title: Text(
                            '${subcategory.name}',
                            textAlign: TextAlign.start,
                            style: DefaultAppTheme.title3,
                          ),
                          activeColor: DefaultAppTheme.tertiaryColor,
                          checkColor: Colors.white,
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                    ],
                  ),
                ),
              )
            ])
          : Container();
    });
  }

  void _onClearAllPressed() {
    setState(() {
      _catalogStore.filter = [];
    });
  }
}
