\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{examcollection}[2026/10/20 Recalled mathematics examination collection]
\LoadClass[UTF8,zihao=-4,fontset=fandol,oneside]{ctexart}
\RequirePackage[paperwidth=199.3mm,paperheight=277.7mm,left=19mm,right=19mm,top=17mm,bottom=20mm,headheight=14pt,headsep=7mm]{geometry}
\RequirePackage{amsmath,amssymb,mathtools,bm,esint,graphicx,needspace,fancyhdr,longtable,booktabs}
\RequirePackage[unicode,hidelinks,bookmarksnumbered]{hyperref}
\RequirePackage{bookmark}
\setmainfont{TeX Gyre Termes}
\setsansfont{TeX Gyre Heros}
\setlength{\parindent}{1em}
\setlength{\parskip}{2pt plus 1pt}
\linespread{1.16}
\setlength{\abovedisplayskip}{6pt plus 2pt minus 2pt}
\setlength{\belowdisplayskip}{6pt plus 2pt minus 2pt}
\setlength{\emergencystretch}{2em}
\allowdisplaybreaks[2]
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small 2024--2026 年各高校数学分析真题汇总}
\fancyhead[R]{\small 精校稿}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\newcounter{exam}
\newcounter{sourceblock}
\newcommand{\examhead}[3]{%
  \par\addvspace{16pt}\Needspace{10\baselineskip}%
  \refstepcounter{exam}\label{exam:#1}%
  \addcontentsline{toc}{section}{\protect\numberline{#1}#2}%
  {\centering\heiti\large #1.\quad #2\par}%
  {\centering\scriptsize 原书第 #3 页起\par}\nobreak\smallskip}
\newcommand{\question}[1]{\par\addvspace{3pt}\noindent #1.\enspace}
\newcommand{\majorquestion}[1]{\par\Needspace{5\baselineskip}\question{#1}}
\newcommand{\blockanchor}[1]{\refstepcounter{sourceblock}\label{block:#1}}
\newcommand{\auditref}[2]{\hyperref[block:#1]{#2}}
\newcommand{\R}{\mathbb{R}}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\arccot}{arccot}
\DeclareMathOperator{\sh}{sh}
\DeclareMathOperator{\ch}{ch}

\newsavebox{\formulabox}
\newcommand{\displayformula}[1]{%
  \[\sbox{\formulabox}{$\displaystyle #1$}%
  \ifdim\wd\formulabox>\linewidth
    \typeout{FORMULA-WIDTH block=\arabic{sourceblock} width=\the\wd\formulabox limit=\the\linewidth}%
    \resizebox{\linewidth}{!}{\usebox{\formulabox}}%
  \else\usebox{\formulabox}\fi\]}
\tolerance=3000
\setlength{\emergencystretch}{4em}
\endinput
