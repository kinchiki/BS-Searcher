require 'anemone'

# Anemoneのメイン処理の流れ p.73
# 4か5は通常どちらか一つ
# 4か5がメイン処理

# 1. 巡回対象サイトのURLを指定
Anemone.crawl("http://examole.com") do |anemone|

  # 2. 除外対象ページのURLパターンを指定
  anemone.skip_links_like /除外対象のURLパターン/

  # 3. 巡回対象ページのURLを指定
  anemone.focus_crawl do |page|
    page.links # => Array of links
  end

  # 4. 正規表現で一致したページのみ処理
  anemone.on_pages_like(/処理対象のURLパターン/) do |page|
    # ページに対する処理の記述
  end

  # 5. すべてのページに対しての処理
  anemone.on_every_page do |page|
    # ページに対する処理の記述
  end

  # 6. ストレージに対する処理
  anemone.after_crawl do |page|
    # ストレージに対する処理の記述
  end

end