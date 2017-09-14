# encoding: utf-8

steps_for :make_article_attachment do
  #記事作成時の添付ファイルに関する処理
  #'item_url'には添付したいファイルのパスを入力する
  step '保存ファイル名を":names", 表示ファイル名を":titles", 代替テキストを":alts"にして":item_path"をアップロード' do |names, titles, alts, item_path|
    puts '保存ファイル名を"' + names + '", 表示ファイル名を"' + titles + '", 代替テキストを"' + alts + '"にして"' + item_path + '"をアップロード'

    within_frame(page.all('iframe', visible: false)[0]) do
      attach_file 'files[]', item_path, visible: false
      fill_in 'names[]', with: names
      fill_in 'titles[]', with: titles
      fill_in 'alts[]', with: alts
      click_on 'アップロード'
    end
  end
#####
  #記事作成時の添付ファイルの項目内でファイルをアップロードする
  step '添付ファイル内の":file"に":item_path"をアップロード' do |file, item_path|
    puts '添付ファイル内の"' + file + '"に"' + item_path + '"をアップロード'

    if file == 'ファイル'
      file_name = 'files[]'
    else
      file_name = file
    end

    within_frame(page.all('iframe', visible: false)[0]) do
      attach_file file_name, item_path, visible: false
    end
  end
#####
  #記事作成時の添付ファイルの項目内のセレクトボックスで要素を選択する
  step '添付ファイル内の":select_box"で":select"を選択' do |select_box, select|
    puts '添付ファイル内の"' + select_box + '"で"' + select + '"を選択'

    if select_box == '画像リサイズ'
      select_name = 'image_resize'
    else
      select_name = select_box
    end

    within_frame(page.all('iframe', visible: false)[0]) do
      select select, from: select_name
    end
  end
#####
  #記事作成時の添付ファイルの項目内でフォームにテキストを入力する
  step '添付ファイル内の上から":n"番目の":form"に":text"を入力' do |n, form, text|
    puts '添付ファイル内の上から"' + n + '"番目の"' + form + '"に"' + text + '"を入力'

    if form == '保存ファイル名'
      form_id = '#names_'
    elsif form == '表示ファイル名'
      form_id = '#titles_'
    elsif form == '代替テキスト'
      form_id = '#alts_'
    else
      form_id = form
    end

    within_frame(page.all('iframe', visible: false)[0]) do
      page.all(form_id)[n.to_i-1].set(text)
    end
  end
#####
  #記事作成時の添付ファイルの項目内でフォームにテキストを入力する
  step '添付ファイル内の更新用":form"に":text"を入力' do |form, text|
    puts '添付ファイル内の更新用"' + form + '"に"' + text + '"を入力'

    within_frame(page.all('iframe', visible: false)[0]) do
      fill_in form, with: text
    end
  end

  #記事作成時の添付ファイルの項目内のリンクやボタンをクリックする
  step '添付ファイル内の上から":n"番目の":link_button"をクリック' do |n, link_button|
    puts '添付ファイル内の上から"' + n + '"番目の"' + link_button + '"をクリック'

    within_frame(page.all('iframe', visible: false)[0]) do
      page.all(:link_or_button, link_button)[n.to_i-1].click
    end
  end
###
  #記事内の'記事'や'公開日'のようなタブを切り替える
  #'tab_name'には切り替えたいタブの'text'を入力する
  #タブの切り替えを行うと処理が止まることがあるため, タブを切り替える際にデータを保存しページの再読み込みを行っている
  step 'タブの":tab_name"をクリック' do |tab_name|
    puts 'タブの"' + tab_name + '"をクリック'

    x = page.find('#contentBody').all('a').size
    size = x.to_i
    y = 0
    text = ''
    id = ''
    p size
    while y < size
      text = page.find('#contentBody').all('a')[y].text
      p text
      if text == tab_name
        id = page.find('#contentBody').all('a')[y][:id]
        break
      end
      y += 1
    end

    xpath = '//*[@id="' + id + '"]'
    find(:xpath, xpath).trigger('click')
    sleep 1
  end

  #公開日などの日時設定を'#ui-datepicker-div'を使用して行う処理
  #日付の指定とスライドバーの下のメモリを使用した時刻の指定を行う
  #カレンダーの月の切り替えは'":link_button"をクリック'の'link_button'に'次'・'前'のいずれかを入力することで行う
  #'閉じる'ボタンをおして閉じないと次の処理ができない場合がある
  step '":day_time"の":number"をクリック' do |day_time, number|
    puts '"' + day_time + '"の"' + number + '"をクリック'

    if number == '00' || number == '0'
      num = 0
    elsif number == '04' || number == '4' || number == '10'
      num = 1
    elsif number == '08' || number == '8' || number == '20'
      num = 2
    elsif number == '12' || number == '30'
      num = 3
    elsif number == '16' || number == '40'
      num = 4
    elsif number == '20' || number == '50'
      num = 5
    end

    if day_time == '日付' || day_time == '日にち' || day_time == '日' || day_time == 'カレンダー'
      click_on number
    elsif day_time == '時間' || day_time == '時'
      all('.ui-tpicker-grid-label')[0].all('td')[num].click
    elsif day_time == '分'
      all('.ui-tpicker-grid-label')[1].all('td')[num].click
    end
  end

  #公開日などの日時設定を'#ui-datepicker-div'を使用して行う処理
  #スライドバーを利用した時刻の指定を行う
  #'閉じる'ボタンをおして閉じないと次の処理ができない場合がある
  step '":time"のスライドバーの":number"をクリック' do |time, number|
    puts '"' + time + '"のスライドバーの"' + number + '"をクリック'

    num = number.to_i
    if time == '時間' || time == '時'
      all('.ui-tpicker-grid-label')[0].all('td')[0].click
      while num > 0
        all('.ui-slider-handle')[0].click.send_keys(:right)
        num -= 1
      end
    elsif time == '分'
      all('.ui-tpicker-grid-label')[1].all('td')[0].click
      while num > 0
        all('.ui-slider-handle')[1].click.send_keys(:right)
        num -= 1
      end
    end
  end

  #リッチテキストエリアに文字列を入力する処理
  #'label'にはリッチテキストエリアに対応する'label'の'text'を入力する
  #コンテンツ内のリッチテキストエリア以外は未確認
  step 'リッチテキストエリア":label"に":form_data"を入力' do |label, form_data|
    puts 'リッチテキストエリア"' + label + '"に"' + form_data + '"を入力'

    sleep 1
    x = page.all('tr').size
    table = x.to_i
    y = 0
    text = ''
    while y < table
      m = all('tr')[y].all('th').size
      header = m.to_i
      n = 0

      while n < header
        text = all('tr')[y].all('th')[n].text
        if text == label
          if current_path.include?('gp_article') || current_path.include?('piece_frees')
            all('tr')[y+1].find('td').find('a', text: "ソース").click
            sleep 1
            find('textarea').click.set(form_data)
            n = header
            y = table
          else
            all('tr')[y].find('td').find('a', text: "ソース").click
            sleep 1
            all('tr')[y].find('td').find('textarea').click.set(form_data)
            n = header
            y = table
          end
        end
        n += 1
      end
      y += 1
    end
  end

  #記事の添付ファイルの項目内の表示の確認
  step '添付ファイルの":table_title"が":table_data"で":yes_no"ことを確認' do |table_title, table_data, yes_no|
    puts '添付ファイルの"' + table_title + '"が"' + table_data + '"で"' + yes_no + '"ことを確認'

    within_frame(page.all('iframe', visible: false)[0]) do
      if yes_no == 'ある'
        expect(page).to have_selector('td', text: table_data)
      elsif yes_no == 'ない'
        expect(page).to have_no_selector('td', text: table_data)
      end
    end
  end

  #動作未確認
  step '新しいウインドウを開く' do
    puts '新しいウインドウを開く'

    switch_to_window open_new_window
  end

#####
  step '記事番号・記事URL・タイトル・ディレクトリ名・作成日時・編集日時の取得' do
    puts '記事番号・記事URL・タイトル・ディレクトリ名・作成日時・編集日時の取得'

    click_on '詳細'
    $gp_article_num = find(:xpath, '//*[@id="tab1"]/table[1]/tbody/tr[1]/td').text
    $gp_article_url = find(:xpath, '//*[@id="tab1"]/table[1]/tbody/tr[2]/td/a').text
    if current_path.start_with?('/_system')
      $gp_article_title = find(:xpath, '//*[@id="tab1"]/table[1]/tbody/tr[3]/td[1]').text
    elsif current_path.start_with?('/_admin')
      $gp_article_title = find(:xpath, '//*[@id="tab1"]/table[1]/tbody/tr[4]/td[1]').text
    end
    click_on 'オプション'
    text = find(:xpath, '//*[@id="tab8"]/table[1]/tbody/tr[3]/td').text
    $gp_article_directory = text.match(%r{(.+?) / })[1]
    $gp_article_make = find(:xpath, '//*[@id="tab8"]/table[5]/tbody/tr[2]/td').text
    $gp_article_update = find(:xpath, '//*[@id="tab8"]/table[5]/tbody/tr[3]/td').text
p $gp_article_num
p $gp_article_url
p $gp_article_title
p $gp_article_directory
p $gp_article_make
p $gp_article_update
p $approval_confirm
    click_on '編集'
    text = find(:xpath, '//*[@id="tabs"]/ul').text
    if text.include?('承認')
      click_on '承認'
      size = $approval_confirm.size - 1
      p size
      n = 0
      for count in 0..size
        if count%2 == 1
          n += 1
          select_command = $approval_confirm[count]
          for count_size in 0..(select_command.size-1)
            page.find(:xpath, '//*[@id="assignments1_' + (count+1).to_s + '"]').select(select_command[count_size]) if select_command[count_size] != ''
          end
          page.all(:link_or_button, '追加')[n-1].click
        end
      end
    end
  end
#####
  step '編集日時の修正' do
    puts '編集日時の修正'

    click_on '全記事'
    wide = page.find('.index').all('th').size - 1
    high = page.find('.index').all('tr').size - 1
    count_th = 0
    count_th1 = 0
    count_th2 = 0
    count_th3 = 0
    count_td = 1
    breaker = 0
    count_all = page.find('.count').text.to_i
    count_all = count_all / 30 + 1
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      if text == '更新日時'
        break
      end
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == '記事番号'
      count_th1 += 1
    end
    while count_th2 < wide
      text = page.find('.index').all('th')[count_th2].text
      break if text == 'タイトル'
      count_th2 += 1
    end
    while count_th3 < wide
      text = page.find('.index').all('th')[count_th3].text
      break if text == 'ディレクトリ名'
      count_th3 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s)
      count_td = 1
      high = page.find('.index').all('tr').size - 1
      while count_td < high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
        if text == $gp_article_num
          text = page.find('.index').all('tr')[count_td].all('td')[count_th2].text
          if text == $gp_article_title
            text = page.find('.index').all('tr')[count_td].all('td')[count_th3].text
            if text == $gp_article_directory
              $gp_article_update = page.find('.index').all('tr')[count_td].all('td')[count_th].text
              breaker = 1
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if count_gparticle < count_all
      count_gparticle += 1
    end
p $gp_article_update
  end

end

