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

次に、RMagick（gem）を準備。  
※bundlerを使いましたが、gemでもOKだと…思います。

次のGemfileを用意しておいて

```
source 'https://rubygems.org'
gem 'rmagick'
```

ターミナルから

```sh
bundle install
```

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
