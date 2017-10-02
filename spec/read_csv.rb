require 'csv'
require 'yaml'

titles = ARGV[0].dup
title = titles.match(%r{csv_files/(.+?).csv})[1]
file_name = ARGV[0].dup

count = 1
row_end = -1
column_end = 1
lines = Array.new(0).map{ Array.new(0) }

CSV.foreach(file_name, encoding: 'Shift_JIS:UTF-8').each do |row|
  case count
  when 1
    column_end = row.length
  else
    lines[count-2] = row
    row_end += 1
  end
  count += 1
end
setting = YAML.load_file("/var/www/zomeki_auto_test_files/config.yml")
target = setting["config"]["target"]
account = setting["config"]["account"]
password = setting["config"]["password"]

column_link = Array.new
scenario_count = 1 #シナリオNo
connect_length = 0 #シナリオ行数
count_steps = 0 #step数のカウント
tree = 0 #class='tree'の有無 1:treeから新規作成・編集画面へ移動している場合, 2:treeから詳細画面に移動している場合
content_kind = '' #[コンテンツ]-[コンテンツ]のコンテンツ種別
gp_article_tab = '記事' #タブの切り替えの有無
file_upload = 0 #記事作成のファイルアップロード部分の操作の有無
gparticle_on_off = 0 #記事作成の記事タブの開く・閉じるの組み合わせ
loop_count = [0] #同一シナリオを複数回出力する
loop_over = 0 #loop中にloopを行う場合その重なった回数
loop_start = [0] #loopするstepの開始地点no
loop_end_check = 0 #loopにstopが書かれていなかった場合最後のstepまでloopするように
variable_check = [0] #変数をリセットする場所のカウント loop_overが0になったときリセット
variable_check_count = 0
variable_value = 1 #タイトル名等を個別のものにするための数値
variable_count = 0
log_in_out = 1 #ログイン状態
refine_count = 0 #絞り込み回数
refine_th = ['', '', '']
refine_td = ['', '', '']
page_menu = ['ログイン', '', ''] #mainMenu・contentMenuのクリック状況
command_input = 0 #page・mainMenu・contentMenu以外の入力があったかの確認
search_on_off = 0 #拡張検索の開閉
scenario_name = nil #シナリオ名の取得

File.open('/var/www/zomeki_auto_test_files/spec/features/' + title.to_s + '.feature', "w") do |f|
  f.puts('# encoding: utf-8')
  f.puts('# language: ja')
  f.puts()
  f.puts('# ' + title + '.feature')
  f.puts()
  f.puts('@page @make_article_attachment')
  f.puts('機能: 自動動作確認テスト')
  f.puts()
  f.puts('  背景: ログイン')
  if target == 'zomeki'
    f.puts('    もし   アカウント"' + account + '"とパスワード"' + password + '"でzomekiにログイン')
  elsif target == 'NACCSzomeki'
    f.puts('    もし   アカウント"' + account + '"とパスワード"' + password + '"でNACCSzomekiにログイン')
  elsif target == 'Joruri'
    #f.puts('    もし   アカウント"' + account + '"とパスワード"' + password + '"でJoruriにログイン')
  end

  for row_count in 0..row_end

    if lines[row_count][21] != nil
      line_loop = lines[row_count][21]
      if line_loop.include?('start')
        loop_over += 1
        loop_count[loop_over] = line_loop.match(%r{start:([0-9]+)})[1].to_i - 1
        loop_count[loop_over+1] = 0
        loop_start[loop_over] = count_steps
        variable_check[variable_check_count] = count_steps
        variable_check_count += 1
        loop_end_check += 1
      elsif line_loop.include?('loop')
        loop_over += 1
        loop_count[loop_over] = line_loop.match(%r{loop:([0-9]+)})[1].to_i - 1
        loop_start[loop_over] = count_steps
        variable_check[variable_check_count] = count_steps
        variable_check_count += 1
        loop_end_check += 1
      end
    end

    for column_count in 1..column_end

      scenario_count = lines[row_count][0].to_i
      if row_count+1 <= row_end
        if scenario_count != lines[row_count+1][0].to_i && loop_end_check >= 1 && lines[row_count][21] == nil && column_count == 21
          lines[row_count][21] = 'stop'
        elsif scenario_count == lines[row_end][0].to_i && loop_end_check >= 1 && lines[row_end][21] == nil && column_count == 21
          lines[row_end][21] = 'stop'
        end
      end
      if lines[row_count][column_count] != nil
        if column_count <= 3 && count_steps >= 1 && lines[row_count][0].to_i != scenario_count
          for columns in (column_count-1)..3
            column_link[columns] = nil
          end
        end

        case column_count

        when 1 #page
          count_steps = 0 if command_input == 0

          if lines[row_count][column_count] == 'ログイン画面' || lines[row_count][column_count] == 'ログアウト'
            column_link[count_steps] = '    もし   "ログアウト"をクリック'
            log_in_out = 0
            page_menu[0] = 'ログアウト'
            page_menu[1] = ''
            page_menu[2] = ''
          elsif lines[row_count][column_count] == '管理画面' || lines[row_count][column_count] == 'NACCS管理画面' || lines[row_count][column_count] == 'naccs管理画面'
            if target == 'zomeki'
              column_link[count_steps] = '    ならば "/_system"に移動'
            elsif target == 'NACCSzomeki'
              column_link[count_steps] = '    ならば "/_admin"に移動'
            end
            log_in_out = 1
          else
            column_link[count_steps] = '    ならば "' + lines[row_count][column_count].to_s + '"に移動'
          end

          column_link[count_steps+1] = nil
          column_link[count_steps+2] = nil
          count_steps += 1

        when 2 #mainMenu
          count_steps = 1 if command_input == 0
          column_link[count_steps] = '    もし   "class""mainMenu"の"' + lines[row_count][column_count].to_s + '"をクリック'
          column_link[count_steps+1] = nil
          count_steps += 1
          page_menu[1] = lines[row_count][column_count]

          if lines[row_count][column_count] == 'コンテンツ'
            page_menu[2] = 'コンテンツ'
          elsif lines[row_count][column_count] == 'データ'
            page_menu[2] = 'テキスト'
          elsif lines[row_count][column_count] == 'デザイン'
            page_menu[2] = 'ピース'
          elsif lines[row_count][column_count] == 'ディレクトリ'
            page_menu[2] = 'ディレクトリ'
          elsif lines[row_count][column_count] == 'サイト'
            page_menu[2] = 'コンセプト'
            tree = 0
          elsif lines[row_count][column_count] == 'ユーザー'
            page_menu[2] = 'グループ'
            tree = 0
          elsif lines[row_count][column_count] == 'ログ'
            page_menu[2] = '操作ログ'
          elsif lines[row_count][column_count] == 'システム'
            page_menu[2] = 'メンテナンス情報'
          else
            page_menu[2] = ''
          end

        when 3 #contentMenu
          count_steps = 2 if command_input == 0
          column_link[count_steps] = '    もし   "class""contentMenu"の"' + lines[row_count][column_count].to_s + '"をクリック'
          count_steps += 1
          page_menu[2] = lines[row_count][column_count]

        when 4 #navi
          count_steps = 3 if count_steps <= 2
          column_link[count_steps] = '    もし   "class""navi"の"' + lines[row_count][column_count].to_s + '"をクリック'

          if page_menu[1] == 'ユーザー' && page_menu[2] == 'グループ' || page_menu[1] == 'サイト' && page_menu[2] == 'コンセプト'
            tree = 0
          end

          count_steps += 1
          command_input = 1

        when 5 #navi_select
          count_steps = 3 if count_steps <= 2

          if lines[row_count][column_count-1] == nil
            column_link[count_steps] = '    もし   "class""navi"の上から"1"番目の"naviPath"のセレクトボックスで"' + lines[row_count][column_count].to_s + '"を選択'
          else
            column_link[count_steps] = '    もし   "class""navi"の上から"1"番目の"' + lines[row_count][column_count-1].to_s + '"のセレクトボックスで"' + lines[row_count][column_count].to_s + '"を選択'
          end

          count_steps += 1
          command_input = 1

        when 6 #button
          count_steps = 3 if count_steps <= 2

          if page_menu[1] == 'サイト' && page_menu[2] == 'ドメイン'
            if lines[row_count][column_count+1]  =~ /\A[0-9]*\Z/
              column_link[count_steps] = '    もし   上から"' + lines[row_count][column_count+1].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
            else
              column_link[count_steps] = '    もし   上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
            end
          else
            column_link[count_steps] = '    もし   "class""actionMenu"の"' + lines[row_count][column_count].to_s + '"をクリック'
            if page_menu[1] == 'ユーザー' && page_menu[2] == 'グループ' && (lines[row_count][column_count] == '新規グループ' || lines[row_count][column_count] == '新規ユーザー') || page_menu[1] == 'サイト' && page_menu[2] == 'コンセプト' && lines[row_count][column_count] == '新規作成'
              tree = 1
            elsif tree == 2 && lines[row_count][column_count] == '編集'
              tree = 1
            elsif tree == 1 && lines[row_count][column_count] == '詳細'
              tree = 2
            elsif (tree == 1 || tree == 2) && (lines[row_count][column_count] != '編集' || lines[row_count][column_count] != '詳細')
              tree = 0
            end
            page_menu[1] == 'サイト' if page_menu[1] == 'システム' && page_menu[2] == '辞書' && lines[row_count][column_count] == '動作確認'
          end

          gp_article_tab = '記事'
          count_steps += 1
          command_input = 1

        when 8 #search
          count_steps = 3 if count_steps <= 2

          if lines[row_count][column_count+1] == 'クリック'
            if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
              column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
            else
              column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
            end

            search_on_off = 1 if lines[row_count][column_count] == '拡張検索'
            search_on_off = 0 if lines[row_count][column_count] == '基本検索'
          elsif lines[row_count][column_count+1] == '入力'
            if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
              column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
            else
              column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
            end

          elsif lines[row_count][column_count+1] == '選択'
            if search_on_off == 0
              if content_kind == '記事' && target == 'NACCSzomeki'
                if lines[row_count][column_count] == '公開先'
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"公開先"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                elsif lines[row_count][column_count] == 'カテゴリ種別'
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"カテゴリ種別"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                elsif lines[row_count][column_count] == 'カテゴリ'
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"カテゴリ"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              else
                if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                  column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                else
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              end
            elsif search_on_off == 1
              if lines[row_count][column_count] == '公開先'
                column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"公開先"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
              elsif lines[row_count][column_count] == 'カテゴリ種別'
                if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                  column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"カテゴリ種別"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                else
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"カテゴリ種別"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              elsif lines[row_count][column_count] == 'カテゴリ'
                if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                  column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"カテゴリ"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                else
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"カテゴリ"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              elsif lines[row_count][column_count] == '日付'
                if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                  column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"日付"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                else
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"日付"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              elsif lines[row_count][column_count] == '状態'
                column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"状態"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
              elsif lines[row_count][column_count] == 'ユーザー'
                if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                  column_link[count_steps] = '    もし   "class""search"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"ユーザー"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                else
                  column_link[count_steps] = '    もし   "class""search"の上から"1"番目の"ユーザー"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                end
              end
            end
          elsif lines[row_count][column_count+1] == 'ボタン選択'
            column_link[count_steps] = '    もし   "class""search"のラジオボタンの"' + lines[row_count][column_count].to_s + '"を選択'
          elsif lines[row_count][column_count+1] == 'ファイル選択'
            column_link[count_steps] = '    もし   "class""search"の"' + lines[row_count][column_count].to_s + '"で"' + lines[row_count][column_count+2].to_s + '"ファイルを選択'
          elsif lines[row_count][column_count+1] == 'チェック'
            if lines[row_count][column_count+2] == 'ON'
              column_link[count_steps] = '    もし   "class""search"で"' + lines[row_count][column_count].to_s + '"のチェックを"入れる"'
            else
              column_link[count_steps] = '    もし   "class""search"で"' + lines[row_count][column_count].to_s + '"のチェックを"はずす"'
            end
          elsif lines[row_count][column_count+1] == '表示'
            column_link[count_steps] = '    ならば ページ内"class""search"のテキストに"' + lines[row_count][column_count].to_s + '"が含まれて"いる"ことを確認'
          end

          count_steps += 1
          command_input = 1

        when 12 #command
          count_steps = 3 if count_steps <= 2

          if log_in_out == 0
            #ログイン画面
            if lines[row_count][column_count+1] == 'クリック'
              if lines[row_count][column_count] == 'ログイン'
                column_link[count_steps] = '    もし   "ログイン"をクリック'
                log_in_out = 1
                page_menu[0] = 'ログイン'
              elsif lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                column_link[count_steps] = '    もし   上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
              else
                column_link[count_steps] = '    もし   上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
              end
            elsif lines[row_count][column_count+1] == '入力'
              if lines[row_count][column_count] == 'アカウント' || lines[row_count][column_count] == 'ユーザーID' || lines[row_count][column_count] == 'account'
                column_link[count_steps] = '    もし   "account"に"' + lines[row_count][column_count+2].to_s + '"を入力'
              elsif lines[row_count][column_count] == 'パスワード' || lines[row_count][column_count] == 'password'
                column_link[count_steps] = '    もし   "password"に"' + lines[row_count][column_count+2].to_s + '"を入力'
              else
                column_link[count_steps] = '    もし   "' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
              end
            elsif lines[row_count][column_count+1] == '表示'
              if lines[row_count][column_count].include?('バージョン')
                column_link[count_steps] = '    ならば "ページ"内に"バージョン情報"の表示が"ある"ことを確認'
              else
                column_link[count_steps] = '    ならば "ページ"内に"' + lines[row_count][column_count].to_s + '"の表示が"ある"ことを確認'
              end
            end

          else
            #管理画面
            if page_menu[1] == 'ユーザー' && page_menu[2] == 'グループ' && tree == 0 || page_menu[1] == 'サイト' && page_menu[2] == 'コンセプト' && tree == 0
              if lines[row_count][column_count+1] == 'クリック'
                if lines[row_count][column_count] == 'グループ' || lines[row_count][column_count] == 'コンセプト'
                  if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    number = lines[row_count][column_count+3].to_i * 2
                    column_link[count_steps] = '    もし   "xpath""//div[@id=\'contentBody\']/div/div/div/a[' + number.to_s + ']"をクリック'
                  else
                    column_link[count_steps] = '    もし   "xpath""//div[@id=\'contentBody\']/div/div/div/a[2]"をクリック'
                  end
                else
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "class""tree"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   "class""tree"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                  if lines[row_count][column_count] == '詳細'
                    tree = 2
                  end
                end
              elsif lines[row_count][column_count+1] == '表示'
                column_link[count_steps] = '    ならば ページ内"class""tree"のテキストに"' + lines[row_count][column_count].to_s + '"が含まれて"いる"ことを確認'
              end

            else
              if lines[row_count][column_count+1] == 'クリック'
                if page_menu[1] == 'ユーザー' && page_menu[2] == 'エクスポート'
                  if lines[row_count][column_count+2] == 'グループ' || lines[row_count][column_count+2] == nil
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"エクスポート"をクリック'
                  elsif lines[row_count][column_count+2] == 'ユーザー'
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"2"番目の"エクスポート"をクリック'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                elsif page_menu[1] == 'ユーザー' && page_menu[2] == 'インポート'
                  if lines[row_count][column_count+2] == 'グループ' || lines[row_count][column_count+2] == nil
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"インポート"をクリック'
                  elsif lines[row_count][column_count+2] == 'ユーザー'
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"2"番目の"インポート"をクリック'
                  else
                    if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                    else
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                    end
                  end
                elsif page_menu[1] == 'ディレクトリ' && page_menu[2] == '再構築'
                  if lines[row_count][column_count] == '再構築' && lines[row_count][column_count+1] == 'クリック' && lines[row_count][column_count+2] == 'コンテンツ'
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"再構築"をクリック'
                  elsif lines[row_count][column_count] == '再構築' && lines[row_count][column_count+1] == 'クリック' && lines[row_count][column_count+2] == 'ページ'
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"2"番目の"再構築"をクリック'
                  else
                    if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                    else
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                    end
                  end
                elsif lines[row_count][column_count] == 'CMS'
                  column_link[count_steps] = '    もし   "CMS"をクリック'
                  page_menu[1] = ''
                  page_menu[2] = ''
                elsif lines[row_count][column_count] == 'メンテナンス情報' && page_menu[1] == '' && page_menu[2] == ''
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""maintenances"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"リンク"をクリック'
                  elsif
                    column_link[count_steps] = '    もし   "ID""maintenances"の上から"1"番目の"リンク"をクリック'
                  end
                elsif lines[row_count][column_count] == 'お知らせ' && page_menu[1] == '' && page_menu[2] == ''
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""messages"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"リンク"をクリック'
                  elsif
                    column_link[count_steps] = '    もし   "ID""messages"の上から"1"番目の"リンク"をクリック'
                  end
                elsif lines[row_count][column_count] == '開く' && lines[row_count][column_count+2] == 'タイトル設定'
                  column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"開く"をクリック'
                  gparticle_on_off = 1 if gparticle_on_off == 0
                  gparticle_on_off = 3 if gparticle_on_off == 2
                elsif lines[row_count][column_count] == '閉じる' && lines[row_count][column_count+2] == 'タイトル設定'
                  column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"閉じる"をクリック'
                  gparticle_on_off = 0 if gparticle_on_off == 1
                  gparticle_on_off = 2 if gparticle_on_off == 3
                elsif lines[row_count][column_count] == '開く' && lines[row_count][column_count+2] == '添付ファイル'
                  if gparticle_on_off == 0
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"2"番目の"開く"をクリック'
                    gparticle_on_off = 2
                  elsif gparticle_on_off == 1
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"開く"をクリック'
                    gparticle_on_off = 3
                  end
                  file_upload = 1
                elsif lines[row_count][column_count] == '閉じる' && lines[row_count][column_count+2] == '添付ファイル'
                  if gparticle_on_off == 2
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"閉じる"をクリック'
                    gparticle_on_off = 0
                  elsif gparticle_on_off == 3
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"2"番目の"閉じる"をクリック'
                    gparticle_on_off = 1
                  end
                  file_upload = 0
                elsif lines[row_count][column_count+2] == 'タブ'
                  column_link[count_steps] = '    もし   タブの"' + lines[row_count][column_count].to_s + '"をクリック'
                  gp_article_tab = lines[row_count][column_count] if content_kind == '記事'
                elsif lines[row_count][column_count+2] != nil
                  if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""contentBody"のヘッダ名"' + lines[row_count][column_count+2].to_s + '"にある上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"のヘッダ名"' + lines[row_count][column_count+2].to_s + '"にある上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                elsif file_upload == 1 && gp_article_tab == '記事' && (lines[row_count][column_count] == 'アップロード' || lines[row_count][column_count] == '詳細' || lines[row_count][column_count] == '添付' || lines[row_count][column_count].include?('画像貼付'))
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   添付ファイル内の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   添付ファイル内の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                  file_upload = 2 if lines[row_count][column_count] == '詳細'
                elsif file_upload == 2 && gp_article_tab == '記事' && (lines[row_count][column_count] == '一覧' || lines[row_count][column_count] == '編集' || lines[row_count][column_count] == '削除')
                  if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   添付ファイル内の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   添付ファイル内の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                  file_upload = 1 if lines[row_count][column_count] == '一覧'
                  file_upload = 3 if lines[row_count][column_count] == '編集'
                elsif  file_upload == 3 && gp_article_tab == '記事' && (lines[row_count][column_count] == '一覧' || lines[row_count][column_count] == '詳細' || lines[row_count][column_count] == '更新')
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   添付ファイル内の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   添付ファイル内の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                  file_upload = 1 if lines[row_count][column_count] == '一覧' || lines[row_count][column_count] == '更新'
                  file_upload = 2 if lines[row_count][column_count] == '詳細'
                else
                  if (lines[row_count][column_count] == '即時公開' || lines[row_count][column_count] == '承認依頼') && content_kind == '記事'
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"下書き保存"をクリック'
                    count_steps += 1
                    column_link[count_steps] = '    ならば 記事番号・記事URL・タイトル・ディレクトリ名・作成日時・編集日時の取得'
                    count_steps += 1
                  end
                  if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"をクリック'
                  end
                  file_upload = 1 if lines[row_count][column_count] == '開く' && lines[row_count][column_count+3] == '2'
                  file_upload = 0 if lines[row_count][column_count] == '閉じる' && lines[row_count][column_count+3] == '2'
                  if lines[row_count][column_count] == '下書き保存' && content_kind == '記事'
                    gp_article_tab = '記事'
                    count_steps += 1
                    column_link[count_steps] = '    ならば 記事番号・記事URL・タイトル・ディレクトリ名・作成日時・編集日時の取得'
                  elsif (lines[row_count][column_count] == '即時公開' || lines[row_count][column_count] == '承認依頼') && content_kind == '記事'
                    gp_article_tab = '記事'
                    count_steps += 1
                    column_link[count_steps] = '    ならば 編集日時の修正'
                  end
                end
                file_upload = 0 if content_kind == '記事' && (lines[row_count][column_count] == 'リンクチェック' || lines[row_count][column_count] == 'アクセシビリティチェック' || lines[row_count][column_count] == '下書き保存' || lines[row_count][column_count] == '承認依頼' || lines[row_count][column_count] == '即時公開')
                if page_menu[1] == 'サイト' && page_menu[2] == 'コンセプト' || page_menu[1] == 'ユーザー' && page_menu[2] == 'グループ'
                  tree = 0 if lines[row_count][column_count] == '登録する' || lines[row_count][column_count] == '更新する'
                end

              elsif lines[row_count][column_count+1] == '入力'
                if content_kind == '記事'
                  if lines[row_count][column_count] == '内容' || lines[row_count][column_count] == '携帯用内容'
                    column_link[count_steps] = '    もし   リッチテキストエリア"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  elsif file_upload == 1 && gp_article_tab == '記事'
                    if lines[row_count][column_count+3]  =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   添付ファイル内の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    else
                      column_link[count_steps] = '    もし   添付ファイル内の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    end
                  elsif file_upload == 3 && gp_article_tab == '記事'
                    column_link[count_steps] = '    もし   添付ファイル内の更新用"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  else
                    if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   タブ"' + gp_article_tab + '"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    else
                      column_link[count_steps] = '    もし   タブ"' + gp_article_tab + '"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    end
                  end
                elsif content_kind == '問合せ'
                  if lines[row_count][column_count] == '概要' || lines[row_count][column_count] == '説明' || lines[row_count][column_count] == '送信後のメッセージ'
                    column_link[count_steps] = '    もし   リッチテキストエリア"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  else
                    if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    else
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    end
                  end
                elsif content_kind == '業務用カレンダー'
                  if lines[row_count][column_count] == '概要' || lines[row_count][column_count] == '説明'
                    column_link[count_steps] = '    もし   リッチテキストエリア"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  else
                    if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    else
                      column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                    end
                  end
                else
                  if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"' + lines[row_count][column_count+3].to_s + '"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"を入力'
                  end
                end

              elsif lines[row_count][column_count+1] == '選択'
                if lines[row_count][column_count] == 'グループ' || lines[row_count][column_count] == 'ユーザー'
                  column_link[count_steps] = '    もし   "ID""contentBody"の上から"1"番目の"' + lines[row_count][column_count].to_s + '"のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                elsif page_menu[1] == 'コンテンツ' && page_menu[2] == 'コンテンツ' && tree == 0
                  if lines[row_count][column_count] == '所属'
                    column_link[count_steps] = '    もし   "ID""contentBody"の"関連記事"内の上から"1"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif lines[row_count][column_count] == '作成者'
                    column_link[count_steps] = '    もし   "ID""contentBody"の"関連記事"内の上から"2"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif lines[row_count][column_count] == 'カテゴリ種別'
                    column_link[count_steps] = '    もし   "ID""contentBody"の"関連記事"内の上から"3"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif lines[row_count][column_count] == 'カテゴリ'
                    column_link[count_steps] = '    もし   "ID""contentBody"の"関連記事"内の上から"4"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif lines[row_count][column_count] == '記事'
                    column_link[count_steps] = '    もし   "ID""contentBody"の"関連記事"内の上から"5"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif file_upload >= 1 && gp_article_tab == '記事' && lines[row_count][column_count] == '画像リサイズ'
                    column_link[count_steps] = '    もし   添付ファイル内の"' + lines[row_count][column_count].to_s + '"で"' + lines[row_count][column_count+2].to_s + '"を選択'
                  elsif lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"内の上から"' + lines[row_count][column_count+3].to_s + '"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"内の上から"1"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  end
                else
                  if lines[row_count][column_count+3] =~ /\A[0-9]*\Z/
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"内の上から"' + lines[row_count][column_count+3].to_s + '"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"内の上から"1"番目のセレクトボックスで"' + lines[row_count][column_count+2].to_s + '"を選択'
                  end
                end

              elsif lines[row_count][column_count+1] == 'ボタン選択'
                column_link[count_steps] = '    もし   "ID""contentBody"のラジオボタンの"' + lines[row_count][column_count+2].to_s + '"を選択'

              elsif lines[row_count][column_count+1] == 'ファイル選択'
                if page_menu[1] == 'ユーザー' && page_menu[2] == 'インポート'
                  if lines[row_count][column_count+2] == 'グループ' || lines[row_count][column_count+2] == nil
                    column_link[count_steps] = '    もし   "グループ"で"' + lines[row_count][column_count+2].to_s + '"ファイルを選択'
                  elsif lines[row_count][column_count+2] == 'ユーザー'
                    column_link[count_steps] = '    もし   "ユーザー"で"' + lines[row_count][column_count+2].to_s + '"ファイルを選択'
                  else
                    column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"で"' + lines[row_count][column_count+2].to_s + '"ファイルを選択'
                  end
                elsif file_upload >= 1 && gp_article_tab == '記事'
                  column_link[count_steps] = '    もし   添付ファイル内の"' + lines[row_count][column_count].to_s + '"に"' + lines[row_count][column_count+2].to_s + '"をアップロード'
                else
                  column_link[count_steps] = '    もし   "ID""contentBody"の"' + lines[row_count][column_count].to_s + '"で"' + lines[row_count][column_count+2].to_s + '"ファイルを選択'
                end

              elsif lines[row_count][column_count+1] == 'チェック'
                if lines[row_count][column_count+2] == 'ON'
                  column_link[count_steps] = '    もし   "ID""contentBody"で"' + lines[row_count][column_count].to_s + '"のチェックを"入れる"'
                else
                  column_link[count_steps] = '    もし   "ID""contentBody"で"' + lines[row_count][column_count].to_s + '"のチェックを"はずす"'
                end

              elsif lines[row_count][column_count+1] == '表示'
                column_link[count_steps] = '    ならば ページ内"ID""contentBody"のテキストに"' + lines[row_count][column_count].to_s + '"が含まれて"いる"ことを確認'
              end
            end
          end
          count_steps += 1
          command_input = 1

        when 16 #object
          count_steps = 3 if count_steps <= 2

          lines[row_count][column_count+2].gsub!(/\//, '-') if lines[row_count][column_count] == '更新日時' && lines[row_count][column_count+2] != nil
          if lines[row_count][column_count+1] == 'クリック'
            if refine_count == 1
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"の"リンク"をクリック'
              content_kind = refine_td[0] if refine_th[0] == 'コンテンツ種別' && page_menu[1] == 'コンテンツ' && page_menu[2] == 'コンテンツ'
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            elsif refine_count == 2
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"かつth"' + refine_th[1].to_s + '"が"' + refine_td[1].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"の"リンク"をクリック'
              if page_menu[1] == 'コンテンツ' && page_menu[2] == 'コンテンツ'
                content_kind = refine_td[0] if refine_th[0] == 'コンテンツ種別'
                content_kind = refine_td[1] if refine_th[1] == 'コンテンツ種別'
              end
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            elsif refine_count == 3
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"かつth"' + refine_th[1].to_s + '"が"' + refine_td[1].to_s + '"かつth"' + refine_th[2].to_s + '"が"' + refine_td[2].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"の"リンク"をクリック'
              if page_menu[1] == 'コンテンツ' && page_menu[2] == 'コンテンツ'
                content_kind = refine_td[0] if refine_th[0] == 'コンテンツ種別'
                content_kind = refine_td[1] if refine_th[1] == 'コンテンツ種別'
                content_kind = refine_td[2] if refine_th[2] == 'コンテンツ種別'
              end
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            elsif lines[row_count][column_count+3] =~ /\A[0-9]*\Z/ && lines[row_count][column_count+2] == nil || lines[row_count][column_count+2] == 'リンク'
              column_link[count_steps] = '    もし   indexテーブルのヘッダが"' + lines[row_count][column_count] + '"のときの"' + lines[row_count][column_count+3].to_s + '"段目の"リンク"をクリック'
              content_kind = 'unknown'
            else
              column_link[count_steps] = '    もし   indexテーブルのヘッダが"' + lines[row_count][column_count] + '"のときの"1"段目の"リンク"をクリック'
              content_kind = 'unknown'
            end
            refine_count = 0
          elsif lines[row_count][column_count+1] == '表示'
            if lines[row_count][column_count+2] == nil
              column_link[count_steps] = '    ならば ヘッダ名"' + lines[row_count][column_count] + '"が"ある"ことを確認'
            elsif page_menu[1] == 'サイト' && page_menu[2] == 'コンセプト' && tree == 0
              if lines[row_count][column_count] == 'コンテンツ名'
                column_link[count_steps] = '    ならば 上から"1"番目のindexテーブルのヘッダ名"' + lines[row_count][column_count].to_s + '"にデータ"' + lines[row_count][column_count+2].to_s + '"が"ある"ことを確認'
              elsif lines[row_count][column_count] == 'レイアウトID' || lines[row_count][column_count] == 'レイアウト名'
                column_link[count_steps] = '    ならば 上から"2"番目のindexテーブルのヘッダ名"' + lines[row_count][column_count].to_s + '"にデータ"' + lines[row_count][column_count+2].to_s + '"が"ある"ことを確認'
              elsif lines[row_count][column_count] == 'ピースID' || lines[row_count][column_count] == 'ピース名'
                column_link[count_steps] = '    ならば 上から"3"番目のindexテーブルのヘッダ名"' + lines[row_count][column_count].to_s + '"にデータ"' + lines[row_count][column_count+2].to_s + '"が"ある"ことを確認'
              end
            elsif refine_count == 1
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"にデータ"' + lines[row_count][column_count+2] + '"が"ある"ことを確認'
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            elsif refine_count == 2
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"かつth"' + refine_th[1].to_s + '"が"' + refine_td[1].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"にデータ"' + lines[row_count][column_count+2] + '"が"ある"ことを確認'
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            elsif refine_count == 3
              column_link[count_steps] = '    ならば indexテーブルのth"' + refine_th[0].to_s + '"が"' + refine_td[0].to_s + '"かつth"' + refine_th[1].to_s + '"が"' + refine_td[1].to_s + '"かつth"' + refine_th[2].to_s + '"が"' + refine_td[2].to_s + '"のときヘッダ名"' + lines[row_count][column_count] + '"にデータ"' + lines[row_count][column_count+2] + '"が"ある"ことを確認'
              refine_th = ['', '', '']
              refine_td = ['', '', '']
              refine_count = 0
            else
              column_link[count_steps] = '    ならば indexテーブルのヘッダ名"' + lines[row_count][column_count].to_s + '"にデータ"' + lines[row_count][column_count+2].to_s + '"が"ある"ことを確認'
            end
            refine_count = 0
          elsif lines[row_count][column_count+1] == '絞り込み'
            if refine_count < 3
              refine_th[refine_count] =  lines[row_count][column_count]
              refine_td[refine_count] =  lines[row_count][column_count+2]
              refine_count += 1
            end
          end
          count_steps += 1
          command_input = 1

        when 20 #screenshot
          count_steps = 3 if count_steps <= 2
          column_link[count_steps] = '    ならば スクリーンショット"' + lines[row_count][column_count] + '"を撮影'
          count_steps += 1
          command_input = 1

        when 21 #loop
          if lines[row_count][21] != nil && lines[row_count][21] == 'stop' && (count_steps >= 1 || row_count+1 <= row_end && scenario_count != lines[row_count+1][0].to_i || scenario_count == lines[row_end][0].to_i)
            loop_counter = loop_over
            for counter in 0..loop_counter
              loop_stop = count_steps-1
              while loop_count[loop_over] != 0
                for loops in loop_start[loop_over]..loop_stop
                  column_link[count_steps] = Marshal.load(Marshal.dump(column_link[loops]))
                  count_steps += 1
                end
                loop_count[loop_over] -= 1
              end
              loop_end_check -= 1
              loop_over -= 1
              variable_check[variable_check_count] = count_steps-1
              variable_check_count += 1
              if loop_end_check == 0
                variable_check[variable_check_count] = 0
                variable_check_count += 1
              end
            end
          elsif lines[row_count][21] != nil && lines[row_count][21].include?('loop:') && count_steps >= 1
            loop_stop = count_steps-1
            while loop_count[loop_over] != 0
              for loops in loop_start[loop_over]..loop_stop
                column_link[count_steps] = Marshal.load(Marshal.dump(column_link[loops]))
                count_steps += 1
              end
              loop_count[loop_over] -= 1
            end
            loop_end_check -= 1
            loop_over -= 1
            variable_check[variable_check_count] = count_steps-1
            variable_check_count += 1
            if loop_end_check == 0
              variable_check[variable_check_count] = 0
              variable_check_count += 1
            end
          end
        when 22 #scenario_name
          scenario_name = lines[row_count][22] if lines[row_count][22] != nil
        else
        end
      end
    end

    if row_count+1 <= row_end && lines[row_count+1][0].to_i != scenario_count || row_count == row_end
      f.puts()
      if scenario_name != nil
        f.puts('  シナリオ: ' + scenario_name + '_' + scenario_count.to_s)
      else
        f.puts('  シナリオ: シナリオ_' + scenario_count.to_s)
      end
      variable_check_count = 0
      for columns in 0..count_steps-1
        if column_link[columns] != nil
          variable_check_count += 1 if columns == variable_check[variable_check_count]
          line_variable = column_link[columns]
          while line_variable.include?('[variable]')
            line_variable.sub!(/\[variable\]/, variable_value.to_s)
            variable_value += 1
          end
          while line_variable =~ /\[variable\+[0-9]*\]/
            text = Marshal.load(Marshal.dump(line_variable))
            text.slice!(/\A.*\[variable\+/)
            text.slice!(/\].*\Z/)
            variable_value += text.to_i
            line_variable.sub!(/\[variable\+[0-9]*\]/, variable_value.to_s)
            variable_value += 1
          end
          column_link[columns] = line_variable
          f.puts(column_link[columns])
          if variable_check[variable_check_count] == 0
            variable_value = 0
            variable_check_count += 1
          end
        end
      end
      f.puts('    ならば railsエラーが出ていないか確認する')

      for columns in 3..count_steps
        column_link[columns] = nil
      end
      p '--- シナリオ_' + scenario_count.to_s + ' ---'
      connect_length = 0
      count_steps = 3
      tree = 0
      content_kind = ''
      gp_article_tab = '記事'
      file_upload = 0
      gparticle_on_off = 0
      loop_count = [0]
      loop_over = 0
      loop_start = [0]
      loop_end_check = 0
      variable_check = [0]
      variable_check_count = 0
      variable_value = 1
      variable_count = 0
      log_in_out = 1
      refine_count = 0
      refine_th = ['', '', '']
      refine_td = ['', '', '']
      page_menu = ['ログイン', '', '']
      page_menu[1] = column_link[1].match(%r{.もし   "class""mainMenu"の"(.+?)"をクリック})[1] if column_link[1] != nil
      page_menu[2] = column_link[2].match(%r{.もし   "class""contentMenu"の"(.+?)"をクリック})[1] if column_link[2] != nil
      command_input = 0
      search_on_off == 0
      scenario_name = nil
    elsif lines[row_count+1][0].to_i == scenario_count
      connect_length += 1
    end
  end
end
