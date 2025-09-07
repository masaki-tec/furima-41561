# アプリケーション名
フリマーケットアプリ拡張版

# アプリケーション概要
テックキャンプで学習後に制作したフリマアプリを拡張。  
基本的な出品・購入・ログイン機能に加え、ユーザー体験や検索利便性、品質向上を意識して下記機能を追加しました。  

【追加した機能】
- 検索機能(キーワード検索とカテゴリー検索)
- 出品機能（カテゴリ選択・タグ追加）
- 画像プレビュー機能（編集画面でも切り替え可能）
- コメント機能（非同期通信、Action Cableでリアルタイム共有）
- バリデーション（カテゴリー必須、検索やタグ、コメントの文字数制限など）

【元々の機能】
- 出品機能
- 商品一覧表示機能
- 商品詳細表示機能
- 商品情報編集機能
- 商品削除機能
- 商品購入機能(PAY.jpのクレジットカード決済を実装)

# URL

# テスト用アカウント

# アプリケーションに独自機能を実装した背景

# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能

# データベース設計

# 画面遷移図

# 開発環境
- フロントエンド
- バックエンド
- インフラ
- テスト
- テキストエディタ
- タスク管理

# ローカルでの動作方法
以下のコマンドを順に実行。
git clone https://github.com/masaki-tec/furima-41561.git
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s

# 工夫したポイント

## 1. 検索機能の拡張
- キーワード検索（商品名・説明文・タグ・出品者名）を追加
- カテゴリー検索（親カテゴリ選択）を追加
- 検索条件の組み合わせで商品を絞り込める

## 2. 出品・編集画面の改善
- 画像プレビュー機能を実装（変更時にプレビューが切り替わる）
- 可変式カテゴリー選択（親→子→孫）を実装
- 任意でタグを追加可能（文字数制限・重複禁止を実装）

## 3. バリデーション・エラーメッセージ
- 全モデル・全画面でバリデーションを実装
- バリデーションメッセージを日本語化（I18n対応）
- ユーザーが直感的に入力エラーを理解できる工夫

## 4. コメント機能
- Action Cableでリアルタイム更新を実装
- 投稿者以外に不要なエラーが表示されないようAJAXで制御

## 5. 品質管理
- RSpecでモデル・機能単位のテストを作成
- テストコードも日本語化して可読性を向上

## 技術スタック
- Ruby on Rails, PostgreSQL, Active Storage, Action Cable
- Ransack（検索機能）
- I18n（日本語化）
- RSpec（テスト）
- JavaScript / Ajax（非同期処理）

# 改善点

# 制作時間

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | --------------------------|
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_furigana  | string | null: false               |
| first_name_furigana | string | null: false               |
| birth               | date   | null: false               |

### Association

- has_many :items
- has_many :buys


## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| product_description    | text       | null: false                    |
| category_id            | integer    | null: false                    |
| status_id              | integer    | null: false                    |
| cover_delivery_cost_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| delivery_id            | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :buy

## buys テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :delivery

## deliveries テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| post_code           | string     | null: false                    |
| prefecture_id       | integer    | null: false                    |
| municipality        | string     | null: false                    |
| street_address      | string     | null: false                    |
| building_name       | string     |                                |
| telephone_number    | string     | null: false                    |
| buy                 | references | null: false, foreign_key: true |

### Association

- belongs_to :buy