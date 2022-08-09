
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:road_work_front_end/utils/constants.dart';


class LastFiles extends StatelessWidget {
  const LastFiles({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: const [
              DataColumn2(
                label: Text('Column A'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Column B'),
              ),
              DataColumn(
                label: Text('Column C'),
              ),
              DataColumn(
                label: Text('Column D'),
              ),
              DataColumn(
                label: Text('Column NUMBERS'),
                numeric: true,
              ),
            ],
            rows: List<DataRow>.generate(
                10,
                    (index) => DataRow(cells: [
                  DataCell(Text('A' * (10 - index % 10))),
                  DataCell(Text('B' * (10 - (index + 5) % 10))),
                  DataCell(Text('C' * (15 - (index + 5) % 10))),
                  DataCell(Text('D' * (15 - (index + 10) % 10))),
                  DataCell(Text(((index + 0.1) * 25.4).toString()))
                ]))),
    );
  }
}
