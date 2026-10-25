%% serreladic.cls -- re-typeset template for
%%   J.-P. Serre, "Abelian l-Adic Representations and Elliptic Curves"
%%   (Research Notes in Mathematics 7; Benjamin 1968 / A K Peters 1998)
%%
%% Design fidelity notes:
%%  * paper 156 x 234 mm, text block 108 mm wide (as the original)
%%  * running heads: verso  "<chap>-<page>   ABELIAN l-ADIC REPRESENTATIONS"
%%                   recto  "<chapter short title>   <chap>-<page>"
%%  * pages numbered *within* the chapter:  I-1, II-42, B-5, Index-3;
%%    front matter lowercase roman (v, vii, xiii, ...)
%%  * chapter opening: centered "CHAPTER I" + centered uppercase title,
%%    no running head, bare folio bottom center
%%  * section heads  "§2.  l-ADIC REPRESENTATIONS OF NUMBER FIELDS" (underlined)
%%  * subsections    "1.1.  Definition" / "A.1.  Equipartition" (underlined)
%%  * statements: THEOREM/PROPOSITION/COROLLARY/LEMMA/DEFINITION + "--",
%%    numbered EXACTLY as the original (manual numbers, some unnumbered);
%%    body set in italics (the original underlines them)
%%  * display equations are unnumbered throughout (as the original)
%%  * the Index points to *section codes* (e.g. III.A.2), not pages
%%  * bibliography: biblatex, numbering locked to the original [1]-[78] + supp.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{serreladic}[2026/10/12 Serre l-adic re-typeset template]
\LoadClass[11pt]{book}

%% ---------- encoding / fonts ----------
%% XeLaTeX + fontspec (TU encoding): native Unicode, so that diacritics
%% (Čebotarev, Šafarevič, Astérisque, Œuvres...) typeset correctly.
\usepackage{fontspec}
\setmainfont{lmroman12}[
  Extension=.otf, UprightFont=*-regular, BoldFont=*-bold,
  ItalicFont=*-italic, BoldItalicFont=lmroman10-bolditalic,
  SmallCapsFont=lmromancaps10-regular,
]
\newfontfamily\capsfont{lmromancaps10-regular}[Extension=.otf]
\RequirePackage[english]{babel}
\RequirePackage{amsmath,amssymb,mathtools}
\RequirePackage{enumitem}
\RequirePackage{ulem}          % \uline : underlined heads (original style)
\normalem
\RequirePackage[
  paperwidth=156mm,paperheight=234mm,
  textwidth=108mm,textheight=182mm,
  top=25mm,inner=20mm,
  headheight=14pt,headsep=7mm,footskip=9mm
]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{hyperref}     % hyperref BEFORE biblatex
\RequirePackage[
  backend=biber,style=numeric,sorting=serre,labelnumber=true,
  giveninits=true,
  autocite=inline,
  maxbibnames=10,minbibnames=1,maxcitenames=2,
  isbn=false,url=false,doi=false,eprint=false
]{biblatex}
\hypersetup{
  colorlinks=true, linkcolor=blue!50!black, citecolor=green!35!black,
  urlcolor=blue!60!black, bookmarksnumbered=false,
  pdftitle={Abelian l-Adic Representations and Elliptic Curves},
  pdfauthor={Jean-Pierre Serre}
}

%% ---------- page-numbering machinery ----------
%% Kernel \pagenumbering{<style>} re-defines \thepage globally, so any
%% custom format must be re-applied afterwards.  We therefore keep the
%% printing style separate (\serrepagfmt) and rebuild \thepage/\theHpage
%% after every \pagenumbering call.
\newcommand\chapcode{}
\newcommand\serrepagfmt{\arabic{page}}% used when \chapcode is empty
\newcommand\serrefixpage{%
  \renewcommand\thepage{%
    \ifx\chapcode\empty \serrepagfmt \else \chapcode-\arabic{page}\fi}%
  \ifx\theHpage\undefined
    \newcommand\theHpage{\thepage}%
  \else
    \renewcommand\theHpage{\thepage}%
  \fi}% destinations == printed folio
\serrefixpage % initial state (hyperref not loaded yet -- safe now)

%% \fmroman{n}  -- front-matter switch: roman folios beginning at n
\newcommand\fmroman[1]{%
  \pagenumbering{roman}\setcounter{page}{#1}%
  \renewcommand\serrepagfmt{\romannumeral\c@page}%
  \serrefixpage}

%% \folio{n} -- force the (roman) folio of the next front-matter head to
%%   the original book's number, but only forward: if our typesetting runs
%%   longer than the original block we simply keep counting on, so that no
%%   roman folio is ever printed twice.
\newcommand\folio[1]{\ifnum\value{page}<#1\relax\setcounter{page}{#1}\fi}

%% folio printed on chapter / back-matter OPENING pages is bare arabic
\newcommand\chapfolio{\arabic{page}}

%% ---------- running heads ----------
\newcommand\bktitle{ABELIAN \textit{l}-ADIC REPRESENTATIONS}
\newcommand\capsshorttitle{}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LE]{\normalfont\small\thepage}
\fancyhead[RO]{\normalfont\small\thepage}
\fancyhead[RE]{\normalfont\small\bktitle}
\fancyhead[LO]{\normalfont\small\capsshorttitle}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\normalfont\small\chapfolio}%
}
\fancypagestyle{fmplain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\normalfont\small\thepage}%
}
%% continuation heads (the styles set by \pagestyle, not \thispagestyle):
%%  * fmfancy  -- front matter / Supplementary Bibliography: same geometry
%%                as `fancy' (folio on the outer edge) but the *section*
%%                name replaces the book title on the inner edge
%%  * idxfancy -- Index: bare folio on the outer edge, no other running head
%% (the body / main-bibliography continuation head is the plain `fancy' style)
\fancypagestyle{fmfancy}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhead[LE]{\normalfont\small\thepage}%
  \fancyhead[RE]{\normalfont\small\capsshorttitle}%
  \fancyhead[LO]{\normalfont\small\capsshorttitle}%
  \fancyhead[RO]{\normalfont\small\thepage}%
}
\fancypagestyle{idxfancy}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhead[LE]{\normalfont\small\thepage}%
  \fancyhead[RO]{\normalfont\small\thepage}%
}

%% ---------- chapter opening ----------
%% \chapterhead{I}{l-adic Representations}{l-ADIC REPRESENTATIONS}{SHORT HEAD}
\newcommand\chapterhead[4]{%
  \clearpage
  \def\chapcode{#1}%
  \setcounter{page}{1}%
  \renewcommand\capsshorttitle{#4}%
  \thispagestyle{plain}%
  \pagestyle{fancy}%
  \pdfbookmark[0]{Chapter #1: #2}{chap:#1}%
  \phantomsection
  \edef\@currentlabel{#1}%
  \label{chap:#1}%
  \addtocontents{toc}{\string\chlc{Chapter #1}{#2}{\thepage}{chap:#1}}%
  \begingroup
    \centering
    {\scshape Chapter\ #1\par}
    \vspace{2.4\baselineskip}
    {#3\par}
  \endgroup
  \vspace{2.4\baselineskip}
}

%% ---------- front matter head ----------
%% \fmhead[13]{INTRODUCTION}{Introduction}{introduction}{INTRODUCTION}
%%   1st (optional)   : starting folio as an arabic number (5=v, 7=vii, 13=xiii ...)
%%   2nd (mandatory)  : the heading as printed at the top of the page
%%   3rd (mandatory)  : title used in bookmarks and in the Contents
%%   4th (mandatory)  : label/anchor suffix  (referenced as fm:<name>)
%%   5th (mandatory)  : running head on the following pages
%% When the optional folio is given the page counter is only *advanced* to
%% it (never rewound), so repeated builds stay stable.
\newcommand\fmhead[5][]{%
  \clearpage
  \ifx\\#1\\\else\ifnum\value{page}<#1\relax\setcounter{page}{#1}\fi\fi
  \renewcommand\capsshorttitle{#5}%
  \thispagestyle{fmplain}%
  \pagestyle{fmfancy}%
  \pdfbookmark[0]{#3}{fm:#4}%
  \phantomsection
  \edef\@currentlabel{\thepage}%
  \label{fm:#4}%
  \addtocontents{toc}{\string\fml{#3}{\thepage}{fm:#4}}%
  \begingroup
    \centering #2\par
  \endgroup
  \vspace{1.8\baselineskip}
}

%% ---------- section / subsection heads ----------
%% \sechead{2}{l-adic representations of number fields}{l-ADIC REPRESENTATIONS OF NUMBER FIELDS}
%%   prints  "§2.  <UPPERCASE>" underlined ; \ref{sec:I.2} -> 2
\newcounter{secaux}
\newcommand\sechead[3]{%
  \par\bigskip
  \refstepcounter{secaux}%
  \phantomsection
  \edef\@currentlabel{#1}%
  \pdfbookmark[1]{§#1  #2}{sec:\chapcode.#1}%
  \label{sec:\chapcode.#1}%
  \addtocontents{toc}{\string\chls{#1}{#2}{\thepage}{sec:\chapcode.#1}}%
  \noindent
  \uline{\bfseries §#1.\ \ #3}%
  \par\nobreak\vspace{0.8\baselineskip}%
}
%% \apphead{Killing arithmetic groups in tori}{KILLING ARITHMETIC GROUPS IN TORI}
%%   following subsections get code A.1, A.2, ... (references: III.A.1 etc.)
\newcommand\apphead[2]{%
  \par\bigskip
  \refstepcounter{secaux}%
  \phantomsection
  \edef\@currentlabel{A}%
  \pdfbookmark[1]{Appendix  #1}{sec:\chapcode.A}%
  \label{sec:\chapcode.A}%
  \addtocontents{toc}{\string\chlapp{Appendix}{#1}{\thepage}{sec:\chapcode.A}}%
  \noindent
  \uline{\bfseries Appendix.\ \ #2}%
  \par\nobreak\vspace{0.8\baselineskip}%
}
%% \subsechead{1.1}{Definition}  -- code given explicitly (1.1 ... 2.8, A.1 ...)
%%   \ref{sec:I.1.1} -> 1.1 ; \ref{sec:III.A.2} -> A.2
\newcommand\subsechead[2]{%
  \par\medskip
  \phantomsection
  \edef\@currentlabel{#1}%
  \pdfbookmark[2]{#1  #2}{sec:\chapcode.#1}%
  \label{sec:\chapcode.#1}%
  \addtocontents{toc}{\string\chlu{#1}{#2}{\thepage}{sec:\chapcode.#1}}%
  \noindent
  \uline{#1.\ \ #2}%
  \par\nobreak\vspace{0.5\baselineskip}%
}
%% sub-subsections exist only in the chapter IV appendix: A.1.1, A.2.1 ...
\newcommand\subsubsechead[2]{%
  \par\medskip
  \phantomsection
  \edef\@currentlabel{#1}%
  \pdfbookmark[3]{#1  #2}{sec:\chapcode.#1}%
  \label{sec:\chapcode.#1}%
  \addtocontents{toc}{\string\chlu{#1}{#2}{\thepage}{sec:\chapcode.#1}}%
  \noindent
  \uline{#1.\ \ #2}%
  \par\nobreak\vspace{0.5\baselineskip}%
}

%% ---------- statement environments ----------
%% hidden counter only to mint unique hyperref anchors
\newcounter{stmt}
%% \begin{stmt}{THEOREM}{1}  ...  \end{stmt}     (numbered)
%% \begin{stmt}{LEMMA}{}      ...  \end{stmt}     (unnumbered)
\newenvironment{stmt}[2]{%
  \par\addvspace{1.15\baselineskip}%
  \refstepcounter{stmt}%
  \ifx\\#2\\\else\protected@edef\@currentlabel{#2}\fi
  \noindent
  {\bfseries #1\ifx\\#2\\\else\ #2\fi\/\textbf{~---}\hspace{0.55em}\itshape}%
  \ignorespaces
}{\par\addvspace{0.45\baselineskip}}
\newenvironment{theorem}[1][]{\begin{stmt}{THEOREM}{#1}}{\end{stmt}}
\newenvironment{proposition}[1][]{\begin{stmt}{PROPOSITION}{#1}}{\end{stmt}}
\newenvironment{corollary}[1][]{\begin{stmt}{COROLLARY}{#1}}{\end{stmt}}
\newenvironment{lemma}[1][]{\begin{stmt}{LEMMA}{#1}}{\end{stmt}}
\newenvironment{dfn}[1][]{\begin{stmt}{DEFINITION}{#1}}{\end{stmt}}
\newenvironment{scholium}[1][]{\begin{stmt}{SCHOLIUM}{#1}}{\end{stmt}}

%% ---------- proofs ----------
\newenvironment{proof}[1][Proof]{%
  \par\noindent{\itshape #1.}\hspace{0.6em}\ignorespaces
}{%
  \hspace*{\fill}$\square$\par\smallskip
}

%% ---------- "Remarks" / "Examples" / "Exercises" running heads ----------
\newcommand\runhead[1]{%
  \par\medskip\noindent\uline{#1}\par\nobreak\vspace{0.5\baselineskip}}
\newenvironment{remarks}{\runhead{Remarks}\ignorespaces}{\par\medskip}
\newenvironment{examples}{\runhead{Examples}\ignorespaces}{\par\medskip}
\newenvironment{exercises}{\runhead{Exercises}\ignorespaces}{\par\medskip}

%% ---------- compact lists ----------
\newlist{alist}{enumerate}{2}
\setlist[alist,1]{label=(\alph*),leftmargin=2.2em,itemsep=0.15ex,topsep=0.4ex}
\newlist{nlist}{enumerate}{2}
\setlist[nlist,1]{label=\arabic*),leftmargin=2.2em,itemsep=0.15ex,topsep=0.4ex}
\newlist{rlist}{enumerate}{2}
\setlist[rlist,1]{label=(\roman*),leftmargin=2.2em,itemsep=0.15ex,topsep=0.4ex}
\setlist[itemize,1]{label=--,leftmargin=2.2em,topsep=0.5ex}

%% ---------- math shortcuts ----------
\newcommand{\tens}{\mathbin{\otimes}}
\newcommand{\GLV}{\mathrm{GL}_V}
\newcommand{\Z}{\mathbf{Z}}
\newcommand{\Q}{\mathbf{Q}}
\newcommand{\R}{\mathbf{R}}
\newcommand{\C}{\mathbf{C}}
\newcommand{\N}{\mathbf{N}}
\newcommand{\F}{\mathbf{F}}
\newcommand{\A}{\mathbf{A}}
\newcommand{\Gm}{\mathbf{G}_m}
\newcommand{\Gal}{\mathrm{Gal}}
\newcommand{\Aut}{\mathrm{Aut}}
\newcommand{\Hom}{\mathrm{Hom}}
\newcommand{\End}{\mathrm{End}}
\newcommand{\GL}{\mathrm{GL}}
\newcommand{\SL}{\mathrm{SL}}
\DeclareMathOperator{\PSL}{PSL}
\DeclareMathOperator{\PGL}{PGL}
\DeclareMathOperator{\SU}{SU}
\DeclareMathOperator{\SO}{SO}
\DeclareMathOperator{\Sp}{Sp}
\DeclareMathOperator{\GSp}{GSp}
\DeclareMathOperator{\Occ}{Occ}
\newcommand{\Spec}{\mathrm{Spec}}
\newcommand{\Supp}{\mathrm{Supp}}
\newcommand{\Ker}{\mathrm{Ker}}
\newcommand{\Coker}{\mathrm{Coker}}
\newcommand{\Ima}{\mathrm{Im}}

\endinput
