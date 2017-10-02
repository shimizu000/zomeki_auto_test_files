# encoding: utf-8

steps_for :page do
  step 'アカウント":account"とパスワード":password"でzomekiにログイン' do |account, password|
    puts 'アカウント"' + account + '"とパスワード"' + password + '"でzomekiにログイン'

    visit '/_system/login'
    fill_in 'account', with: account
    fill_in 'password', with: password
    click_button 'ログイン'

    $approval_select = Array.new(2).map{Array.new(0,0)}
    $approval_confirm = Array.new(2).map{Array.new(0,0)}
    $approval_length = 2
  end

  step 'アカウント":account"とパスワード":password"でNACCSzomekiにログイン' do |account, password|
    puts 'アカウント"' + account + '"とパスワード"' + password + '"でNACCSzomekiにログイン'

    visit '/_admin/login'
    fill_in 'account', with: account
    fill_in 'password', with: password
    click_button 'ログイン'

    $approval_select = Array.new(2).map{Array.new(0,0)}
    $approval_confirm = Array.new(2).map{Array.new(0,0)}
    $approval_length = 2
  end

  #'page_url'には移動したいページのURLを入力する
  step '":page_url"に移動' do |page_url|
    puts '"' + page_url + '"に移動'

    if page_url == 'トップページ'
      visit '/_system'
    elsif page_url == 'NACCSトップページ'
      visit '/_admin'
    else
      visit page_url
    end
    sleep 1
  end

  #public下に'screenshot'というフォルダを作りその中に保存する
  step 'スクリーンショット":name"を撮影' do |name|
    puts 'スクリーンショット"' + name + '"を撮影'

    ssname = 'public/screenshot/' + name + '.png'
    page.save_screenshot ssname, full: true, js: true
  end

  #ページ読み込み待ち
  step '":n"秒間待機' do |n|
    puts '"' + n + '"秒間待機'
    sleep n.to_i
  end

  step 'railsエラーが出ていないか確認する' do
    puts 'railsエラーが出ていないか確認する'

    if current_path.end_with?('/login')
      version = page.find('.version').text
      puts '[画面表示:' + version + ']'
    else
      click_on 'ログアウト'
      version = page.find('.version').text
      puts '[ログアウト完了]'
    end
  end

  #'link_button'にはクリックしたいリンクやボタンの'text'か'alt'を入力する
  #'link_button'が'リンクチェック'か'アクセシビリティチェック'の場合は
  #その場面のスクリーンショットを撮影する
  step '":link_button"をクリック' do |link_button|
    puts '"' + link_button + '"をクリック'

    if link_button == '次'
      page.find('.ui-datepicker-next', visible: false).click
    elsif link_button == '前'
      page.find('.ui-datepicker-prev', visible: false).click
    else
      page.should have_button(link_button)
      click_on link_button
    end

    if link_button == 'リンクチェック' || link_button == 'アクセシビリティチェック'
      ssname = 'public/screenshot/' + link_button + '.png'
      page.save_screenshot ssname, full: true, js: true
      page.should have_button('下書き保存')
      click_on '下書き保存'
    end

    sleep 1
  end

  step '":n"回":link_button"をクリック' do |n, link_button|
    puts '"' + n + '"回"' + link_button + '"をクリック'

    num = n.to_i
    while num > 0
      if link_button == '次'
        page.find('.ui-datepicker-next', visible: false).click
      elsif link_button == '前'
        page.find('.ui-datepicker-prev', visible: false).click
      else
        page.should have_button(link_button)
        click_on link_button
      end
      num -= 1
    end

    if link_button == 'リンクチェック' || link_button == 'アクセシビリティチェック'
      ssname = 'public/screenshot/' + link_button + '.png'
      page.save_screenshot ssname, full: true, js: true
      page.should have_button('下書き保存')
      click_on '下書き保存'
    end

    sleep 1
  end

  #'path_type'には'ID'・'class'・'name'・'xpath'・'cssパス'のいずれか, 'menu_name'には指定した要素を入力する
  #クリックしたい箇所が id="test"の場合 : id_class_name -> ID, menu_name -> test
  step '":path_type"":path_text"をクリック' do |path_type, path_text|
    puts '"' + path_type + '""' + path_text + '"をクリック'

    if path_type == 'ID' || path_type == 'id'
      click_text = '#' + path_text
    elsif path_type == 'class' || path_type == 'クラス'
      click_text = '.' + path_text
    else
      click_text = path_text
    end

    if path_type == 'xpath' || path_type == 'Xpath'
      page.find(:xpath, click_text).click
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      page.find(:css, click_text).click
    else
      page.find(click_text).click
    end

    sleep 1
  end

  step '画面上の座標(":wide",":high")をクリック' do |wide, high|
    puts '画面上の座標("' + wide + '","' + high + '")をクリック'

    page.driver.click(wide.to_i, high.to_i)

    sleep 1
  end
###
  #上のstepに加えて'text'も指定する場合
  step '":path_type"":path_text"の":content_name"をクリック' do |path_type, path_text, content_name|
    puts '"' + path_type + '""' + path_text + '"の"' + content_name + '"をクリック'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if current_path.start_with?('/_system/cms/tool_convert') && path_name == '.actionMenu' && content_name != ('CSV出力')
      page.all('.actionMenu')[0].click_on(content_name)
    elsif current_path.start_with?('/_system/cms/tool_convert') && path_name == '.actionMenu' && content_name == ('CSV出力')
      page.all('.actionMenu')[1].click_on('CSV出力')
    else
      page.find(path_name).click_on(content_name)
    end

    sleep 1
  end
#####
  step '":path_type"":path_text"の上から":n"番目の":content_name"をクリック' do |path_type, path_text, n, link_button|
    puts '"' + path_type + '""' + path_text + '"の上から"' + n + '"番目の"' + link_button + '"をクリック'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if link_button == 'リンク' || link_button == ''
      page.find(path_name).all(:link_or_button)[n.to_i-1].click
    elsif link_button == '拡張検索' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
      page.find(:xpath, '//*[@id="toggleSearch"]').click
    else
      page.find(path_name).all(:link_or_button, link_button)[n.to_i-1].click
    end

    sleep 1
  end
#####
  #td内にあるリンクやボタンをクリックする場合
  step '":path_type"":path_text"のヘッダ名":content"にある上から":n"番目の":link_button"をクリック' do |path_type, path_text, content, n, link_button|
    puts '"' + path_type + '""' + path_text + '"のヘッダ名"' + content + '"にある上から"' + n + '"番目の"' + link_button + '"をクリック'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    tr = page.find(path_name).all('tr').size
    td_select = 0
    count_tr = 0
    count_th = 0
    while count_tr < tr
      th = page.find(path_name).all('tr')[count_tr].all('th').size
      count_th = 0
      while count_th < th
        text = page.find(path_name).all('tr')[count_tr].all('th')[count_th].text
        if text == content
          if link_button == 'リンク' || link_button == ''
            page.find(path_name).all('tr')[count_tr].all('td')[count_th].all(:link_or_button)[n.to_i-1].click
          else
            page.find(path_name).all('tr')[count_tr].all('td')[count_th].all(:link_or_button, link_button)[n.to_i-1].click
            if content == '承認フロー' && link_button == '追加'
              if $approval_confirm[n.to_i*2-1].empty?
                $approval_confirm[n.to_i*2-1] = $approval_select[n.to_i*2-1]
                p '$approval_confirm:'
                p $approval_confirm
                $approval_select[n.to_i*2-1] = []
                p $approval_select
              else
                $approval_confirm[n.to_i*2-1].push($approval_select[n.to_i*2-1])
                $approval_confirm[n.to_i*2-1].flatten!
                p '$approval_confirm:'
                p $approval_confirm
                $approval_select[n.to_i*2-1] = []
                p $approval_select
              end
            elsif content == '承認フロー' && link_button == '除外'
              unless $approval_confirm.empty?
                if $approval_select[n.to_i*2] != nil
                  delete_command = $approval_select[n.to_i*2]
                  length = delete_command.size
                  p length
                  for counter in 0..(length-1)
                    $approval_confirm[n.to_i*2-1].delete(delete_command[counter])
                  end
                end
                p '$approval_confirm:'
                p $approval_confirm
                $approval_select[n.to_i*2] = []
                p $approval_select
              end
            end
          end
          td_select = 1
          break
        end
        count_th += 1
      end
      break if td_select == 1
      count_tr += 1
    end

    sleep 1
  end

  #パスを使わずに同一名のものが複数ある要素のいずれかを選択する場合
  step '上から":n"番目の":link_button"をクリック' do |n, link_button|
    puts '上から"' + n + '"番目の"' + link_button + '"をクリック'

    count = n.to_i - 1
    page.all(:link_or_button, link_button)[count].click

    sleep 1
  end

  step '上から":n"番目の":path_type"":path_text"をクリック' do |n, path_type, path_text|
    puts '上から"' + n + '"番目の"' + path_type + '""' + path_text + '"をクリック'

    count = n.to_i - 1
    if path_type == 'ID' || path_type == 'id'
      click_text = '#' + path_text
    elsif path_type == 'class' || path_type == 'クラス'
      click_text = '.' + path_text
    else
      click_text = path_text
    end
    page.all(click_text)[count].click

    sleep 1
  end

  #'class'が'index'のテーブルの中のリンクやボタンをクリック
  step 'indexテーブルの":x"段目の左から":y"列目の":link_button"をクリック' do |x, y, link_button|
    puts 'indexテーブルの"' + x + '"段目の左から"' + y + '"列目の"' + link_button + '"をクリック'

    high = x.to_i
    wide = y.to_i - 1
    text = page.find('.index').all('tr')[high].all('td')[wide].text
    if link_button == 'リンク' || link_button == ''
      page.find('.index').all('tr')[high].all('td')[wide].find(:link_or_button).click
    else
      page.find('.index').all('tr')[high].all('td')[wide].find(:link_or_button, link_button).click
    end

    sleep 1
  end

  step 'indexテーブルの左から":x"列目が":content"のときの":y"列目":link_button"をクリック' do |x, content, y, link_button|
    puts 'indexテーブルの左から"' + x + '"列目が"' + content + '"のときの"' + y + '"列目"' + link_button + '"をクリック'

    wide = x.to_i - 1
    mark = y.to_i - 1
    high = 1
    count = page.all('tr').count
    text = ''
    name = ''
    while high < count
      text = page.all('tr')[high].all('td')[wide].text
      if text == content
        name = page.all('tr')[high].all('td')[mark].text #unless page.all('tr')[high].include?('colspan')
        if link_button == 'リンク' || link_button == ''
          page.all('tr')[high].all('td')[mark].find(:link_or_button).click
        else
          page.all('tr')[high].all('td')[mark].find(:link_or_button, link_button).click
        end
        break
      end
      high += 1
    end

    sleep 1
  end
#####
  step 'indexテーブルの左から":x"列目が":content"のときヘッダが":th_content"の":link_button"をクリック' do |x, content, th_content, link_button|
    puts 'indexテーブルの左から"' + x + '"列目が"' + content + '"のときヘッダが"' + th_content + '"の"' + link_button + '"をクリック'

    th_count = page.find('.index').all('th').size
    th_wide = 0
    while th_wide < th_count
      text = page.find('.index').all('th')[th_wide].text
      break if text == th_content
      th_wide += 1
    end

    wide = x.to_i - 1
    high = 1
    count = page.find('.index').all('tr').size
    while high < count
      p page.all('tr')[high].has_css?('colspan')
      text = page.find('.index').all('tr')[high].all('td')[wide].text #if page.all('tr')[high].has_no_css?('colspan')
      if text == content
        if link_button == 'リンク' || link_button == ''
          page.find('.index').all('tr')[high].all('td')[th_wide].find(:link_or_button, link_button).click
        else
          page.find('.index').all('tr')[high].all('td')[th_wide].find(:link_or_button).click
        end
        break
      end
      high += 1
    end

    sleep 1
  end
#####
  step 'indexテーブルのヘッダが":content"のときの":n"段目の":link_button"をクリック' do |content, n, link_button|
    puts 'indexテーブルのヘッダが"' + content + '"のときの"' + n + '"段目の"' + link_button + '"をクリック'

    high = n.to_i
    wide = 0
    count = page.find('.index').all('th').count
    text = ''
    name = ''
    link_count = 0
    while wide < count
      text = page.find('.index').all('th')[wide].text
      if text == content
        if link_button == 'リンク' || link_button == ''
          page.find('.index').all('tr')[high].all('td')[wide].find(:link_or_button).click
        else
          high = 1
          count = page.find('.index').all('tr').count
          while high < count
            text = page.find('.index').all('tr')[high].all('td')[wide].text
            if text == link_button
              link_count += 1
              if link_count == n.to_i
                page.find('.index').all('tr')[high].all('td')[wide].find(:link_or_button, link_button).click
                break
              end
            end
            high += 1
          end
        end
        break
      end
      wide += 1
    end

    sleep 1
  end
#####
  step 'indexテーブルのth":th1"が":td1"のときヘッダ名":th"の":link_button"をクリック' do |th1, td1, th, link_button|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    link_button = $gp_article_num if link_button == '$gp_article_num'
    link_button = $gp_article_url if link_button == '$gp_article_url'
    link_button1 = $gp_article_title if link_button == '$gp_article_title'
    link_button = $gp_article_directory if link_button == '$gp_article_directory'
    link_button = $gp_article_make if link_button == '$gp_article_make'
    link_button = $gp_article_update if link_button == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"のときヘッダ名"' + th + '"の"' + link_button + '"をクリック'

    high = page.find('.index').all('tr').count - 1
    wide = page.find('.index').all('th').count - 1
    count_th = 0
    count_th1 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s) if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').count - 1
      while count_td <= high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html
            if doc.include?('href')
              if link_button == 'リンク' || link_button == ''
                page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button).click
              else
                page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button, link_button).click
              end
              breaker = 1
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle != count_all
      count_gparticle += 1
    end

    if breaker != 1
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th1].text).to eq(td1)
      expect(Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html).to include('href')
    end
    sleep 1
  end
#####
  step 'indexテーブルのth":th1"が":td1"かつth":th2"が":td2"のときヘッダ名":th"の":link_button"をクリック' do |th1, td1, th2, td2, th, link_button|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    td2 = $gp_article_num if td2 == '$gp_article_num'
    td2 = $gp_article_url if td2 == '$gp_article_url'
    td2 = $gp_article_title if td2 == '$gp_article_title'
    td2 = $gp_article_directory if td2 == '$gp_article_directory'
    td2 = $gp_article_make if td2 == '$gp_article_make'
    td2 = $gp_article_update if td2 == '$gp_article_update'
    link_button = $gp_article_num if link_button == '$gp_article_num'
    link_button = $gp_article_url if link_button == '$gp_article_url'
    link_button1 = $gp_article_title if link_button == '$gp_article_title'
    link_button = $gp_article_directory if link_button == '$gp_article_directory'
    link_button = $gp_article_make if link_button == '$gp_article_make'
    link_button = $gp_article_update if link_button == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"かつth"' + th2 + '"が"' + td2 + '"のときヘッダ名"' + th + '"の"' + link_button + '"をクリック'

    high = page.find('.index').all('tr').count - 1
    wide = page.find('.index').all('th').count - 1
    count_th = 0
    count_th1 = 0
    count_th2 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) == true && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end
    while count_th2 < wide
      text = page.find('.index').all('th')[count_th2].text
      break if text == th2
      count_th2 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s)if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').count - 1
      while count_td <= high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            text = page.find('.index').all('tr')[count_td].all('td')[count_th2].text
            if text == td2
              doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html
              if doc.include?('href')
                if link_button == 'リンク' || link_button == ''
                  page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button).click
                else
                  page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button, link_button).click
                end
                breaker = 1
              end
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle != count_all
      count_gparticle += 1
    end

    if breaker != 1
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th1].text).to eq(td1)
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th2].text).to eq(td2)
      expect(Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html).to include('href')
    end
    sleep 1
  end
#####
  step 'indexテーブルのth":th1"が":td1"かつth":th2"が":td2"かつth":th3"が":td3"のときヘッダ名":th"の":link_button"をクリック' do |th1, td1, th2, td2, th3, td3, th, link_button|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    td2 = $gp_article_num if td2 == '$gp_article_num'
    td2 = $gp_article_url if td2 == '$gp_article_url'
    td2 = $gp_article_title if td2 == '$gp_article_title'
    td2 = $gp_article_directory if td2 == '$gp_article_directory'
    td2 = $gp_article_make if td2 == '$gp_article_make'
    td2 = $gp_article_update if td2 == '$gp_article_update'
    td3 = $gp_article_num if td3 == '$gp_article_num'
    td3 = $gp_article_url if td3 == '$gp_article_url'
    td3 = $gp_article_title if td3 == '$gp_article_title'
    td3 = $gp_article_directory if td3 == '$gp_article_directory'
    td3 = $gp_article_make if td3 == '$gp_article_make'
    td3 = $gp_article_update if td3 == '$gp_article_update'
    link_button = $gp_article_num if link_button == '$gp_article_num'
    link_button = $gp_article_url if link_button == '$gp_article_url'
    link_button1 = $gp_article_title if link_button == '$gp_article_title'
    link_button = $gp_article_directory if link_button == '$gp_article_directory'
    link_button = $gp_article_make if link_button == '$gp_article_make'
    link_button = $gp_article_update if link_button == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"かつth"' + th2 + '"が"' + td2 + '"かつth"' + th3 + '"が"' + td3 + '"のときヘッダ名"' + th + '"の"' + link_button + '"をクリック'

    high = page.find('.index').all('tr').count - 1
    wide = page.find('.index').all('th').count - 1
    count_th = 0
    count_th1 = 0
    count_th2 = 0
    count_th3 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end
    while count_th2 < wide
      text = page.find('.index').all('th')[count_th2].text
      break if text == th2
      count_th2 += 1
    end
    while count_th3 < wide
      text = page.find('.index').all('th')[count_th3].text
      break if text == th3
      count_th3 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s)if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      high = page.find('.index').all('tr').count - 1
      count_td = 1
      while count_td <= high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            text = page.find('.index').all('tr')[count_td].all('td')[count_th2].text
            if text == td2
              text = page.find('.index').all('tr')[count_td].all('td')[count_th3].text
              if text == td3
                doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html
                if doc.include?('href')
                  if link_button == 'リンク' || link_button == ''
                    page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button).click
                  else
                    page.find('.index').all('tr')[count_td].all('td')[count_th].find(:link_or_button, link_button).click
                  end
                  breaker = 1
                end
              end
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle != count_all
      count_gparticle += 1
    end

    if breaker != 1
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th1].text).to eq(td1)
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th2].text).to eq(td2)
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th3].text).to eq(td3)
      expect(Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].css('td')[count_th].inner_html).to include('href')
    end
    sleep 1
  end

  #画面左上の'#currentNaviSite'をクリックして開いておく必要がある
  step 'サイトを":sites"に変更' do |sites|
    puts 'サイトを"' + sites + '"に変更'

    page.find('#naviSites').click_link(sites)
  end

  #画面左上の'#currentNaviConcept'をクリックして開いておく必要がある
  step 'ルートの":concept"を選択' do |concept|
    puts 'ルートの"' + concept + '"を選択'

    page.find('#naviConcepts').click_link(concept)
  end

  #'path_type'には'ID'・'name'・'xpath'のいずれかを入力する
  #'select_command'には選択したい選択肢を入力する
  #'グループ'と'ユーザー'は記事等作成時の作成者の欄
  #'コンテンツ'と'ページ'はディレクトリの再構築の欄
  step '":path_text"のセレクトボックスで":select_command"を選択' do |path_text, select_command|
    puts '"' + path_text + '"のセレクトボックスで"' + select_command + '"を選択'

    if path_text == 'グループ'
      select select_command, from: 'item_creator_attributes_group_id'
    elsif path_text == 'ユーザー'
      select select_command, from: 'item_creator_attributes_user_id'
    elsif path_text == 'コンテンツ'
      select select_command, from: 'target_content_ids'
    elsif path_text == 'ページ'
      select select_command, from: 'target_node_ids'
    else
      select select_command, from: path_text
    end
  end

  #'xpath'で指定するとき
  step '":path_type"":path_text"のセレクトボックスで":select_command"を選択' do |path_type, path_text, select_command|
    puts '"' + path_type + '""' + path_text + '"のセレクトボックスで"' + select_command + '"を選択'

    if path_text == 'グループ'
      select select_command, from: 'item_creator_attributes_group_id'
    elsif path_text == 'ユーザー'
      select select_command, from: 'item_creator_attributes_user_id'
    elsif path_text == 'コンテンツ'
      select select_command, from: 'target_content_ids'
    elsif path_text == 'ページ'
      select select_command, from: 'target_node_ids'
    elsif path_type == 'xpath' || path_type == 'Xpath'
      page.find(:xpath, path_text).select(select_command)
    else
      select select_command, from: path_text
    end
  end
#####
  step '":path_type"":path_text"の":select_box"内の上から":n"番目のセレクトボックスで":select_command"を選択' do |path_type, path_text, select_box, n, select_command|
    puts '"' + path_type + '""' + path_text + '"の"' + select_box + '"内の上から"' + n + '"番目のセレクトボックスで"' + select_command + '"を選択'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    tr = page.find(path_name).all('tr').size
    td_select = 0
    count_tr = 0
    count_th = 0
    while count_tr < tr
      th = page.find(path_name).all('tr')[count_tr].all('th').size
      count_th = 0
      while count_th < th
        text = page.find(path_name).all('tr')[count_tr].all('th')[count_th].text
        text = 'コンテンツ種別' if text == 'コンテンツ種別 ※'
        if text == select_box
          if select_box == "課"
            if select_command.empty?
              page.find(path_name).all('tr')[count_tr+n.to_i-1].find('select').all('option')[0].select_option
            else
              page.find(path_name).all('tr')[count_tr+n.to_i-1].find('select').select(select_command)
            end
          else
            if select_command.empty?
              page.find(path_name).all('tr')[count_tr].all('select')[n.to_i-1].all('option')[0].select_option
              if select_box == '承認フロー'
                if $approval_length.to_i < n.to_i+1
                  for num in 0..(n.to_i-$approval_length.to_i+1)
                    new_array1 = Array.new(0)
                    new_array2 = Array.new(0)
                    $approval_select.push(new_array1)
                    $approval_confirm.push(new_array2)
                  end
                  $approval_length = n.to_i+1
                end
                $approval_select[n.to_i].push(page.find(path_name).all('tr')[count_tr].all('select')[n.to_i-1].all('option')[0].text)
                $approval_select[n.to_i].uniq!
                p '$approval_select:'
                p $approval_select
              end
            else
              page.find(path_name).all('tr')[count_tr].all('select')[n.to_i-1].select(select_command)
              if select_box == '承認フロー'
                if $approval_length.to_i < n.to_i+1
                  for num in 0..(n.to_i-$approval_length.to_i+1)
                    new_array1 = Array.new(0)
                    new_array2 = Array.new(0)
                    $approval_select.push(new_array1)
                    $approval_confirm.push(new_array2)
                  end
                  $approval_length = n.to_i+1
                end
                $approval_select[n.to_i].push(select_command)
                $approval_select[n.to_i].uniq!
                p '$approval_select:'
                p $approval_select
              end
            end
          end
          td_select = 1
          break
        end
        count_th += 1
      end
      count_tr += 1
      break if td_select == 1
    end
  end
#####
  step '":path_type"":path_text"の上から":n"番目の":select_box"のセレクトボックスで":select_command"を選択' do |path_type, path_text, n, select_box, select_command|
    puts '"' + path_type + '""' + path_text + '"の上から"' + n + '"番目の"' + select_box + '"のセレクトボックスで"' + select_command + '"を選択'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    unless (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
      td_select = 0
      th = page.find(path_name).all('th').size
      count_th = 0
      count_box = 0
      while count_th < th
        text = page.all('th')[count_th].text
        if text == select_box
          count_box += 1
          if count_box == n.to_i
            count_th += 1 if select_box == '状態' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
            if select_command.empty?
              page.find(path_name).all('td')[count_th].find('select').select_option
              break
            else
              page.find(path_name).all('td')[count_th].find('select').select(select_command)
              break
            end
            td_select = 1
            break
          end
        end
        count_th += 1
      end
    end

    unless td_select == 1
      if path_type == 'class' && path_text == 'search'
        td = page.find('.search').all('td').size
        th = page.find('.search').all('th').size
        count_td = 0
        count_th = 0
        count_box = 0
        number = 0
        if select_box == 'コンセプト選択'
          if current_path.end_with?('/data_files')
            if select_command.empty?
              page.find('.search').all('td')[2].all('option')[0].select_option
              break
            else
              page.find('.search').all('td')[2].find('select').select(select_command)
              break
            end
          end
        else
          while count_th < th
            text = page.find('.search').all('th')[count_th].text
            if text == select_box
              if text == '日付' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                if n == '1'
                  if select_command.empty?
                    page.find(:xpath, '//*[@id="criteria_date_column"]').select(select_command).all('option')[0].select_option
                    break
                  else
                    page.find(:xpath, '//*[@id="criteria_date_column"]').select(select_command)
                    break
                  end
                else
                  if select_command.empty?
                    page.find(:xpath, '//*[@id="criteria_date_operation"]').select(select_command).all('option')[0].select_option
                    break
                  else
                    page.find(:xpath, '//*[@id="criteria_date_operation"]').select(select_command)
                    break
                  end
                end
              elsif text == 'ユーザー' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                if n == '1'
                  if select_command.empty?
                    page.find(:xpath, '//*[@id="criteria_user_operation"]').select(select_command).all('option')[0].select_option
                    break
                  else
                    page.find(:xpath, '//*[@id="criteria_user_operation"]').select(select_command)
                    break
                  end
                else
                  if select_command.empty?
                    page.find(:xpath, '//*[@id="criteria_user_group_id"]').select(select_command).all('option')[0].select_option
                    break
                  else
                    page.find(:xpath, '//*[@id="criteria_user_group_id"]').select(select_command)
                    break
                  end
                end
              elsif text == '公開先' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                if select_command.empty?
                  page.find(:xpath, '//*[@id="criteria_public_destination"]').select(select_command).all('option')[0].select_option
                  break
                else
                  page.find(:xpath, '//*[@id="criteria_public_destination"]').select(select_command)
                  break
                end
              elsif text == 'カテゴリ種別' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                number = n.to_i-1
                if select_command.empty?
                  page.find(:xpath, '//*[@id="criteria_category_type_ids_' + number.to_s + '"]').select(select_command).all('option')[0].select_option
                  break
                else
                  page.find(:xpath, '//*[@id="criteria_category_type_ids_' + number.to_s + '"]').select(select_command)
                  break
                end
              elsif text == 'カテゴリ' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                number = n.to_i-1
                if select_command.empty?
                  page.find(:xpath, '//*[@id="criteria_category_ids_' + number.to_s + '"]').select(select_command).all('option')[0].select_option
                  break
                else
                  page.find(:xpath, '//*[@id="criteria_category_ids_' + number.to_s + '"]').select(select_command)
                  break
                end
              elsif text == '状態' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
                if select_command.empty?
                  page.find(:xpath, '//*[@id="criteria_state"]').select(select_command).all('option')[0].select_option
                  break
                else
                  page.find(:xpath, '//*[@id="criteria_state"]').select(select_command)
                  break
                end
              else
                count_box += 1
                if count_box == n.to_i
                  if count_th >= 2 && current_path.end_with?('/data_files')
                    if select_command.empty?
                      page.find('.search').all('td')[count_th+1].all('option')[0].select_option
                      break
                    else
                      page.find('.search').all('td')[count_th+1].find('select').select(select_command)
                      break
                    end
                  else
                    if select_command.empty?
                      page.find('.search').all('td')[count_th].all('option')[0].select_option
                      break
                    else
                      page.find('.search').all('td')[count_th].find('select').select(select_command)
                      break
                    end
                  end
                end
              end
            end
            count_th += 1
          end
        end
      elsif path_type == 'class' && path_text == 'navi'
        page.find('.navi').find('select').select(select_command)
      else
        if select_box == 'グループ'
          if select_command.empty?
            page.find(path_name).find('#item_creator_attributes_group_id').all('option')[0].select_option
          else
            page.find(path_name).find('#item_creator_attributes_group_id').select(select_command)
          end
        elsif select_box == 'ユーザー'
          if select_command.empty?
            page.find(path_name).find('#item_creator_attributes_user_id').all('option')[0].select_option
          else
            page.find(path_name).find('#item_creator_attributes_user_id').select(select_command)
          end
        elsif select_box == 'コンテンツ'
          if select_command.empty?
            page.find(path_name).find('#target_content_ids').all('option')[0].select_option
          else
            page.find(path_name).find('#target_content_ids').select(select_command)
          end
        elsif select_box == 'ページ'
          if select_command.empty?
            page.find(path_name).find('#target_node_ids').all('option')[0].select_option
          else
            page.find(path_name).find('#target_node_ids').select(select_command)
          end
        elsif select_box == '対象コンセプト'
          if select_command.empty?
            page.find(path_name).find('#item_concept_id').all('option')[0].select_option
          else
            page.find(path_name).find('#item_concept_id').select(select_command)
          end
        elsif select_box == 'コンセプト選択'
          if select_command.empty?
            page.find(path_name).find('#target_concept').all('option')[0].select_option
          else
            page.find(path_name).find('#target_concept').select(select_command)
          end
        elsif select_box == ''
          if select_command.empty?
            page.find(path_name).find('select').all('option')[0].select_option
          else
            page.find(path_name).find('select').select(select_command)
          end
        else
          if select_command.empty?
            page.find(path_name).find(select_box).find('select').all('option')[0].select_option
          else
            page.find(path_name).find(select_box).find('select').select(select_command)
          end
        end
      end
    end
  end

    #追加ボタンを押すことでセレクトボックスが増えるものを選択する場合
  step '上から":n"番目の":path_type"":path_text"のセレクトボックスで":select_command"を選択' do |n, path_type, path_text, select_command|
    puts '上から"' + n + '"番目の"' + path_type + '""' + path_text + '"のセレクトボックスで"' + select_command + '"を選択'

    count = n.to_i - 1
    if path_type == "id" || path_type == "ID"
      select = '#' + path_text
      select(select_command, from: all(select)[count])
    elsif path_type == "class" || path_type == "クラス"
      select = '.' + path_text
      select(select_command, from: all(select)[count])
    elsif path_type == "name"
      select = "select[name='" + path_text + "']"
      all(select)[count].select(select_command)
    end
  end

  #ファイルアップロードを'ID'・'class'・'name'・'xpath'・'cssパス'で指定
  step '":path_type"":path_text"で":item_path"ファイルを選択' do |path_type, path_text, item_path|
    puts '"' + path_type + '""' + path_text + '"で"' + item_path + '"ファイルを選択'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if path_type == 'xpath' || path_type == 'Xpath'
      page.find(:xpath, path_name).set(item_path)
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      page.find(:css, path_name).set(item_path)
    else
      page.find(path_name).set(item_path)
    end
  end
###
  #[ユーザー]-[インポート]の'グループ'・'ユーザー', [ディレクトリ]-[ファイル管理]の'アップロード'等
  #ヘッダ名がファイルアップロードのlabelでない場合もヘッダ名で指定できるようにする
  step '":path_type"":path_text"の":input_value"で":item_path"ファイルを選択' do |path_type, path_text, input_value, item_path|
    puts '"' + path_type + '""' + path_text + '"の"' + input_value + '"で"' + item_path + '"ファイルを選択'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if input_value == 'グループ'
      all('form')[0].attach_file('item_file', item_path)
    elsif input_value == 'ユーザー'
      all('form')[1].attach_file('item_file', item_path)
    elsif input_value == '画像'
      attach_file('file', item_path)
    elsif input_value == 'アップロード'
      attach_file('files', item_path)
    elsif input_value == 'ファイル'
      attach_file('item_file', item_path)
    else
      page.find(path_name).find(input_value).set(item_path)
    end
  end

#####
  step '":input_value"で":item_path"ファイルを選択' do |input_value, item_path|
    puts '"' + input_value + '"で"' + item_path + '"ファイルを選択'

    if input_value == 'グループ'
      all('form')[0].attach_file('item_file', item_path)
    elsif input_value == 'ユーザー'
      all('form')[1].attach_file('item_file', item_path)
    elsif input_value == '画像'
      attach_file('file', item_path)
    elsif input_value == 'アップロード'
      attach_file('files', item_path)
    elsif input_value == 'ファイル'
      attach_file('item_file', item_path)
    else
      page.find(input_value).set(item_path)
    end
  end

  #'item_target'には選択したいラジオボタンの'label'の'text'を入力する
  step 'ラジオボタンの":item_target"を選択' do |item_target|
    puts 'ラジオボタンの"' + item_target + '"を選択'

    choose item_target if item_target.empth?
  end
#####
  step '":path_type"":path"のラジオボタンの":item_target"を選択' do |path_type, path_text, item_target|
    puts '"' + path_type + '""' + path_text + '"のラジオボタンの"' + item_target + '"を選択'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    page.find(path_name).choose(item_target)
  end

  #'text'には指定したいフォームの'text'を, 'form_data'には入力したい内容を入力する
  step '":path_text"に":form_data"を入力' do |path_text, form_data|
    puts '"' + path_text + '"に"' + form_data + '"を入力'

    fill_in path_text, with: form_data
  end
#####
  step '":path_type"":path_text"の上から":n"番目の":form"に":form_data"を入力' do |path_type, path_text, n, form, form_data|
    puts '"' + path_type + '""' + path_text + '"の上から"' + n + '"番目の"' + form + '"に"' + form_data + '"を入力'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    tr = page.find(path_name).all('tr').size
    count_tr = 0
    count_form = 0
    numer = 0
    save_text = ''
    while count_tr < tr
      th = page.find(path_name).all('tr')[count_tr].all('th').size
      count_th = 0
      while count_th < th
        text = page.find(path_name).all('tr')[count_tr].all('th')[count_th].text
        text = 'タイトル' if text == 'タイトル （※入力必須）'
        text = 'サイト名称' if text.include?('サイト名称') && text.include?('※')
        text = 'サイトURL' if text.include?('サイトURL') && text.include?('※')
        if text == 'コンテンツID ※'
          save_text = text
          text = 'コンテンツID'
        end
        if text == 'コンテンツ名 ※'
          save_text = text
          text = 'コンテンツ名'
        end
        if text == form
          count_form += 1
          if text == '日付' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
            number = n.to_i-1
            page.find(:xpath, '//*[@id="criteria_dates_' + number.to_s + '"]').set(form_data)
          elsif text == 'ユーザー' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
            page.find(:xpath, '//*[@id="criteria_user_name"]').set(form_data)
          elsif text == 'タイトル・内容・ディレクトリ名など' && (current_path.start_with?('/_system/gp_article') || current_path.start_with?('/_admin/gp_article')) && current_path.end_with?('/docs')
            page.find(:xpath, '//*[@id="criteria_free_word"]').set(form_data)
          elsif count_form == n.to_i
            if form == '期間'
              page.find(path_name).all('td')[count_th].find('#start_date').set(form_data)
              page.find(path_name).all('td')[count_th].find('#close_date').set(form_data)
            else
              doc = Nokogiri::HTML.parse(html).css(path_name).css('tr')[count_tr].css('th')[count_th].inner_html
              if doc.include?('label')
                if save_text == 'コンテンツID ※'
                  page.find('#item_code').set(form_data)
                elsif save_text == 'コンテンツ名 ※'
                  page.find('#item_name').set(form_data)
                else
                  fill_in form, with: form_data
                end
                if form == '公開日' || form == '公開開始日時' || form == '公開終了日時'
                  page.driver.click(401, 0)
                end
              else
                doc = Nokogiri::HTML.parse(html).css(path_name).css('tr')[count_tr].css('td')[count_th].to_html
                if doc.include?('input')
                  page.find(path_name).all('tr')[count_tr].all('td')[count_th].find('input').set(form_data)
                elsif doc.include?('textarea')
                  page.find(path_name).all('tr')[count_tr].all('td')[count_th].find('textarea').set(form_data)
                end
              end
            end
          end
        end
        count_th += 1
      end
      count_tr += 1
    end
  end
#####
  step 'タブ":tab_text"の上から":n"番目の":form"に":form_data"を入力' do |tab_text, n, form, form_data|
    puts 'タブ"' + tab_text + '"の上から"' + n + '"番目の"' + form + '"に"' + form_data + '"を入力'

    tabs_count = 0
    tabs = Nokogiri::HTML.parse(html).css('#contentBody').css('#tabs').css('ul').css('a').to_html
    tabs_all = tabs.scan(/<\/a>/).size
    while tabs_count < tabs_all
      text = Nokogiri::HTML.parse(html).css('#contentBody').css('#tabs').css('ul').css('a')[tabs_count].text
      if text == tab_text
        doc = Nokogiri::HTML.parse(html).css('#contentBody').css('#tabs').css('ul').css('a')[tabs_count].to_html
        tab_name = doc[/\<a href=\"(\#\w+)\"/, 1]
        break
      end
      tabs_count += 1
    end

    tr = page.find('#contentBody').find(tab_name).all('tr').size
    count_n = 0
    count_tr = 0
    while count_tr < tr
      th = page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('th').size
      count_th = 0
      while count_th < th
        text = page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('th')[count_th].text
        text = 'タイトル' if text == 'タイトル （※入力必須）'
        if text == form
          count_n += 1
          if count_n == n.to_i
            if tab_text == '地図' && form == '座標'
              data = form_data.split('.')
              p data
              page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('td')[count_th].all('input')[0].set(data[0])
              if data[1] != nil
                page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('td')[count_th].all('input')[1].set(data[1])
              else
                page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('td')[count_th].all('input')[1].set('0')
              end
            else
              doc = Nokogiri::HTML.parse(html).css('#contentBody').css(tab_name).css('tr')[count_tr].css('th')[count_th].to_html
              if doc.include?('label')
                fill_in form, with: form_data
                if form == '公開日' || form == '公開開始日時' || form == '公開終了日時'
                  page.driver.click(0, 61)
                end
              else
                doc = Nokogiri::HTML.parse(html).css('#contentBody').css(tab_name).css('tr')[count_tr].css('td')[count_th].to_html
                if doc.include?('input')
                  page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('td')[count_th].find('input').set(form_data)
                elsif doc.include?('textarea')
                  page.find('#contentBody').find(tab_name).all('tr')[count_tr].all('td')[count_th].find('textarea').set(form_data)
                end
              end
            end
          end
        end
        count_th += 1
      end
      count_tr += 1
    end
  end

  #'path_type'には'ID'・'label'・'name'・'xpath'・'cssパス'のいずれかを入力する
  step '":path_type"":path_text"に":form_data"を入力' do |path_type, path_text, form_data|
    puts '"' + path_type + '""' + path_text + '"に"' + form_data + '"を入力'

    if path_type == 'xpath' || path_type == 'Xpath'
      page.find(:xpath, path_text).set(form_data)
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      page.find(path_text).set(form_data)
    else
      fill_in path_text, with: form_data
    end
  end
###
  #'target'には指定したいチェックボックスの'label'の'text'を, 'on_off'には'入れる'・'はずす'のいずれかを入力する
  step '":target"のチェックを":on_off"' do |target, on_off|
    puts '"' + target + '"のチェックを"' + on_off + '"'

    if target == 'レイアウト' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(false)
      end
    elsif target == 'ピース' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(false)
      end
    else
      if on_off == '入れる'
        check target
      elsif on_off == 'はずす'
        uncheck target
      end
    end
  end
#####
  step '":path_type"":path_text"で":target"のチェックを":on_off"' do |path_type, path_text, target, on_off|
    puts '"' + path_type + '""' + path_text + '"で"' + target + '"のチェックを"' + on_off + '"'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end
    if target == 'レイアウト' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(false)
      end
    elsif target == 'ピース' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(false)
      end
    else
      if on_off == '入れる'
        page.find(path_name).check(target)
      elsif on_off == 'はずす'
        page.find(path_name).uncheck(target)
      end
    end
  end
###
  #チェックボックスを'xpath'・'cssパス'で指定
  step '":path_type"":path_text"のチェックを":on_off"' do |path_type, path_text, on_off|
    puts '"' + path_type + '""' + path_text + '"のチェックを"' + on_off + '"'

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if target == 'レイアウト' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][layout]']").set(false)
      end
    elsif target == 'ピース' && current_path.end_with?('/cms/tool_export')
      if on_off == '入れる'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(true)
      elsif on_off == 'はずす'
        page.find(path_name).find(:xpath, "//input[@name='item[target][piece]']").set(false)
      end
    else
      if path_type == 'xpath' || path_type == 'Xpath'
        if on_off == '入れる'
          page.find(:xpath, path_name).set(true)
        elsif on_off == 'はずす'
          page.find(:xpath, path_name).set(false)
        end
      elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
        if on_off == '入れる'
          page.find(:css, path_name).set(true)
        elsif on_off == 'はずす'
          page.find(:css, path_name).set(false)
        end
      else
        if on_off == '入れる'
          page.find(path_name).set(true)
        elsif on_off == 'はずす'
          page.find(path_name).set(false)
        end
      end
    end
  end

  #現在のURLが'page_url'と完全一致することを確認
  #'yes_no'には'ある'・'ない'のどちらかを入れる
  step 'URLが":page_url"で":yes_no"ことを確認' do |page_url, yes_no|
    puts 'URLが"' + page_url + '"で"' + yes_no + '"ことを確認'

    if yes_no == 'ある'
      expect(current_path).to eq(page_url)
    elsif yes_no == 'ない'
      expect(current_path).to_not eq(page_url)
    end
  end

  #現在のURLに'page_url'が含まれることを確認
  #'yes_no'には'いる'・'いない'のどちらかを入れる
  step 'URLに":page_url"が含まれて":yes_no"ことを確認' do |page_url, yes_no|
    puts 'URLに"' + page_url + '"が含まれて"' + yes_no + '"ことを確認'

    if yes_no == 'いる'
      expect(current_path).to include(page_url)
    elsif yes_no == 'いない'
      uexpect(current_path).to_not include(page_url)
    end
  end

  #現在のURLが'page_url'で始まる, あるいは終わることを確認
  #'head_tail'には'冒頭'・'末尾'のどちらかを入れる
  #'yes_no'には'ある'・'ない'のどちらかを入れる
  step 'URLの":head_tail"が":page_url"で":yes_no"ことを確認' do |head_tail, page_url, yes_no|
    puts 'URLの"' + head_tail + '"が"' + page_url + '"で"' + yes_no + '"ことを確認'

    if head_tail == '冒頭' || head_tail == '始め'
      if yes_no == 'ある'
        expect(current_path).to start_with(page_url)
      elsif yes_no == 'ない'
        expect(current_path).to_not start_with(page_url)
      end
    elsif head_tail == '末尾' || head_tail == '終わり'
      if yes_no == 'ある'
        expect(current_path).to end_with(page_url)
      elsif yes_no == 'ない'
        expect(current_path).to_not end_with(page_url)
      end
    end
  end

  #記事などのプレビュー画面を表示したときの確認
  step 'プレビュータブ":page_url"の確認' do |page_url|
    puts 'プレビュータブ"' + page_url + '"の確認'

    handle = page.driver.browser.window_handles.last

    page.driver.browser.within_window(handle) do
      expect(current_path).to eq(page_url)
      page.save_screenshot "public/screenshot/preview.png", full: true, js: true
    end
  end

  #ページ上に表示されている文字列の確認(部分一致)
  #'text'には検索したい文字列を, 'yes_no'には'ある'・'ない'のいずれかを入力する
  #基本的には表示されているページ全体から探す
  #テーブル内の要素の表示確認は別の処理を追加したためそちらの使用を推奨
  step '":place"内に":text"の表示が":yes_no"ことを確認' do |place, text, yes_no|
    puts '"' + place + '"内に"' + text + '"の表示が"' + yes_no + '"ことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if current_path == '/_system/cms/tool_search' || current_path == '/_admin/cms/tool_search' || place == 'テーブル'
      if yes_no == 'ある'
        expect(page).to have_selector('td', text: /\A.*#{text}.*\Z/)
      elsif yes_no == 'ない'
        expect(page).to have_no_selector('td', text: /\A.*#{text}.*\Z/)
      end
    elsif place == '添付ファイル'
      within_frame(page.all('iframe', visible: false)[0]) do
        if yes_no == 'ある'
          expect(page).to have_content(/\A.*#{text}.*\Z/)
        elsif yes_no == 'ない'
          expect(page).to have_no_content(/\A.*#{text}.*\Z/)
        end
      end
    elsif text == 'バージョン情報'
      if yes_no == 'いる'
        expect(page.find(".version").text).to have_content(/\A.*Ver\.\d+\.\d+\.\d+\sbuild-\d+.*\Z/)
      elsif yes_no == 'いない'
        expect(page.find(".version").text).to_not have_content(/\A.*Ver\.\d+\.\d+\.\d+\sbuild-\d+.*\Z/)
      end
    else
      if yes_no == 'ある'
        expect(page).to have_content(/\A.*#{text}.*\Z/)
      elsif yes_no == 'ない'
        expect(page).to have_no_content(/\A.*#{text}.*\Z/)
      end
    end
  end

  #ページ上に表示されている文字列の確認(部分一致)
  #'ID'・'label'・'xpath'・'cssパス'の'text'を画面上の指定された場所から探し確認する
  step 'ページ内":path_type"":path_text"のテキストに":text"が含まれて":yes_no"ことを確認' do |path_type, path_text, text, yes_no|
    puts 'ページ内"' + path_type + '""' + path_text + '"のテキストに"' + text + '"が含まれて"' + yes_no + '"ことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    elsif path_type == 'ID' || path_type == 'id'
      path_name = '#' + path_text
    else
      path_name = path_text
    end

    if path_type == 'xpath' || path_type == 'Xpath'
      if yes_no == 'いる'
        expect(page.find(:xpath, path_name)).to have_content(/\A.*#{text}.*\Z/)
      elsif yes_no == 'いない'
        expect(page.find(:xpath, path_name)).to_not have_content(/\A.*#{text}.*\Z/)
      end
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      if yes_no == 'いる'
        expect(page.find(:css, path_name)).to have_content(/\A.*#{text}.*\Z/)
      elsif yes_no == 'いない'
        expect(page.find(:css, path_name)).to_not have_content(/\A.*#{text}.*\Z/)
      end
    else
      if yes_no == 'いる'
        expect(page.find(path_name).text).to have_content(/\A.*#{text}.*\Z/)
      elsif yes_no == 'いない'
        expect(page.find(path_name).text).to_not have_content(/\A.*#{text}.*\Z/)
      end
    end
  end

  #ページ上に表示されている文字列の確認(完全一致)
  #'ID'・'class'・'label'・'xpath'・'cssパス'の'text'を画面上の指定された場所から探し確認する
  step 'ページ内":path_type"":path_text"のテキストが":text"で":yes_no"ことを確認' do |path_type, path_text, text, yes_no|
    puts 'ページ内"' + path_type + '""' + path_text + '"のテキストが"' + text + '"で"' + yes_no + '"ことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    elsif path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    else
      path_name = path_text
    end

    if path_type == 'xpath' || path_type == 'Xpath'
      if yes_no == 'ある'
        expect(page.find(:xpath, path_name)).to have_content(/\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page.find(:xpath, path_name)).to_not have_content(/\A#{text}\Z/)
      end
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      if yes_no == 'ある'
        expect(page.find(:css, path_name)).to have_content(/\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page.find(:css, path_name)).to_not have_content(/\A#{text}\Z/)
      end
    else
      if yes_no == 'ある'
        expect(page.find(path_name).text).to have_content(/\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page.find(path_name).text).to_not have_content(/\A#{text}\Z/)
      end
    end
  end

  #ページ上に表示されている文字列の確認(完全一致)
  #文字列の場所を'xpath'・'cssパス'で指定
  step 'ページ内":path_type"":path_text"のテキストが入っていないことを確認' do |path_type, path_text|
    puts 'ページ内"' + path_type + '""' + path_text + '"のテキストが入っていないことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if path_type == 'id' || path_type == 'ID'
      path_name = '#' + path_text
    elsif path_type == 'class' || path_type == 'クラス'
      path_name = '.' + path_text
    else
      path_name = path_text
    end

    if path_type == 'xpath' || path_type == 'Xpath'
      expect(page.find(:xpath, path_text)).to have_content(/\A\Z/)
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      expect(page.find(:css, path_text)).to have_content(/\A\Z/)
    else
      expect(page.find(path_name).text).to_not have_content(/\A\Z/)
    end
  end

  #フォームに入力されている文字列の確認(部分一致)
  #'ID'・'name'・'label'・'xpath'・'cssパス'の'text'のいずれかを指定することで指定したいフォームが検索できる
  step '":path_type"":path_text"の中身に":text"が含まれて":yes_no"ことを確認' do |path_type, path_text, text, yes_no|
    puts '"' + path_type + '""' + path_text + '"の中身に"' + text + '"が含まれて"' + yes_no + '"ことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if path_type == 'xpath' || path_type == 'Xpath'
      if yes_no == 'いる'
        expect(page.find(:xpath, path_text).value).to match /\A.*#{text}.*\Z/
      elsif yes_no == 'いない'
        expect(page.find(:xpath, path_text).value).to_not match /\A.*#{text}.*\Z/
      end
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      if yes_no == 'いる'
        expect(page.find(:css, path_text).value).to match /\A.*#{text}.*\Z/
      elsif yes_no == 'いない'
        expect(page.find(:css, path_text).value).to_not match /\A.*#{text}.*\Z/
      end
    else
      if yes_no == 'いる'
        expect(page).to have_field path_text, with: /\A.*#{text}.*\Z/
      elsif yes_no == 'いない'
        expect(page).to_not have_field path_text, with: /\A.*#{text}.*\Z/
      end
    end
  end

  #フォームの入力内容確認(完全一致)
  #文字列の場所を'xpath'・'cssパス'で指定
  #'yes_no'には'ある'・'ない'のいずれかを入力する
  step '":path_type"":path_text"の中身が":text"で":yes_no"ことを確認' do |path_type, path_text, text, yes_no|
    puts '"' + path_type + '""' + path_text + '"の中身が"' + text + '"で"' + yes_no + '"ことを確認'

    text.gsub!(/[\(\)\[\]\{\}\.\?\+\*\|\\]/,
      "(" => "\\\(", ")" => "\\\)", "[" => "\\\[", "]" => "\\\]", "{" => "\\\{", "}" => "\\\}", "." => "\\\.", "?" => "\\\?", "+" => "\\\+", "*" => "\\\*", "|" => "\\\|", "\\" => "\\\\" )

    if path_type == 'xpath' || path_type == 'Xpath'
      if yes_no == 'ある'
        expect(page.find(:xpath, path_text)).to have_content(/\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page.find(:xpath, path_text)).to_not have_content(/\A#{text}\Z/)
      end
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      if yes_no == 'ある'
        expect(page.find(:css, path_text)).to have_content(/\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page.find(:css, path_text)).to_not have_content(/\A#{text}\Z/)
      end
    else
      if yes_no == 'ある'
        expect(page).to have_field(path_text, with: /\A#{text}\Z/)
      elsif yes_no == 'ない'
        expect(page).to_not have_field(path_text, with: /\A#{text}\Z/)
      end
    end
  end

  #フォームが空であることの確認(完全一致)
  #'text_box'には'id'・'name'・'label'・'xpath'・'cssパス'のいずれかを入力する
  step '":path_type"":path_text"の中身が入っていないことを確認' do |path_type, path_text|
    puts '"' + path_type + '""' + path_text + '"の中身が入っていないことを確認'

    if path_type == 'xpath' || path_type == 'Xpath'
      expect(page.find(:xpath, path_text)).to have_content(/\A\Z/)
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      expect(page.find(:css, path_text)).to have_content(/\A\Z/)
    else
      expect(page).to have_field(path_text, with: /\A\Z/)
    end
  end

  #'target_name'にはチェックボックスの'label'の'text'・'ID'・'name'を, 'yes_no'には'いる'・'いない'のいずれかを入力する
  step '":target_name"のチェックが入って":yes_no"ことを確認' do |target_name, yes_no|
    puts '"' + target_name + '"のチェックが入って"' + yes_no + '"ことを確認'

    if yes_no == 'いる'
      expect(page).to have_checked_field(target_name)
    elsif yes_no == 'いない'
      expect(page).to have_unchecked_field(target_name)
    end
  end

  #'yes_no'には'ある'・'ない'のいずれかを入力する
  step 'ラジオボタンの選択が":item_target"で":yes_no"ことを確認' do |item_target, yes_no|
    puts 'ラジオボタンの選択が"' + item_target + '"で"' + yes_no + '"ことを確認'

    if yes_no == 'ある'
      expect(page).to have_checked_field(item_target)
    elsif yes_no == 'ない'
      expect(page).to have_no_checked_field(item_target)
    end
  end

  #ラジオボタンを'xpath'・'cssパス'で指定
  step 'ラジオボタンの選択が":path_type"":path_text"で":yes_no"ことを確認' do |path_type, path_text, yes_no|
    puts 'ラジオボタンの選択が"' + path_type + '""' + path_text + '"で"' + yes_no + '"ことを確認'

    if path_type == 'xpath' || path_type == 'Xpath'
      if yes_no == 'ある'
        expect(page).to have_checked_field(:xpath, path_text)
      elsif yes_no == 'ない'
        expect(page).to have_no_checked_field(:xpath, path_text)
      end
    elsif path_type == 'css' || path_type == 'cssパス' || path_type == 'csspath'
      if yes_no == 'ある'
        expect(page).to have_checked_field(:css, path_text)
      elsif yes_no == 'ない'
        expect(page).to have_no_checked_field(:css, path_text)
      end
    else
      if yes_no == 'ある'
        expect(page).to have_checked_field(path_text)
      elsif yes_no == 'ない'
        expect(page).to have_no_checked_field(path_text)
      end
    end
    end

  #'class'が'index'のテーブルのデータを確認
  #'yes_no'には'ある'・'ない'のいずれかを入力する
  step 'indexテーブルの":x"段目の左から":y"列目が":td"で":yes_no"ことを確認' do |x, y, td, yes_no|
    puts 'indexテーブルの"' + x + '"段目の左から"' + y + '"列目が"' + td + '"で"' + yes_no + '"ことを確認'

    high = x.to_i
    wide = y.to_i - 1
    if yes_no == 'ある'
      expect(page.find('.index').all('tr')[high].all('td')[wide].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index').all('tr')[high].all('td')[wide].text).to_not eq(td)
    end
  end

  #indexテーブルが同一ページに複数あるときの処理
  step '上から":n"番目のindexテーブルの":x"段目の左から":y"列目が":td"で":yes_no"ことを確認' do |n, x, y, td, yes_no|
    puts '上から"' + n + '"番目のindexテーブルの"' + x + '"段目の左から"' + y + '"列目が"' + td + '"で"' + yes_no + '"ことを確認'

    number = n.to_i - 1
    high = x.to_i
    wide = y.to_i - 1
    if yes_no == 'ある'
      expect(page.all('.index')[number].all('tr')[high].all('td')[wide].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index')[number].all('tr')[high].all('td')[wide].text).to_not eq(td)
    end
  end
#####
  step '上から":n"番目のindexテーブルのヘッダ名":th"にデータ":td"が":yes_no"ことを確認' do |n, th, td, yes_no|
    puts '上から"' + n + '"番目のindexテーブルのヘッダ名"' + th + '"にデータ"' + td + '"が"' + yes_no + '"ことを確認'

    high = page.all('.index')[n.to_i-1].all('tr').size - 1
    wide = page.all('.index')[n.to_i-1].all('th').size - 1
    count_th = 0
    count_td = 1

    while count_th < wide
      text = page.all('.index')[n.to_i-1].all('th')[count_th].text
      break if text == th
      count_th += 1
    end

    while count_td < high
      text = page.all('.index')[n.to_i-1].all('tr')[count_td].all('td')[count_th].text
      break if text == td
      count_td += 1
    end

    if yes_no == 'ある'
      expect(page.all('.index')[n.to_i-1].all('tr')[count_td].all('td')[count_th].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.all('.index')[n.to_i-1].all('tr')[count_td].all('td')[count_th].text).to_not eq(td)
    end
  end
#####
  step 'indexテーブルのヘッダ名":th"にデータ":td"が":yes_no"ことを確認' do |th, td, yes_no|
    td = $gp_article_num if td == '$gp_article_num'
    td = $gp_article_url if td == '$gp_article_url'
    td = $gp_article_title if td == '$gp_article_title'
    td = $gp_article_directory if td == '$gp_article_directory'
    td = $gp_article_make if td == '$gp_article_make'
    td = $gp_article_update if td == '$gp_article_update'
    puts 'indexテーブルのヘッダ名"' + th + '"にデータ"' + td + '"が"' + yes_no + '"ことを確認'

    high = page.find('.index').all('tr').size - 1
    wide = page.find('.index').all('th').size - 1
    count_th = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s)if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').size - 1
      while count_td < high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th].text
          if text == td
            breaker = 1
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle != count_all
      count_gparticle += 1
    end

    if yes_no == 'ある'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to_not eq(td)
    end
  end
#####
  step 'indexテーブルのth":th1"が":td1"のときヘッダ名":th"にデータ":td"が":yes_no"ことを確認' do |th1, td1, th, td, yes_no|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    td = $gp_article_num if td == '$gp_article_num'
    td = $gp_article_url if td == '$gp_article_url'
    td = $gp_article_title if td == '$gp_article_title'
    td = $gp_article_directory if td == '$gp_article_directory'
    td = $gp_article_make if td == '$gp_article_make'
    td = $gp_article_update if td == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"のときヘッダ名"' + th + '"にデータ"' + td + '"が"' + yes_no + '"ことを確認'

    wide = page.find('.index').all('th').size - 1
    high = page.find('.index').all('tr').size - 1
    count_th = 0
    count_th1 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s) if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').size - 1
      while count_td < high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            text = page.find('.index').all('tr')[count_td].all('td')[count_th].text
            if text == td
              breaker = 1
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle != count_all
      count_gparticle += 1
    end

    if yes_no == 'ある'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to_not eq(td)
    end
  end
#####
  step 'indexテーブルのth":th1"が":td1"かつth":th2"が":td2"のときヘッダ名":th"にデータ":td"が":yes_no"ことを確認' do |th1, td1, th2, td2, th, td, yes_no|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    td2 = $gp_article_num if td2 == '$gp_article_num'
    td2 = $gp_article_url if td2 == '$gp_article_url'
    td2 = $gp_article_title if td2 == '$gp_article_title'
    td2 = $gp_article_directory if td2 == '$gp_article_directory'
    td2 = $gp_article_make if td2 == '$gp_article_make'
    td2 = $gp_article_update if td2 == '$gp_article_update'
    td = $gp_article_num if td == '$gp_article_num'
    td = $gp_article_url if td == '$gp_article_url'
    td = $gp_article_title if td == '$gp_article_title'
    td = $gp_article_directory if td == '$gp_article_directory'
    td = $gp_article_make if td == '$gp_article_make'
    td = $gp_article_update if td == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"かつth"' + th2 + '"が"' + td2 + '"のときヘッダ名"' + th + '"にデータ"' + td + '"が"' + yes_no + '"ことを確認'

    wide = page.find('.index').all('th').size - 1
    high = page.find('.index').all('tr').size - 1
    count_th = 0
    count_th1 = 0
    count_th2 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      break if text == th
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end
    while count_th2 < wide
      text = page.find('.index').all('th')[count_th2].text
      break if text == th2
      count_th2 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s) if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').size - 1
      while count_td < high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            text = page.find('.index').all('tr')[count_td].all('td')[count_th2].text
            if text == td2
              text = page.find('.index').all('tr')[count_td].all('td')[count_th].text
              if text == td
                breaker = 1
              end
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle < count_all
      count_gparticle += 1
    end

    if yes_no == 'ある'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to_not eq(td)
    end
  end
#####
  step 'indexテーブルのth":th1"が":td1"かつth":th2"が":td2"かつth":th3"が":td3"のときヘッダ名":th"にデータ":td"が":yes_no"ことを確認' do |th1, td1, th2, td2, th3, td3, th, td, yes_no|
    td1 = $gp_article_num if td1 == '$gp_article_num'
    td1 = $gp_article_url if td1 == '$gp_article_url'
    td1 = $gp_article_title if td1 == '$gp_article_title'
    td1 = $gp_article_directory if td1 == '$gp_article_directory'
    td1 = $gp_article_make if td1 == '$gp_article_make'
    td1 = $gp_article_update if td1 == '$gp_article_update'
    td2 = $gp_article_num if td2 == '$gp_article_num'
    td2 = $gp_article_url if td2 == '$gp_article_url'
    td2 = $gp_article_title if td2 == '$gp_article_title'
    td2 = $gp_article_directory if td2 == '$gp_article_directory'
    td2 = $gp_article_make if td2 == '$gp_article_make'
    td2 = $gp_article_update if td2 == '$gp_article_update'
    td3 = $gp_article_num if td3 == '$gp_article_num'
    td3 = $gp_article_url if td3 == '$gp_article_url'
    td3 = $gp_article_title if td3 == '$gp_article_title'
    td3 = $gp_article_directory if td3 == '$gp_article_directory'
    td3 = $gp_article_make if td3 == '$gp_article_make'
    td3 = $gp_article_update if td3 == '$gp_article_update'
    td = $gp_article_num if td == '$gp_article_num'
    td = $gp_article_url if td == '$gp_article_url'
    td = $gp_article_title if td == '$gp_article_title'
    td = $gp_article_directory if td == '$gp_article_directory'
    td = $gp_article_make if td == '$gp_article_make'
    td = $gp_article_update if td == '$gp_article_update'
    puts 'indexテーブルのth"' + th1 + '"が"' + td1 + '"かつth"' + th2 + '"が"' + td2 + '"かつth"' + th3 + '"が"' + td3 + '"のときヘッダ名"' + th + '"にデータ"' + td + '"が"' + yes_no + '"ことを確認'

    wide = page.find('.index').all('th').size - 1
    high = page.find('.index').all('tr').size - 1
    count_th = 0
    count_th1 = 0
    count_th2 = 0
    count_th3 = 0
    count_td = 1
    breaker = 0
    if (current_path.include?('/_system/gp_article/') == true || current_path.include?('/_admin/gp_article/') == true) && current_path.include?('/content_settings') == false
      count_all = page.find('.count').text.to_i
      count_all = count_all / 30 + 1
    else
      count_all = 1
    end
    count_gparticle = 1

    while count_th < wide
      text = page.find('.index').all('th')[count_th].text
      if text == th
        break
      end
      count_th += 1
    end
    while count_th1 < wide
      text = page.find('.index').all('th')[count_th1].text
      break if text == th1
      count_th1 += 1
    end
    while count_th2 < wide
      text = page.find('.index').all('th')[count_th2].text
      break if text == th2
      count_th2 += 1
    end
    while count_th3 < wide
      text = page.find('.index').all('th')[count_th3].text
      break if text == th3
      count_th3 += 1
    end

    while count_gparticle <= count_all
      puts ('page' + count_gparticle.to_s) if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/'))
      count_td = 1
      high = page.find('.index').all('tr').size - 1
      while count_td < high
        doc = Nokogiri::HTML.parse(html).css('.index').css('tr')[count_td].inner_html
        if doc.include?('colspan') == false
          text = page.find('.index').all('tr')[count_td].all('td')[count_th1].text
          if text == td1
            text = page.find('.index').all('tr')[count_td].all('td')[count_th2].text
            if text == td2
              text = page.find('.index').all('tr')[count_td].all('td')[count_th3].text
              if text == td3
                text = page.find('.index').all('tr')[count_td].all('td')[count_th].text
                if text == td
                  breaker = 1
                end
              end
            end
          end
        end
        break if breaker == 1
        count_td += 1
      end
      break if breaker == 1
      page.find('.pagination').click_on('次へ') if (current_path.include?('/_system/gp_article/') || current_path.include?('/_admin/gp_article/')) && count_gparticle < count_all
      count_gparticle += 1
    end

    if yes_no == 'ある'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.find('.index').all('tr')[count_td].all('td')[count_th].text).to_not eq(td)
    end
  end
###
  #'class'が'show'のテーブルのデータで, ヘッダと入力内容が対応しているかを確認
  #'yes_no'には'ある'・'ない'のいずれかを入力する
  step 'ヘッダ名が":th"のデータが":td"で":yes_no"ことを確認' do |th, td, yes_no|
    td = $gp_article_num if td == '$gp_article_num'
    td = $gp_article_url if td == '$gp_article_url'
    td = $gp_article_title if td == '$gp_article_title'
    td = $gp_article_directory if td == '$gp_article_directory'
    td = $gp_article_make if td == '$gp_article_make'
    td = $gp_article_update if td == '$gp_article_update'
    puts 'ヘッダ名が"' + th + '"のデータが"' + td + '"で"' + yes_no + '"ことを確認'

    x = 1
    count = 0
    num = 0
    data = ''
    while x == 1 do
      size = page.all('tr')[count].all('th').size
      num = size.to_i - 1
      while num >= 0
        data = page.all('tr')[count].all('th')[num].text
        break if data == th
        num -= 1
      end
      if th == '内容' && count > 0 || th == '携帯用内容' && count > 0
        data = page.all('tr')[count-1].all('th')[num].text
      end
      break if data == th
      count += 1
    end
    if yes_no == 'ある'
      expect(page.all('tr')[count].all('td')[num].text).to eq(td)
    elsif yes_no == 'ない'
      expect(page.all('tr')[count].all('td')[num].text).to_not eq(td)
    end
  end
#####
  step 'ヘッダ名":th"が":yes_no"ことを確認' do |th, yes_no|
    puts 'ヘッダ名"' + th + '"が"' + yes_no + '"ことを確認'

    x = 1
    count = 0
    num = 0
    data = ''
    while x == 1 do
      size = page.all('tr')[count].all('th').size
      num = size.to_i - 1
      while num >= 0
        data = page.all('tr')[count].all('th')[num].text
        break if data == th
        num -= 1
      end
      if th == '内容' && count > 0 || th == '携帯用内容' && count > 0
        data = page.all('tr')[count-1].all('th')[num].text
      end
      break if data == th
      count += 1
    end
    if yes_no == 'ある'
      expect(data).to eq(th)
    elsif yes_no == 'ない'
      expect(data).to_not eq(th)
    end
  end

  #記事一覧の'#contentHeader'のいずれかが選択されているとき表示されている記事が正常に絞り込めているかの確認
  #'content_title'には'状態'・'所属'を, 'yex_no'には'ある'・'ない'のいずれかを入力する
  #'content_item'には'#contentHeader'の'新規作成'以外の'text'のいずれかを入力する
  step '":content_title"が":content_item"で":yes_no"ことを確認' do |content_title, content_item, yes_no|
    puts '"' + content_title + '"が"' + content_item + '"で"' + yes_no + '"ことを確認'

    if content_title == '状態' && content_item == '公開前'
      count = page.all('td', text: '下書き').size
      count += page.all('td', text: '公開待ち').size
      count += page.all('td', text: '承認待ち').size
      count += page.all('td', text: '公開日時待ち').size
      if yes_no == 'ある'
        expect(page.all(:link, text: '詳細').size).to eq(count)
      elsif yes_no == 'ない'
        expect(page.all(:link, text: '詳細').size).to_not eq(count)
      end
    elsif content_title == '状態' && content_item == '全記事'
      count = page.all('td', text: '下書き').size
      count += page.all('td', text: '公開待ち').size
      count += page.all('td', text: '承認待ち').size
      count += page.all('td', text: '公開日時待ち').size
      count += page.all('td', text: '公開中').size
      count += page.all('td', text: '公開終了').size
      if yes_no == 'ある'
        expect(page.all(:link, text: '詳細').size).to eq(count)
      elsif yes_no == 'ない'
        expect(page.all(:link, text: '詳細').size).to_not eq(count)
      end
    elsif content_title == '所属' && content_item == '全所属'
      page.should have_button('拡張検索')
      click_link '拡張検索'
      texts = nil
      within page.find_field('criteria[user_group_id]', visible: false) do
        texts = page.all('option', visible: false).map(&:text)
      end
      texts.uniq!
      page.should have_button('拡張検索')
      click_link '基本検索'
      n = 1
      count = 0
      equal = 0
      text = nil
      login = page.find('.loginGroup').text
      loop do
        text = page.find('table', class: 'index').all('tr')[n].all('td')[4].text
        num = 1
        loop do
          equal = 1 if texts[num] == login
          if text == texts[num]
            count += 1
            break
          end
          num += 1
          break if texts[num].nil?
        end
        n += 1
        break if page.find('table', class: 'index').all('tr')[n].nil?
      end
      count += page.all('td', text: login).size if equal == 0
      if yes_no == 'ある'
        expect(page.all(:link, text: '詳細').size).to eq(count)
      elsif yes_no == 'ない'
        expect(page.all(:link, text: '詳細').size).to_not eq(count)
      end
    else
      if yes_no == 'ある'
        expect(page.all(:link, text: '詳細').size).to eq(page.all('td', text: content_item).size)
      elsif yes_no == 'ない'
        expect(page.all(:link, text: '詳細').size).to_not eq(page.all('td', text: content_item).size)
      end
    end
  end
end




