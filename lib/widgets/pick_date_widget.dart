import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/utils/extensions/gourmet_timepicker.dart';
import 'package:esentai/utils/helpers.dart';
import 'package:esentai/utils/themes/default.dart';
import 'package:esentai/widgets/cupertino_switchstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PickDateWidget extends StatefulWidget {
  PickDateWidget({Key? key}) : super(key: key);

  @override
  _PickDateWidgetState createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  late OrderStore _orderStore;

  bool switchListTileValue = false;
  DateTime? _currentDate;
  TimeOfDay? _currentTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    // if (_currentTime != null) {
    //   if (_currentTime!.minute < 15) {
    //     _currentTime = TimeOfDay(hour: _currentTime!.hour, minute: 0);
    //   } else if (_currentTime!.minute >= 15 && _currentTime!.minute < 30) {
    //     _currentTime = TimeOfDay(hour: _currentTime!.hour, minute: 15);
    //   } else if (_currentTime!.minute >= 30 && _currentTime!.minute < 45) {
    //     _currentTime = TimeOfDay(hour: _currentTime!.hour, minute: 30);
    //   } else if (_currentTime!.minute >= 45 && _currentTime!.minute < 60) {
    //     _currentTime = TimeOfDay(hour: _currentTime!.hour, minute: 45);
    //   }
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderStore = Provider.of<OrderStore>(context);

    switchListTileValue = _orderStore.dateIsAsap;

    if (_orderStore.dateStart != null) {
      _currentDate = _orderStore.dateStart;
      _currentTime = TimeOfDay(
          hour: _orderStore.dateStart!.hour,
          minute: _orderStore.dateStart!.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            _onClose();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: DefaultAppTheme.textColor,
            size: 24,
          ),
        ),
        title: Text(
          'Время доставки',
          style: DefaultAppTheme.title2.override(
            fontFamily: 'Gilroy',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      // key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(children: [
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: CupertinoSwitchListTile(
              activeColor: DefaultAppTheme.primaryColor,
              dense: true,
              onChanged: (newValue) =>
                  setState(() => switchListTileValue = newValue),
              title: Text(
                'Доставить как можно раньше',
                style: DefaultAppTheme.bodyText1,
              ),
              value: switchListTileValue ??= true,
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: switchListTileValue == false
              ? Container(
                  height: 445,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    children: [
                      CalendarCarousel<Event>(
                        height: 360,
                        locale: 'ru',
                        onDayPressed: (DateTime date, List<Event> events) {
                          this.setState(() => _currentDate = date);
                        },
                        weekdayTextStyle: TextStyle(
                          color: Color(0x4D3C3C43),
                        ),
                        weekendTextStyle: TextStyle(
                          color: Color(0xFF313234),
                        ),
                        thisMonthDayBorderColor: Colors.grey,
                        selectedDayButtonColor: DefaultAppTheme.primaryColor,
                        showHeaderButton: true,
                        showHeader: true,
                        // firstDayOfWeek: 1,
                        minSelectedDate: DateTime.now(),
                        selectedDayTextStyle: TextStyle(
                            // backgroundColor: DefaultAppTheme.primaryColor,
                            ),
                        //      weekDays: null, /// for pass null when you do not want to render weekDays
                        //      headerText: Container( /// Example for rendering custom header
                        //        child: Text('Custom Header'),
                        //      ),
                        customDayBuilder: (
                          /// you can provide your own build function to make custom day containers
                          bool isSelectable,
                          int index,
                          bool isSelectedDay,
                          bool isToday,
                          bool isPrevMonthDay,
                          TextStyle textStyle,
                          bool isNextMonthDay,
                          bool isThisMonthDay,
                          DateTime day,
                        ) {},
                        nextMonthDayBorderColor: DefaultAppTheme.primaryColor,
                        prevMonthDayBorderColor: DefaultAppTheme.primaryColor,

                        headerTextStyle: TextStyle(color: Colors.black),
                        weekFormat: false,
                        // markedDatesMap: _markedDateMap,
                        // height: 420.0,
                        selectedDateTime: _currentDate,
                        daysHaveCircularBorder: null,

                        /// null for not rendering any border, true for circular border, false for rectangular border
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Время',
                              style: DefaultAppTheme.title1,
                            ),
                            InkWell(
                              onTap: () {
                                _showTimePicker();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0x1F767680),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Row(
                                    children: [
                                      Text('${_currentTime?.format(context)}',
                                          style: DefaultAppTheme.title1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
              : Container(),
        ),
        _buildApproxDeliveryTime(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
          child: ElevatedButton(
            onPressed: () {
              _onSubmit();
            },
            style: DefaultAppTheme.buttonDefaultStyle,
            child: Text('Далее'),
          ),
        ),
      ]),
    );
  }

  Widget _buildApproxDeliveryTime() {
    DateTime? current = _getTotalDate();

    if (current == null) {
      return Container();
    }

    DateTime oneHourPlus = current.add(Duration(hours: 1));

    int startHour = current.hour;
    int startMinute = current.minute;
    int endHour = oneHourPlus.hour;
    int endMinute = oneHourPlus.minute;

    String start = Helpers.formatHourMinute(current);
    String end = Helpers.formatHourMinute(oneHourPlus);
    print("time: $start, $end");

    if (!switchListTileValue)
      return Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text('Примерное время доставки: ${start} - ${end}',
              style: DefaultAppTheme.bodyText1.override(fontSize: 13)));

    return Container();
  }

  void _showTimePicker() async {
    print('pick time');

    DatePicker.showPicker(context,
        pickerModel: GourmetTimePicker(currentTime: DateTime.now()),
        locale: LocaleType.ru,
        showTitleActions: true, onConfirm: (date) {
      setState(() {
        _currentTime = TimeOfDay(hour: date.hour, minute: date.minute);
      });
    });

    // DatePicker.showTimePicker(context,
    //     locale: LocaleType.ru,
    //     showTitleActions: true,
    //     showSecondsColumn: false,
    //     currentTime: DateTime.now(), onConfirm: (date) {
    //   setState(() {
    //     _currentTime = TimeOfDay(hour: date.hour, minute: date.minute);
    //   });
    // });

    // final TimeOfDay? res = await showTimePicker(
    //     initialEntryMode: TimePickerEntryMode.dial,
    //     hourLabelText: '',
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //     cancelText: 'Отмена',
    //     confirmText: 'ОК');

    // if (res != null) {
    //   setState(() {
    //     _currentTime = res;
    //   });
    // }

    // print("${res?.format(context)}");
  }

  void _onSubmit() {
    if (switchListTileValue == true) {
      _orderStore.dateIsAsap = true;
      _orderStore.dateStart = null;
      Navigator.of(context).pop();
      return;
    }

    // if date
    _orderStore.dateIsAsap = false;
    _orderStore.dateStart = _getTotalDate();

    Navigator.of(context).pop();
  }

  void _onClose() {
    Navigator.of(context).pop();
  }

  DateTime? _getTotalDate() {
    if (_currentDate != null && _currentTime != null) {
      return DateTime(_currentDate!.year, _currentDate!.month,
          _currentDate!.day, _currentTime!.hour, _currentTime!.minute);
    }

    return null;
  }
}
