import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/home/models/models.dart';
import 'package:weather_app/home/widgets/widgets.dart';

class WeatherTable extends ConsumerWidget {
  const WeatherTable({
    super.key,
    required this.contentHeight,
    required this.contentWidth,
  });
  final double contentHeight;
  final double contentWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<WeatherListData> weather = ref.watch(
      fetchWeatherListProvider,
    );

    return Container(
      height: contentHeight,
      width: double.infinity,
      alignment: Alignment.center,
      // color: Colors.amber,
      child: weather.when(
        data: (data) {
          late WeatherData featureData;
          List<WeatherData> tableData = [];
          for (var i = 0; i < data.list.length; i++) {
            if (i == 0) {
              featureData = data.list[i];
              continue;
            }
            if (i % 8 == 0) {
              tableData.add(data.list[i]);
            }
          }
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _detailsDialogBuilder(context, data.list),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  crossAxisCount: 4,
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  children:
                      tableData.map((forecast) {
                        return WeatherItem(data: forecast);
                      }).toList(),
                ),
                SizedBox(
                  height: contentWidth * 0.45,
                  width: contentWidth * 0.4,
                  child: WeatherItem(data: featureData, isFeature: true),
                ),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('$error'),
      ),
    );
  }

  Future<void> _detailsDialogBuilder(
    BuildContext context,
    List<WeatherData> data,
  ) {
    return showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return WeatherTile(data: data[index]);
                      },
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
    );
  }
}
