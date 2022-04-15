require 'open-uri'
require 'nokogiri'

uri = "https://nlftp.mlit.go.jp/ksj/gml/codelist/PrefCd.html"

body = ""
charset = ""
# Nokogiriの設定　readで文字列に直す
open(uri) { |go|
  body = go.read
  charset = go.charset
}
html = Nokogiri::HTML.parse(body, nil, charset)

# trの塊で取得
tr=html.css('tr').text
prefectures = []
prefectures = tr.split.sort

# 不要な情報の削除
prefectures.slice!(47,51)
pre = []

# 取得
prefectures.each do |prefecture|
  prefecture.delete if prefecture.empty?    
  pre_code=prefecture.slice(0..1)
  pre_name=prefecture.slice(2..-1)
  ans = pre_code+ "," + pre_name
  pre.push(ans)
end

puts pre



