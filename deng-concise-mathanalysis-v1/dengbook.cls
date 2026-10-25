% !TeX program = xelatex
% ================================================================
%  dengbook.cls
%  《数学分析简明教程（下册）第二版》(邓东皋 尹小玲) LaTeX 重排模板
%  版式依据原书扫描页逐页核对设计：
%    · 16 开纸型，正文宋体、标题黑体，行距约 1.2；
%    · 章名居中（第 X 章 中文数字），字间拉宽；章首页无页眉页码；
%    · 节名居中 "§ N 节名"；小节 "1." 顶格缩进黑体；
%    · 页眉：偶数页 左页码 + 居中章名；奇数页 居中节名 + 右页码；通栏细线；
%    · 定理类 run-in 样式：黑体 "定理 10.1" + 空 + 正文（同字体），
%      定理/定义各按章独立计数 X.Y；引理/推论/命题按节计数、只显示 "N"；
%      例按节计数 "例 N"；
%    · 证明 run-in，结尾实心方块；
%    · 公式章级编号 (10.1)，仅原书有编号者使用 equation；
%    · 图注 "图 15-1"（章-序），居中，无图题文字；
%    · 习题：居中 "习 题"，题号 1. 2. ...，子题 (1)(2)。
% ================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dengbook}[2026/10/02 v1.0 邓东皋《数学分析简明教程(下册)》重排模板]

\makeatletter

% ---------------- 1. 基础类 ----------------
\PassOptionsToPackage{dvipsnames}{xcolor}
\LoadClass[UTF8,11pt,fontset=none,twoside,openany]{ctexbook}

% ---------------- 2. 页面（16 开，核对原书文本块比例） ----------------
\RequirePackage[a4paper=false,paperwidth=18.5cm,paperheight=26cm,
  left=1.65cm,right=1.65cm,top=1.95cm,bottom=1.85cm,
  headheight=14pt,headsep=11pt,footskip=20pt]{geometry}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\linespread{1.18}

% ---------------- 3. 字体（TeX Live 自带 Fandol，西文 CM Unicode） ----------------
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\setmainfont{cmunrm.otf}[
  BoldFont=cmunbx.otf, ItalicFont=cmunti.otf, BoldItalicFont=cmunbi.otf]
\setCJKmainfont{FandolSong-Regular.otf}[
  BoldFont=FandolSong-Bold.otf, ItalicFont=FandolKai-Regular.otf]
\newCJKfontfamily\songfont{FandolSong-Regular.otf}[
  BoldFont=FandolSong-Bold.otf, ItalicFont=FandolKai-Regular.otf]
\newCJKfontfamily\heifont{FandolHei-Regular.otf}[BoldFont=FandolHei-Regular.otf]
\newCJKfontfamily\heiboldfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
\newCJKfontfamily\kaifont{FandolKai-Regular.otf}
\setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
\setCJKmonofont{FandolFang-Regular.otf}
% 带圈数字（①②…）交由 CJK 字体渲染（FandolSong 含字形）
\xeCJKDeclareCharClass{CJK}{"2460 -> "2473}
% 标题字体入口（可整体换）
\newcommand{\headfont}{\heiboldfont}
% 定理头 / 证明头 / 小节标题：原书为宋体加粗
\newcommand{\thmheadfont}{\songfont\bfseries}
% 标题字间拉宽：章/节标题内把 CJK 字距撑开
\newcommand{\DB@wideglue}{\renewcommand{\CJKglue}{\hskip 0.28em plus 0.05\baselineskip}}

% ---------------- 4. 数学与宏包 ----------------
\RequirePackage{amsmath,amssymb,amsthm,mathtools,mathrsfs}
\RequirePackage[minimal]{yhmath}
\RequirePackage{graphicx}
\graphicspath{{figures/}{work/figures/}}
\RequirePackage{tikz}
\usetikzlibrary{patterns,arrows.meta,decorations.markings,decorations.pathreplacing}
\RequirePackage{array,booktabs,longtable,multirow}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{caption}
\RequirePackage{titlesec,etoolbox}
\RequirePackage{fancyhdr}

% ---------------- 5. 颜色与链接 ----------------
\RequirePackage[dvipsnames]{xcolor}
\definecolor{ThemeColor}{named}{MidnightBlue}
\RequirePackage[colorlinks=true,bookmarksnumbered=true,linktoc=all,
  linkcolor=ThemeColor,citecolor=BrickRed,urlcolor=ThemeColor]{hyperref}
\RequirePackage{bookmark}

% ---------------- 6. 页眉页脚 ----------------
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{\CTEXthechapter\quad #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
\fancyhead[LE]{\thepage}
\fancyhead[CE]{\small\leftmark}
\fancyhead[RE]{}
\fancyhead[LO]{}
\fancyhead[CO]{\small\rightmark}
\fancyhead[RO]{\thepage}
\renewcommand{\headrulewidth}{0.6pt}
\fancypagestyle{plain}{%
  \fancyhf{}\renewcommand{\headrulewidth}{0pt}}
\assignpagestyle{\chapter}{plain}

% ---------------- 7. 章 / 节 / 小节样式 ----------------
% 章：居中 "第十章 数项级数"，黑体三号，字间拉宽
\titleformat{\chapter}[block]
  {\normalfont\DB@wideglue\centering\headfont\zihao{3}}
  {\CTEXthechapter\hspace{2.5em}}
  {0pt}{}
\titlespacing*{\chapter}{0pt}{42pt}{30pt}

\renewcommand{\thesection}{§\,\arabic{section}}
\titleformat{\section}[hang]
  {\normalfont\DB@wideglue\centering\headfont\zihao{4}}
  {\thesection\hspace{1.2em}}
  {0pt}{}
\titlespacing*{\section}{0pt}{20pt plus 6pt minus 4pt}{14pt plus 4pt minus 2pt}

\renewcommand{\thesubsection}{\arabic{subsection}.}
\titleformat{\subsection}[hang]
  {\normalfont\thmheadfont\zihao{5}}
  {\thesubsection\hspace{0.6em}}
  {0pt}{}
\titlespacing*{\subsection}{2em}{10pt plus 3pt}{6pt plus 2pt}

% 目录只到节
\setcounter{tocdepth}{1}

% ---------------- 8. 定理类环境（run-in，章级共用计数器） ----------------
\newtheoremstyle{dengrunin}%
  {6pt}{6pt}%
  {\normalfont}% 正文字体同正文
  {\parindent}% 整段首行缩进 2em
  {\thmheadfont}% 标题宋体加粗
  {\relax}% 标题后不加标点
  {1.2em}% 标题与正文间距
  {\thmname{#1}\thmnumber{ #2}\thmnote{ #3}}

% 核对原书（第十章及全书 grep 验证）：
%   定理/定义 各按章独立计数 "定理 10.1"/"定义 10.1"（两套计数器）；
%   引理/推论/命题 按节计数、只显示 "引理1/推论1/命题1"；
%   例 按节计数 "例 N"。
\theoremstyle{dengrunin}
\newtheorem{theorem}{定理}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[section]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{axiom}{公理}[section]
\renewcommand{\thelemma}{\arabic{lemma}}
\renewcommand{\thecorollary}{\thechapter.\arabic{corollary}}
% 不编号变体（原书有无号"引理"，如 §3 拉阿比判别法前）
\newtheorem*{theorem*}{定理}
\newtheorem*{lemma*}{引理}
\newtheorem*{corollary*}{推论}
\newtheorem*{proposition*}{命题}

% 例：按节计数，只显示 "例 N"
\newtheorem{example}{例}[section]
\renewcommand{\theexample}{\arabic{example}}
\theoremstyle{dengrunin}

% 注
\newtheorem{remark}{注}[section]
\renewcommand{\theremark}{\arabic{remark}}

% cleveref 中文名
\RequirePackage[nameinlink,capitalize]{cleveref}
\crefname{theorem}{定理}{定理}
\crefname{definition}{定义}{定义}
\crefname{lemma}{引理}{引理}
\crefname{corollary}{推论}{推论}
\crefname{proposition}{命题}{命题}
\crefname{example}{例}{例}
\crefname{equation}{式}{式}
\crefname{figure}{图}{图}
\crefname{section}{节}{节}

% 证明：run-in；按用户要求，证明环境结束统一加证毕符号 □
% （amsthm 机制：行末排 □，若本行放不下则另起一行右对齐）
\renewcommand{\proofname}{证明}
\renewcommand{\qedsymbol}{$\square$}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont
  \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item\hskip\parindent{\thmheadfont #1}\hspace{1.2em}\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}

% ---------------- 9. 公式编号：章级 (10.1) ----------------
\renewcommand{\theequation}{\thechapter.\arabic{equation}}

% ---------------- 10. 图：注 "图 15-1"，无图题 ----------------
\renewcommand{\thefigure}{\thechapter\nobreak--\nobreak\arabic{figure}}
\captionsetup[figure]{labelsep=quad,font={small},justification=centering,skip=4pt}
% 原书图注只显示编号；配套宏：\figcap 生成 "图 15-1"
\newcommand{\figcap}{\caption{\relax}}

% ---------------- 11. 习题 ----------------
\newcounter{xiti}[section]
\renewcommand{\thexiti}{\arabic{xiti}}
\newenvironment{xiti}{%
  \par\medskip
  \begingroup
  \centering{\headfont\zihao{4}习\hspace{2em}题}\par\smallskip
  \setlength{\parindent}{0pt}%
  \begin{list}{\thexiti.\ }{%
      \usecounter{xiti}%
      \setlength{\leftmargin}{3em}\setlength{\labelwidth}{2.4em}%
      \setlength{\itemindent}{0.6em}% 题号整体缩进两字
      \setlength{\labelsep}{0.5em}%
      \setlength{\itemsep}{4pt}}%
}{%
  \end{list}\endgroup\medskip
}
% 子题 (1)(2)
\newenvironment{ziti}{%
  \begin{enumerate}[label=(\arabic*),leftmargin=3.2em,itemsep=2pt,topsep=2pt]}%
  {\end{enumerate}}

% ---------------- 12. 常用数学宏（转写时统一用） ----------------
\newcommand{\dd}{\,\mathrm{d}}
\renewcommand{\epsilon}{\varepsilon}
\providecommand{\bm}[1]{\boldsymbol{#1}}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\supp}{supp}
\DeclareMathOperator{\Int}{int}
\DeclareMathOperator{\cl}{cl}
\DeclareMathOperator{\diam}{diam}

\endinput
