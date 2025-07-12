![alt text](https://github.com/GouZenKun/WeatherApp/blob/main/assets/images/screenshot.png?raw=true)

## 概要
天気予報アプリです。
[Open Weather Map](https://openweathermap.org/)のAPIを使用されてるため、.envファイルを作成してAPI_KEYを設定してください。
株式会社バリーン・スタジオのキャラクターを使用させていただきました。

## アーキテクチャ
* アーキテクチャ：MVVM

### 剪定理由

* Riverpodを使えば、UIとViewModelをつなぎ合わせることが簡単です。
* MVVMは開発効率と保守性が高い、メンテナンスしやすいメリットがあります。
* 個人的にはいい練習になります。

## 改善できる点

* MediaQueryを使わず、代わりにFlexibleでレスポンシブUIを実装します。
* 一覧ダイアログのデータを日程でグループし、もっとわかりやすくします。
* ↳ フリックで切り替えなどすれば操作性が良くなるかもしれません。
* バリンちゃんがエラーメッセージを言ってもらいます。
