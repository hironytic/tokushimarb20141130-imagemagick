ImageMagick (RMagick)で画像処理
===============================

やってみた。

準備
----

まずはImageMagick（ネイティブのソフト）をインストール  
※下記はMacでターミナルからHomebrewを使ってインストールした例

```sh
brew update
brew install imagemagick
```

### For RedHat/CentOS/Fedora user

```sh
sudo yum install ImageMagick-devel
```

### For Debian/Ubuntu user

```sh
sudo apt-get install libmagickwand-dev
```

次に、RMagick（gem）を準備。  
※bundlerを使いましたが、gemでもOKだと…思います。

次のGemfileを用意しておいて

```ruby
source 'https://rubygems.org'
gem 'rmagick'
```

ターミナルから

```sh
bundle install
```

Ubuntu 14.04 の人は以下のように実行しないとダメかも…

```
PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig bundle install
```

### 参考

[Ruby - RMagickのインストールでエラー - Qiita](http://qiita.com/hiroara@github/items/6b1c6c7257042a159cc9)

実際に画像処理してみる
----------------------

ドキュメント  
http://www.imagemagick.org/RMagick/doc/

### 画像の読み込み

```ruby
image = Magick::ImageList.new('image.png')
```

### 画像の幅・高さの取得

```ruby
puts "W:#{image.columns}, H:#{image.rows}."
```

### エッジ抽出

```ruby
image2 = image.edge(0)
```

### 画像の書き出し

```ruby
image2.write('out.png')
```

### 各ピクセルのRGB値の検出

```ruby
# (0,0)から幅1, 高さ1のピクセルを取得
pixel = image.get_pixels(0, 0, 1, 1)[0]
```

`pixel.red`, `pixel.green`, `pixel.blue`で各RGB成分が取得できます。  
それぞれ、0 〜 `Magick::QuantumRange`までの範囲をとります。  
0〜255の範囲にしたければスケーリングが必要。

```ruby
red = 255 * pixel.red / Magick::QuantumRange
```

実際にやってみたコード
------------

test.rb  
このリポジトリに置いておきます。
