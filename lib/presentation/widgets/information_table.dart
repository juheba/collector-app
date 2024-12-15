import 'package:collector/presentation/utils/list_utils.dart';
import 'package:flutter/material.dart';

class InformationTable extends StatelessWidget {
  const InformationTable({
    required this.rows,
    super.key,
  });

  final List<(String title, Widget child)> rows;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: rows
          .map(
            (e) => TableRow(
              children: [
                TableCell(
                  child: Text(
                    e.$1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                TableCell(
                  child: e.$2,
                ),
              ],
            ),
          )
          .toList()
          .insertBetweenElements(
            const TableRow(
              children: [
                SizedBox(height: 8),
                SizedBox(height: 8),
              ],
            ),
          ),
    );
  }
}
