# 設計メモ

URLは、2020/class_name がいい



# 作成記録

参考にしたページ
[ツイッター風Railsアプリ最短復習（忙しい人の流し読みで開発シリーズ） - Qiita](https://qiita.com/annaPanda8170/items/844684cb739f99d3f114)

```bash
$ rails new classshare -d mysql # mysqlなので
# gem install してくれてるっぽい。nokogiri長いし
# 作ったらcdした

$ rails db:create
# config/database.ymlからDB作ってくれる
# DB名も決めてくれてた
# dev,test,proの3つが最初から書かれてた。devのDBはrootユーザーで空パスワードらしい

$ rails s
# サーバー立ち上げ http://localhost:3000/ で見れた

$ rails g controller lecture index show
# Controllerつくる
# gはgenereteの略
# indexで一覧ページ、showで個別ページ
Running via Spring preloader in process 48280
      create  app/controllers/lecture_controller.rb
       route  get 'lecture/index'
get 'lecture/show'
      invoke  erb
      create    app/views/lecture
      create    app/views/lecture/index.html.erb
      create    app/views/lecture/show.html.erb
      invoke  test_unit
      create    test/controllers/lecture_controller_test.rb
      invoke  helper
      create    app/helpers/lecture_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/lecture.scss
# lecture_controllerが追加されてて、view/lectureにindexとshowが作られてた。(どれも空っぽ)
# routeに、lecture/indexとlecture/showのgetが定義された
```

route.rbのgetを、lecture/all が lecture#index に, lecture/hoge が lecture#show に行くようにした

showで、URLを取得してerbで表示させるようにしてみる。erbにはemmet使おう. `C-y,` で展開

```bash
$ rails g model lecture term:string year:string course:string dayofweek:string code:integer category:string name:string teacher:string
Running via Spring preloader in process 85495
      invoke  active_record
      create    db/migrate/20200320033846_create_lectures.rb
      create    app/models/lecture.rb
      invoke    test_unit
      create      test/models/lecture_test.rb
      create      test/fixtures/lectures.yml
```
models内にLectureクラスが出来てた
マイグレーションファイルも出来てた => マイグレーション実行
```bash
$ rake db:migrate
```
できた
`rails dbconsole` で対話でDB見れる? 普通のmysqlコンソールにしか見えない

コメントコントローラーを作るモデルも作る
```
❯ rails g controller comment
❯ rails g model comment text:string
```
コメントがbelongs_toでlectureに、逆にhas_manyも設定した。

マイグレーションファイルも変えないといけない。外部キーを追加するにはこれ。インデックスも張ってくれる。
`t.references :lecture`
これを最新のマイグレーションファイルに追加。migrateした。OK

0からマイグレーションファイル作るにはどうするんだろう? コマンドからじゃなくて直接書いてマイグレーションしたいとき。

=> こんな感じに、ファイル名だけ指定する。
```
❯ rails generate migration AddColumnEnglishName
Running via Spring preloader in process 49432
      invoke  active_record
      create    db/migrate/20200320042711_add_column_english_name.rb
```



外部キー制約とは、MySQLの用語。今回は指定しなかった。
> カラムに FOREIGN KEY 制約(外部キー制約)を設定することで、
> 対象のカラムに格納できる値を他のテーブルに格納されている値だけに限定することができます。

コメントnewの機能を作る。
その前にてきとうなレコード入れとく。
- フィクスチャ: テスト用DBレコード
- シードファイル: マスタ用DBレコード seed.rb

その前に、英語名のカラムと、年度のカラムを追加した。元々のyearを年度に使って(intに変える)、gradeを受講できる学年に使う。
```ruby
# ❯ rails generate migration ChangeColumnTypeYear
# を実行すると、マイグレーションファイルが出来るから、それを書き換える。
class ChangeColumnTypeYear < ActiveRecord::Migration[6.0]
  def change
    change_column :lectures, :year, :integer
  end
end
```

`rake db:seed` でシード入れた。

lectureをshowできるように。
そろそろクロールしないと

lecture#showでコメントを作れるようにする。
@lectureがnilじゃなければ@commnentを作る。
```html
<%= form_with url: 'comment/new' do |f| %>
  <%= f.label :text %><br>
  <%= f.text_field :title %>
<% end %>
```

```html
<%= form_for(@comment, :url => { :controller => :comment, :action => :new } ) do |f| %>
  <%= f.text_field :text %>
  <br>
<% end %>
```
こっち。

ファイル名の大文字小文字、単数複数に注意。

---

色々やって、授業ページからコメント投稿するのはできた

変数名変えたい

授業科目名
/Course title (Japanese)
英文授業科目名
/Course title (English)
科目番号
/Code
開講年度
/Academic year
開講年次
/Year offered
開講学期
/Semester(s) offered
開講コース・課程
/Faculty offering the course
授業の方法
/Teaching method
単位数
/Credits
科目区分
/Category
開講学科・専攻
/Cluster/Department
担当教員名
/Lecturer(s)
居室
/Office
公開E-Mail
/e-mail
授業関連Webページ
/Course website
更新日
/Last updated
更新状況
/Update status
主題および達成目標
/Topic and goals
前もって履修しておくべき科目
/Prerequisites
前もって履修しておくことが望ましい科目
/Recommended prerequisites and preparation
教科書等
/Course textbooks and materials
授業内容とその進め方
/Course outline and weekly schedule
実務経験を活かした授業内容(実務経験内容も含む)
/Course content utilizing practical experience
授業時間外の学習（予習・復習等）
/Preparation and review outside class
成績評価方法および評価基準（最低達成基準を含む）
/Evaluation and grading
オフィスアワー：授業相談
/Office hours
学生へのメッセージ
/Message for students
その他
/Others
キーワード
/Keyword(s)

emailは無くて良いかも。危険だし。あと全部stringにしよう。

- すること
  - DBのテーブル変える
  - クロール(前年度)
  - 英名変換
  - showページ改修
  - マークダウン記法OKに
  - コメント文字数&内容制限
  - indexページ改修
  - bootstrap
  - コメント数を表示
  - エラー処理
- 今後
  - ユーザーの仕組み
  - twitter認証
  - アップロード機能(pdf,img)
  - herokuとかにUP
  - 2020になったらクロール


DBテーブル変更
絡む追加して、lecturesからcoursesに変えた。モデルも作り直し

マイグレーションファイル、使いづらい。書き間違えた時に取り消す方法がわからないので。















