import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomTable extends StatelessWidget {
  CustomTable({
    Key? key,
    required this.headings,
    required this.rowDatas,
    required this.columnWidths, required this.onRefresh,
  }) : super(key: key);

  final List<String> headings;
  final List<List<String>> rowDatas;
  final Map<int, TableColumnWidth>? columnWidths;
  final Future<void> Function() onRefresh;
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: () async {
        await onRefresh();
        refreshController.refreshCompleted();
      },
      child: ListView(
        // shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.all(4),
            child: Table(
              columnWidths: columnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                _buildTableHeading(headings),
                ...rowDatas.map((e) {
                  return _buildTableDataRow(rowDatas.indexOf(e), e);
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTableHeading(List<String> heading) {
    return TableRow(
      decoration: BoxDecoration(
        color: Pallete.primaryCol,
      ),
      children: heading
          .map((e) => SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    e,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
              ))
          .toList(),
    );
  }

  TableRow _buildTableDataRow(int index, List<String> rowData) {
    return TableRow(
      decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white : Colors.grey.shade400),
      children: rowData
          .map(
            (e) => SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
