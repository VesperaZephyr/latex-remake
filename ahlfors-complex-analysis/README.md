# Ahlfors《Complex Analysis》第三版重排

本项目保留英文原文，以随附原书 PDF 页面图像为依据设计模板、转写正文和核对公式。
成品为 `main.pdf`；主文件为 `main.tex`，版式由 `ahlfors.cls` 控制。

## 构建与修改

本机已安装 Python、XeLaTeX 和 makeindex。常规构建：

```powershell
python tools/build.py
```

重新从原始 OCR、原图和修订表生成全部文件：

```powershell
python tools/build.py --regenerate
```

构建默认运行四遍 XeLaTeX，生成索引，核对并补全 PDF 缺失的页码命名目标，再运行结构验收。
页码目标补全保留既有内容、页序、书签、图像和目标；结果单独记入
`audit/pdf-destination-repair.json`。只有验收脚本退出码为 0，才表示结构门槛通过。

修改正文须改 `tools/make_body.py` 或经原图确认的修订表，随后重新生成；
不要直接修改生成的 `chapters/*.tex`。191 项内容修订保存在
`audit/math-corrections-*.json` 和 `audit/text-corrections.json`；29 项公式断行调整
保存在 `audit/display-overrides.json`。构建末尾统一清除紧邻行间公式前后的空行，
但保留普通段落分隔；检查规则在 `tools/normalize_display_spacing.py`。
所有 tex/cls/py 文件使用 UTF-8 无 BOM、CRLF。

## 当前内容与链接

- 全部 8 章，原书正文 321 页（PDF 物理页 17—337）。
- 161 个节/小节，129 个陈述环境，297 个习题目标。
- 原始 OCR 的 982 个显示块均已对照原图；两块本为行内公式，一段推导被 OCR 拆成两块，已合并。另按原书把习题中的函数和积分列表改为无号行间排版；281 个原书公式号保留。
- 27 条脚注及其正文跳转，42 份原扫描裁图，涵盖 43 幅编号插图。
- 原索引 445 项作为核对底账保留；正文 435 种索引键的 1,304 条原页引用转换为实词定位和讨论范围，另保留原索引的 see 关系。
- 原书没有独立参考文献表；脚注中的文献信息按原结构保留。

公式、陈述、节、小节、习题及图的内部标签包含章号；显示编号遵循原书。
三处原书自身没有对应目标的引用保留原文，见 `audit/reference-exceptions.json`，
不以猜测的编号替换。

## 核验范围与限制

最新结构验收结果见 `audit/build-report.json`；包含编译错误、重复标签、缺字、
溢出、未定义引用、PDF 原始链接目标、页级来源锚点、页外文字及编码检查。
不能只凭编译通过推定没有死链。

982 个 OCR 显示块均有分章原图核对记录，见 `audit/math-audit-12.md`、
`audit/math-audit-34.md`、`audit/math-audit-58.md`。高风险行内符号另有
`audit/inline-accent-audit.md`；全文经过双 OCR 缺漏初筛及重点核图，见
`audit/text-audit.md`。第 1—8 章的 297 道习题题干均已逐题对照原图；
第 3—4 章复核记录及新增修订见 `audit/calibration-integration.md` 和
`audit/exercises14-progress.md`。
插图与索引的成品检查分别见
`audit/figures-final-review.md` 和 `audit/index-final-verification.json`。

当前是完整、可继续校订的全书重排稿，**尚未完成所有行内公式和普通正文的逐字终审**。
原扫描中确实模糊的字形及原书疑误均保留并登记；索引讨论范围也不能代替每个词项的语义校对。
插图复用原扫描质量，属于原 PDF 内容裁切，并非矢量重绘。

## 技能改进

已将本次验证过的有界子代理分工、文件所有权、跨页 OCR 合并、数学 span 脚注、
图块与图号的区别、引用上下文及 PDF 命名目标验收经验补充到已安装的
`latex-book-retypeset` 技能。项目内留有 `skill-updates/` 副本。

当前最后审核记录见 `audit/final-review.md`，其中明确区分通过项与尚未完成的人工验收。

本轮收尾结果见 `audit/acceptance-final.md`。原物理页334指数为有记录的数学订正；原索引记录保留，成品导航按审定修复表生成。
