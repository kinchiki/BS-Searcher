# BS-Searcher
開催時間で会社説明会を複数就職情報サイトから横断検索するサービス。

[一応公開](https://bs-searcher.herokuapp.com/)しています。
しかし、まだクローラーが定期的に動くようにはなっていないので、データは更新されません。

検索の度に条件に合う説明会を取得するのは処理時間がかかりすぎるため、スクレイピングしてデータベースを構築しています。
現在はリクナビとマイナビにある程度対応しています。

`my_file`に冗談抜きで超絶クソコードのスクレイピングプログラムがあります。
