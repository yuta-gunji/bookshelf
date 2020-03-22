# README

## 概要

書籍管理サービスです。 読んだ書籍のレビューを残したり、他のユーザのレビューを参考にして自分の本棚を作成できます。ポートフォリオとして作成しました。

## アプリケーションURL

https://www.mybkshlf.net/

## 機能一覧

- ユーザー登録機能（メール送信）、ログイン機能、パスワード再発行機能
- ユーザープロフィール画像アップロード（Active Storage）
- [GoogleBooksAPI](https://developers.google.com/books)を使用した書籍検索機能
- 自分の本棚への追加機能
- レビュー投稿機能(CRU)
- ユーザー間でのフォロー機能(Ajax)
- レビューに対するお気に入り機能(Ajax)
- ランキング機能(本棚追加数、レビュー数)
- 各ページでのページネーション

## 使用技術一覧

- Ruby 2.6.5
- Ruby on Rails 6.0.2
- PostgresSQL 11.6
- Material Design for Bootstrap
- Docker
- Docker Compose(development)
- Nginx
- AWS
  - VPC
  - EC2
  - ECS
  - ECR
  - RDS for PostgreSQL
  - ACM
  - ELB(ALB)
  - Route53
  - S3
- CircleCI(CI/CD)

## AWS構成図

![readme-image](https://user-images.githubusercontent.com/29705494/77250256-101f6100-6c8a-11ea-9478-d3d5350d24f4.png)

## テスト

- Rspec
  - system spec
  - request spec
  - model spec

## CI/CD

- CircleCI
任意のブランチで自動テストを行います。masterブランチへマージすると、 自動テスト、自動ビルド(Docker image)、自動デプロイ、タスク定義の更新を行います。
