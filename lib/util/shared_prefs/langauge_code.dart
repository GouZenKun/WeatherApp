import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_prefs.dart';

part 'langauge_code.g.dart';

@Riverpod(keepAlive: true)
class LangaugeCode extends _$LangaugeCode {
  @override
  Future<String> build() async {
    final pref = await ref.read(prefWithCacheProvider.future);
    return pref.getString('languageCode') ?? "ja";
  }

  Future<void> toggleLangauge() async {
    if (state.isLoading || state.hasError) return;
    final pref = await ref.read(prefWithCacheProvider.future);
    await pref.setString(
      'languageCode',
      state.requireValue == "ja" ? "en" : "ja",
    );
    ref.invalidateSelf();
  }
}
