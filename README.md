# bookmeter_exporter

A command line tool to export read books data from https://bookmeter.com as CSV

[読書メーター](https://bookmeter.com)から読み終わった本をエクスポートするCLIツール

## Requirements

* Ruby >= 2.6 and bundler
* `chromedriver` in $PATH and same version of Google Chrome
  * Download: https://chromedriver.chromium.org/downloads
* 読書メーターのアカウントにメールアドレスとパスワードが設定されていること

## Installation

```bash
$ gem install bookmeter_exporter
```

## Usage

```bash
$ bookmeter_exporter
Commands:
  bookmeter_exporter export EMAIL    # This command exports all read books of an account as CSV.
  bookmeter_exporter help [COMMAND]  # Describe available commands or one specific command
  bookmeter_exporter version         # Display version info
```

Example:

```bash
$ bookmeter_exporter export ikuwow@example.com
Password for EMAIL: # Type the password of your account
Starting Chrome... # Chrome window opens
Login success.
Book count: XXX
XX books fetched...
YY books fetched...
[...]
Books are successfully exported as './books.csv'.
```

## CSV Format

|ASIN|Read Date|Review|
|---|---|---|
|ex. B071K5WM6P|ex. 2021/07/31|ex. This book is awesome!|

Ex.

```csv
4408167967,2021/06/02,ここまで読んだ
B09366V8V2,2021/05/13,""
B093KCX58C,2021/05/12,""
```

## Miscellaneous

### [ブクログ](https://booklog.jp)へのインポート

ブクログはCSVファイルから本をインポートすることが出来ます:
https://booklog.zendesk.com/hc/ja/articles/360048930533-他の読書管理サイトからブクログへデータを移行したいです

bookmeter_exporterで出力したCSVをExcel等でフォーマットを整えるとよいです。

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ikuwow/bookmeter_exporter.

## Wishlist

* More tests
* More fields in CSV

## License

MIT
