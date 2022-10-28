class EGREP
  def initialize
    # コマンドライン引数をわかりやすく変数へ

    # ファイル名を取得
    _err, @filename = filename_extraction(ARGV)
    if !_err.nil?
      puts _err
      exit(-1)
    end

    # 正規表現を取得
    _err, @regexp = regexp_extraction(ARGV)
    if !_err.nil?
      puts _err
      exit(-1)
    end

    # ファイルを読み込み
    _err, @file = file_loading(@filename)
    if !_err.nil?
      puts _err
      exit(-1)
    end

    # 検索
    matched_array = search(@file, @regexp)

    # 一致した行を出力
    puts matched_array

    # ファイルを閉じる
    @file.close

  end

  # コマンドライン引数よりファイル名を取得
  def filename_extraction(argv)
    _err = nil
    filename = nil
    begin
      filename = argv[1].to_s
    rescue
      _err = $!
    end
    return _err, filename
  end

  # コマンドライン引数より正規表現を取得
  def regexp_extraction(argv)
    _err = nil
    regexp = nil
    begin
      regexp = Regexp.new(argv[0])
    rescue
      _err = $!
    end
    return _err, regexp
  end

  # ファイルを読み込み
  def file_loading(filename)
    _err = nil
    file = nil
    begin
      # 検索対象の文章をファイルから読み込み
      file = File.open(filename, "r")
    rescue
      _err = $!
    end
    return _err, file
  end

  # ファイルから正規表現に一致する行を検索
  def search(file, regexp)
    matched_array = []
    print file.path, "ファイルより、正規表現(/", regexp.source, "/)を実行します。\n"
    # 一行ずつ照会
    file.each{|line|
      # 一致する場合
      if !(regexp =~ line).nil? # 正規表現を照会した結果indexが帰ってきた場合
        # 一致する行を出力
        matched_array.append(line)
      end
    }
    return matched_array
  end
end

EGREP.new


## 実行結果

## 正常動作
# $ ruby egrep.rb aA words
# wordsファイルより、正規表現(/aA/)を実行します。
# aA
# aAa
# aAaA
# aAaAa
# aAaAaA
# aAaAaAa


## 存在しないファイル指定
# $ ruby egrep.rb aA abc
# No such file or directory @ rb_sysopen - abc

## 正規表現が不正
# $ ruby egrep.rb 'a(' words
# end pattern with unmatched parenthesis: /a(/
