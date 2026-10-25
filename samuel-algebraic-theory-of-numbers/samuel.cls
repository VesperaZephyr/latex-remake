%% samuel.cls -- re-typeset template for
%%   Pierre Samuel, "Algebraic Theory of Numbers"
%%   Hermann, Paris, 1967 (English translation: Benjamin, 1970; reprint: AMS Chelsea)
%%
%% Layout reproduced from the original:
%%   * paper 141 x 188.5 mm; text block 103 x 152 mm
%%   * Times text + Times math (TeX Gyre Termes)
%%   * chapter opening: centered "Chapter I" (small caps), centered large title,
%%     no running head, no folio
%%   * section heads: bold "1.1  Title" (chapter.section), not underlined
%%   * statements: italic run-in "Theorem 1.  ..." ; separate counters for
%%     theorem / proposition / corollary / lemma / definition, each restarting
%%     inside every section, displayed as bare numbers
%%   * display equations numbered "(n)" per section, flush right
%%   * running heads
%%       verso: folio | CHAPTER TITLE | §§ c.s1--c.s2 (or § c.s)
%%       recto: §§ c.s1--c.s2 | SECTION TITLE | folio
%%   * pages numbered continuously in arabic, matching the printed folios
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{samuel}[2026/10/22 Samuel re-typeset template]
\LoadClass[10pt,twoside,openany]{book}

%% ---------- fonts: Times (TeX Gyre Termes) ----------
\RequirePackage{fontspec}
\setmainfont{texgyretermes}[
  Extension=.otf,
  UprightFont=*-regular, BoldFont=*-bold,
  ItalicFont=*-italic, BoldItalicFont=*-bolditalic,
  SmallCapsFeatures={Letters=SmallCaps},
]
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\setmathfont{texgyretermes-math.otf}
\RequirePackage{mathtools}
\RequirePackage[english]{babel}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\setlength{\emergencystretch}{2em}

%% ---------- base type size (measured from the original: 8.5/9.8 pt) ----------
\renewcommand{\normalsize}{\fontsize{8.5}{9.8}\selectfont}
\renewcommand{\small}{\fontsize{7.5}{9}\selectfont}
\renewcommand{\footnotesize}{\fontsize{7}{8.5}\selectfont}
\normalsize

%% ---------- page geometry (measured: text 113 x 158 mm) ----------
\RequirePackage{geometry}
\geometry{
  paperwidth=141.7mm, paperheight=189.2mm,
  textwidth=113mm, textheight=158mm,
  inner=12.5mm, outer=16.2mm, top=18mm,
  headheight=11pt, headsep=4mm, footskip=8mm
}

%% ---------- running heads ----------
\RequirePackage{fancyhdr}
\RequirePackage{afterpage}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\newcommand{\chaptertitle}{}
\newcommand{\currentsectitle}{}
\newcommand{\currentseccode}{}
\newcommand{\pagefirstsec}{}
\newcommand{\secrange}{}
% "§ 1.1" when the page starts and ends in the same section, else
% "§§ 1.1--1.2" (sections appearing on the page), computed explicitly:
% \pagefirstsec is the section in force at the start of the page,
% \currentseccode the last section begun on it.
\newcommand{\makesecrange}{%
  \ifx\pagefirstsec\empty
    \def\secrange{}%
  \else
    \ifx\pagefirstsec\currentseccode
      \edef\secrange{§\,\currentseccode}%
    \else
      \edef\secrange{§§\,\pagefirstsec--\currentseccode}%
    \fi
  \fi
}
\fancyhead[LE]{\normalfont\small\thepage}
\fancyhead[RO]{\normalfont\small\thepage}
\fancyhead[CE]{\normalfont\scshape\small\chaptertitle}
\fancyhead[CO]{\normalfont\small\currentsectitle}
\fancyhead[RE]{\normalfont\small\makesecrange\secrange}
\fancyhead[LO]{\normalfont\small\makesecrange\secrange}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\normalfont\small\thepage}%
}
\fancypagestyle{emptyhead}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

%% \folio{n}: advance the page counter to the original printed folio n,
%% never rewind (so repeated builds stay stable if we run long).
\newcommand{\folio}[1]{\ifnum\value{page}<#1\relax\setcounter{page}{#1}\fi}

%% ---------- chapter opening ----------
%% \chapterhead{<arabic>}{<roman>}{<Title>}{<TITLE IN CAPS>}
\newcommand\chapterhead[4]{%
  \clearpage
  \setcounter{section}{0}%
  \renewcommand{\chapnum}{#1}%
  \renewcommand{\seclabelprefix}{#1.}%
  \renewcommand{\chaptertitle}{#4}%
  \def\currentsectitle{}%
  \thispagestyle{emptyhead}%
  \pdfbookmark[0]{Chapter #2: #3}{chap:#2}%
  \phantomsection
  \edef\@currentlabel{#2}%
  \label{chap:#2}%
  \addtocontents{toc}{\string\chlc{#2}{#3}{\thepage}{chap:#2}}%
  \begingroup
    \centering
    {\large\scshape Chapter #2\par}\vspace{1.4\baselineskip}
    {\huge #3\par}
  \endgroup
  \vspace{2.2\baselineskip}%
  \@afterheading
}
\newcommand{\chapnum}{1}

%% ---------- front-matter division heading ----------
%% \fmhead{<title>}{<running head>}{<toc anchor>}
\newcommand\fmhead[3]{%
  \clearpage
  \renewcommand{\chapnum}{}%
  \renewcommand{\chaptertitle}{#2}%
  \def\currentsectitle{}%
  \thispagestyle{emptyhead}%
  \phantomsection
  \pdfbookmark[0]{#1}{fm:#3}%
  \edef\@currentlabel{\thepage}%
  \label{fm:#3}%
  \addtocontents{toc}{\string\fml{#1}{\thepage}{fm:#3}}%
  \begin{center}{\Large #1}\end{center}%
  \vspace{1.6\baselineskip}%
  \@afterheading
}

%% ---------- bold unnumbered division head (Supplement subsections) ----------
\newcounter{divbm}
\newcommand\divhead[1]{%
  \par\medskip
  \phantomsection
  \stepcounter{divbm}%
  \pdfbookmark[1]{#1}{div:\arabic{divbm}}%
  \renewcommand{\currentsectitle}{\MakeUppercase{#1}}%
  \noindent{\bfseries #1}%
  \par\nobreak\vspace{0.4\baselineskip}%
  \@afterheading
}

%% ---------- section headings ----------
\newcommand{\seclabelprefix}{?}
\newcommand{\seccodeof}[1]{\seclabelprefix#1}
%% \sechead{<section>}{<Title for ToC/recto head>}{<TITLE FOR RUNNING HEAD>}
\newcommand\sechead[3]{%
  \par\bigskip
  \stepcounter{section}%
  \phantomsection
  \edef\@currentlabel{#1}%
  \edef\@seclab{\chapnum.#1}%
  \pdfbookmark[1]{#1}{sec:\@seclab}%
  \label{sec:\@seclab}%
  \renewcommand{\currentsectitle}{\MakeUppercase{#3}}%
  \global\let\currentseccode\@seclab
  \afterpage{\global\let\pagefirstsec\currentseccode}%
  \addtocontents{toc}{\string\chls{#1}{#2}{\thepage}{sec:\@seclab}}%
  \markboth{\@seclab}{\@seclab}%
  \noindent{\bfseries \@seclab\quad #2}%
  \par\nobreak\vspace{0.5\baselineskip}%
  \@afterheading
}
%% \subsechead{<code>}{<Title>}   e.g. (a), (b) ; not in ToC
\newcommand\subsechead[2]{%
  \par\medskip
  \phantomsection
  \ifx\relax#1\relax
    \noindent{\itshape #2}%
  \else
    \edef\@seclab{\chapnum.#1}%
    \label{sec:\@seclab}%
    \noindent{\itshape #1\quad #2}%
  \fi
  \par\nobreak\vspace{0.35\baselineskip}%
  \@afterheading
}
%% \annexhead{<Title>}{<TITLE FOR RUNNING HEAD>} -- unnumbered Appendix
\newcommand\annexhead[2]{%
  \par\bigskip
  \phantomsection
  \edef\@seclab{\chapnum.Appendix}%
  \pdfbookmark[1]{Appendix: #1}{sec:\@seclab}%
  \label{sec:\@seclab}%
  \renewcommand{\currentsectitle}{\MakeUppercase{#2}}%
  \addtocontents{toc}{\string\chlapp{}{#1}{\thepage}{sec:\@seclab}}%
  \begin{center}
    {\scshape Appendix}\par\vspace{0.8\baselineskip}
    {\itshape #1\par}
  \end{center}
  \vspace{0.8\baselineskip}\@afterheading
}
%% \apphead{<code>}{<Title>}{<TITLE FOR RUNNING HEAD>}
\newcommand\apphead[3]{%
  \par\bigskip
  \phantomsection
  \edef\@seclab{\chapnum.Appendix}%
  \label{sec:\@seclab}%
  \renewcommand{\currentsectitle}{\MakeUppercase{#3}}%
  \addtocontents{toc}{\string\chlapp{#1}{#2}{\thepage}{sec:\@seclab}}%
  \noindent{\bfseries Appendix.\quad #2}%
  \par\nobreak\vspace{0.5\baselineskip}%
  \@afterheading
}

%% ---------- statements: italic run-in, bare numbers per section ----------
\makeatletter
\newcounter{stmt}
\newcounter{theorem}
\newcounter{proposition}
\newcounter{corollary}
\newcounter{lemma}
\newcounter{definition}
\newcounter{conjecture}
\newcounter{example}
\newcounter{remark}
\counterwithin{theorem}{section}
\counterwithin{proposition}{section}
\counterwithin{corollary}{section}
\counterwithin{lemma}{section}
\counterwithin{definition}{section}
\counterwithin{conjecture}{section}
\counterwithin{example}{section}
\counterwithin{remark}{section}
\def\thetheorem{\arabic{theorem}}
\def\theproposition{\arabic{proposition}}
\def\thecorollary{\arabic{corollary}}
\def\thelemma{\arabic{lemma}}
\def\thedefinition{\arabic{definition}}
\def\theconjecture{\arabic{conjecture}}
\def\theexample{\arabic{example}}
\def\theremark{\arabic{remark}}

%% \begin{theorem}[<name>] ... renders "Theorem N (name)." with a normal
%% number, as in the original ("Theorem 2 (Chevalley)." etc.)
\newenvironment{samstatement}[3]{%
  \par\addvspace{0.2\baselineskip}%
  \refstepcounter{#1}%
  \noindent{\itshape #2\ \csname the#1\endcsname\ifx\\#3\\\else{} (#3)\fi.\ }%
  \ignorespaces
  \itshape
}{%
  \par\addvspace{0.1\baselineskip}%
}
\makeatother
\newenvironment{theorem}[1][]{\begin{samstatement}{theorem}{Theorem}{#1}}{\end{samstatement}}
\newenvironment{proposition}[1][]{\begin{samstatement}{proposition}{Proposition}{#1}}{\end{samstatement}}
\newenvironment{corollary}[1][]{\begin{samstatement}{corollary}{Corollary}{#1}}{\end{samstatement}}
\newenvironment{lemma}[1][]{\begin{samstatement}{lemma}{Lemma}{#1}}{\end{samstatement}}
\newenvironment{definition}[1][]{\begin{samstatement}{definition}{Definition}{#1}}{\end{samstatement}}
\newenvironment{conjecture}[1][]{\begin{samstatement}{conjecture}{Conjecture}{#1}}{\end{samstatement}}
\newenvironment{example}[1][]{\begin{samstatement}{example}{Example}{#1}}{\end{samstatement}}
\newenvironment{remark}[1][]{\begin{samstatement}{remark}{Remark}{#1}}{\end{samstatement}}
\newenvironment{unnumremark}{\begin{samstatement}{remark}{Remark}{}}{\end{samstatement}}
%% generic unnumbered statement with an arbitrary label, e.g.
%% \begin{statement}{Corollary of theorem 1} ... \end{statement}
\newenvironment{statement}[1]{%
  \par\addvspace{0.2\baselineskip}\noindent{\itshape #1.\ }\itshape
}{%
  \par\addvspace{0.1\baselineskip}%
}

%% ---------- proofs: roman body, italic "Proof." label, auto Q.E.D. mark ----------
\newenvironment{proof}[1][Proof]{%
  \par\addvspace{0.5\baselineskip}\noindent
  {\itshape #1.}\hspace{0.5em}\ignorespaces
}{%
  \leavevmode\nobreak\hspace{0.7em}\qed
  \par\addvspace{0.25\baselineskip}%
}
\newcommand{\qed}{Q.E.D.}

%% ---------- lists ----------
\newlist{alist}{enumerate}{2}
\setlist[alist,1]{label=(\alph*),leftmargin=2.0em,itemsep=0.1ex,topsep=0.3ex}
\newlist{nlist}{enumerate}{2}
\setlist[nlist,1]{label=\arabic*),leftmargin=2.0em,itemsep=0.1ex,topsep=0.3ex}
\newlist{rlist}{enumerate}{2}
\setlist[rlist,1]{label=(\roman*),leftmargin=2.0em,itemsep=0.1ex,topsep=0.3ex}
\setlist[itemize,1]{label=--,leftmargin=2.0em,topsep=0.3ex}

%% ---------- equation numbering ----------
\AtBeginDocument{%
  \numberwithin{equation}{section}%
  \renewcommand{\theequation}{\arabic{equation}}%
  \renewcommand{\theHequation}{\arabic{equation}}%
}

%% ---------- ToC ----------
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,linkcolor=blue!70!black,citecolor=blue!70!black,
  urlcolor=blue!70!black,
  pdftitle={Algebraic Theory of Numbers},pdfauthor={Pierre Samuel}}
\makeatletter
\renewcommand{\tableofcontents}{%
  \clearpage
  \thispagestyle{emptyhead}%
  \pdfbookmark[0]{Contents}{toc}%
  \begin{center}{\Large\scshape Contents}\end{center}%
  \vspace{1.2\baselineskip}%
  \@starttoc{toc}%
}
\newcommand{\hyperpage@samuel}[2]{%
  \@ifundefined{r@#2}{#1}{\hyperref[#2]{#1}}}
\newcommand{\tocline@samuel}[4]{%
  \par\noindent {#1}\dotfill\ \hyperpage@samuel{#2}{#3}\par}
\newcommand{\fml}[3]{%
  \addvspace{1.0\baselineskip}%
  \tocline@samuel{\bfseries\scshape #1}{#2}{#3}{}}
\newcommand{\chlc}[4]{%
  \addvspace{1.2\baselineskip}%
  \tocline@samuel{\bfseries \textsc{Chapter #1}\quad #2}{#3}{#4}{}}
\newcommand{\chls}[4]{%
  \nobreak\vspace{0.25\baselineskip}%
  \par\noindent\hspace{2em}#1.\quad #2\dotfill\ \hyperpage@samuel{#3}{#4}\par}
\newcommand{\chlapp}[4]{%
  \nobreak\vspace{0.25\baselineskip}%
  \par\noindent\hspace{2em}Appendix\quad #2\dotfill\ \hyperpage@samuel{#3}{#4}\par}
\newcommand{\chlu}[4]{%
  \par\noindent\hspace{3.5em}{\itshape #1\quad #2}\dotfill\ \hyperpage@samuel{#3}{#4}\par}
\makeatother

%% ---------- math shortcuts ----------
\newcommand{\Z}{\mathbf{Z}}
\newcommand{\Q}{\mathbf{Q}}
\newcommand{\R}{\mathbf{R}}
\newcommand{\C}{\mathbf{C}}
\newcommand{\N}{\mathbf{N}}
\newcommand{\F}{\mathbf{F}}
\newcommand{\A}{\mathbf{A}}
\newcommand{\Gal}{\mathrm{Gal}}
\newcommand{\Aut}{\mathrm{Aut}}
\newcommand{\Hom}{\mathrm{Hom}}
\newcommand{\End}{\mathrm{End}}
\newcommand{\GL}{\mathrm{GL}}
\newcommand{\SL}{\mathrm{SL}}
\newcommand{\Spec}{\mathrm{Spec}}
\newcommand{\Ker}{\mathrm{Ker}}
\newcommand{\Coker}{\mathrm{Coker}}
\newcommand{\Ima}{\mathrm{Im}}
\newcommand{\Tr}{\mathrm{Tr}}
\newcommand{\Norm}{\mathrm{N}}
\newcommand{\disc}{\mathrm{D}}

\endinput
