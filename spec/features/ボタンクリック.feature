# encoding: utf-8
# language: ja

# ボタンクリック.feature

@page @make_article_attachment
機能: 自動動作確認テスト

  背景: ログイン
    もし   アカウント"zomeki"とパスワード"zomeki"でzomekiにログイン

  シナリオ: [コンテンツ]-[コンテンツ]-[新規作成]-[一覧]_1
    ならば "/_system"に移動
    もし   "class""mainMenu"の"コンテンツ"をクリック
    もし   "class""contentMenu"の"コンテンツ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [コンテンツ]-[コンテンツ]-[新規作成]-[登録する]_2
    ならば "/_system"に移動
    もし   "class""mainMenu"の"コンテンツ"をクリック
    もし   "class""contentMenu"の"コンテンツ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [コンテンツ]-[検索]-[検索]-[リセット]_3
    ならば "/_system"に移動
    もし   "class""mainMenu"の"コンテンツ"をクリック
    もし   "class""contentMenu"の"検索"をクリック
    もし   "ID""contentBody"の上から"1"番目の"検索"をクリック
    もし   "ID""contentBody"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [コンテンツ]-[リンクチェック]-[検索]-[リセット]-[CSV出力]_4
    ならば "/_system"に移動
    もし   "class""mainMenu"の"コンテンツ"をクリック
    もし   "class""contentMenu"の"リンクチェック"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    もし   "class""search"の上から"1"番目の"CSV出力"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[テキスト]-[新規作成]-[一覧]_5
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"テキスト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[テキスト]-[新規作成]-[登録する]_6
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"テキスト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[ファイル]-[ファイル]-[新規作成]-[一覧]_7
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[ファイル]-[ファイル]-[新規作成]-[登録する]_8
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[ファイル]-[フォルダ]-[新規作成]-[一覧]_9
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"フォルダ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [データ]-[ファイル]-[フォルダ]-[新規作成]-[登録する]_10
    ならば "/_system"に移動
    もし   "class""mainMenu"の"データ"をクリック
    もし   "class""contentMenu"の"ファイル"をクリック
    もし   "class""actionMenu"の"フォルダ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[ピース]-[新規作成]-[一覧]_11
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"ピース"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[ピース]-[新規作成]-[登録する]_12
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"ピース"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[レイアウト]-[新規作成]-[一覧]_13
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"レイアウト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[レイアウト]-[新規作成]-[登録する]_14
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"レイアウト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[スタイルシート]-[_themes]_15
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"スタイルシート"をクリック
    もし   "class""navi"の"_themes"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[スタイルシート]-[新規ディレクトリ]-[作成する]_16
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"スタイルシート"をクリック
    もし   "class""actionMenu"の"新規ディレクトリ"をクリック
    もし   "ID""contentBody"の上から"1"番目の"作成する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[スタイルシート]-[新規ファイル]-[作成する]_17
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"スタイルシート"をクリック
    もし   "class""actionMenu"の"新規ファイル"をクリック
    もし   "ID""contentBody"の上から"1"番目の"作成する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [デザイン]-[スタイルシート]-[アップロード]-[アップロード]_18
    ならば "/_system"に移動
    もし   "class""mainMenu"の"デザイン"をクリック
    もし   "class""contentMenu"の"スタイルシート"をクリック
    もし   "class""actionMenu"の"アップロード"をクリック
    もし   "ID""contentBody"の上から"1"番目の"アップロード"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ディレクトリ]-[ZOMEKI]_19
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ディレクトリ"をクリック
    もし   "class""navi"の"ZOMEKI"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ディレクトリ]-[[詳細]]_20
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ディレクトリ"をクリック
    もし   "class""navi"の"[詳細]"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ディレクトリ]-[新規作成]-[一覧]_21
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ディレクトリ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ディレクトリ]-[新規作成]-[登録する]_22
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ディレクトリ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ディレクトリ]-[検索]-[リセット]_23
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ディレクトリ"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ファイル管理]-[ディレクトリ]-[作成する]_24
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ファイル管理"をクリック
    もし   "class""actionMenu"の"新規ディレクトリ"をクリック
    もし   "ID""contentBody"の上から"1"番目の"作成する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ファイル管理]-[新規ファイル]-[作成する]_25
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ファイル管理"をクリック
    もし   "class""actionMenu"の"新規ファイル"をクリック
    もし   "ID""contentBody"の上から"1"番目の"作成する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[ファイル管理]-[アップロード]-[アップロード]_26
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"ファイル管理"をクリック
    もし   "class""actionMenu"の"アップロード"をクリック
    もし   "ID""contentBody"の上から"1"番目の"アップロード"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ディレクトリ]-[再構築]-[再構築](コンテンツ)-[再構築](ページ)_27
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ディレクトリ"をクリック
    もし   "class""contentMenu"の"再構築"をクリック
    もし   "ID""contentBody"の上から"1"番目の"再構築"をクリック
    もし   "ID""contentBody"の上から"2"番目の"再構築"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[コンセプト]-[コンセプト]_28
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"コンセプト"をクリック
    もし   "class""navi"の"コンセプト"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[コンセプト]-[新規作成]-[一覧]_29
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"コンセプト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[コンセプト]-[新規作成]-[登録する]_30
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"コンセプト"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[新規作成]-[一覧]_31
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   上から"1"番目の"新規作成"をクリック
    もし   上から"1"番目の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[新規作成]-[登録する]_32
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   上から"1"番目の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[一覧]_33
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"1"番目の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集]-[詳細]_34
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"1"番目の"編集"をクリック
    もし   上から"1"番目の"詳細"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集]-[更新する]_35
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"1"番目の"編集"をクリック
    もし   "ID""contentBody"の上から"1"番目の"更新する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集](Basic認証)-[ドメイン詳細]_36
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"2"番目の"編集"をクリック
    もし   上から"1"番目の"ドメイン詳細"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集](Basic認証)-[新規作成]-[一覧]_37
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"2"番目の"編集"をクリック
    もし   上から"1"番目の"新規作成"をクリック
    もし   上から"1"番目の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集](Basic認証)-[新規作成]-[登録する]_38
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"2"番目の"編集"をクリック
    もし   上から"1"番目の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集](Basic認証)-[認証ON]-[認証ON(更新)]-[認証OFF]_39
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"2"番目の"編集"をクリック
    もし   上から"1"番目の"認証ON"をクリック
    もし   上から"1"番目の"認証ON（更新）"をクリック
    もし   上から"1"番目の"認証OFF"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[ドメイン]-[詳細]-[編集](Basic認証)-[新規作成]-[認証ON]-[認証ON(更新)]-[認証OFF]_40
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"ドメイン"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   上から"2"番目の"編集"をクリック
    もし   上から"1"番目の"新規作成"をクリック
    もし   上から"1"番目の"認証ON"をクリック
    もし   上から"1"番目の"認証ON（更新）"をクリック
    もし   上から"1"番目の"認証OFF"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[辞書]-[新規作成]-[一覧]_41
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[辞書]-[新規作成]-[登録する]_42
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[辞書]-[データ一覧]_43
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"データ一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[辞書]-[辞書更新]_44
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"辞書更新"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[辞書]-[動作確認]-[ふりがな]-[音声テキスト]-[音声ファイル]_45
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"動作確認"をクリック
    もし   "ID""contentBody"の上から"1"番目の"ふりがな"をクリック
    もし   "ID""contentBody"の上から"1"番目の"音声テキスト"をクリック
    もし   "ID""contentBody"の上から"1"番目の"音声ファイル"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](1)-[一覧]_46
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](1)-[プロセス実行]-[停止]_47
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"プロセス実行"をクリック
    もし   "ID""contentBody"の上から"1"番目の"停止"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](2)-[一覧]_48
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"2"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](2)-[プロセス実行]-[停止]_49
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"2"段目の"リンク"をクリック
    もし   "class""actionMenu"の"プロセス実行"をクリック
    もし   "ID""contentBody"の上から"1"番目の"停止"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](3)-[一覧]_50
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"3"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](3)-[プロセス実行]-[停止]_51
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"3"段目の"リンク"をクリック
    もし   "class""actionMenu"の"プロセス実行"をクリック
    もし   "ID""contentBody"の上から"1"番目の"停止"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](4)-[一覧]_52
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"4"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](4)-[プロセス実行]-[停止]_53
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"4"段目の"リンク"をクリック
    もし   "class""actionMenu"の"プロセス実行"をクリック
    もし   "ID""contentBody"の上から"1"番目の"停止"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](5)-[一覧]_54
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"5"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](5)-[プロセス実行]-[停止]_55
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"5"段目の"リンク"をクリック
    もし   "class""actionMenu"の"プロセス実行"をクリック
    もし   "ID""contentBody"の上から"1"番目の"停止"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[プロセス]-[詳細](6)-[一覧]_56
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"プロセス"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"6"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[エクスポート]-[エクスポート]_57
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"エクスポート"をクリック
    もし   "ID""contentBody"の上から"1"番目の"エクスポート"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[インポート]-[インポート]_58
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"インポート"をクリック
    もし   "ID""contentBody"の上から"1"番目の"インポート"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](1)-[一覧]_59
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](1)-[登録する]_60
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"1"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](2)-[一覧]_61
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"2"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](2)-[登録する]_62
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"2"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](3)-[一覧]_63
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"3"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](3)-[登録する]_64
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"3"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](4)-[一覧]_65
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"4"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](4)-[登録する]_66
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"4"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](5)-[一覧]_67
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"5"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](5)-[登録する]_68
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"5"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](6)-[一覧]_69
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"6"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](6)-[登録する]_70
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"6"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](7)-[一覧]_71
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"7"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](7)-[登録する]_72
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"7"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](8)-[一覧]_73
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"8"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](8)-[登録する]_74
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"8"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](9)-[一覧]_75
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"9"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[設定]-[編集](9)-[登録する]_76
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"設定"をクリック
    もし   indexテーブルのヘッダが"編集"のときの"9"段目の"リンク"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[非常時]-[新規作成]-[一覧]_77
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"非常時"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[非常時]-[新規作成]-[登録する]_78
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"非常時"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[メッセージ]-[新規作成]-[一覧]_79
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"メッセージ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [サイト]-[非常時]-[新規作成]-[登録する]_80
    ならば "/_system"に移動
    もし   "class""mainMenu"の"サイト"をクリック
    もし   "class""contentMenu"の"メッセージ"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[トップ]_81
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""navi"の"トップ"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規グループ]-[一覧]_82
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規グループ"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規グループ]-[トップ]_83
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規グループ"をクリック
    もし   "class""navi"の"トップ"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規グループ]-[追加]-[除外]-[登録する]_84
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規グループ"をクリック
    もし   "ID""contentBody"のヘッダ名"サイト"にある上から"1"番目の"追加"をクリック
    もし   "ID""contentBody"のヘッダ名"サイト"にある上から"1"番目の"除外"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規ユーザー]-[一覧]_85
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規ユーザー"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規ユーザー]-[トップ]_86
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規ユーザー"をクリック
    もし   "class""navi"の"トップ"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[新規ユーザー]-[追加]-[除外]-[登録する]_87
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""actionMenu"の"新規ユーザー"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"追加"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"除外"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[詳細]-[一覧]_88
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""tree"の上から"1"番目の"詳細"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[詳細]-[編集]-[一覧]_89
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""tree"の上から"1"番目の"詳細"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[詳細]-[編集]-[詳細]_90
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""tree"の上から"1"番目の"詳細"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "class""actionMenu"の"詳細"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[グループ]-[詳細]-[編集]-[追加]-[除外]-[更新する]_91
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"グループ"をクリック
    もし   "class""tree"の上から"1"番目の"詳細"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"追加"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"除外"をクリック
    もし   "ID""contentBody"の上から"1"番目の"更新する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[新規作成]-[一覧]_92
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[新規作成]-[追加]-[除外]-[登録する]_93
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"追加"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"除外"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[検索]-[リセット]_94
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[詳細]-[一覧]_95
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[詳細]-[編集]-[一覧]_96
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[詳細]-[編集]-[詳細]_97
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "class""actionMenu"の"詳細"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ユーザー]-[詳細]-[編集]-[追加]-[除外]-[更新する]_98
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ユーザー"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"編集"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"追加"をクリック
    もし   "ID""contentBody"のヘッダ名"ロール権限"にある上から"1"番目の"除外"をクリック
    もし   "ID""contentBody"の上から"1"番目の"更新する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ロール]-[新規作成]-[一覧]_99
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ロール"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ロール]-[新規作成]-[登録する]_100
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ロール"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[ロール]-[検索]-[リセット]_101
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"ロール"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[エクスポート]-[エクスポート](1)-[エクスポート](2)_102
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"エクスポート"をクリック
    もし   "ID""contentBody"の上から"1"番目の"エクスポート"をクリック
    もし   "ID""contentBody"の上から"2"番目の"エクスポート"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ユーザー]-[インポート]-[インポート](1)-[インポート](2)_103
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ユーザー"をクリック
    もし   "class""contentMenu"の"インポート"をクリック
    もし   "ID""contentBody"の上から"1"番目の"インポート"をクリック
    もし   "ID""contentBody"の上から"2"番目の"インポート"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ログ]-[操作ログ]-[検索]-[リセット]-[CSV出力]_104
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ログ"をクリック
    もし   "class""contentMenu"の"操作ログ"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    もし   "class""search"の上から"1"番目の"CSV出力"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ログ]-[操作ログ]-[詳細]-[一覧]_105
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ログ"をクリック
    もし   "class""contentMenu"の"操作ログ"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ログ]-[プロセスログ]-[検索]-[リセット]_106
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ログ"をクリック
    もし   "class""contentMenu"の"プロセスログ"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ログ]-[プロセスログ]-[詳細]-[一覧]_107
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ログ"をクリック
    もし   "class""contentMenu"の"プロセスログ"をクリック
    もし   indexテーブルのヘッダが"詳細"のときの"1"段目の"リンク"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[ダウンロード]-[実行する]_108
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"ダウンロード"をクリック
    もし   "ID""contentBody"の上から"1"番目の"実行する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[ファイル一覧]_109
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"ファイル一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[変換設定]_110
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"変換設定"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[書き込み]-[書き込む]_111
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"書き込み"をクリック
    もし   "ID""contentBody"の上から"1"番目の"書き込む"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[書き込み済一覧]-[CSV出力]_112
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"書き込み済一覧"をクリック
    もし   "class""actionMenu"の"CSV出力"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[コンバート]-[書き込み済一覧]-[検索]-[リセット]_113
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"コンバート"をクリック
    もし   "class""actionMenu"の"書き込み済一覧"をクリック
    もし   "class""search"の上から"1"番目の"検索"をクリック
    もし   "class""search"の上から"1"番目の"リセット"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[プラグイン]-[新規作成]-[一覧]_114
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"プラグイン"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [ツール]-[プラグイン]-[新規作成]-[登録する]_115
    ならば "/_system"に移動
    もし   "class""mainMenu"の"ツール"をクリック
    もし   "class""contentMenu"の"プラグイン"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[メンテナンス情報]-[新規作成]-[一覧]_116
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"メンテナンス情報"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[メンテナンス情報]-[新規作成]-[登録する]_117
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"メンテナンス情報"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[モード設定]-[登録する]_118
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"モード設定"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[辞書]-[新規作成]-[一覧]_119
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "class""actionMenu"の"一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[辞書]-[新規作成]-[登録する]_120
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"新規作成"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[辞書]-[データ一覧]_121
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"データ一覧"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[辞書]-[辞書更新]_122
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"辞書更新"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[辞書]-[動作確認]-[ふりがな]-[音声テキスト]-[音声ファイル]_123
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"辞書"をクリック
    もし   "class""actionMenu"の"動作確認"をクリック
    もし   "ID""contentBody"の上から"1"番目の"ふりがな"をクリック
    もし   "ID""contentBody"の上から"1"番目の"音声テキスト"をクリック
    もし   "ID""contentBody"の上から"1"番目の"音声ファイル"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[メール]-[メール送信]-[送信する]_124
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"メール"をクリック
    もし   "class""actionMenu"の"メール送信"をクリック
    もし   "ID""contentBody"の上から"1"番目の"送信する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[メール]-[リンクチェック]-[確認する]_125
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"メール"をクリック
    もし   "class""actionMenu"の"リンクチェック"をクリック
    もし   "ID""contentBody"の上から"1"番目の"確認する"をクリック
    ならば railsエラーが出ていないか確認する

  シナリオ: [システム]-[SSL]-[登録する]_126
    ならば "/_system"に移動
    もし   "class""mainMenu"の"システム"をクリック
    もし   "class""contentMenu"の"SSL"をクリック
    もし   "ID""contentBody"の上から"1"番目の"登録する"をクリック
    ならば railsエラーが出ていないか確認する
