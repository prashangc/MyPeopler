import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/utils/dateUtils.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateButton extends StatelessWidget {
  const DateButton({
    Key? key,
    this.onTap,
    required this.label,
    this.date,
    this.iconData = Icons.calendar_month,
  }) : super(key: key);
  final void Function()? onTap;
  final String label;
  final NepaliDateTime? date;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 2.7,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: SplashWidget(
        bgCol: Colors.white,
        onTap: onTap,
        radius: 8,
        splashColor: Colors.grey,
        margin: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        shadowColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date != null ? MyDateUtils.getNepaliDateOnly(date!) : label),
              Icon(
                iconData,
                color: Pallete.primaryCol,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DateRangeButton extends StatelessWidget {
  const DateRangeButton({
    Key? key,
    this.onTap,
    required this.label,
    this.dateFrom,
    this.nepaliDateFrom,
    this.nepaliDateTo,
    this.dateTo,
    this.iconData = Icons.calendar_month,
    this.isNepaliDate = false,
    required this.width,

  }) : super(key: key);
  final void Function()? onTap;
  final String label;
  final DateTime? dateFrom;
  final NepaliDateTime? nepaliDateFrom;
  final DateTime? dateTo;
  final NepaliDateTime? nepaliDateTo;
  final IconData iconData;
  final double width;
  final bool isNepaliDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / width,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: SplashWidget(
        bgCol: Colors.white,
        onTap: onTap,
        radius: 8,
        splashColor: Colors.grey,
        margin: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        shadowColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: isNepaliDate?
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nepaliDateFrom != null ? MyDateUtils.getNepaliDateOnly(nepaliDateFrom!) : ''),
              nepaliDateFrom != null && nepaliDateTo != null?Text('-'):Text(label),
              Text(nepaliDateTo != null ? MyDateUtils.getNepaliDateOnly(nepaliDateTo!) : ''),
              Icon(
                iconData,
                color: Pallete.primaryCol,
              ),
            ],
          ):
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFrom != null ? MyDateUtils.getDateOnly(dateFrom!) : ''),
              dateFrom != null && dateTo != null?Text('-'):Text(label),
              Text(dateTo != null ? MyDateUtils.getDateOnly(dateTo!) : ''),
              Icon(
                iconData,
                color: Pallete.primaryCol,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeRangeButton extends StatelessWidget {
  const TimeRangeButton({
    Key? key,
    this.onTap,
    required this.label,
    this.timeFrom,
    this.timeTo,
    this.iconData = Icons.access_time_outlined,
    required this.width,

  }) : super(key: key);
  final void Function()? onTap;
  final String label;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;
  final IconData iconData;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / width,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: SplashWidget(
        bgCol: Colors.white,
        onTap: onTap,
        radius: 8,
        splashColor: Colors.grey,
        margin: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        shadowColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(timeFrom != null ? '${timeFrom!.hour.toString()} : ${timeFrom!.minute.toString()}' : ''),
              timeTo != null && timeTo != null?Text('-'):Text(label),
              Text(timeTo != null ? '${timeTo!.hour.toString()} : ${timeTo!.minute.toString()}' : ''),
              Icon(
                iconData,
                color: Pallete.primaryCol,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
