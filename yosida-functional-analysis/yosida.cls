% yosida.cls — 复刻 Kôsaku Yosida, "Functional Analysis", 6th ed.
% (Springer-Verlag, Grundlehren 123) 的版式
% 版面实测: 开本 155×235mm, 版心宽 108.5mm, 正文 10/12pt, 每页约 41 行
% 页眉: 偶页=页码+章标题, 奇页=节标题+页码; 章首页页脚=页码+书名(小型大写)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yosida}[2026/09/02 Yosida Functional Analysis layout]
\LoadClass[11pt,twoside]{book}

% ---------- 版面 ----------
\RequirePackage[a4paper,
  top=13.2mm,bottom=25mm,outer=25mm,inner=25mm,
  includehead,headheight=7.8mm,headsep=3.6mm,
  footskip=9mm]{geometry}
\RequirePackage{amsmath,amssymb,amsfonts}
\RequirePackage{mathrsfs}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{array}

% 正文 11pt
\linespread{1.3}\selectfont
\setlength{\baselineskip}{12pt}
\setlength{\parindent}{1.2em}
\setlength{\parskip}{0pt}
\setlength{\columnsep}{6mm}
% 版心底对齐放宽, 消除整页 Underfull \vbox 警告
\raggedbottom
% 允许行内数学在关系/运算点紧急断行, 消除段落 Overfull
\tolerance=2000
\emergencystretch=3em
% 数学密集段落偶尔出现拉松的字距(视觉不可见), 不再逐行报警
\hbadness=10000

% 显示公式间距(原书较紧凑)
\AtBeginDocument{%
  \abovedisplayskip=6pt plus 2pt minus 3pt
  \belowdisplayskip=6pt plus 2pt minus 3pt
  \abovedisplayshortskip=3pt plus 2pt
  \belowdisplayshortskip=3pt plus 2pt}

% ---------- 页眉页脚 ----------
% 章前换页: 空白页不带页码 (class 内 @ 已是字母, 无需 makeatletter)
\newcommand{\clearemptydoublepage}{\clearpage{\pagestyle{empty}\cleardoublepage}}
% 正常页: 偶页(左)= 页码 页码在左 + 章标题居中; 奇页(右)= 节标题居中 + 页码在右
\fancypagestyle{main}{%
  \fancyhf{}%
  \fancyhead[LE]{\footnotesize\thepage}%
  \fancyhead[CE]{\footnotesize\nouppercase{\leftmark}}%
  \fancyhead[RO]{\footnotesize\thepage}%
  \fancyhead[CO]{\footnotesize\nouppercase{\rightmark}}%
  \renewcommand{\headrulewidth}{0pt}}
% 章首页: 页脚 "页码  Yosida, Functional Analysis"(小型大写), 无页眉
\fancypagestyle{chapopen}{%
  \fancyhf{}%
  \fancyfoot[FL]{\footnotesize\thepage\hspace{1.4em}\textsc{Yosida, Functional Analysis}}%
  \renewcommand{\headrulewidth}{0pt}}
% 前置部分(罗马页码居中)
\fancypagestyle{front}{%
  \fancyhf{}%
  \fancyfoot[FC]{\footnotesize\thepage}%
  \renewcommand{\headrulewidth}{0pt}}
\pagestyle{main}

% 页眉标记: 左页=章标题("I. Semi-norms"), 右页=节标题("1. Semi-norms and ...")
\providecommand{\chaptermark}[1]{}
\providecommand{\sectionmark}[1]{}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

% ---------- 标题 ----------
% 章: 居中黑体 "I. Semi-norms"
% 可选首参给出较短的页眉文字(标题过长时避免页眉撞页码), 缺省用完整标题。
\newcounter{yoschap}
\renewcommand{\theyoschap}{\roman{yoschap}}
\newcommand{\yoschapter}[3][]{% #1=(可选)页眉短标题, #2=编号文本(I, XIV...), #3=标题
  \stepcounter{yoschap}%
  \setcounter{equation}{0}% 章首导言自成编号域(原书: 章首导言从 (1) 起算)
  \clearemptydoublepage\thispagestyle{chapopen}%
  \phantomsection\addcontentsline{toc}{chapter}{#2.\ \ #3}%
  \vspace*{4.5mm}%
  {\centering\large\bfseries #2.\ \ #3\par}%
  \vspace{3.2mm}%
  \@afterindentfalse\@afterheading
  \def\@currentlabel{#2}%
  \if\relax\detokenize{#1}\relax\markboth{#2.\ \ #3}{}\else\markboth{#1}{}\fi}
% 无编号章(附录/补遗等)
\newcommand{\yoschapterstar}[1]{%
  \stepcounter{yoschap}%
  \setcounter{equation}{0}% 附录自成编号域(原书: Appendix to Chapter X 从 (1) 起算)
  \clearemptydoublepage\thispagestyle{chapopen}%
  \ifyostocentry\phantomsection\addcontentsline{toc}{chapter}{#1}\fi
  \vspace*{4.5mm}%
  {\centering\large\bfseries #1\par}%
  \vspace{3.2mm}%
  \@afterindentfalse\@afterheading
  \markboth{#1}{}}
% 节: 居中黑体 "1. Title"
% 可选首参给出较短的页眉文字(标题过长时避免页眉撞页码), 缺省用完整标题。
\newcounter{yossec}[yoschap]
\renewcommand{\theyossec}{\arabic{yossec}}
\newcommand{\yossection}[3][]{% #1=(可选)页眉短标题, #2=节号, #3=标题
  \stepcounter{yossec}%
  \vspace{3.0mm}%
  \phantomsection
  {\centering\normalsize\bfseries #2.\ \ #3\par}%
  \vspace{1.6mm}%
  \@afterindentfalse\@afterheading
  \addcontentsline{toc}{section}{#2.\ \ #3}%
  \setcounter{equation}{0}%
  \def\@currentlabel{#2}%
  \if\relax\detokenize{#1}\relax\markright{#2.\ \ #3}\else\markright{#1}\fi}
% 小节(无编号, 居中黑体, 如 "Zorn's Lemma")
\newcommand{\yossub}[1]{%
  \vspace{2.4mm}%
  {\centering\bfseries #1\par}%
  \nobreak\vspace{1.2mm}%
  \@afterindentfalse\@afterheading}
% 定理性声明: 黑体行内标签 (Theorem 1. 等), 正文直立; 同时设置 \label 的引用值
\newcommand{\yoslabel}[2]{% #1=类型(Theorem), #2=编号; 供交叉引用
  \textbf{#1~#2.}\ \ \def\@currentlabel{#1~#2}\ignorespaces}

% ---------- 定理类环境 (amsthm 自定义样式, 复刻原书: 黑体标签+直立体, 编号按节) ----------
\RequirePackage{amsthm}
\newtheoremstyle{yosida}% 名称
  {6pt plus 1pt minus 2pt}{6pt plus 1pt minus 2pt}% 上/下间距
  {\upshape}% 正文字体(原书直立)
  { }% 头部缩进
  {\bfseries}% 头部字体
  {.}% 头部标点
  {.5em}% 头后间距
  {}% 头部规格
\theoremstyle{yosida}
\newtheorem{theorem}{Theorem}[yossec]
\renewcommand{\thetheorem}{\arabic{theorem}}
\newtheorem{proposition}{Proposition}[yossec]
\renewcommand{\theproposition}{\arabic{proposition}}
\newtheorem{lemma}{Lemma}[yossec]
\renewcommand{\thelemma}{\arabic{lemma}}
\newtheorem{corollary}{Corollary}[yossec]
\renewcommand{\thecorollary}{\arabic{corollary}}
\newtheorem{definition}{Definition}[yossec]
\renewcommand{\thedefinition}{\arabic{definition}}
\newtheorem{example}{Example}[yossec]
\renewcommand{\theexample}{\arabic{example}}
% 原书中不带编号的黑体声明 (Definition. / Theorem. 等)
\newtheorem*{theoremu}{Theorem}
\newtheorem*{propositionu}{Proposition}
\newtheorem*{lemmau}{Lemma}
\newtheorem*{corollaryu}{Corollary}
\newtheorem*{definitionu}{Definition}
\newtheorem*{remarku}{Remark}
% 原书中带人名/编号的黑体声明 (Tychonov's Theorem. / Remark 1. 等):
% 头部显示方括号中的注记文本; 若未给注记, 则显示环境名 (如 "Example."),
% 否则句点会孤立地落在段首。
\newtheoremstyle{yosidanamed}
  {6pt plus 1pt minus 2pt}{6pt plus 1pt minus 2pt}%
  {\upshape}{ }{\bfseries}{}{.5em}%
  {\ifx\relax#3\relax\thmname{#1}.\else\thmnote{#3.}\fi}
\theoremstyle{yosidanamed}
\newtheorem*{theoremn}{Theorem}
\newtheorem*{propositionn}{Proposition}
\newtheorem*{lemman}{Lemma}
\newtheorem*{corollaryn}{Corollary}
\newtheorem*{definitionn}{Definition}
\newtheorem*{examplen}{Example}
\newtheorem*{remarkn}{Remark}
\theoremstyle{yosida}
% 各类极限记号: 强极限 s-lim, 弱极限 w-lim, 弱* 极限 w*-lim, 序极限 O-lim
\providecommand{\slim}{\ensuremath{\text{s-}\lim}}
\providecommand{\wlim}{\ensuremath{\text{w-}\lim}}
\providecommand{\wstarlim}{\ensuremath{\text{w}^{*}\text{-}\lim}}
\providecommand{\Olim}{\ensuremath{\text{O-}\lim}}

% 证明环境: 黑体 "Proof." 直立体, 证毕用开框符号
\renewcommand{\proofname}{\normalfont\bfseries Proof}
\renewcommand{\qedsymbol}{\openbox}

% 多行公式块。原书这类多行公式用 array 排在 equation 里(列硬性、行距由 array
% 的 strut 决定)。改用 amsmath 的 aligned 后行距会多出一个 \jot, 整书因此长了
% 十几页; 这里把 \jot 归零, 使行距与原 array 一致, 视觉上更整齐而篇幅不变。
\newenvironment{yoslines}{\setlength{\jot}{0pt}\begin{aligned}}{\end{aligned}}

% ---------- 目录 ----------
% 条目由 \yoschapter / \yossection / \yoschapterstar 经 \addcontentsline 写入,
% 版式用 book 类默认 \tableofcontents; \yostoc 只生成目录正文(不带章节标题)
\renewcommand{\contentsname}{Contents}
\newcommand{\yostoc}{\@starttoc{toc}}
% 目录条目开关(Contents 自身不进目录)
\newif\ifyostocentry
\yostocentrytrue

% 数学杂项
\providecommand{\norm}[1]{\left\lVert#1\right\rVert}

\endinput
