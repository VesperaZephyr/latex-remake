% ============================================================
% pms32.cls -- Princeton Mathematical Series 32 re-typesetting class
%
% Layout parameters derived from the PaddleOCR-VL-1.6 JSON of the
% original scan (309 pages, block labels + bboxes):
%   * physical page       : 6.125in x 9.25in  (441 x 666 pt @72dpi)
%   * text block          : x in [124, 755] of 850  -> width ~327pt,
%                           left margin ~0.90in, right margin ~0.68in
%   * running head        : y ~109-128 (same line as the folio),
%                           centred on the text block;
%                           folio at x~128 on even pages, x~744 on odd
%   * body text starts    : y ~145 of 1132 -> top margin ~1.05in
%   * paragraph style     : first-line indent ~19px (~10pt), no parskip
%
% Numbering scheme read off the original book:
%   * chapters   : CHAPTER I, II, ... VII   (Roman)
%   * sections   : 1., 2., ...              (reset per chapter)
%   * equations  : (section.number) e.g. (1.5), reset per chapter
%   * theorems / lemmas / corollaries share ONE counter with equations,
%     so the printed sequence inside a section is 1.1, 1.2, (1.5), 1.7 ...
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pms32}[2026/09/26 v1.0 PMS-32 book class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,twoside,openright,final]{book}

% ---------- page geometry (from JSON bbox measurement) ----------
\RequirePackage{geometry}
\geometry{
  paperwidth=6.125in,
  paperheight=9.25in,
  inner=0.90in,
  outer=0.72in,
  top=1.05in,
  bottom=1.10in,
  headheight=13pt,
  headsep=15pt,
  footskip=22pt,
  heightrounded
}

% ---------- fonts: Times text, MathTime Pro 2 mathematics ----------
% The book was composed in Monotype Times.  newtxtext gives the text face,
% mtpro2 (= MathTime Pro 2, the Times-compatible math font) the mathematics.
% Only the Lite subset of mtpro2 is installed here, and ``lite'' forces
% \mtp@fullfalse, which switches off every package option that would select
% the Script / Blackboard / Fraktur alphabets (they are gated behind the
% complete font set).  Those faces *are* part of the Lite set, so they are
% wired up by hand right after the package.
\RequirePackage[T1]{fontenc}
% the original prints every equation number in the LEFT margin
\RequirePackage[leqno]{amsmath}
\RequirePackage{amsthm}
\RequirePackage{newtxtext}
\RequirePackage[lite,uprightGreek,uprightoperators,curlybraces]{mtpro2}

% MathTime Pro 2 alphabets.
%   Script      U/mt2ms -- chapter I calls the Schwartz class \mathscr{S};
%                          the other chapters call the same kind of letters
%                          \mathcal{D}, \mathcal{S}, \mathcal{M}, ...  The
%                          printed book has ONE script face, so both names
%                          are given it.
%   Blackboard  U/mt2bb -- \mathbb{C}, \mathbb{R}, \mathbb{Q}
%   Fraktur     U/mt2mf -- the Siegel upper half plane \mathfrak{H}
\DeclareMathAlphabet{\mathcal}  {U}{mt2ms}{m}{it}
\SetMathAlphabet    {\mathcal}  {bold}{U}{mt2ms}{b}{it}
\DeclareMathAlphabet{\mathbcal} {U}{mt2ms}{b}{it}
\let\mathscr\mathcal
\DeclareMathAlphabet{\mathbb}   {U}{mt2bb}{m}{n}
\SetMathAlphabet    {\mathbb}   {bold}{U}{mt2bb}{b}{n}
\DeclareMathAlphabet{\mathfrak} {U}{mt2mf}{m}{n}
\SetMathAlphabet    {\mathfrak} {bold}{U}{mt2mf}{b}{n}

% amssymb comes last: it supplies the AMS symbols the Lite set leaves out.
% Its own \mathbb / \mathfrak declarations are wrapped in \@ifundefined
% (amsfonts.sty), so the MathTime alphabets above survive it.
\RequirePackage{amssymb}
\RequirePackage{microtype}
% NOTE: mathtools must NOT be loaded here -- it breaks ``aligned`` inside
% \left...\right (all piecewise definitions in this book), cf. test t1.tex
\RequirePackage{bm}

% ---------- numbering ----------
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\theequation}{\thesection.\arabic{equation}}
\counterwithin*{equation}{section}

% theorem-like environments share the equation counter (matches the book)
\theoremstyle{plain}
\newtheorem{theorem}[equation]{THEOREM}
\newtheorem{lemma}[equation]{LEMMA}
\newtheorem{corollary}[equation]{COROLLARY}
\newtheorem{proposition}[equation]{PROPOSITION}
\renewcommand{\thetheorem}{\thesection.\arabic{equation}}
\renewcommand{\thelemma}{\thesection.\arabic{equation}}
\renewcommand{\thecorollary}{\thesection.\arabic{equation}}
\renewcommand{\theproposition}{\thesection.\arabic{equation}}
\renewcommand{\proofname}{PROOF}

% ---------- the numbered remarks of the "Further Results" sections ----------
% Every chapter closes with a section of numbered remarks -- Chapter II 5.1-5.8,
% Chapter III 6.1-6.16, IV 5.1-5.10, VI 5.1-5.10, VII 6.1-6.10.  Their number is
% the SECTION number of "Further Results" plus the index of the remark, and the
% running text refers to them exactly like an equation: "further details can be
% found in (5.8) below", "introduced in (6.13) of Chapter III".  They are not
% equations, so they get their own counter; \frp{<sec>}{<num>} prints "<sec>.<num>."
% and records the label frp:c<chapter>-<sec>-<num>.
\newcounter{frp}[section]
\renewcommand{\thefrp}{\thesection.\arabic{frp}}
\newcommand{\frp}[2]{%
  \refstepcounter{frp}%
  \label{frp:c\arabic{chapter}-#1-#2}%
  \paragraph{#1.#2.}}

% the book marks the end of a proof by nothing at all, and prints the head
% "PROOF." in small capitals
\renewcommand{\qedsymbol}{}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep\scshape #1\@addpunct{.}]\ignorespaces
}{\popQED\endtrivlist\@endpefalse}

% Prime variants (e.g., Theorem 4.4', Corollary 1.3') that don't advance the counter
\newtheorem{innercustomthm}{THEOREM}
\newenvironment{customthm}[1]
  {\renewcommand\theinnercustomthm{#1}\innercustomthm}
  {\endinnercustomthm}
\newtheorem{innercustomcor}{COROLLARY}
\newenvironment{customcor}[1]
  {\renewcommand\theinnercustomcor{#1}\innercustomcor}
  {\endinnercustomcor}
\newtheorem{innercustomlem}{LEMMA}
\newenvironment{customlem}[1]
  {\renewcommand\theinnercustomlem{#1}\innercustomlem}
  {\endinnercustomlem}

\theoremstyle{definition}
\newtheorem{definition}[equation]{DEFINITION}
\renewcommand{\thedefinition}{\thesection.\arabic{equation}}

% ---------- titles ----------
\RequirePackage{titlesec}
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\contentsname}{CONTENTS}
\titleformat{\chapter}[display]
  {\normalfont\large\filcenter}
  {\filcenter CHAPTER \thechapter}
  {1.5ex}
  {\large}
\titlespacing*{\chapter}{0pt}{0pt}{2.5ex}

\titleformat{\section}
  {\normalfont\bfseries\filcenter}
  {\thesection.}{0.5em}{}
\titlespacing*{\section}{0pt}{2.2ex plus .6ex minus .2ex}{1.2ex plus .3ex}

\titleformat{\subsection}
  {\normalfont\bfseries\filcenter}
  {}{0pt}{}
\titlespacing*{\subsection}{0pt}{1.8ex plus .5ex}{1ex}

% unnumbered chapter-end note heading ("Bibliographical Notes")
\newcommand{\bibnoteshead}{%
  \begin{center}\bfseries Bibliographical Notes\end{center}\vspace{0.5ex}}

% ---------- running heads ----------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter: #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\S\thesection. #1}}
\fancyhead[EC]{\small\MakeUppercase{\leftmark}}
\fancyhead[OC]{\small\MakeUppercase{\rightmark}}
\fancyhead[LE,RO]{\small\thepage}
\renewcommand{\headrulewidth}{0pt}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

% ---------- paragraph shape ----------
\setlength{\parindent}{10pt}
\setlength{\parskip}{0pt}
\RequirePackage{indentfirst}

% the original text block is narrow and the mathematics dense: allow a little
% extra stretch so that wide displays do not overflow the measure
\setlength{\emergencystretch}{2.5em}
\allowdisplaybreaks[2]

% ---------- floats ----------
\RequirePackage{graphicx}
\graphicspath{{figures/}}
\RequirePackage{caption}

% ---------- index ----------
\RequirePackage{imakeidx}
\makeindex[columns=2,intoc=true,title={Index}]

% ---------- bibliography (biblatex / biber, mandatory) ----------
\RequirePackage[backend=biber,style=alphabetic,sorting=nyt,
  hyperref=auto,backref=true,backrefstyle=three]{biblatex}

% ---------- hyperlinks & bookmarks ----------
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[colorlinks=true,linkcolor=blue,citecolor=red,
  urlcolor=MidnightBlue,linktoc=all,
  bookmarksnumbered=true,bookmarksopen=true,bookmarksopenlevel=1]{hyperref}
\RequirePackage{bookmark}
\bookmarksetup{numbered,open,openlevel=1}

% appendix / back matter bookmarks stay at root level
\RequirePackage{etoolbox}
\pretocmd{\printbibliography}{\bookmarksetup{startatroot}}{}{}
\pretocmd{\listoffigures}{\bookmarksetup{startatroot}}{}{}
\pretocmd{\listoftables}{\bookmarksetup{startatroot}}{}{}
\AtBeginDocument{%
  \@ifpackageloaded{makeidx}{%
    \pretocmd{\printindex}{\bookmarksetup{startatroot}}{}{}}{}}

% ---------- misc ----------
\RequirePackage{enumitem}
\RequirePackage[normalem]{ulem}
\RequirePackage{textcomp}

% helper: footnote-style raised marker used in the original for notes
\newcommand{\note}[1]{$^{#1}$}

\endinput
