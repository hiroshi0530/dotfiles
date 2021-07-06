## [Plala 原因調査 02] イナズマイレブンと遊戯王が多くのユーザーにレコメンドされる

Plala様から原因調査の依頼があったので調査を行う。
この記事は前回の[Plala 原因調査](https://abeja.docbase.io/posts/1882267)に次ぐものである。

大作さんより依頼のあった、以下の対応を行う。

```bash
【追加で対応】
a. 使用したコンテンツ／ユーザデータの属性（格納場所、データ名、期間など）を明記する【わやまさん、きょうさん】
b. 今回NTTぷらら様が掲出した期間のコンテンツ／ユーザデータに合わせることは可能か？【わやまさん、きょうさん】
c. 分散のグラフをより大きく【わやまさん、きょうさん】
d. 調査内容の記載を、NTTぷらら様上位レイヤ・関連部署の方々に、よりわかりやすく、硬い文体へ変更【大作】
f.「作品のベクトルのノルムの平均や分散を確認」の記載内容から試行時の不要な内容、及び結論に対して欠落している内容を追記する【わやまさん、きょうさん】
g.先方問い合わせ「 ④遊戯王が出ているのはJOJO/進撃の巨人を見たといっているひとで似ているか」※に対する回答を追加分析する【わやまさん、きょうさん】
※「JOJO」や「進撃の巨人」を閲覧しているユーザは、「イナズマイレブン」や「遊戯王」をみる計算結果になっているのか？と解釈
＞上記ユーザが、「イナズマイレブン」や「遊戯王」と、ベクトル空間上で近しい位置に存在するのか集計する（以前、Slackではっとりさんがやってくれてた集計と同じイメージ）
----------
【Next Action】
・5/7（金）夕方に本日関係者で状況確認のMTGを実施
　・アジェンダ：完了箇所まで結果説明、かつ完了予定日の調整を想定
```


## 対応

####  a. 使用したコンテンツ／ユーザデータの属性（格納場所、データ名、期間など）を明記する【わやまさん、きょうさん】

- inputするファイル群は以下の通り
  - action_log_20210423.tsv.gz
  - basicinfo_20210423.tsv.gz
  - iptv_ch_meta_20210422.tar.gz
  - iptv_log_20210422.tsv.gz
  - iptv_meta_20210422.tar.gz
  - user_master_20210422.tsv.gz
  - video_personal_recommend_step2_20210423.tsv.gz


#### b.  今回NTTぷらら様が掲出した期間のコンテンツ／ユーザデータに合わせることは可能か？【わやまさん、きょうさん】

- a. のファイル群をインプットしたことで、合わせたデータになっている

#### c.  分散のグラフをより大きく【わやまさん、きょうさん】

- 下記のグラフで対応済み

#### d.  調査内容の記載を、NTTぷらら様上位レイヤ・関連部署の方々に、よりわかりやすく、硬い文体へ変更【大作】

- 大作さん、よろしくお願いします(>_<)

#### f. 「作品のベクトルのノルムの平均や分散を確認」の記載内容から試行時の不要な内容、及び結論に対して欠落している内容を追記する【わやまさん、きょうさん】

- グラフと説明を追記

#### g. 先方問い合わせ「 ④遊戯王が出ているのはJOJO/進撃の巨人を見たといっているひとで似ているか」※に対する回答を追加分析する【わやまさん、きょうさん】

- 調査中

#### h.  [追加？]
- STEP1で既にレコメンド対象であったユーザのうち10%をランダム抽出：約1万3千人
- STEP2で新たにレコメンド対象となったユーザ：約2万4千人


## 調査の方針

多くのユーザーのレコメンドリストに含まれるので、ベクトル空間を主軸に考えた場合、ありえるパターンは次の二通り

1. 上記の作品群がベクトル空間上で広く均一に配置される場合
2. ベクトル空間上での分布が予想以上に偏っている

- 1.の場合 => 他作品と比較して、各ベクトルから作品の平均ベクトルを差し引いたベクトルのノルムの平均や分散が大きいと考えられる
- 2.の場合 => ベクトル空間内のプロットの様子を可視化してみる

### 生データの読み込み


```python
import sys

sys.path.append( "../src/" )

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from vodrec.data import VODDataset

# 今回のPlala様から頂いたファイルで作成したpkl
file_name = '../data/files/210423/output/vod_5_result.pkl'

data = VODDataset.load(file_name)
```

## 作品のベクトルのノルムの平均や標準偏差を確認

- 先方から頂いた作品群で「全XXX話」以後の文字列を削除し、タイトルやシノプシスにその文言が含まれる場合のみを計算に含めるようにする
- ベクトル空間上で該当する作品が散らばって存在する場合、多くのユーザーのレコメンドリストに入る可能性が高いので、ノルムの平均とその標準偏差を計算する
    - 計算する際、各ベクトルから中心を差し引く　


```python
"""
 イナズマイレブン オリオンの刻印 全49話【あにてれしあたー】                                           11673
 イナズマイレブン アレスの天秤 全26話【あにてれしあたー】                                             8398
 遊☆戯☆王デュエルモンスターズ　乃亜(ノア)編　全24話【あにてれしあたー】                             8058
 遊☆戯☆王デュエルモンスターズ  バトルシティ編(前編)　全46話【あにてれしあたー】                     8009
 ハイスコアガール 全12話                                                                              7812
 あんさんぶるスターズ！　                                                                             7747
 【ｵﾘｼﾞﾅﾙ】OH！舞 DA PUMP!!                                                                           7668
 ダーリン・イン・ザ・フランキス　全24話                                                               7661
 TVアニメ「青の祓魔師 京都不浄王篇」　全12話                                                          7660
 妖怪学園Y ～Nとの遭遇～（妖怪ウォッチJam） 全63話【あにてれしあたー】                                7596
 ぼくらの 全24話                                                                                      7164
 ハヤテのごとく!!                                                                                     7101
 ヴィレヴァン！２                                                                                     7055
 遊☆戯☆王デュエルモンスターズ　王(ファラオ)の記憶編　全26話【あにてれしあたー】                     7041
 ジョジョの奇妙な冒険 ダイヤモンドは砕けない 全39話                                                   6895
 N.Y.マックスマン                                                                                     6757
 遊☆戯☆王デュエルモンスターズ  ドーマ編  全40話【あにてれしあたー】                                 6704
 妖怪ウォッチ　全214話【あにてれしあたー】                                                            6687
 妖怪ウォッチ シャドウサイド 全49話【あにてれしあたー】                                               6523
 青の祓魔師 全25話                                                                                    6457
 遊☆戯☆王ZEXAL（ドクター・フェイカー編）　全73話【あにてれしあたー】                                6389
 魔入りました！入間くん 第1シリーズ　全23話                                                           6382
"""

word_list = [
'イナズマイレブン オリオンの刻印', 
'イナズマイレブン アレスの天秤', 
'遊☆戯☆王デュエルモンスターズ　乃亜(ノア)編', 
'遊☆戯☆王デュエルモンスターズ  バトルシティ編(前編)', 
'ハイスコアガール', 
'あんさんぶるスターズ！', 
'【ｵﾘｼﾞﾅﾙ】OH！舞 DA PUMP!!', 
'ダーリン・イン・ザ・フランキス', 
'TVアニメ「青の祓魔師 京都不浄王篇」', 
'妖怪学園Y ～Nとの遭遇～（妖怪ウォッチJam）', 
'ぼくらの', 
'ハヤテのごとく!!', 
'ヴィレヴァン！２', 
'遊☆戯☆王デュエルモンスターズ　王(ファラオ)の記憶編', 
'ジョジョの奇妙な冒険 ダイヤモンドは砕けない', 
'N.Y.マックスマン', 
'遊☆戯☆王デュエルモンスターズ  ドーマ編', 
'妖怪ウォッチ', 
'妖怪ウォッチ シャドウサイド', 
'青の祓魔師', 
'遊☆戯☆王ZEXAL（ドクター・フェイカー編）', 
'魔入りました！入間くん 第1シリーズ', 
]

count_list = [
  11673,
  8398,
  8058,
  8009,
  7812,
  7747,
  7668,
  7661,
  7660,
  7596,
  7164,
  7101,
  7055,
  7041,
  6895,
  6757,
  6704,
  6687,
  6523,
  6457,
  6389,
  6382,
]


def get_norm_mean_std(word):

  content_vector_list = []
  tag_vector_list = []
  collaborative_vector_list = []
  
  i = 0
  for meta in data.meta_db:
    if word in meta.main_title or word in str(meta.synopsis):
      # print(meta.main_title)
      content_vector_list.append(meta.vectors['content_vector'])
      tag_vector_list.append(meta.vectors['tag_vector'])
      collaborative_vector_list.append(meta.vectors['collaborative_vector'])
      i += 1
      # if i > 3:
      #   break
  
  if i == 0:
    return None
  
  tag_vector_list = np.array(tag_vector_list)
  tag_vector_list_mean = np.mean(tag_vector_list, axis=0)
  tag_vector_list = tag_vector_list - tag_vector_list_mean
  tag_vector_norm_mean = np.mean(np.linalg.norm(tag_vector_list, axis=1))
  tag_vector_norm_std = np.std(np.linalg.norm(tag_vector_list, axis=1))
  
  content_vector_list = np.array(content_vector_list)
  content_vector_list_mean = np.mean(content_vector_list, axis=0)
  content_vector_list = content_vector_list - content_vector_list_mean
  content_vector_norm_mean = np.mean(np.linalg.norm(content_vector_list, axis=1))
  content_vector_norm_std = np.std(np.linalg.norm(content_vector_list, axis=1))
  
  collaborative_vector_list = np.array(collaborative_vector_list)
  collaborative_vector_list_mean = np.mean(collaborative_vector_list, axis=0)
  collaborative_vector_list = collaborative_vector_list - collaborative_vector_list_mean
  collaborative_vector_norm_mean = np.mean(np.linalg.norm(collaborative_vector_list, axis=1))
  collaborative_vector_norm_std = np.std(np.linalg.norm(collaborative_vector_list, axis=1))
 
  norm_mean = np.mean([tag_vector_norm_mean, content_vector_norm_mean, collaborative_vector_norm_mean])
  norm_std = np.std([tag_vector_norm_std, content_vector_norm_std, collaborative_vector_norm_std])

  return [(norm_mean, tag_vector_norm_mean, content_vector_norm_mean, collaborative_vector_norm_mean, i, word) ,
          (norm_std, tag_vector_norm_std, content_vector_norm_std, collaborative_vector_norm_std, i, word)]

ret_word_list = []
norm_mean_list = []
norm_std_list = []

for word in word_list:
  ret = get_norm_mean_std(word)
  if ret is not None:
    norm_mean_list.append(ret[0][0])
    norm_std_list.append(ret[1][0])
    ret_word_list.append(word)

    
# mean
plt.figure(figsize=(10, 10))
fig, ax1 = plt.subplots(figsize=(10, 10))
ax2 = ax1.twinx()
ax1.bar([i for i in range(22)], norm_mean_list)
ax2.plot([i for i in range(22)], count_list, color='red')
ax1.set_ylabel('norm mean', fontsize=24)
ax2.set_ylabel('views', fontsize=24)
ax1.grid()
ax1.tick_params(labelsize=24) 
ax2.tick_params(labelsize=24) 
plt.show()
plt.close()

# std
plt.figure(figsize=(10, 10))
fig, ax1 = plt.subplots(figsize=(10, 10))
ax2 = ax1.twinx()
ax1.bar([i for i in range(22)], norm_std_list)
ax2.plot([i for i in range(22)], count_list, color='red')
ax1.set_ylabel('norm std', fontsize=24)
ax2.set_ylabel('views', fontsize=24)
ax1.grid()
ax1.tick_params(labelsize=24) 
ax2.tick_params(labelsize=24) 
plt.show()
plt.close()
```

### ノルムの平均と標準偏差

左軸に、ノルムの平均（３つのベクトルの平均を計算し、さらにその平均）、もしくは、ノルムの標準偏差（３つのベクトルの標準偏差を計算し、さらにその平均）、右軸に、レコメンドリスに入った回数（御社から頂いたviewの回数）、横軸は、作品（左から数が多い順にソート済み）としている。

#### 平均
![bug\_210430\_02\_5\_1.png](https://image.docbase.io/uploads/15a6ffae-f7ef-4d0e-ab2d-b55c429c5ef4.png =WxH)

今回の仮定が正しければ、views(折れ線グラフ)が下がるにつれて、norm mean(棒グラフ)も下がる傾向にあるはずだが、そのような傾向はない。

#### 標準偏差
$\text{標準偏差}= \sqrt{\text{分散}}$である。

![bug\_210430\_02\_5\_3.png](https://image.docbase.io/uploads/a458931e-5a3e-4e68-875b-df4d5c56fcc6.png =WxH)

標準偏差も今回の仮定が正しければ、views(折れ線グラフ)が下がるにつれて、norm mean(棒グラフ)も下がる傾向にあるはずだが、そのような傾向はない。

### ばらつきに関する結論

該当の作品がベクトル空間上で特段にばらつきが大きいわけではない

## ベクトル空間上を可視化

といあえず、ベクトル空間上での配置の様子をみるために、t-SNEを用いて二次元に圧縮してみる。
ユーザーは１００人を完全にランダムに抽出。


```python
user_db_list = []
user_num = 3000

np.random.seed(123)
basic_contract_ids_list = np.random.choice(data.user_db.basic_contract_ids, user_num)
for i in basic_contract_ids_list:
  user_db_list.append(data.user_db.data[i])
```


```python
user_tag_vector_list = []
user_content_vector_list = []
user_collaborative_vector_list = []

for i in user_db_list:
  user_tag_vector_list.append(i.vectors['tag_vector'])
  user_content_vector_list.append(i.vectors['content_vector'])
  user_collaborative_vector_list.append(i.vectors['collaborative_vector'])

user_tag_vector_list = np.array(user_tag_vector_list)
user_content_vector_list = np.array(user_content_vector_list)
user_collaborative_vector_list = np.array(user_collaborative_vector_list)
```


```python
word_1 = 'イナズマイレブン オリオンの刻印'
word_2 = 'イナズマイレブン アレスの天秤'
word_3 = '遊☆戯☆王デュエルモンスターズ　乃亜(ノア)編'
word_4 = '遊☆戯☆王デュエルモンスターズ  バトルシティ編(前編)'
word_5 = 'コナン'
word_6 = 'ドラゴンボール'

content_vector_list = []
tag_vector_list = []
collaborative_vector_list = []

i = 0
for word in [word_1, word_2, word_3, word_4, word_5, word_6]:
  for meta in data.meta_db:
    if word in meta.main_title or word in str(meta.synopsis):
      # print(meta.main_title)
      content_vector_list.append(meta.vectors['content_vector'])
      tag_vector_list.append(meta.vectors['tag_vector'])
      collaborative_vector_list.append(meta.vectors['collaborative_vector'])
      i += 1
      # if i > 3:
      #   break

tag_vector_list = np.array(tag_vector_list)
content_vector_list = np.array(content_vector_list)
collaborative_vector_list = np.array(collaborative_vector_list)
```


```python
collaborative_stack = np.vstack((user_collaborative_vector_list, collaborative_vector_list))
content_stack = np.vstack((user_content_vector_list, content_vector_list))
tag_stack = np.vstack((user_tag_vector_list, tag_vector_list))
```


```python
from sklearn.manifold import TSNE

data_tag = TSNE(n_components=2, perplexity=8.5, random_state=0).fit_transform(tag_stack)
content_tag = TSNE(n_components=2, perplexity=8.5, random_state=0).fit_transform(content_stack)
collaborative_tag = TSNE(n_components=2, perplexity=8.5, random_state=0).fit_transform(collaborative_stack)
```


```python
def tsne_plot_helper(data1):

  msize = 100
  mtype = 'o'
  SHIFT_X, SHIFT_Y = 0.1, 0.1
  plt.figure(figsize=(10, 10))

  plt.scatter(data1[0: user_num, 0], data1[0: user_num, 1], s=msize, marker=mtype, c='red', label='user')
  plt.scatter(data1[user_num: user_num + 49, 0], data1[user_num: user_num + 49, 1], s=msize, marker=mtype, c='blue', label='inazuma orion')
  plt.scatter(data1[user_num + 49: user_num + 75, 0], data1[user_num + 49: user_num + 75, 1], s=msize, marker=mtype, c='green', label='inazuma asure')
  plt.scatter(data1[user_num + 75: user_num + 99, 0], data1[user_num + 75: user_num + 99, 1], s=msize, marker=mtype, c='yellow', label='yuugiou noa')
  plt.scatter(data1[user_num + 99: user_num + 145, 0], data1[user_num + 99: user_num + 145, 1], s=msize, marker=mtype, c='orange', label='yuugiou battle city')
  plt.scatter(data1[user_num + 145: user_num + 500, 0], data1[user_num + 145: user_num + 500, 1], s=msize, marker=mtype, c='black', label='conan')

  plt.tick_params(labelsize=24) 
  plt.grid(True)
  plt.legend(fontsize=15)
```

## グラフのプロット

- 赤； ユーザー ランダム１００人
- 青： 'イナズマイレブン オリオンの刻印' 全４６話
- 緑: 'イナズマイレブン アレスの天秤' 全４６話
- 黄色: '遊☆戯☆王デュエルモンスターズ　乃亜(ノア)編' 全４６話
- オレンジ: '遊☆戯☆王デュエルモンスターズ  バトルシティ編(前編)' 全４６話
- 黒: 'コナン' 500 - 上記総作品数


### タグベクトル


```python
tsne_plot_helper(data_tag)
```

![bug\_210430\_02\_15\_0.png](https://image.docbase.io/uploads/486a123b-1c36-4c1d-946a-a5f5bd65908e.png =WxH)


- 赤のユーザー群が一部に密集している
- 色ごとにクラスターを形成している（アニメや映画など様々なタグを持つコナン：黒は除く）

###  コンテンツベクトル


```python
tsne_plot_helper(content_tag)
```

![bug\_210430\_02\_19\_0.png](https://image.docbase.io/uploads/c4b2b208-9efb-4dfc-b439-2ccbaa7c14ea.png =WxH)

- おそらく、今回の問題の最も重要な原因と思われる
- 赤のユーザー群が一部に密集している、かつ、イナズマイレブンや遊戯王が作るクラスターに、クラスターレベルで近い位置を占める
- コナンよりも近い

### 協調ベクトル


```python
tsne_plot_helper(collaborative_tag)
```

![bug\_210430\_02\_23\_0.png](https://image.docbase.io/uploads/28df2799-3d62-4f83-a223-10e5e3c389d1.png =WxH)

- 赤のユーザー群が一部に密集している
- 作品は広く分布している

## ランダムユーザー3000人の場合

- タグベクトル

![bug\_210430\_02\_15\_0.png](https://image.docbase.io/uploads/8e4e8aed-a662-490f-9151-51069a6655c3.png =WxH)

- コンテンツベクトル

![bug\_210430\_02\_19\_0.png](https://image.docbase.io/uploads/972f3877-d8af-48c3-ba31-3c61db438507.png =WxH)

- 協調ベクトル

![bug\_210430\_02\_23\_0.png](https://image.docbase.io/uploads/afbeee34-37f0-4b20-88d8-d8ced4883448.png =WxH)

事前のイメージとしては、赤のプロットがｘｙ平面全体に均一に散らばる。

### 可視化に関する結論

- あくまでも二次元に圧縮したという場合だが、ユーザーのベクトルが想像以上に一箇所に集中しすぎている
- 主にコンテンツベクトルにおいて、ユーザークラスターとイレブンナインクラスター、遊戯王クラスターが近く、どのようにユーザーをサンプリングしても、二つの作品がレコメンドリストに載る結果になる

## 「JOJO」や「進撃の巨人」を閲覧しているユーザ が「イナズマイレブン」や「遊戯王」をみるか

注意：以下のプログラムを実行するには大きなメモリが必要 => クラウド上で実行すること

- ※「JOJO」や「進撃の巨人」を閲覧しているユーザは、「イナズマイレブン」や「遊戯王」をみる計算結果になっているのか？と解釈


### ジョジョや進撃の巨人を見ているユーザーを洗い出す


```python
# とりあえず、見ているユーザーTOP１０で確認する
top_k = 10
```


```python
log_datas = data.user_log_db.data
meta_dbs = data.meta_db

bcid2id = data.user_log_db.bcid2id
crid2id = data.user_log_db.crid2id

id2bcid = data.user_log_db.id2bcid
id2crid = data.user_log_db.id2crid

pd_contents = [] 
pd_index = []

str_shingeki = "進撃の巨人"
str_jojo = "ジョジョ"

for user, logs in log_datas.items():
  # print(id2bcid[user])
  
  bcid = id2bcid[user]
  cnt_jojo = 0
  cnt_shingeki = 0

  pd_index.append(bcid)
  
  for log in logs:
    crid = id2crid[log]
    title = meta_dbs.get(crid).main_title
    # print('  {}'.format(title))
    
    if str_jojo in title:
      cnt_jojo += 1

    if str_shingeki in title:
      cnt_shingeki += 1
   
  pd_contents.append({
    str_jojo: cnt_jojo,
    str_jojo + "_ratio": float(cnt_jojo / len(logs)),
    str_shingeki: cnt_shingeki,
    str_shingeki + "_ratio": float(cnt_shingeki / len(logs)),
    "logs": len(logs)
  })

df = pd.DataFrame(pd_contents, index=pd_index)
```


```python
df.sort_values(str_shingeki, ascending=False)[[str_shingeki, str_shingeki + '_ratio']].head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>進撃の巨人</th>
      <th>進撃の巨人_ratio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>af971f1aee1b760</th>
      <td>1817</td>
      <td>0.453683</td>
    </tr>
    <tr>
      <th>f2a2c5de909a501a</th>
      <td>1590</td>
      <td>0.366613</td>
    </tr>
    <tr>
      <th>45f54cc6daaa7556</th>
      <td>1300</td>
      <td>0.307765</td>
    </tr>
    <tr>
      <th>2fe0350db4b0ac8a</th>
      <td>994</td>
      <td>0.537879</td>
    </tr>
    <tr>
      <th>207bc1482944f41b</th>
      <td>990</td>
      <td>0.836149</td>
    </tr>
    <tr>
      <th>19632521e4271461</th>
      <td>933</td>
      <td>0.590506</td>
    </tr>
    <tr>
      <th>638b5252e80c6713</th>
      <td>933</td>
      <td>0.216273</td>
    </tr>
    <tr>
      <th>54b9605d4a6b2021</th>
      <td>840</td>
      <td>0.410959</td>
    </tr>
    <tr>
      <th>5ee0fac8e038f8b6</th>
      <td>823</td>
      <td>0.230339</td>
    </tr>
    <tr>
      <th>127709d55858f45e</th>
      <td>772</td>
      <td>0.803330</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.sort_values(str_jojo, ascending=False)[[str_jojo, str_jojo + '_ratio']].head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ジョジョ</th>
      <th>ジョジョ_ratio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a7d68f64631cba5e</th>
      <td>275</td>
      <td>0.588865</td>
    </tr>
    <tr>
      <th>92c7fb011338d3e5</th>
      <td>166</td>
      <td>0.120991</td>
    </tr>
    <tr>
      <th>3180360f909b275</th>
      <td>130</td>
      <td>0.221843</td>
    </tr>
    <tr>
      <th>4a201388fbdea9ed</th>
      <td>126</td>
      <td>0.075449</td>
    </tr>
    <tr>
      <th>7dc429c7f3f381d8</th>
      <td>126</td>
      <td>0.137405</td>
    </tr>
    <tr>
      <th>298a27712a41cd80</th>
      <td>119</td>
      <td>0.708333</td>
    </tr>
    <tr>
      <th>85331569608f2138</th>
      <td>113</td>
      <td>0.055665</td>
    </tr>
    <tr>
      <th>a5afc8eca7bbe5d3</th>
      <td>99</td>
      <td>0.245658</td>
    </tr>
    <tr>
      <th>6c51354e0d30988c</th>
      <td>98</td>
      <td>0.161450</td>
    </tr>
    <tr>
      <th>a5de55452e65749d</th>
      <td>97</td>
      <td>0.192843</td>
    </tr>
  </tbody>
</table>
</div>




```python
shingeki_top_k_bcid = df.sort_values(str_shingeki, ascending=False).index[:top_k]
jojo_top_k_bcid = df.sort_values(str_jojo, ascending=False).index[:top_k]
```


```python
shingeki_top_k_bcid
```




    Index(['af971f1aee1b760', 'f2a2c5de909a501a', '45f54cc6daaa7556',
           '2fe0350db4b0ac8a', '207bc1482944f41b', '19632521e4271461',
           '638b5252e80c6713', '54b9605d4a6b2021', '5ee0fac8e038f8b6',
           '127709d55858f45e'],
          dtype='object')




```python
jojo_top_k_bcid
```




    Index(['a7d68f64631cba5e', '92c7fb011338d3e5', '3180360f909b275',
           '4a201388fbdea9ed', '7dc429c7f3f381d8', '298a27712a41cd80',
           '85331569608f2138', 'a5afc8eca7bbe5d3', '6c51354e0d30988c',
           'a5de55452e65749d'],
          dtype='object')



### UserToVodの結果から、上記ユーザーが「イナズマイレブン」や「遊戯王」を見ているか確認する


```python
# 巨大なファイル群
# 出力ファイルが数十GBオーダー

!ls -alh ../data/files/210423/output/
```

    total 97G
    drwxr-xr-x 2 root root 4.0K May  2 11:51 .
    drwxr-xr-x 4 root root 4.0K May  1 13:20 ..
    -rw-r--r-- 1 root root 7.5G May  2 04:55 tv_1_result.pkl
    -rw-r--r-- 1 root root 7.5G May  2 08:18 tv_2_result.pkl
    -rw-r--r-- 1 root root 9.2G May  2 10:06 tv_3_result.pkl
    -rw-r--r-- 1 root root 480M Apr 30 07:29 vod_1_result.pkl
    -rw-r--r-- 1 root root 483M Apr 30 08:12 vod_2_result.pkl
    -rw-r--r-- 1 root root 481M Apr 30 08:09 vod_2_result_before.pkl
    -rw-r--r-- 1 root root 2.7G Apr 30 12:52 vod_3_2_result.pkl
    -rw-r--r-- 1 root root 3.5G Apr 30 13:04 vod_3_3_result.pkl
    -rw-r--r-- 1 root root 3.6G Apr 30 13:15 vod_4_result.pkl
    -rw-r--r-- 1 root root 3.7G Apr 30 13:17 vod_5_result.pkl
    -rw-r--r-- 1 root root 3.7G May  1 16:09 vod_6_result.pkl
    -rw-r--r-- 1 root root 3.7G May  2 15:33 vod_7_result.pkl
    -rw-r--r-- 1 root root 3.7G May  1 17:34 vod_7_result_no_tv.pkl
    -rw-r--r-- 1 root root 8.8G May  1 16:08 vod_program_based_recommendation.json
    -rw-r--r-- 1 root root  26G May  2 15:32 vod_user_based_recommendation.json
    -rw-r--r-- 1 root root  13G May  1 17:33 vod_user_based_recommendation_no_tv.json



```python
import json

file_dir = "../data/files/210423/output/"
vod_to_vod_file_name = "vod_program_based_recommendation.json"
user_to_vod_file_name = "vod_user_based_recommendation.json"
user_to_vod_no_tv_file_name = "vod_user_based_recommendation_no_tv.json"

############################################################
# ファイルがとても巨大なので、一括して読み込むとOOM
# 一つづつ読み込むこと
############################################################

# with open(file_dir + vod_to_vod_file_name) as f:
#   vod_to_vod_json  = json.load(f)

with open(file_dir + user_to_vod_file_name) as f:
  user_to_vod_json  = json.load(f)

# with open(file_dir + user_to_vod_no_tv_file_name) as f:
#   user_to_vod_json_no_tv  = json.load(f)
```


```python
# Index(['45f54cc6daaa7556', '638b5252e80c6713', '54b9605d4a6b2021',
#        'c633420c6d16bb69', '5aac5d508328aa2a', '957e51610930e788',
#        'e78ed8bb4dc5ff2e', '46caa99b18da21af', 'd1fda84420cc82e1',
#        'f5f00699c99fa37a'],
# 

# イナズマイレブン オリオンの刻印 全49話【あにてれしあたー】                                           11673
# イナズマイレブン アレスの天秤 全26話【あにてれしあたー】                                             8398
#  遊☆戯☆王デュエルモンスターズ　乃亜(ノア)編　全24話【あにてれしあたー】                             8058
#  遊☆戯☆王デュエルモンスターズ  バトルシティ編(前編)　全46話【あにてれしあたー】                     8009

str_eleven_nine = 'イナズマイレブン'
str_yuugiou = '遊☆戯☆王'

def get_eleven_nine_yuugiou_cnt_list(bcid_list):
  
  count = 0
  ret_list = []
  
  user_count = 0
  cnt_eleven_nine = 0
  cnt_yuugiou = 0
 
  value_reciprocal_eleven_nine = 0
  value_reciprocal_yuugiou = 0

  for bcid in bcid_list:
      
    if bcid in user_to_vod_json.keys():
      df = pd.DataFrame.from_dict(user_to_vod_json[bcid]).set_index('crids')
      user_count += 1
    else:
      continue
   
    for i, (crid, v) in enumerate(df.iterrows()):
      title = meta_dbs.get(crid).main_title
      count += 1
      
      if str_eleven_nine in title:
        cnt_eleven_nine += 1
        value_reciprocal_eleven_nine += 1 / (i + 1)
      
      if str_yuugiou in title:
        cnt_yuugiou += 1
        value_reciprocal_yuugiou += 1 / (i + 1)
  
  ret_list.append({
    str_eleven_nine: cnt_eleven_nine,
    str_eleven_nine + "_user_ratio": float(cnt_eleven_nine / user_count) if user_count != 0 else 0,
    str_eleven_nine + "_ratio": float(cnt_eleven_nine / count) if count != 0 else 0,
    str_eleven_nine + "_reciprocal_ratio": float(value_reciprocal_eleven_nine / count) if count != 0 else 0,
    str_yuugiou: cnt_yuugiou,
    str_yuugiou + "_user_ratio": float(cnt_yuugiou / user_count) if user_count != 0 else 0,
    str_yuugiou + "_ratio": float(cnt_yuugiou / count) if count != 0 else 0,
    str_yuugiou + "_reciprocal_ratio": float(value_reciprocal_yuugiou / count) if count != 0 else 0,
    "count": count,
  })
  
  return ret_list
```


```python
target_shingeki_bcid_eleven_nine_yuugiou_cnt_list = get_eleven_nine_yuugiou_cnt_list(shingeki_top_k_bcid)
target_shingeki_bcid_eleven_nine_yuugiou_cnt_list
```




    [{'イナズマイレブン': 277,
      'イナズマイレブン_user_ratio': 27.7,
      'イナズマイレブン_ratio': 0.0554,
      'イナズマイレブン_reciprocal_ratio': 0.0024019269949217925,
      '遊☆戯☆王': 458,
      '遊☆戯☆王_user_ratio': 45.8,
      '遊☆戯☆王_ratio': 0.0916,
      '遊☆戯☆王_reciprocal_ratio': 0.0013097165724892431,
      'count': 5000}]




```python
target_jojo_bcid_eleven_nine_yuugiou_cnt_list = get_eleven_nine_yuugiou_cnt_list(jojo_top_k_bcid)
target_jojo_bcid_eleven_nine_yuugiou_cnt_list
```




    [{'イナズマイレブン': 131,
      'イナズマイレブン_user_ratio': 13.1,
      'イナズマイレブン_ratio': 0.0262,
      'イナズマイレブン_reciprocal_ratio': 0.000681706331035436,
      '遊☆戯☆王': 446,
      '遊☆戯☆王_user_ratio': 44.6,
      '遊☆戯☆王_ratio': 0.0892,
      '遊☆戯☆王_reciprocal_ratio': 0.002533838370265288,
      'count': 5000}]



ランダムサンプリングして、同じ結果を出力し比較する


```python
np.random.seed(123)

all_bcid_list = data.user_db.basic_contract_ids
selected_bcid_list  = np.random.choice(all_bcid_list, 3000)

selected_eleven_nine_yuugiou_bcid_cnt_list = get_eleven_nine_yuugiou_cnt_list(selected_bcid_list)
selected_eleven_nine_yuugiou_bcid_cnt_list
```




    [{'イナズマイレブン': 11331,
      'イナズマイレブン_user_ratio': 3.8645975443383356,
      'イナズマイレブン_ratio': 0.007767108751861063,
      'イナズマイレブン_reciprocal_ratio': 0.00015299640193981595,
      '遊☆戯☆王': 24947,
      '遊☆戯☆王_user_ratio': 8.508526603001364,
      '遊☆戯☆王_ratio': 0.017100526170036,
      '遊☆戯☆王_reciprocal_ratio': 0.0002623721631539834,
      'count': 1458844}]



|                         | TOP５００の推薦リスト <br> イナズマイレブン作品数 | TOP５００の推薦リスト <br> 遊戯王作品数  |TOP５００の推薦リスト <br> イナズマイレブンMRR  | TOP５００の推薦リスト <br> 遊戯王MRR |
| :---:                   | :---: | :---: |:---: |:---: |
| [進撃の巨人]を見てるTOP１０人 | 27.7 |  45.8| $2.40 \times 10^{-3}$ | $1.30 \times 10^{-3}$|
| [ジョジョ]を見ているTOP１０人   | 13.1 | 44.6 | $6.82 \times 10^{-4}$ | $2.53 \times 10^{-3}$ |
| サンプリング <br> 3000人   | 3.9 | 8.5 | $1.53 \times 10^{-4}$ |$2.62 \times 10^{-4}$ |

$\ast$ MMR(Mean Reciptical Rank)は順位の逆数の平均

### 「イナズマイレブン」や「遊戯王」に関する結論

進撃の巨人やジョジョを見ているユーザーには、イナズマイレブンや遊戯王が相対的に多く推薦されることがわかった。

## 結論

- ベクトル空間上でイナズマイレブンや遊戯王が相対的に分散が大きいわけではない
- ユーザークラスタが予想以上に密集しており、イナズマイレブンクラスタや遊戯王クラスタにより近い
- 進撃の巨人やジョジョを見ているユーザーには相対的にイナズマイレブンや遊戯王が推薦される
- 推薦アルゴリズムのバグではなく、仕様通りである
