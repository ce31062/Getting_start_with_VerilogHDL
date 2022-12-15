# Getting Start With VerilogHDL
CQ出版 "入門VerilogHDL記述"の内容に従い、<br>
Lattice MachXO3D Breaking Boardへの実装を行ったり、テストベンチを作成して動作確認を行っている。<br>

## 第1章
- 4-bit加算器 (adder4.v)<br>
- 全加算器 (fulladd.v)<br>
- 4-bit全加算器 (adder_ropple.v)<br>
- 4-bitカウンタ (counter4.v)<br>
## 第2章
### 電子錠 (elelock.v)<br>
暗唱番号は回路で"5963"に固定<br>
LED点灯：開錠<br>
LED消灯: 施錠<br>
![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/74296872/195470252-a4ecb009-b716-4882-bf28-3a325552aa3e.gif)

## 第4章
- 等号演算によるデコーダ (decoder_cond.v)<br>
- if文によるデコーダ (decoder_if.v)<br>
- case文によるデコーダ (decoder_case.v)<br>
## 第5章
- 同期SR-FF (srff_sync.v)<br>
- 同期セット/リセット付きD-FF (dff_sync.v)<br>
- 同期セット/リセット付きJK-FF (jkff_sync.v)<br>
- 同期リセット付きT-FF (tff_syc.v)<br>
- 同期リセット/ロード付きD-FF (dff.v)<br>
- 4bitカウンタ (counter.v)<br>
## 第6章
- ROMシミュレーションモデル (rom.v)<br>
- RAMシミュレーションモデル (ram.v)<br>
- ADCシミュレーションモデル (ad_block.v)<br>
- DACシミュレーションモデル (da_block.v)<br>
## 第8章
- CLKGEN (clkgen.v)<br>
- Keyscan (keyscan.v)<br>
- 本体 (elelock2.v)<br>
- 表示部 (display.v)<br>
- トップモジュール(top_elelock2.v)<br>
