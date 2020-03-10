# 200214現在、古い（削除しても良い）
# c.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"
# c.ContentsManager.default_jupytext_formats = "ipynb,py"

import io
import os
from notebook.utils import to_api_path
from subprocess import check_call

# 200310:
# - ipynbを保存したら自動的にpyとmdを保存したい
# - ただし、mdはOutputを残し、pyはOutputを削除⇒Git管理のため
# - おそらく、仕様上c.FileContentsManager.post_save_hookは二つ使えない
# ⇒よって一つの関数で、mdとpyを作成するが、その途中でOutputを削除する処理を入れる

# ipynbを保存したら、マークダウン形式で自動保存する。ただし、Outputの部分を残すので、下の二つの関数より先に実行する。下の二つの関数ではOutputなどを削除（Git管理のため）
def post_save(model, os_path, contents_manager):
    """post-save hook for converting notebooks to .py scripts
    ipynbが保存されるたびに[py, html, md, tex, pdf]を作成する。"""

    ################################################
    # 1. mdの保存

    if model['type'] != 'notebook':
        return # only do this for notebooks
    d, fname = os.path.split(os_path)
    base, ext = os.path.splitext(fname)
    # check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)
    # check_call(['jupyter', 'nbconvert', '--to', 'html', fname], cwd=d)
    check_call(['jupyter', 'nbconvert', '--to', 'markdown', fname], cwd=d)
    # check_call(['jupyter-nbconvert', '--to', 'latex', fname, '--template', 'jsarticle.tplx'], cwd=d)
    # check_call(['extractbb', base+'_files/*.png'], cwd=d)
    # check_call(['platex', '-interaction=nonstopmode', '-synctex=1', '-kanji=utf8', '-guess-input-enc' , base+'.tex'], cwd=d)
    # check_call(['dvipdfmx', base+'.dvi'], cwd=d)


    ################################################
    # 2. Outputの削除
    # 200214: 
    # ipynbの更新時に、pyの方も自動で更新
    # その際、出力結果や演算の順番も削除
    # 
    # https://qiita.com/mmsstt/items/6f8382afcc94f57861d4
    # http://jupyter-notebook.readthedocs.org/en/latest/extending/savehooks.html

    def scrub_output_pre_save(model, **kwargs):
        """scrub output before saving notebooks"""
        # only run on notebooks
        if model['type'] != 'notebook':
            return
        # only run on nbformat v4
        if model['content']['nbformat'] != 4:
            return
    
        for cell in model['content']['cells']:
            if cell['cell_type'] != 'code':
                continue
            cell['outputs'] = []
            cell['execution_count'] = None
    
    c.FileContentsManager.pre_save_hook = scrub_output_pre_save

    ################################################
    # 3. pyファイルを保存 
    check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)


################################################
# 1. save markdonw
# 2. delete output
# 3. save markdonw
c.FileContentsManager.post_save_hook = post_save
