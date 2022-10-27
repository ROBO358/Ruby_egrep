print ARGV[1], "ファイルより、正規表現(/", ARGV[0], "/)を実行します。\n"

# コマンドライン引数をわかりやすく変数へ
filename = ARGV[1].to_s

begin
  regexp = Regexp.new(ARGV[0])
rescue
  print($!.to_s + "\n")
  exit(-1)
end

begin
  # 検索対象の文章をファイルから読み込み
  f = File.open(filename, "r")
rescue
  print($!.to_s + "\n")
  exit(-1)
end

# 一行ずつ照会
f.each{|line|
  # 一致する場合
  if !(regexp =~ line).nil? # 正規表現を照会した結果indexが帰ってきた場合
    # 一致する行を出力
    print line
  end
}

# ファイルを閉じる
f.close
