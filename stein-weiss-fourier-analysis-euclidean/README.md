# Introduction to Fourier Analysis on Euclidean Spaces（欧氏空间上的傅里叶分析）

*LaTeX 重排版* — 高保真重排 / high-fidelity LaTeX retypeset

本目录是 **latex-remake（LaTeX 书籍重排合集）** 合集的一个子项目。

---

## 项目简介 / Project Introduction

本目录是 **latex-remake（LaTeX 书籍重排合集）** 中的一本：对经典数学教材《Introduction to Fourier Analysis on Euclidean Spaces》的 LaTeX 高保真重排。我们忠实于原书版式与内容，仅以 LaTeX 重新排版，不改动任何正文、公式、编号与引用。

This directory is part of the **latex-remake (LaTeX book retypesetting collection)**: a high-fidelity LaTeX retypesetting of the classic textbook *Introduction to Fourier Analysis on Euclidean Spaces*. We stay faithful to the original layout and content, re-typesetting it in LaTeX without altering any text, formulas, numbering, or references.

---

## 项目特点 / Project Features

- **忠实原书**：版式、公式、定理编号、习题安排均严格遵从原版，不改动内容
- **专业 LaTeX 排版**：数学公式清晰锐利，选用与原书风格相近的现代字体
- **优化的阅读体验**：行距与页边距经仔细调整，适合屏幕阅读与打印
- **完整的超链接支持**：目录、引用、定理编号、索引页码均为可点击链接
- **开源**：所有 LaTeX 源以 CC BY-NC-SA 4.0 国际许可证托管，可自由获取与改进

- **Faithful to the source**: layout, formulas, theorem numbering and exercise arrangement strictly follow the original (retypeset) / rendered into Chinese while staying close to the meaning (translation)
- **Professional LaTeX typesetting**: crisp and sharp mathematical formulas with modern fonts
- **Optimized reading experience**: carefully adjusted line spacing and margins for screen and print
- **Full hyperlink support**: table of contents, citations, theorem numbers and index page numbers are clickable
- **Open source**: all LaTeX source is hosted under the CC BY-NC-SA 4.0 International License

---

## 编译方法 / Compilation Instructions

本项目使用 XeLaTeX 编译器。建议通过 `latexmk` 自动完成多轮编译：

This project uses the XeLaTeX compiler. We recommend `latexmk` for multiple passes:

```bash
# 基础编译 / basic
xelatex main.tex

# 若使用 biblatex/biber:
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex

# 一键编译 / one-shot
latexmk -xelatex main.tex
```

### 编译环境要求 / Environment Requirements

- TeX Live 2023 或更高版本 / TeX Live 2023 or later
- 已安装 ctex 宏包（中文支持）/ ctex package installed (Chinese support)
- 已安装 amsmath、amssymb、graphicx 等常用数学与图形宏包

---

## 项目结构 / Project Structure

```
stein-weiss-fourier-analysis-euclidean/
├── main.tex
├── pms32.cls
├── refs.bib
├── chapters/  (9 个 .tex)
├── chapters_backup_v1/  (11 个 .tex)
├── chapters_backup_v3/  (5 个 .tex)
├── chapters_backup_v4/  (7 个 .tex)
├── chapters_backup_v5/  (7 个 .tex)
├── chapters_backup_v6/  (2 个 .tex)
├── chapters_backup_v7/  (7 个 .tex)
├── chapters_backup_v8/  (7 个 .tex)
└── figures/  (0 个 .tex, 含 .png 插图)
```

> 说明：上表为源码概要；被 `\includegraphics` 实际引用的插图（如 `figs/`、`figures/`）一并纳入，构建产物（`*.pdf`、`*.aux` 等）不随仓库分发。

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

- 由衷感谢《Introduction to Fourier Analysis on Euclidean Spaces》的原作者 **Elias M. Stein & Guido Weiss** 写下这部著作。
- 感谢所有为本子项目贡献力量与建议的数学爱好者。

- Sincere thanks to **Elias M. Stein & Guido Weiss** for writing *Introduction to Fourier Analysis on Euclidean Spaces*.
- Thanks to all mathematics enthusiasts who contributed to this sub-project.

