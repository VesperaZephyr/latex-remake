# 数学分析试题汇总：LaTeX 重排

## 文件

- `output/数学分析试题汇总-精校稿.pdf`：全套试卷重排稿，含可点击目录、原页定位和审阅附录。
- `main.tex`、`examcollection.cls`：主文件与按原书样式设计的模板。
- `chapters/exam001.tex` 至 `exam198.tex`：198 套试卷，自动生成，不直接修改。
- `audit/题目审阅记录.md`：全书精校中的错误、条件缺失、题面异常与回忆缺失。
- `audit/findings.json`、`audit/coverage.json`：问题及逐卷状态的机器可读台账。
- `source/corrections.json`：核原页后恢复的识别错误，含逐条依据。
- `audit/verification.json`：最近一次构建的排版、覆盖与链接检查结果。
- `skill-update/`：此次技能更新副本及更新前备份；新经验已同步到原技能目录。

## 构建与修订

在项目根目录执行 `python scripts/build.py`。需要 TeX Live 的 XeLaTeX 和 Python 的 PyMuPDF。脚本从原 MinerU 结构化数据重建正文和审阅附录，清除可重建的辅助文件，编译四遍并验证，最后导出 PDF。所有工程 `.tex/.cls/.py` 使用 UTF-8 无 BOM、CRLF。

录入修订改 `source/corrections.json`；审阅结论改 `scripts/review.py`；版式改 `examcollection.cls`。每次修订需保留来源定位与核图依据。原始 PDF、Markdown 和 JSON 均保留不动。

## 版式与来源

正文沿用原书约 199 × 278 mm 的幅面、居中黑体卷名、宋体单栏正文和连续编排。保留学校、年份、题号、分值、原编括注和回忆缺失。长公式酌情改行间排版，增加页眉、来源页、点击目录及附录回跳。扫描书内的推广页、二维码和广告页脚不重排。

原 PDF 共 189 个物理页；正文在第 10—188 页，对应印刷第 9—187 页。正文共 198 套卷。来源 ID 如 `p111-b03` 指 PDF 第 111 页的原始正文块，`p176-h00` 是从误分类页眉中核图恢复的题号。

## 精校完成范围

198套、179页正文（原PDF第10—188页）已逐页查看扫描图与同页重排校样。实际查看台账为`audit/full-proof/pages.json`。修复17个来源块中的识别、遗漏、错位及题号问题；原书错误不静默改入正文。最终稿228页，含目录及审阅附录。

审阅记录66项：52项人工数学或题面问题及14项原书回忆缺失。记录附原页、题块和依据；不等同于逐题完整解答，未列问题的题目也未据此声明全部数学正确。

`source/corrections.json`保存可复现修订，`audit/verification.json`保存构建验证，`audit/full-proof/`保存逐页核对状态。旧重排审阅稿仍保留供比较。
