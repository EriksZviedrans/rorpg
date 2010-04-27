class CreateEncodings < ActiveRecord::Migration
  def self.up
    create_table :encodings do |t|
	 t.string :enco
    end

execute "INSERT INTO encodings (enco) VALUES ('BIG5')"
execute "INSERT INTO encodings(enco) VALUES ('EUC_CN')"
execute "INSERT INTO encodings (enco) VALUES ('EUC_JP')"
execute "INSERT INTO encodings (enco) VALUES ('EUC_KR')"
execute "INSERT INTO encodings (enco) VALUES ('EUC_TW')"
execute "INSERT INTO encodings (enco) VALUES ('GB18030')"
execute "INSERT INTO encodings (enco) VALUES ('ISO_8859_5')"
execute "INSERT INTO encodings (enco) VALUES ('ISO_8859_6')"
execute "INSERT INTO encodings (enco) VALUES ('ISO_8859_7')"
execute "INSERT INTO encodings (enco) VALUES ('ISO_8859_8')"
execute "INSERT INTO encodings (enco) VALUES ('JOHAB')"
execute "INSERT INTO encodings (enco) VALUES ('KOI8')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN1')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN2')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN3')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN4')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN5')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN6')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN7')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN8')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN9')"
execute "INSERT INTO encodings (enco) VALUES ('LATIN10')"
execute "INSERT INTO encodings (enco) VALUES ('MULE_INTERNAL')"
execute "INSERT INTO encodings (enco) VALUES ('SJIS')"
execute "INSERT INTO encodings (enco) VALUES ('SQL_ASCII')"
execute "INSERT INTO encodings (enco) VALUES ('UHC')"
execute "INSERT INTO encodings (enco) VALUES ('UTF8')"
execute "INSERT INTO encodings (enco) VALUES ('WIN866')"
execute "INSERT INTO encodings (enco) VALUES ('WIN874')"
execute "INSERT INTO encodings (enco) VALUES ('WIN1250')"
execute "INSERT INTO encodings (enco) VALUES ('WIN1251')"
execute "INSERT INTO encodings (enco) VALUES ('WIN1252')"
execute "INSERT INTO encodings (enco) VALUES ('WIN1256')"
execute "INSERT INTO encodings (enco) VALUES ('WIN1258')"
  end

  def self.down
    drop_table :encodings
  end
end
