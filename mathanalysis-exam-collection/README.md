# 数学分析试题汇总（2024—2026 各高校真题）

*LaTeX 重排版* — 高保真重排 / high-fidelity LaTeX retypeset

本目录是 **latex-remake（LaTeX 书籍重排合集）** 的一个子项目。

---

## 项目简介 / Project Introduction

本目录是 **latex-remake（LaTeX 书籍重排合集）** 中的一本：把《2024—2026 年各高校数学分析真题汇总》（原编：扬哥真题编译组，2027 考研版）重排为可编译的 LaTeX 源码。共 **198 套试卷**，依据原书扫描版与 MinerU 识别底稿重排，保留原题号、分值、学校年份与「回忆缺失」标注，并加可点击目录、逐卷来源页码与题块定位。

This directory is part of the **latex-remake (LaTeX book retypesetting collection)**: a LaTeX retypeset of a collection of 198 real exam papers in mathematical analysis (2024–2026, Chinese universities). Question numbers, marks, school/year labels and "recalled with gaps" notes are preserved; a clickable table of contents and per-paper source-page locators are added.

---

## 项目特点 / Project Features

- **忠实原书**：题号、分值、学校年份、原编括注与回忆缺失文字一律保留，原书疑点不在正文擅改
- **版式复刻**：沿用原书 199 × 278 mm 幅面、居中黑体卷名、单栏宋体正文与连续编排
- **逐页核对**：198 套、179 页正文已逐页比对扫描图与重排校样；确认的识别错误经原图核对后在源头修复
- **可点击导航**：目录、题目引用、来源页码与附录回跳均为超链接
- **工程文件不随仓库分发**：扫描图、识别底稿、审阅台账与构建脚本按 `.gitignore` 排除（见下节）

- **Faithful to the source**: question numbers, marks, school/year labels and editorial notes are preserved; doubtful readings are not silently altered
- **Layout reproduction**: original trim size, centred bold paper titles, single-column body and continuous pagination
- **Page-by-page proofing**: all 198 papers (179 body pages) compared against the scanned originals
- **Clickable navigation**: contents, cross-references, source pages and appendix back-links are hyperlinks
- **Engineering files excluded**: scans, OCR dumps, review ledgers and build scripts are not shipped (see below)

---

## 编译方法 / Compilation Instructions

本项目使用 XeLaTeX 编译器，无需 biber。目录与交叉引用需多轮编译：

This project uses XeLaTeX only (no biber). Multiple passes are needed for the TOC and cross-references:

```bash
# 三趟编译（生成目录与题内引用）/ three passes
xelatex main.tex
xelatex main.tex
xelatex main.tex

# 或一键 / or one-shot
latexmk -xelatex main.tex
```

### 编译环境要求 / Environment Requirements

- TeX Live 2023 或更高版本 / TeX Live 2023 or later
- 已安装 ctex 宏包（中文支持）/ ctex package installed (Chinese support)
- 已安装 amsmath、amssymb、geometry 等常用宏包

---

## 项目结构 / Project Structure

```
mathanalysis-exam-collection/
├── main.tex
├── examcollection.cls
├── proof.tex
├── chapters/  (199 个 .tex: exam001–exam198 + all.tex)
└── audit/  (1 个 .tex: notes.tex，审阅附录，被 main.tex 引用)
```

> `main.tex` 通过 `chapters/all.tex` 依次 `\input` 198 套试卷，最后 `\input{audit/notes}` 引入审阅附录，因此 `audit/notes.tex` 是**编译必需**文件。
> `proof.tex` 是 9pt 紧凑版式的审阅稿，供与扫描图逐页比对，不参与 `main.tex` 的编译。

---

## 未纳入仓库的工程文件 / Files Not Shipped

按仓库 `.gitignore` 约定，以下工程文件**不随仓库分发**（它们是可重建的中间产物，或含大量扫描图/OCR 数据）：

| 路径 | 内容 | 处理方式 |
|---|---|---|
| `*.pdf` | 原书扫描版、成品 PDF | 排除；成品请自行编译 |
| `MinerU_*.json` / `MinerU_*.md` | OCR 识别底稿 | 排除（`*.json`） |
| `scripts/*.py` | 构建、审阅脚本 | 排除（`*.py`） |
| `audit/*.json` | 审阅台账（findings / coverage / verification） | 排除（`*.json`） |
| `audit/*.md`、`audit/read-through.txt` | 精校报告与通读记录 | 排除（`*.txt`；`.md` 中仅 README 入库） |
| `source/corrections.json` | 逐条修订依据 | 排除（`*.json`） |
| `output/`、`tmp/`、`skill-update/` | 构建输出与工具副本 | 排除 |
| `audit/notes.tex` | **审阅附录** | **已纳入**（`main.tex` 编译必需） |

> 因此原项目「在根目录执行 `python scripts/build.py`」的流程在本仓库内不可用，请直接按上一节用 `xelatex` 编译。

---

## 精校状态 / Proofreading Status

- 198 套、179 页正文（原 PDF 第 10—188 页，印刷页 = 物理页 − 1）已逐页对照扫描图与同页重排校样。
- 修复 17 个来源块中的识别、遗漏、错位与题号问题；原书自身的错误不静默改入正文。
- 审阅记录 66 项（52 项人工数学或题面问题 + 14 项原书回忆缺失），逐项附原页、题块与依据。
- 审阅记录**不等于**逐题完整解答；未被列入问题的题目也未据此声明数学上全部正确。

---

## 贡献指南 / Contributing

我们非常欢迎任何形式的贡献！若在阅读中发现排版错误、印刷错误、内容疏漏或可改进之处，请通过以下方式参与：

We warmly welcome contributions of any kind! If you find typesetting errors, typos, omissions or improvements, please contribute via:

1. 提交 GitHub Issue 详细描述问题 / Submit a GitHub Issue describing the problem
2. Fork 本仓库，修改后提交 Pull Request / Fork and submit a Pull Request
3. 发送邮件至 vesperazephyr2006@gmail.com

---

## 许可证 | License

本作品采用 **CC BY-NC-SA 4.0 国际许可证** 授权。

This work is licensed under the **CC BY-NC-SA 4.0 International License**.

[![CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

您可以自由地：**分享**（复制、发行本作品）与 **改编**（二次创作），但须遵守：

You are free to **Share** (copy and redistribute) and **Adapt** (remix, transform), subject to:

- **署名 (Attribution)**：给出适当署名，提供许可证链接，并标明是否改动
- **非商业性 (NonCommercial)**：不得将本作品用于商业目的
- **相同方式共享 (ShareAlike)**：二次创作须采用相同许可证分发

完整许可证文本见本目录 `LICENSE` 文件。

Full license text: see the `LICENSE` file in this directory.

> 如果您愿意支持本项目持续制作更多高质量数学教材的重排与中文翻译，请参见仓库顶层 README 的 **「支持作者 / Support the Authors」** 一节：`../README.md#支持作者--support-the-authors`。

---

## 致谢 / Acknowledgments

- 由衷感谢原编 **扬哥真题编译组** 整理并发布这套真题汇总。
- 感谢所有为本子项目贡献力量与建议的数学爱好者。

- Sincere thanks to the original compilers (**扬哥真题编译组**) for assembling this collection.
- Thanks to all mathematics enthusiasts who contributed to this sub-project.
