# latexremake-introduction-to-commutative-algebra
Atiyah &amp; Macdonald 'Introduction to Commutative Algebra' LaTeX retypesetting.

本项目是M. F. Atiyah与I. G. MacDonald经典著作《Introduction to Commutative Algebra》（交换代数导引）的非官方LaTeX重排版。

This project is an unofficial LaTeX typeset version of the classic textbook *Introduction to Commutative Algebra* by M. F. Atiyah and I. G. MacDonald.

---

## 项目简介 / Project Introduction

《交换代数导引》自1969年问世以来，一直是交换代数领域的经典入门教材。全书篇幅精炼，却以极其清晰的脉络涵盖了环与模的基本理论、局部化、整性、赋值环、维数理论以及完备化等核心内容，被无数数学工作者视为案头必读书。

Since its publication in 1969, *Introduction to Commutative Algebra* has been the classic introductory textbook in the field of commutative algebra. Despite its concise length, it covers core topics such as the basic theory of rings and modules, localization, integrality, valuation rings, dimension theory, and completion with exceptional clarity. It is regarded as an essential reference by countless mathematicians.

然而，由于原书成书年代较早，市面上流通的扫描版电子文件普遍存在字体模糊、符号不清、版面拥挤的问题，长期阅读容易造成视觉疲劳。为了让新一代学习者能够更舒适地研读这部经典，我们发起了本次非官方重排项目。

However, due to the book's age, scanned electronic copies available online generally suffer from blurry fonts, unclear symbols, and cramped layouts, which can cause eye strain during prolonged reading. To enable a new generation of learners to study this classic more comfortably, we initiated this unofficial typesetting project.

---

## 项目特点 / Project Features

- **完全忠实于原书**：定理编号、证明结构、习题安排均严格遵从1969年原版，未作任何内容删改
- **专业LaTeX排版**：数学公式清晰锐利，字体选用与原书风格相近的现代衬线体
- **优化的阅读体验**：正文行距和页边距经过仔细调整，适合屏幕阅读和打印
- **完整的超链接支持**：目录、引用、定理编号、索引页码均为可点击超链接，方便跳转
- **开源**：所有LaTeX源代码以CC BY-NC-SA 4.0 国际许可证托管，任何人都可以自由获取和改进

- **Completely faithful to the original**: Theorem numbering, proof structure, and exercise arrangement strictly follow the 1969 original edition with no content modifications
- **Professional LaTeX typesetting**: Crisp and sharp mathematical formulas with modern serif fonts similar in style to the original book
- **Optimized reading experience**: Carefully adjusted line spacing and margins suitable for both screen reading and printing
- **Full hyperlink support**: Table of contents, citations, theorem numbers, and index page numbers are all clickable hyperlinks for easy navigation
- **Fully open source**: All LaTeX source code is hosted under the MIT license, freely available for anyone to obtain and improve

---

## 编译方法 / Compilation Instructions

本项目使用XeLaTeX编译器，需要按照以下顺序编译才能生成正确的PDF：

This project uses the XeLaTeX compiler. Follow this sequence to generate the correct PDF:

```bash
xelatex main.tex
makeindex main.idx
xelatex main.tex
xelatex main.tex
```

或者使用latexmk自动完成所有编译步骤：

Or use latexmk to automate all compilation steps:

```bash
latexmk -xelatex main.tex
```

### 编译环境要求 / Environment Requirements

- TeX Live 2023或更高版本 / TeX Live 2023 or later
- 已安装ctex宏包（支持中文）/ ctex package installed (for Chinese support)
- 已安装amsmath、amssymb等数学宏包 / amsmath, amssymb and other mathematical packages installed

---

## 项目结构 / Project Structure

```
introduction-to-commutative-algebra/
├── main.tex              # 主文档文件 / Main document file
├── introduction.tex      # 引言和记号 / Introduction and Notation
├── chapter01.tex         # 第1章：环和理想 / Chapter 1: Rings and Ideals
├── chapter02.tex         # 第2章：模 / Chapter 2: Modules
├── chapter03.tex         # 第3章：分式环和分式模 / Chapter 3: Rings and Modules of Fractions
├── chapter04.tex         # 第4章：准素分解 / Chapter 4: Primary Decomposition
├── chapter05.tex         # 第5章：整相关性和赋值环 / Chapter 5: Integral Dependence and Valuation Rings
├── chapter06.tex         # 第6章：链条件 / Chapter 6: Chain Conditions
├── chapter07.tex         # 第7章：Noether环 / Chapter 7: Noetherian Rings
├── chapter08.tex         # 第8章：Artin环 / Chapter 8: Artinian Rings
├── chapter09.tex         # 第9章：离散赋值环和Dedekind整环 / Chapter 9: Discrete Valuation Rings and Dedekind Domains
├── chapter10.tex         # 第10章：完备化 / Chapter 10: Completions
├── chapter11.tex         # 第11章：维数理论 / Chapter 11: Dimension Theory
├── LICENSE               # MIT许可证 / MIT License
└── README.md             # 本文件 / This file
```

---

## 下载PDF / Download PDF

你可以在本仓库的[这里](https://github.com/VesperaZephyr/latexremake-introduction-to-commutative-algebra/releases/tag/Math)下载最新编译好的PDF文件。

You can download the latest compiled PDF file from [here](https://github.com/VesperaZephyr/latexremake-introduction-to-commutative-algebra/releases/tag/Math) of this repository.

---

## 支持作者 / Support the Authors

本项目是一个完全免费的开源项目，所有工作都是由志愿者利用业余时间完成的。我们投入了大量的时间和精力来确保排版质量和内容准确性。

This project is a completely free and open source initiative, and all work is done by volunteers in their spare time. We have invested a significant amount of time and effort to ensure the quality of typesetting and accuracy of content.

如果这个重排版对你的学习和研究有所帮助，并且你愿意支持我们继续制作更多高质量的数学教材重排版，可以考虑进行小额捐赠。所有捐赠将用于：

If this typeset version has been helpful for your study and research, and you would like to support us in creating more high-quality typeset versions of mathematics textbooks, you may consider making a small donation. All donations will be used for:

- 购买更多数学经典教材的正版书籍
- 维护项目服务器和域名
- 购买LaTeX相关的工具和资源
- 支持更多开源数学项目

- Purchasing official copies of more classic mathematics textbooks
- Maintaining project servers and domain names
- Purchasing LaTeX-related tools and resources
- Supporting more open source mathematics projects

### 捐赠方式 / Donation Methods

你可以通过微信或支付宝进行扫码捐赠：

You can donate by scanning the QR code with WeChat or Alipay:

| 微信支付 / WeChat Pay | 支付宝 / Alipay |
|----------------------|-----------------|
| <img width="439" height="597" alt="33cbf63064ab37fe340505fcd149b1d2_720" src="https://github.com/user-attachments/assets/dee2c09a-b5e6-403d-8977-e7fcb99010f7" /> | <img width="420" height="630" alt="949d2b5ab41b91f2f4e318e486c96886_720" src="https://github.com/user-attachments/assets/67ed9d86-049f-497c-b44c-7acaefbf3efe" /> |

---

## 贡献指南 / Contributing

我们非常欢迎任何形式的贡献！如果你在阅读过程中发现：

We warmly welcome contributions of any kind! If you discover any of the following while reading:

- 排版错误（公式对齐、字体大小、行距等）
- 印刷错误（原书中的错误，我们会以脚注形式标明）
- 内容疏漏
- 可以改进的地方

- Typesetting errors (formula alignment, font size, line spacing, etc.)
- Typographical errors (errors in the original book will be marked with footnotes)
- Content omissions
- Areas for improvement

请通过以下方式参与改进：

Please contribute improvements in the following ways:

1. 提交GitHub Issue详细描述问题 / Submit a GitHub Issue describing the problem in detail
2. Fork本仓库，修改后提交Pull Request / Fork this repository and submit a Pull Request with your changes
3. 发送邮件到vesperazephyr2006@gmai.com.

---

## 版权声明 / Copyright Notice

## 许可证

## 许可证 | License

本作品采用 **CC BY-NC-SA 4.0 国际许可证** 授权。  
This work is licensed under the **CC BY-NC-SA 4.0 International License**.

[![CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

您可以自由地：  
You are free to:
- **分享** — 在任何媒介以任何形式复制、发行本作品  
  **Share** — copy and redistribute the material in any medium or format
- **改编** — 二次创作、转换或以本作品为基础进行创作  
  **Adapt** — remix, transform, and build upon the material

在以下条件下：  
Under the following terms:
- **署名** — 您必须给出适当的署名，提供指向本许可证的链接，并说明是否进行了更改  
  **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made
- **非商业性** — 您不得将本作品用于商业目的  
  **NonCommercial** — You may not use the material for commercial purposes
- **相同方式共享** — 如果您二次创作、转换或以本作品为基础进行创作，您必须采用与原作相同的许可证分发您的作品  
  **ShareAlike** — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original

完整许可证文本 | Full license text:  
https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

Copyright (c) 2026 VesperaZephyr

## 致谢 / Acknowledgments

- 由衷感谢 **M. F. Atiyah教授** 和 **I. G. MacDonald教授** 写下了这本不朽的数学经典
- 感谢Addison-Wesley出版社当年独具慧眼的出版
- 感谢所有为这个重排项目做出贡献的数学爱好者

- Sincere thanks to **Professor M. F. Atiyah** and **Professor I. G. MacDonald** for writing this timeless mathematical classic
- Thanks to Addison-Wesley Publishing Company for their insightful publication
- Thanks to all mathematics enthusiasts who have contributed to this typesetting project
