% !TeX program = xelatex
% ==================================================================
%  zhmbook.cls  ——  中文数学书籍 LaTeX 重排类
% ------------------------------------------------------------------
%  实例：徐森林、薛春华《数学分析》（第二册）第 11 章
%        曲线积分、曲面积分、外微分形式积分与场论
%
%  版式参数全部由原书扫描件实测反推（原书 16 开，185mm x 260mm）：
%    · 版心      165mm x 220mm        （扫描件实测 164.8mm x 220.4mm）
%    · 正文      小四 (12pt)，行距 ≈ 18.8pt（实测 20.9pt @ 扫描比例 1.114）
%    · 2 字缩进  实测 27.4pt @ 扫描比例 = 24.6pt ≈ 2 x 12pt ✓
%    · 章标题    小二 (18pt) 黑体，居中；章号与标题间空约 1em
%    · 节标题    小三 (15pt) 黑体，居中；节号与标题间空约 1em
%    · 定理型    行内粗体标签（黑体）紧接正文，编号 章.节.序；无终止标点
%    · 证明/解   行内粗体标签 + 约 1em 空白；以空心方框 □ 收尾并右顶格
%    · 页眉      偶数页：页码(靠外) + 章标题(版心居中)；
%                奇数页：节标题(版心居中) + 页码(靠外)；页眉下加 0.6pt 细线
%    · 章首页    无页眉无页码（原书第 296 页即如此）
%    · 公式      居中、一律不编号（与原书一致）
%
%  标点：遵循《中文数学书籍 LaTeX 重排规范》§1.3，全文（含数学环境）
%        一律使用英文标点；原书的「，。；：（）」已在重排时转换。
%
%  用法示例：
%    \documentclass[BookTitleCN=数学分析,AuthorCN=徐森林\quad 薛春华]
%                   {zhmbook}
% ==================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zhmbook}[2026/09/17 v1.0 中文数学书籍重排类]

\makeatletter

% ==================================================================
%  1. 类选项
% ==================================================================
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=ZMB, prefix=ZMB@}

\DeclareStringOption[black]{ThemeColor}      % 超链接主色（原书为黑白印刷）
\DeclareStringOption[185mm]{PaperWidth}
\DeclareStringOption[260mm]{PaperHeight}
\DeclareStringOption[165mm]{TextWidth}
\DeclareStringOption[220mm]{TextHeight}
\DeclareStringOption[296]{StartPage}         % 正文起始页码（与原书对齐）

\DeclareStringOption{BookTitleCN}
\DeclareStringOption{BookTitleCNSub}
\DeclareStringOption{BookTitleEN}
\DeclareStringOption{AuthorCN}
\DeclareStringOption{Publisher}
\DeclareStringOption{Edition}
\DeclareStringOption{Year}
\DeclareStringOption{ISBN}
\DeclareStringOption{Translator}
\DeclareStringOption[翻译及重排]{TranslatorRole}
\DeclareStringOption{TranslationDate}

\DeclareStringOption[logo.pdf]{LogoFile}
\DeclareStringOption[4.6cm]{LogoWidth}

\DeclareBoolOption[true]{Biblatex}
\DeclareStringOption[alphabetic]{BibStyle}
\DeclareStringOption[none]{BibSorting}
\DeclareStringOption[refs]{BibFile}

\ProcessKeyvalOptions*

% 注意：kvoptions 消费掉的是「键值」，但 \@classoptionslist 里仍留着原始字符串。
% geometry 加载时会用 \ProcessOptionsKV[c]{Gm} 逐项扫描类选项列表并构造 \csname，
% 一旦某个选项值含控制序列（如 AuthorCN = 徐森林\quad 薛春华，\quad 展开为 \hskip），
% \csname 就会撞上 \hskip，报出
%     geometry.sty:1003: Missing \endcsname inserted. <to be read again> \hskip
% 这里在加载 geometry 之前清空该列表。本类对所有依赖都显式传参，清空无副作用。
\let\@classoptionslist\@empty

% ==================================================================
%  2. 基础类与页面
% ==================================================================
\PassOptionsToPackage{dvipsnames}{xcolor}
\LoadClass[UTF8,zihao=-4,fontset=none,twoside,openany]{ctexbook}

\RequirePackage{geometry}
\geometry{%
  paperwidth=\ZMB@PaperWidth,paperheight=\ZMB@PaperHeight,%
  textwidth=\ZMB@TextWidth,textheight=\ZMB@TextHeight,%
  top=22mm,headheight=14pt,headsep=5mm,footskip=9mm}

\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{0pt}
% 正文行距：原书行距/字号 ≈ 1.56 -> \baselineskip = 1.2*1.3*12pt = 18.7pt
\linespread{1.30}
% 中文正文没有字间可伸缩胶，一旦句中出现又长又不可断的数学块（如 \left...\right
% 成组、长下标），TeX 找不到宽度贴合栏宽的断点，就会把整句排成一行而 overfull。
% 给一点紧急伸缩量：只在非它不可时启用，正常行不受影响（规范 §3.3.7 的补充手段，
% 不减任何内容）。
\setlength{\emergencystretch}{1em}

% ==================================================================
%  3. 字体
% ==================================================================
\RequirePackage{fontspec}
\RequirePackage{xeCJK}

% 西文与数学：原书西文为正体 Times 系（正文、公式中的拉丁字母与数字）。
% 取 XITS（STIX/Times 度量系）而非 TeX Gyre Termes，是因为正文里用得到
% 粗斜体数学向量（x、e、xi），而 XITS 同时提供 Regular/Bold 两套数学字体，
% 可避免「粗体数学字形缺失→静默回退」。
\setmainfont{XITS}[
  BoldFont=XITS-Bold.otf,
  ItalicFont=XITS-Italic.otf,
  BoldItalicFont=XITS-BoldItalic.otf
]

% 中文：正文宋体，标题与定理名黑体，楷体备用。
\setCJKmainfont{FandolSong-Regular.otf}[
  BoldFont=FandolSong-Bold.otf,
  ItalicFont=FandolKai-Regular.otf]
\newCJKfontfamily\songfont{FandolSong-Regular.otf}[
  BoldFont=FandolSong-Bold.otf,
  ItalicFont=FandolKai-Regular.otf]
\newCJKfontfamily\heifont{FandolHei-Regular.otf}[
  BoldFont=FandolHei-Bold.otf]
\newCJKfontfamily\kaifont{FandolKai-Regular.otf}
\setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
\setCJKmonofont{FandolFang-Regular.otf}

% 标题 / 定理名 / 证明名 的统一入口：中文黑体，西文（数字、拉丁词）随主字体加粗。
% 原书「定义 11.1.1」中，汉字为黑体，编号为 Times 粗体，正是这一组合。
\newcommand{\headfont}{\heifont\bfseries}

% ==================================================================
%  4. 数学、图形、表格
% ==================================================================
% 数学：数学字体亦取 Times 系（texgyretermes-math），与原书公式的
% 拉丁字母/数字/直立 d 同族。unicode-math 与 amssymb 互斥，故不载 amssymb；
% \mathbb \mathcal \mathfrak \mathscr 均由 unicode-math 提供。
\RequirePackage{amsmath,amsthm,mathtools}
\RequirePackage{unicode-math}
\setmathfont{XITSMath-Regular.otf}[BoldFont=XITSMath-Bold.otf]
\RequirePackage{graphicx}
\graphicspath{{figures/}{../figures/}}
\RequirePackage{tikz,tikz-cd,titlesec,etoolbox}
\RequirePackage{array,booktabs,longtable,wrapfig,enumitem}
\usetikzlibrary{arrows.meta,calc,decorations.markings,decorations.pathreplacing,patterns,angles,quotes,3d}

% 原书向量用粗斜体（如 x、e、xi），直接用 \boldsymbol{}；
% \vec 保持 LaTeX 原义（M、dM 等带箭头记号仍用 \vec / \overrightarrow）。

% ==================================================================
%  5. 颜色与超链接
% ==================================================================
\RequirePackage[dvipsnames]{xcolor}
\definecolor{ThemeColor}{named}{\ZMB@ThemeColor}

\RequirePackage[
    colorlinks=true,
    bookmarksnumbered=true,
    bookmarksopen=true,
    bookmarksopenlevel=1,
    linktoc=all,
    linkcolor=ThemeColor,
    citecolor=ThemeColor,
    urlcolor=ThemeColor,
    pdfencoding=auto,
    unicode
]{hyperref}
\RequirePackage{bookmark}
\bookmarksetup{numbered,open,openlevel=1}
\RequirePackage[nameinlink,capitalize]{cleveref}

% ==================================================================
%  6. 参考文献（biblatex + biber，规范 §7 强制）
% ==================================================================
\ifZMB@Biblatex
  \edef\ZMB@bibopts{backend=biber,style=\ZMB@BibStyle,sorting=\ZMB@BibSorting,%
    backref=false,giveninits=false,maxbibnames=99}
  \expandafter\RequirePackage\expandafter[\ZMB@bibopts]{biblatex}
  \addbibresource{\ZMB@BibFile.bib}
  \setlength{\bibitemsep}{0.4\baselineskip}
  % ★ 原书参考文献表版式（印刷页 412）逐条对齐：
  %   标号      「1 2 3 …」纯数字，无方括号、无 [a] 字母
  %   顺序      严格按原书编排，不随作者/年份重排 -> BibSorting=none
  %   标点      「作者. 书名. 出版地: 出版社, 年.」（西文点号，非中文句读）
  %   姓名      原样照录，不做「名 姓」倒置、不缩写
  %   无 backref 尾巴（原书没有「cit. on p. xxx」这类回引）
  % 注意：这里用 kvoptions 自带的 \ifdefstring 而非 etoolbox 的 \ifstrequal ——
  % 后者比较的是未展开的宏，会误判为不等而静默跳过整个分支。
  \ifdefstring{\ZMB@BibStyle}{numeric}{%
    % numeric.bbx 默认 \labelnumberwidth = \mkbibbrackets{数字}，即 [1]；
    % 原书是纯数字 1，故去掉方括号。
    % ★ 必须用 \thefield{labelnumber}——biblatex **没有** \bibnumber 这个命令，
    %   写错会在 main.bbl 的每一条书目上各报一次
    %   「Undefined control sequence. \bibnumber」（9 条文献 = 27 处）。
    \DeclareFieldFormat{labelnumberwidth}{\thefield{labelnumber}}%
    % 原书中文书名均为正体宋体，不倾斜、不设楷体
    \DeclareFieldFormat{title}{#1}%
    % 原书多作者之间一律用「, 」平铺，绝对不出现英式连接词「, and 」
    \DeclareDelimFormat{multinamedelim}{\addcomma\space}%
    \DeclareDelimFormat{finalnamedelim}{\addcomma\space}%
  }{}
  % 原书正文中的文献引用是「可参阅^[1]」的上标形式。
  % 注意：不要用 \DeclareCiteCommand 自造 \supcite —— 其实现依赖 biblatex
  % 内部宏（\mkbibarg），在导言区调用会报 Missing \begin{document}。
  % 已验证可行的写法是在调用点直接 \textsuperscript{\cite{...}}。
\fi


% ==================================================================
%  8. 元信息
% ==================================================================
\newcommand{\BookTitleCN}{\ZMB@BookTitleCN}
\newcommand{\BookTitleCNSub}{\ZMB@BookTitleCNSub}
\newcommand{\BookTitleEN}{\ZMB@BookTitleEN}
\newcommand{\AuthorCN}{\ZMB@AuthorCN}
\newcommand{\Publisher}{\ZMB@Publisher}
\newcommand{\Edition}{\ZMB@Edition}
\newcommand{\PubYear}{\ZMB@Year}
\newcommand{\BookISBN}{\ZMB@ISBN}
\newcommand{\Translator}{\ZMB@Translator}
\newcommand{\TranslatorRole}{\ZMB@TranslatorRole}
\newcommand{\TranslationDate}{\ZMB@TranslationDate}

% ==================================================================
%  9. 封面（规范 §8.5：出版社信息下方加「译者  翻译及重排」，字号略大）
% ==================================================================
\newcommand{\ZMB@coverlogo}{%
  \IfFileExists{figures/\ZMB@LogoFile}%
    {\includegraphics[width=\ZMB@LogoWidth]{figures/\ZMB@LogoFile}}%
    {\IfFileExists{\ZMB@LogoFile}%
       {\includegraphics[width=\ZMB@LogoWidth]{\ZMB@LogoFile}}%
       {\rule{0pt}{0pt}}}%
}

\newcommand{\makecover}{%
  \begin{titlepage}%
    \thispagestyle{empty}%
    \centering
    \vspace*{2.2cm}
    {\fontsize{30pt}{38pt}\selectfont\headfont \BookTitleCN\par}
    \ifdefempty{\BookTitleCNSub}{}{%
      \vspace{0.5cm}{\fontsize{18pt}{24pt}\selectfont\headfont \BookTitleCNSub\par}}
    \ifdefempty{\BookTitleEN}{}{%
      \vspace{0.9cm}{\fontsize{14pt}{18pt}\selectfont\itshape \BookTitleEN\par}}
    \vspace{1.4cm}
    \noindent\rule{\textwidth}{0.8pt}\par
    \vspace{1.6cm}
    {\fontsize{20pt}{26pt}\selectfont\headfont \AuthorCN\par}
    \vfill
    {\ZMB@coverlogo\par}
    \vspace{0.6cm}
    \begingroup
    \raggedleft
    \ifdefempty{\Edition}{}{\ifdefempty{\Publisher}{}{\small \Edition\par\vspace{0.18cm}}}%
    \ifdefempty{\Publisher}{}{\small \Publisher\par\vspace{0.18cm}}%
    \ifdefempty{\PubYear}{}{\small \PubYear\par\vspace{0.18cm}}%
    \ifdefempty{\BookISBN}{}{\small ISBN \BookISBN\par\vspace{0.18cm}}%
    \endgroup
    \vspace{0.55cm}
    \begingroup
    \raggedleft
    {\normalsize \Translator\ \TranslatorRole\par}%
    \vspace{0.18cm}%
    {\small \ifdefempty{\TranslationDate}{\today}{\TranslationDate}\par}%
    \endgroup
    \vspace*{1.2cm}
  \end{titlepage}%
}
\providecommand{\maketitle}{}
\renewcommand{\maketitle}{\makecover}

\newcommand{\makecontents}{%
  \cleardoublepage
  \begingroup
  \pagestyle{empty}%
  \thispagestyle{empty}%
  \renewcommand{\contentsname}{目录}%
  \tableofcontents
  \cleardoublepage
  \endgroup
}

% ==================================================================
% 10. 章节样式
% ==================================================================
% ctex 的 scheme=chinese 会把「目录 / 书签」里的章号写成中文数字（第十一章），
% 而原书正文与运行眉一律用阿拉伯数字（第 11 章）。这里把 ctex 专用的
% \CTEXthechapter 也接到 \thechapter 上，使目录、书签、正文三者一致。
\renewcommand{\thechapter}{\arabic{chapter}}
\renewcommand{\CTEXthechapter}{\thechapter}

% 章：整段居中，小二 黑体；「第 11 章」与章标题同段，随宽度自然折行
% （原书第 296 页即「第 11 章　曲线积分、曲面积分、外微分 / 形式积分与场论」两行居中）；
% 章首页无页眉无页码。
\titleformat{\chapter}[block]
  {\normalfont\centering\fontsize{18pt}{26pt}\selectfont\headfont}
  {\if@mainmatter 第\,\thechapter\,章\quad\fi}
  {0pt}
  {}
\titlespacing*{\chapter}{0pt}{24pt}{28pt}
\assignpagestyle{\chapter}{plain}

% 节：居中，小三 黑体；节号与标题间空约 1em。
\titleformat{\section}[block]
  {\normalfont\centering\fontsize{15pt}{20pt}\selectfont\headfont}
  {\thesection}
  {0.8em}
  {}
\titlespacing*{\section}{0pt}{2.4ex plus 1ex minus .2ex}{1.4ex plus .2ex}

% 无编号章（目录、索引等）
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\centering\fontsize{18pt}{26pt}\selectfont\headfont}
  {}
  {0pt}
  {}
\titlespacing*{name=\chapter,numberless}{0pt}{20pt}{24pt}

% 小节标题（原书 11.x 下未再分小节，保留以备后用）
\ctexset{
  subsection={format=\normalfont\fontsize{13pt}{18pt}\selectfont\headfont,
              number={\thesubsection},aftername={}},
  subsubsection={format=\normalfont\fontsize{12pt}{16pt}\selectfont\headfont}
}

% ==================================================================
% 11. 页眉页脚（规范 §8.6；偶数页 章标题、奇数页 节标题；页码靠外）
% ==================================================================
\newif\ifInAppendix
\InAppendixfalse

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\chaptermark}[1]{%
  \if@mainmatter
    \ifInAppendix
      \markboth{附录 \thechapter\quad #1}{}%
    \else
      \markboth{第 \thechapter 章\quad #1}{}%
    \fi
  \else
    \markboth{#1}{}%
  \fi}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
\fancyhead[LE]{\small\hspace*{8pt}\thepage}
\fancyhead[CE]{\small\leftmark}
\fancyhead[CO]{\small\rightmark}
\fancyhead[RO]{\small\thepage\hspace*{8pt}}
\renewcommand{\headrulewidth}{0.6pt}
% 章首页：无页眉、无页码（与原书第 296 页一致）
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}
\fancypagestyle{empty}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

% ==================================================================
% 12. 定理型环境（规范 §4）
% ------------------------------------------------------------------
% · 行内标签 + 紧接正文；标签为黑体 + 粗体西文编号；无终止标点；
% · 编号挂在小节上 -> 显示为「章.节.序」，如 11.1.1；
% · 各类型计数器彼此独立（原书 定义 11.1.1 与 定理 11.1.1 并存即证）。
% ==================================================================
\newtheoremstyle{zmbplain}%
  {1.0\baselineskip}% 上方间距
  {1.0\baselineskip}% 下方间距
  {\normalfont}% 正文字体
  {\parindent}% 首行缩进 = 2 字
  {\headfont}% 标签字体
  {}% 标签后标点：无
  {0.6em}% 标签与正文间距
  {\thmname{#1}\thmnumber{\,#2}\thmnote{\,(#3)}}

\newtheoremstyle{zmbdefn}%
  {1.0\baselineskip}%
  {1.0\baselineskip}%
  {\normalfont}%
  {\parindent}%
  {\headfont}%
  {}%
  {0.6em}%
  {\thmname{#1}\thmnumber{\,#2}\thmnote{\,(#3)}}

\theoremstyle{zmbplain}
\newtheorem{theorem}{定理}[section]
\newtheorem{proposition}{命题}[section]
\newtheorem{lemma}{引理}[section]
\newtheorem{corollary}{推论}[section]
\newtheorem{axiom}{公理}[section]

\theoremstyle{zmbdefn}
\newtheorem{definition}{定义}[section]
\newtheorem{example}{例}[section]
\newtheorem{remark}{注}[section]
\newtheorem{exercise}{习题}[section]
\newtheorem{question}{思考}[section]

% ---- 带撇变体（原书 定义 11.1.1'、定理 11.1.1'）：与前一编号同号，仅加撇 ----
% 关键：amsthm 的 \begin{definition} 会 \refstepcounter 自增一次。要得到
% 「11.1.1'」而不是「11.1.2'」，必须在进入前先把计数器减 1，抵消这次自增：
%   前一个 definition 结束时计数器 = 1
%   definitionp 进入前 -1  -> 0 ；amsthm 自增 -> 1 ；\thedefinition 展开为 11.1.1'
%   退出后计数器仍为 1，故下一个普通 definition 自增到 2 -> 11.1.2  正确
% （\addtocounter 是全局的，所以减 1 不会被 \begin 的分组吞掉；
%   而 \thedefinition 的重定义是局部的，正好只在该环境内生效。）
\newcommand{\zmbprime}{\ensuremath{^{\prime}}}

\newcommand{\ZMB@mkprime}[2]{% #1 主环境名, #2 计数器名
  \newenvironment{#1p}{%
    \par\addvspace{1.0\baselineskip}%
    \addtocounter{#2}{-1}%
    \expandafter\def\csname the#2\endcsname{\thesection.\arabic{#2}\zmbprime}%
    \csname #1\endcsname
  }{%
    \csname end#1\endcsname
    \addvspace{1.0\baselineskip}%
  }%
}
\ZMB@mkprime{definition}{definition}
\ZMB@mkprime{theorem}{theorem}
\ZMB@mkprime{example}{example}
\ZMB@mkprime{proposition}{proposition}
\ZMB@mkprime{lemma}{lemma}
\ZMB@mkprime{corollary}{corollary}
\ZMB@mkprime{remark}{remark}

% ---- 外部引用（指向本册之外、本书其它章的编号对象） ----
% 原书大量引用第 6/9/10 章的定理，而本卷只重排第 11 章，这些目标不在文档内，
% 无法用 \label/\ref 闭合。故提供 \extref 明确标出「外部引用」，避免出现 ??，
% 也避免把跨章编号写死成无来源的裸文本。
\newcommand{\extref}[1]{\textup{#1}}   % 用法：\extref{定义 6.6.1}

% ==================================================================
% 13. 证明 / 解（规范兼容；□ 右顶格收尾）
% ==================================================================
% 让 \[ ... \] 等价于 amsmath 的 equation*（规范 §3.2 仍统一写 \[ \]）。
% 理由：原书的「证明」「解」结尾若是一串行间公式，收尾方框 □ 就落在该公式
% 【末行的右顶格】；而把 □ 放到公式行右端的标准手段是 amsmath 的 \tag*，
% 只有 equation*/align* 一类带标签位的环境才认它。把 \[ \] 接到 equation*
% 上，既保住规范要求的 \[ \] 写法，又拿到与原书一致的 □ 位置。
\AtBeginDocument{%
  \renewcommand{\[}{\begin{equation*}}%
  \renewcommand{\]}{\end{equation*}}%
}

\renewcommand{\proofname}{\headfont 证明}
% 收尾方框：原书为空心方框 □。unicode-math 未提供 \square，故用 \framebox
% 现画一个，不依赖任何字体是否有该字形（避免静默缺字）。
% 必须把 \fboxsep 归零，否则默认 3pt 的 \fboxsep 会把方框撑成竖长方形
% （实测 6.24pt x 11.42pt 而不是正方形）。这里令
%   总宽 = 0.5em                  （\fboxsep=0）
%   总高 = (0.5em - 2\fboxrule) + 2\fboxrule = 0.5em
% 两边严格相等，画出来就是正方形。
\DeclareRobustCommand{\oqedsquare}{%
  \ensuremath{\mathord{\vcenter{\hbox{%
    \setlength{\fboxsep}{0pt}%
    \setlength{\fboxrule}{0.55pt}%
    \framebox[\dimexpr 0.5em\relax]{\rule{0pt}{\dimexpr 0.5em-1.1pt\relax}}}}}}}
\renewcommand{\qedsymbol}{\oqedsquare}

% ---- 收尾方框的落位规则（与原书一致）----
% · 结尾是文字          -> \end{proof} 自己把 □ 右顶格（同 amsthm 效果）
% · 结尾是行间公式      -> 在该公式末行写 \qedhere，用 amsmath 的 \tag* 把 □ 落在
%                          该公式【末行】的右顶格；多行公式请用顶层 align*（规范
%                          §3.3.2 允许），\tag* 写在末行，即落在末行右端。
% 不再用「回退一个基线高度」的土办法：那要手工猜 \belowdisplayskip 与 \baselineskip
% 之和，实测偏移 15.6pt 落到了公式下一行，且随公式行数漂移。\tag* 由 amsmath 自己
% 管理边界，稳。
\newif\ifZMB@qed@done
\newcommand{\ZMB@qedmark}{\unskip\nobreak\hfill\ensuremath{\qedsymbol}}
\DeclareRobustCommand{\qedhere}{%
  \ifmmode
    \tag*{\ensuremath{\qedsymbol}}%
  \else
    \ZMB@qedmark
  \fi
  \global\ZMB@qed@donetrue}

% ---- 抑制自动收尾方框 ----
% 原书并非每个 proof / solution 都以 □ 结束：例 11.2.6 有两段「证法」，
% 只有最后一段（证法 2）末尾有 □，证法 1 末尾没有。在 proof/solution 的
% 末尾写 \noqedhere 即可抑制 \ZMB@thmclose 自动补出的 □（它把「已完成」
% 标志置真，\ZMB@thmclose 便不再补）。
\DeclareRobustCommand{\noqedhere}{\global\ZMB@qed@donetrue}

\newcommand{\ZMB@thmopen}[1]{%
  \par\ZMB@qed@donefalse
  \normalfont
  \topsep 0.4\baselineskip \@plus 2\p@ \@minus 2\p@ \relax
  \trivlist
  \itemindent\parindent
  \item[\hskip\labelsep\normalfont\headfont #1]\hspace{0.5em}\ignorespaces}
\newcommand{\ZMB@thmclose}{%
  \ifZMB@qed@done\else\ifhmode\ZMB@qedmark\fi\fi
  \endtrivlist\@endpefalse}

% 证明：标签黑体 + 约 1em 空白（原书作「证明　设……」，非冒号）。
\renewenvironment{proof}[1][\proofname]{\ZMB@thmopen{#1}}{\ZMB@thmclose}
% 解 / 解法 n：与证明同构，同样以 □ 收尾。
\newenvironment{solution}[1][解]{\ZMB@thmopen{#1}}{\ZMB@thmclose}

% ---- 等号上方写理由：\xlongequal ----
% 原书形如   A \xlongequal{积分中值定理} B ，
% 即把等号拉长成与理由同宽的横线、理由置于线上方。
%
% ★ 实现来源：**extarrows** 宏包（2020/03/12 v1.2.0），它用 amsmath/mathtools
%   的 \ext@arrow 可伸缩箭头机制定义 \xlongequal。
%   注意：mathtools 本体只提供 \xleftrightarrow，不含 \xlongequal；
%   extarrows 依赖的正是 mathtools/amsmath 的 \ext@arrow，所以两者需共存。
%   早期本cls 曾自建（用 \hbox to W{\hrulefill} + \limits^…），结果横线
%   沉到了理由文字**下方**，渲染成「文字加下划线」，与原书不符，已废弃。
%
% 本项目在此之上再加一层包装：把参数包进 \text{} 并用 \small，
% 使调用点可以直接写中文而无需自己套 \text{}（\text 内仍可再嵌 $…$）。
% 用法：
%   A \reason{积分中值定理} B          单行理由（\small）
%   A \reasonb{上标说明}{下标说明} B   双行（下方为可选参数风格）
%   A \xlongequal{积分中值定理} B      原书写法，与 \reason 等价
%   A \xlongequal[下]{上} B            双行
%
% ★ 关键差异（实测踩坑）：**上标注记可包 \text{}，下标注记不可**。
%   \ext@arrow 解析下标注记时仍处于数学模式，一旦被 \text{} 包住就变成
%   文本模式，于是 \substack / \begin{gathered} / $…$ 全部报
%   「Missing } inserted」「\begin{gathered} allowed only in math mode」
%   并级联出上百条错误、PDF 只出 304 页（基线 489）。
%   故 \reasonb 的第 2 参数直接以数学模式传入，调用点写数学内容
%   （多行用 \substack{…\\…}）；第 1 参数仍包 \text{} 以便写中文。
%
% ★ 下标注记的**两种正确写法**（探针逐变体实测）：
%     \reasonb{$t=t(u)$}{\text{换元}}   整条都是文字  -> 下标必须 \text{}
%     \reasonb{$\cdots>0$}{换元}          混排        -> 错的！裸中文缺字
%   下标注记处于数学模式，数学字体 XITSMath **无 CJK 字形**，
%   裸写中文会静默变成豆腐块，日志只给一行
%   「Missing character: There is no 换 (U+6362) in font [XITSMath-Regular.otf]」。
%   整本审计用 tools/_audit_reasonb_lower.py（--fix-dollar 可自动包 \text{}）。
% ★ 反过来，上标注记（第 1 参数）已被 \text{\small …} 包裹，
%   所以里面写纯数学内容必须**自己套 $…$**：\reason{$x=1$}。
\RequirePackage{extarrows}
\DeclareRobustCommand{\ZMB@reason}[1]{\xlongequal{\text{\small #1}}}
\DeclareRobustCommand{\ZMB@reasonb}[2]{%
  \xlongequal[#2]{\text{\small #1}}}
\newcommand{\reason}[1]{\ZMB@reason{#1}}
\newcommand{\reasonw}[1]{\ZMB@reason{#1}}
\newcommand{\reasonb}[2]{\ZMB@reasonb{#1}{#2}}

% ==================================================================
% 14. 插图（规范 §5）
% ==================================================================
\RequirePackage[labelsep=quad,font=small]{caption}
\captionsetup[figure]{name=图,labelsep=quad,position=bottom,skip=6pt}
\captionsetup[table]{name=表}

% 图号：「章.节.序」，如 图 11.1.8
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\@addtoreset{figure}{section}

% 并排两图（原书常见「图 11.2.1 / 图 11.2.2」并肩）
\newcommand{\figpair}[2]{%
  \begin{center}%
    \begin{minipage}[t]{0.46\textwidth}\centering #1\end{minipage}%
    \hfill
    \begin{minipage}[t]{0.46\textwidth}\centering #2\end{minipage}%
  \end{center}%
}

% 不用浮动体、就地居中的图（可保证与原书同页同位）
\newcommand{\fighere}[2][\linewidth]{%
  \begin{center}%
    \begin{minipage}{#1}\centering #2\end{minipage}%
  \end{center}%
}

% ==================================================================
% 14b. 列表编号体系（与原书完全一致）
% ------------------------------------------------------------------
% 依据原书影印件实测（第 7 章 p.1「定义 7.1.1」、p.13「练习题 7.1」）：
%   · 逐条列举的第一级  ->  (1) (2) (3)   半角括号 + Times 阿拉伯数字
%   · 第二级            ->  ① ② ③        圈码，占约一个汉字宽
%   · 第三、四级        ->  (a) (b) / (i) (ii)   （原书罕见，备而不用）
%   · 练习题/思考题的条目 ->  1. 2. 3.（黑体加粗句点，见下面的 exblock）
% 注意 LaTeX 默认的 1. / (a) / i. 与原书不符，须显式改掉。
% ==================================================================
% 圈码：Fandol 字族只提供 U+2460..U+2468（①-⑨），⑩ 以上会静默缺字变豆腐块。
% 为保证任意条数都不缺字，这里用 TikZ 现画一个圆把数字圈起来：矢量、随字号
% 缩放、不依赖任何字体是否有该字形，且 1~99 通吃。
\newcommand{\zmbcircled}[1]{%
  \tikz[baseline=(ZMB@c.base)]{%
    \node[draw,circle,inner sep=0pt,minimum size=0.90em,line width=0.45pt,
          font=\fontsize{7.5}{7.5}\selectfont](ZMB@c){#1};}}

\setlist[enumerate,1]{label=(\arabic*),ref=\arabic*,%
  leftmargin=2.6em,itemsep=0.15\baselineskip,topsep=0.2\baselineskip}
\setlist[enumerate,2]{label=\protect\zmbcircled{\arabic*},ref=\arabic*,%
  leftmargin=2.4em,itemsep=0.15\baselineskip,topsep=0.15\baselineskip}
\setlist[enumerate,3]{label=(\alph*),ref=\alph*,%
  leftmargin=2.2em,itemsep=0.12\baselineskip,topsep=0.12\baselineskip}
\setlist[enumerate,4]{label=(\roman*),ref=\roman*,%
  leftmargin=2.2em,itemsep=0.12\baselineskip,topsep=0.12\baselineskip}

% ==================================================================
% 15. 习题块（练习题 / 思考题 / 复习题）
% ------------------------------------------------------------------
% 原书：标题为黑体居中「练习题11.1」；条目「1.」起首，悬挂缩进，
%       条目内容与首行文字左齐。
% ==================================================================
\newcounter{exno}
\newlength{\exlabelwd}

\newcommand{\ZMB@exitem}{%
  \par\addvspace{0.5\baselineskip}%
  \refstepcounter{exno}%
  \edef\ZMB@cur{\theexno}%
  \settowidth{\exlabelwd}{\headfont\ZMB@cur.\enspace}%
  \hangindent\exlabelwd
  \hangafter=1
  \noindent{\headfont \ZMB@cur.}\enspace
  \ignorespaces}

% 保存原始 \item。exblock 若在内部再嵌套 enumerate 等标准列表，必须让
% 它们用回 LaTeX 自己的 \item，否则内层会误用 exblock 的编号、把外层计数器
% 吃掉（曾使练习题内层 (1)(2)… 显示成 2,3,…，并抛 15 个
% 「LaTeX Error: Something's wrong--perhaps a missing \item」）。
\let\ZMB@origitem\item
\newcommand{\ZMB@exdispatch}{%
  \ifnum\@listdepth>\ZMB@exdepth\relax
    \let\ZMB@thistem\ZMB@origitem
  \else
    \let\ZMB@thistem\ZMB@exitem
  \fi
  \ZMB@thistem}

\newenvironment{exblock}[1]{%
  \par\addvspace{1.2\baselineskip}%
  \noindent{\centering\fontsize{13pt}{18pt}\selectfont\headfont #1\par}%
  \addvspace{0.5\baselineskip}%
  \setcounter{exno}{0}%
  \begingroup
  \setlength{\parindent}{0pt}%
  \edef\ZMB@exdepth{\number\@listdepth}%
  \let\item\ZMB@exdispatch
}{%
  \par\endgroup\addvspace{0.8\baselineskip}%
}

% ==================================================================
% 16. 附录与后置部分（规范 §8.3）
% ==================================================================
\let\ZMB@orig@appendix\appendix
\renewcommand{\appendix}{%
  \cleardoublepage
  \ZMB@orig@appendix
  \InAppendixtrue
  \bookmarksetup{startatroot}%
}
\g@addto@macro\backmatter{\bookmarksetup{startatroot}}
\pretocmd{\listoffigures}{\bookmarksetup{startatroot}}{}{}
\pretocmd{\listoftables}{\bookmarksetup{startatroot}}{}{}
\AtBeginDocument{%
  \@ifpackageloaded{biblatex}{%
    \pretocmd{\printbibliography}{\bookmarksetup{startatroot}}{}{}%
  }{}%
}

\newcommand{\makebibliography}{%
  \backmatter
  \cleardoublepage
  \phantomsection
  \chapter*{参考文献}%
  \addcontentsline{toc}{chapter}{参考文献}%
  \markboth{参考文献}{参考文献}%
  \ifZMB@Biblatex
    \printbibliography[heading=none]%
  \fi}

% ==================================================================
% 17. cleveref 中文名
% ==================================================================
\newcommand{\ZMB@autorefname}[2]{%
  \expandafter\def\csname #1autorefname\endcsname{#2}}
\ZMB@autorefname{definition}{定义}
\ZMB@autorefname{theorem}{定理}
\ZMB@autorefname{proposition}{命题}
\ZMB@autorefname{lemma}{引理}
\ZMB@autorefname{corollary}{推论}
\ZMB@autorefname{remark}{注}
\ZMB@autorefname{example}{例}
\ZMB@autorefname{chapter}{章}
\ZMB@autorefname{section}{节}
\ZMB@autorefname{subsection}{小节}
\ZMB@autorefname{figure}{图}
\ZMB@autorefname{table}{表}
\ZMB@autorefname{equation}{式}

\crefname{definition}{定义}{定义}
\crefname{theorem}{定理}{定理}
\crefname{proposition}{命题}{命题}
\crefname{lemma}{引理}{引理}
\crefname{corollary}{推论}{推论}
\crefname{remark}{注}{注}
\crefname{example}{例}{例}
\crefname{equation}{式}{式}
\crefname{chapter}{章}{章}
\crefname{section}{节}{节}
\crefname{subsection}{小节}{小节}
\crefname{figure}{图}{图}
\crefname{table}{表}{表}

\endinput
