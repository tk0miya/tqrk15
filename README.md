# RBS::Inline を導入してみた話

## RBS::Inline を導入してみた話

RubyKaigi 2024 で発表された RBS::Inline を導入してみました。

導入前:

* ソースコードを書く
* 型定義ファイル(.rbs)を開いて書き換える

導入後:

* ソースコードを書く
* ソースコードに型コメントを書き込む
* `rbs-inline` コマンドを実行する

サンプル:

```
module Tokyu
  class RubyKaigi
    attr_reader :number #: Integer
    attr_reader :members #: Array[String]

    # @rbs number: Integer
    # @rbs return: void
    def initialize(number)
      @number = number
      @members = []
    end
  end
end
```

## 感想

* コードと型がとなりにあるのは便利
* これまで遠巻きに見ていたメンバーも書いてくれそう

## ちょっと工夫した話

### rubocop との組み合わせ

現状では RBS::Inline の型コメントは Rubocop に注意されます。

* Layout/LeadingCommentSpace
  * コメントの先頭にスペースが必要
* Style/AccessorGrouping
  * attr_* 行はひとつにまとめるべき
* Style/CommentedKeyword
  * attr_* や def のあとにコメントを書くな

RBS::Inline を導入するにはこれらを無効化しないといけません。

#### ということで

Rubocop の Cop を調整する PR を投げました。

* https://github.com/rubocop/rubocop/pull/13221
* https://github.com/rubocop/rubocop/pull/13222
* https://github.com/rubocop/rubocop/pull/13223

これらがマージされると、型コメントは許容されるようになります。

#### デモ

### 自動的に rbs-inline を実行したい

RBS::Inline の README には `fswatch` コマンドが推奨されている
しかし、できれば使いたくない

* コマンドを覚えられない
* fswatch をインストールしたくない

#### ということで

VSCode 拡張「RBS helper」に自動的に `rbs-inline` コマンドを実行させる
オプションを追加しました。

#### デモ

### 型コメントで typo しても何も起きない

RBS::Inline では型コメントで typo があっても、たいてい何も起きません。
型コメントではなく、普通のコメントとみなされるためです。

型付けしたつもりができていなかったという新たな地獄の釜が見えてきました。

#### ということで

型コメントっぽいコメントに対して警告を出す Cop を用意しました。
https://github.com/tk0miya/rubocop-rbs_inline

これを使うことで早めにミスに気づけるようになります。

#### デモ

## まとめ

* RBS::Inline を導入してみました
* いくつかの工夫をしてみました
    * Rubocop のルール調整を提案
    * VSCode での rbs-inline の自動実行
    * Rubocop による型コメントの Lint
* その他、バグつぶしなどをお手伝いしました
