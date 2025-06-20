import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/home/models/models.dart';
import 'package:weather_app/services/language_service.dart';

class SearchLocation extends ConsumerWidget {
  const SearchLocation({super.key, required this.contentHeight});
  final double contentHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String searchParam = ref.watch(searchParamProvider);

    return Container(
      height: contentHeight,
      width: double.infinity,
      alignment: Alignment.center,
      // color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 32, color: Colors.red),
              Text(
                searchParam,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: contentHeight * 0.1),
          SearchBar(
            hintText: getLangauge(ref) == "ja" ? "ここで検索．．．" : "Search...",
            onSubmitted: (param) async {
              ref.read(searchParamProvider.notifier).setParam(param);
            },
          ),
        ],
      ),
    );
  }
}
