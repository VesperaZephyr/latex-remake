# LaTeX 书籍重排合集 / LaTeX Book Retypesetting Collection

本仓库统一收纳各类数学教材的**高保真 LaTeX 重排版**：忠实于原书，不改动内容、不做翻译。

This repository collects high-fidelity LaTeX retypesettings of mathematics textbooks: faithful to the originals, with content unaltered and untranslated.

## 收录书籍 / Books

| 目录 / Directory | 书名 / Title | 原作者 / Authors |
|---|---|---|
| `atiyah-macdonald/` | Introduction to Commutative Algebra（交换代数导引） | Atiyah & Macdonald |

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

## 许可 / License

各书源码沿用其原项目许可证（如 CC BY-NC-SA 4.0）。详见各子目录。

Source code is licensed per the original project (e.g., CC BY-NC-SA 4.0). See each subdirectory.
