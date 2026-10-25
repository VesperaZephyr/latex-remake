# LaTeX 书籍重排合集 / LaTeX Book Retypesetting Collection

本仓库统一收纳各类数学教材的**高保真 LaTeX 重排版**：忠实于原书，不改动内容、不做翻译。

This repository collects high-fidelity LaTeX retypesettings of mathematics textbooks: faithful to the originals, with content unaltered and untranslated.

## 收录书籍 / Books

| 目录 / Directory | 书名 / Title | 原作者 / Authors |
|---|---|---|
| `atiyah-macdonald/` | Introduction to Commutative Algebra（交换代数导引） | Atiyah & Macdonald |
| `yosida-functional-analysis/` | Functional Analysis（泛函分析） | Kōsaku Yosida |
| `ahlfors-complex-analysis/` | Complex Analysis（复分析，3rd ed.） | Lars Ahlfors |
| `serre-abelian-l-adic/` | Abelian l-Adic Representations and Elliptic Curves（l进表示与椭圆曲线） | Jean-Pierre Serre |
| `samuel-algebraic-theory-of-numbers/` | Algebraic Theory of Numbers（代数数论） | Pierre Samuel |
| `katz-mazur-arithmetic-moduli-elliptic/` | Arithmetic Moduli of Elliptic Curves（椭圆曲线的算术模） | Nicholas M. Katz & Barry Mazur |
| `chandrasekharan-classical-fourier-transforms/` | Classical Fourier Transforms（经典傅里叶变换） | K. Chandrasekharan |
| `matsumura-commutative-ring-theory/` | Commutative Ring Theory（交换环论） | Hideyuki Matsumura |
| `gelbart-automorphic-forms/` | Automorphic Forms on Adele Groups（自守形式） | Stephen S. Gelbart |
| `stein-weiss-fourier-analysis-euclidean/` | Introduction to Fourier Analysis on Euclidean Spaces（欧氏空间上的傅里叶分析） | Elias M. Stein & Guido Weiss |
| `katz-p-adic-modular-forms/` | p-adic Properties of Modular Schemes and Modular Forms（模格式与模形式的 p 进性质） | Nicholas M. Katz |
| `seminar-on-complex-multiplication/` | Seminar on Complex Multiplication（复乘讨论班） | Jean-Pierre Serre & John Tate |
| `fengkeqin-algebraic-number-theory/` | 代数数论 | 冯克勤 |
| `xushulin-mathanalysis-v1/` | 数学分析（第一册） | 徐森林 & 薛春华 |
| `xushulin-mathanalysis-v2/` | 数学分析（第二册） | 徐森林 & 薛春华 |
| `xushulin-mathanalysis-v3/` | 数学分析（第三册） | 徐森林 & 薛春华 |
| `deng-concise-mathanalysis-v1/` | 数学分析简明教程（上册） | 邓东皋 & 尹小玲 |
| `deng-concise-mathanalysis-v2/` | 数学分析简明教程（下册） | 邓东皋 & 尹小玲 |
| `mathanalysis-exam-collection/` | 数学分析试题汇总 | — |

> 更多书籍将逐步加入。/ More books will be added over time.

## 目录结构 / Structure

每本书一个独立子目录，各自包含 `main.tex` 与章节源文件，可独立编译。

Each book lives in its own subdirectory containing its own `main.tex` and chapter sources, and compiles independently.

```
latex-remake/
├── README.md          # 本文件 / this file
├── .gitignore         # 统一忽略构建产物与工程文件
└── <book-slug>/       # 每本书一个子目录 / one subdirectory per book
    ├── README.md      # 该书说明 / per-book notes
    ├── main.tex
    └── chapter*.tex
```

## 编译 / Build

进入对应子目录，按该书的 `README` 说明编译（通常为 XeLaTeX）。

Enter the book's subdirectory and follow its `README` (usually XeLaTeX).

## 支持作者 / Support the Authors

本合集是一个完全免费的开源项目，所有重排工作均由志愿者利用业余时间完成。我们投入大量精力以确保排版质量与内容准确。

This collection is a completely free open-source project. All retypesetting work is done by volunteers in their spare time. We invest significant effort to ensure typesetting quality and accuracy.

如果这个合集对你的学习与科研有所帮助，欢迎进行小额捐赠，用于购买正版书籍、维护项目与制作更多高质量数学资料：

If this collection helps your study or research, you may consider a small donation. Donations are used to purchase official books, maintain the project, and produce more high-quality mathematical material:

- 购买更多数学经典教材的正版书籍
- 维护项目（仓库托管、域名等）
- 支持更多开源数学项目

- Purchasing official copies of more classic mathematics textbooks
- Maintaining the project (repository hosting, domains, etc.)
- Supporting more open-source mathematics projects

### 捐赠方式 / Donation Methods

| 微信支付 / WeChat Pay | 支付宝 / Alipay |
|----------------------|-----------------|
| ![WeChat](https://github.com/user-attachments/assets/dee2c09a-b5e6-403d-8977-e7fcb99010f7) | ![Alipay](https://github.com/user-attachments/assets/67ed9d86-049f-497c-b44c-7acaefbf3efe) |

## 许可 / License

各书源码沿用其原项目许可证（如 CC BY-NC-SA 4.0）。详见各子目录。

Source code is licensed per the original project (e.g., CC BY-NC-SA 4.0). See each subdirectory.
