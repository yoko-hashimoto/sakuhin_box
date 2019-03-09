# README

<br>

# さくひんB0X

<br>

## 概要
お子様が幼稚園や学校で作った作品を写真に撮って、手軽に保管・整理ができます。									
お子様（クリエイター）は複数人登録できるので、兄弟・姉妹の作品も個別に管理できます。									
お子様と一緒に、他のお子様（クリエイター）が作った作品を見たり、「いいね！」やコメントをすることもできるので、お子様の創作意欲UPや、創作の世界観を広げるお手伝いをいたします。

<br>
  
## コンセプト
お子様の作品管理アプリ

<br>
  
## バージョン
ruby  2.5.3
rails  5.2.2

<br>

## 機能一覧

* ログイン機能(device使用)
* ユーザー登録機能
  * メールアドレス、名前、パスワード、クリエイターは必須
* 作品一覧表示機能
* 作品投稿機能
  * 作品画像、クリエイター、作品公開設定は必須
* 作品編集機能
* 作品削除機能
  * 作品編集と作品削除は投稿者のみ実行可能
* 「いいね！」機能
  * 作品の「いいね！」については1つの作品に対して1人1回しかできない
  * 自分自身の作品には「いいね！」できない
* コメント投稿機能
* コメント編集機能
* コメント削除機能
  * コメント編集とコメント削除はコメントした本人のみ可能
  * コメント機能とお気に入り機能についてはページ遷移なしで実行できる
* 公開設定機能
  * 投稿時に作品の公開、非公開の設定ができる
  * 後から公開設定の変更もできる
* 兄弟管理機能
  * お子様が複数人いる場合も、お子様ごとのページで作品を分けて管理でき
* 作品整理機能
  * 投稿時にタグ付けする事で、作品をフォルダ分けして表示できる
* 作品検索機能
  * 作品一覧画面でクリエイターの名前や一言メモのキーワードで検索できる
* ページネーション機能
   * 作品一覧画面、クリエイターごとの作品一覧画面

<br>

## カタログ設計

https://docs.google.com/spreadsheets/d/1swVFyxESP5nesa8880MHv01SySWxKiOqehSazaHFAZc/edit?usp=sharing

<br>

## テーブル定義

https://docs.google.com/spreadsheets/d/1Csnqunbtn_UxS4OVQ24oif8jGjLPp8hSW_1_pSG5eqU/edit?usp=sharing

<br>

## 画面遷移図

https://docs.google.com/spreadsheets/d/1O4hHXFR_3fjQmFqhXLqko5H161GCOl1tuqCRHQGVor0/edit?usp=sharing

<br>

## 画面ワイヤーフレーム

https://docs.google.com/spreadsheets/d/13pMwr5v9rTltxuwbafryUhLe67pEyXVZxBq0OmMcKrU/edit?usp=sharing

<br>

## 使用予定Gem
* carrierwave
* mini_magick
* devise
* kaminari
* acts-as-taggable-on
* ransack

 <br>

## AWSのS3サーバ使用
