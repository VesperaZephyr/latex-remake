\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ahlfors}[2026/10/20 Ahlfors third edition retypesetting]
\LoadClass[10pt,twoside,openright,leqno]{book}
\RequirePackage[paperwidth=5.5in,paperheight=8.5in,inner=0.85in,outer=0.55in,top=0.64in,bottom=0.65in,headheight=12pt,headsep=16pt]{geometry}
\RequirePackage{fontspec}
\setmainfont{Latin Modern Roman}
\setsansfont{TeX Gyre Heros}
\RequirePackage[leqno]{amsmath}
\RequirePackage{amssymb,mathtools}
\RequirePackage{graphicx}
\RequirePackage{adjustbox}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{imakeidx}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{etoolbox}
\RequirePackage[hidelinks,hyperindex=true,hyperfootnotes=false,linktoc=all,bookmarksnumbered=true,pdfencoding=auto,colorlinks = true, linkcolor = blue, citecolor = red, urlcolor = teal]{hyperref}
\RequirePackage{bookmark}
\RequirePackage{needspace}
\raggedbottom
\setlength{\parindent}{1.25em}
\setlength{\parskip}{0pt}
\setlength{\skip\footins}{8pt plus 4pt minus 2pt}
\setlength{\emergencystretch}{2em}
\hyphenation{re-pa-ram-e-tri-za-tion ir-re-duc-ible}
\linespread{1.04}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\sffamily\bfseries\small\thepage\quad COMPLEX ANALYSIS}
\fancyhead[RO]{\sffamily\bfseries\small\MakeUppercase{\leftmark}\quad\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{#1}}{}}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[R]{\sffamily\bfseries\small\thepage}\renewcommand{\headrulewidth}{0pt}}
\fancypagestyle{bookindex}{\fancyhf{}\fancyhead[LE]{\sffamily\bfseries\small\thepage\quad INDEX}\fancyhead[RO]{\sffamily\bfseries\small INDEX\quad\thepage}\renewcommand{\headrulewidth}{0pt}}
\AtBeginEnvironment{theindex}{\pagestyle{bookindex}}
\titleformat{\chapter}[hang]{\sffamily\bfseries\Large\raggedright}{\fontsize{25}{28}\selectfont\thechapter}{1em}{\MakeUppercase}
\titleformat{name=\chapter,numberless}[hang]{\sffamily\bfseries\Large\raggedright}{}{0pt}{}
\titlespacing*{\chapter}{0pt}{0pt}{145pt}
\titleformat{\section}{\sffamily\bfseries\normalsize}{\thesection.}{0.7em}{\MakeUppercase}
\titlespacing*{\section}{-2.5em}{2ex plus .5ex}{1ex}
\titleformat{\subsection}[runin]{\bfseries\itshape}{\thesubsection.}{0.6em}{}[.]
\titlespacing*{\subsection}{0pt}{1.5ex plus .3ex}{0.6em}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\theHsection}{\thechapter.\arabic{section}}
\renewcommand{\theHsubsection}{\theHsection.\arabic{subsection}}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
\newcounter{originalstatement}
\newenvironment{originalstatement}[3][]{\par\addvspace{1ex}\refstepcounter{originalstatement}\def\@currentlabel{#3}\noindent\textbf{#2\ifstrempty{#3}{}{ #3}\ifstrempty{#1}{}{ (#1)}.}\ \itshape}{\par\addvspace{1ex}}
\newenvironment{originalassertion}{\par\itshape}{\par}
\newenvironment{proof}{\par\noindent\textit{Proof.}\ }{\par}
\newcommand{\sourcepage}[1]{\hypertarget{orig-p\number\numexpr#1-16\relax}{}\csuse{sourceindex@#1}}
\newcommand{\bookfigure}[3]{\begin{figure}[htbp]\centering\csuse{figuretargets@#1@#2}\edef\figureasset{figures/p\ifnum#1<100 0\fi#1-\ifnum#2<10 0\fi#2.pdf}\IfFileExists{\figureasset}{\begin{adjustbox}{max width=.95\linewidth,max totalheight=.55\textheight}\includegraphics{\figureasset}\end{adjustbox}}{\PackageError{ahlfors}{Missing figure \figureasset}{Regenerate figure assets.}}\ifstrempty{#3}{}{\par\small #3}\end{figure}}
\newcommand{\originalnumber}[2]{\Needspace{4\baselineskip}\phantomsection\def\@currentlabel{#1}\label{#2}}
\DeclareMathOperator{\Log}{Log}
\DeclareMathOperator{\Arg}{Arg}
\DeclareMathOperator{\Res}{Res}
\DeclareMathOperator{\res}{res}
\DeclareMathOperator{\Rea}{Re}
\DeclareMathOperator{\Ima}{Im}
\newcommand{\C}{\mathbb C}
\newcommand{\R}{\mathbb R}
\newcommand{\Z}{\mathbb Z}
\makeindex[intoc]
\newcommand{\hyperpagenote}[1]{\hyperpage{#1}\textit{n.}}
% tools/repair_pdf_destinations.py checks page destinations after the last pass.
