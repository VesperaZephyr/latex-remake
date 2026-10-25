% ==============================================================================
% katz-antwerp.cls -- Document class for:
%   Nicholas M. Katz, "p-adic properties of modular schemes and modular forms"
%   International Summer School on Modular Functions, Antwerp 1972
%   (Lecture Notes in Mathematics 350, Springer, 1973; pages 69-190)
%
% Re-typeset matching the original preprint layout:
%   * paper 170 x 244 mm; text block 128 mm wide
%   * running head: folio centred at the top of every page, and the
%     preprint code "Ka-<n>" at the OUTER top corner (n = folio - 68)
%   * chapter opening: "Chapter N: <title>" underlined, flush left
%   * section heads "1.1  <title>" underlined, number outdented to margin
%   * paragraph items and theorem-like statements share ONE counter per
%     section:  (1.1.3) item, THEOREM 1.1.4, ...
%   * displayed equations are numbered per ENCLOSING unit, left-aligned
%     (leqno):  (2.6.1.1), (2.6.1.2), ...
%   * statements: underlined head, upright body; proofs end with "QED"
%   * bibliography: biblatex/biber, entries numbered as the original
%     (0..48 plus "15 bis", "33.bis", "42 1/2"); the list prints the original
%     wording verbatim from each entry's `katext` field and cites print [N]
%   * a subject index (makeindex), added as a value-add
% ==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{katz-antwerp}[2026/10/12 v1.0 Katz Antwerp 1972 re-typeset class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,twoside,openany,final]{book}
\RequirePackage{setspace}
\setstretch{1.1}
% ------------------------------------------------------------------------------
% 1. Page geometry (measured from the original: 170 x 244 mm; text block
%    ~128 mm wide, left/right margins ~21 mm; body top ~25 mm, bottom ~42 mm)
% ------------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{
  paperwidth  = 170mm,
  paperheight = 244mm,
  textwidth   = 128mm,
  textheight  = 180mm,
  top         = 25mm,
  inner       = 21mm,
  outer       = 21mm,
  headheight  = 14pt,
  headsep     = 8mm,
  footskip    = 12mm,
  heightrounded
}

% ------------------------------------------------------------------------------
% 2. Fonts (XeLaTeX + fontspec): clean Latin Modern, per the re-typeset series.
% ------------------------------------------------------------------------------
\RequirePackage{fontspec}
\setmainfont{lmroman10}[
  Extension=.otf, UprightFont=*-regular, BoldFont=*-bold,
  ItalicFont=*-italic, BoldItalicFont=*-bolditalic,
  SmallCapsFont=lmromancaps10-regular,
]
\newfontfamily\capsfont{lmromancaps10-regular}[Extension=.otf]
\RequirePackage[english]{babel}

% ------------------------------------------------------------------------------
% 3. Math & typography
% ------------------------------------------------------------------------------
\RequirePackage[leqno]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{microtype}
\RequirePackage{bm}
\RequirePackage{ulem}
\normalem
\RequirePackage{xspace}
\RequirePackage{xstring}

% ------------------------------------------------------------------------------
% 4. Colors & hyperlinks
% ------------------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{kabib}{RGB}{0, 102, 51}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks = true,
  linkcolor  = blue!50!black,
  citecolor  = kabib,
  urlcolor   = blue!60!black,
  linktoc    = all,
  bookmarksnumbered = true,
  pdfauthor  = {Nicholas M. Katz},
  pdftitle   = {p-adic properties of modular schemes and modular forms},
  pdfsubject = {Mathematics - Arithmetic Algebraic Geometry},
}

% ------------------------------------------------------------------------------
% 5. Bibliography (biblatex + biber).  The original cites by BARE BRACKETED
%    NUMBERS ([14], [33], [15 bis], [42 1/2], ...) and prints the reference list
%    as "0. ... 1. ... 15 bis. ..." (label, period, hanging indent).
%
%    Each .bib entry carries
%      shorthand = {<original label>}  -> \cite prints [<label>] verbatim and
%                                          the list prints the same label
%      sortkey   = {<zero-padded>}     -> locks the original list order
%      katext    = {<original text>}   -> the list prints the ORIGINAL wording
%                                          verbatim (see katz.dbx + the drivers
%                                          below), so the printed list is a
%                                          faithful reproduction while the
%                                          \cite links stay clickable.
% ------------------------------------------------------------------------------
\RequirePackage[backend=biber,style=numeric,sorting=katz,datamodel=katz]{biblatex}
\addbibresource{references.bib}
\DeclareSortingTemplate{katz}{\sort{\field{sortkey}}}
% list label: numeric labels print "N."; the lettered labels "15 bis" / "33.bis"
% print verbatim (no added period), matching the original exactly.
%
% NB: numeric.bbx renders the list label via
%   \printtext[labelnumberwidth]{\printfield{labelprefix}\printfield{labelnumber}}
% so #1 arrives as the UNEXPANDED token list and \IfSubStr{#1} can never see the
% literal "bis".  Read the (expanded) shorthand field instead.  Also, numeric.bbx
% is loaded at \begin{document} and would clobber our formats, so redeclare them
% \AtBeginDocument to win.
\newcommand{\kabiblabel}[1]{%
  \begingroup
  \edef\kb@lbl{\ifdef\abx@field@shorthand{\abx@field@shorthand}{}}%
  \expandafter\endgroup
  \expandafter\kb@bislabel\expandafter{\kb@lbl}{#1}}
\newcommand{\kb@bislabel}[2]{\IfSubStr{#1}{bis}{#2}{#2.}}
\AtBeginDocument{%
  \DeclareFieldFormat{labelnumberwidth}{\kabiblabel{#1}}%
  \DeclareFieldFormat{shorthandwidth}{\kabiblabel{#1}}%
}
% in-text \cite: "[N]" with the shorthand verbatim
\DeclareFieldFormat{shorthand}{\mkbibbrackets{#1}}
% the list body prints the original text verbatim from the katext field
% (note: biblatex renames @phdthesis to entry type `thesis`, so cover both).
\DeclareBibliographyDriver{book}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{article}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{incollection}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{inproceedings}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{thesis}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{phdthesis}{\printfield{katext}\finentry}
\DeclareBibliographyDriver{misc}{\printfield{katext}\finentry}

% ------------------------------------------------------------------------------
% 5b. Index (makeidx + \printindex).  The original has no index; this is added
%     as a value-add, matching the book's typography.  `theindex' is redefined
%     to a single-column list with no chapter head (index.tex prints its own
%     underlined "Index" head), since the book's page is a single narrow column.
% ------------------------------------------------------------------------------
\RequirePackage{makeidx}
\makeindex
\renewenvironment{theindex}%
  {\parindent\z@ \parskip\z@ \@plus .3\p@\relax
   \let\item\@idxitem}%
  {}

% ------------------------------------------------------------------------------
% 6. Graphics (native TikZ only)
% ------------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{matrix,arrows,calc,positioning}
\RequirePackage{tikz-cd}
\RequirePackage{array}

% ------------------------------------------------------------------------------
% 7. Running heads.  Every page carries: folio centred at the top, and the
%    preprint code "Ka-<n>" at the outer top corner, with n = folio - 68.
% ------------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\newcommand{\kacode}{\the\numexpr\value{page}-68\relax}
\newcommand{\karunhead}{%
  \fancyhead[C]{\normalfont\small\thepage}%
  \fancyhead[RO]{\normalfont\small Ka-\kacode}%
  \fancyhead[LE]{\normalfont\small Ka-\kacode}%
}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\karunhead
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \karunhead
}
% title page: no running head at all
\fancypagestyle{empty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
}

% ------------------------------------------------------------------------------
% 8. Front-matter folio control: advance the page counter to the original's
%    folio at each major head (only forward, never rewind).
% ------------------------------------------------------------------------------
\newcommand{\kaheadfolio}[1]{\ifnum\value{page}<#1 \setcounter{page}{#1}\fi}

% ------------------------------------------------------------------------------
% 9. Numbering.  The original assigns its numbers BY HAND and irregularly:
%      section c.s; paragraph items and displays share ONE per-section
%      sequence that may begin at 0 (2.2.0, 2.3.0) or run (2.2.1)...(2.2.11);
%      displays nested under a numbered item read c.s.i.j (2.5.1.0, 2.6.1.1);
%      chapter 1 and the appendices use further variants (1.2.1, 1.6.2.1,
%      1.11.0.3, 1.9.0.0, A1.3.17, A2.4.1).
%    Therefore every number is supplied EXPLICITLY as an argument (fidelity
%    first), while a hidden counter mints unique hyperref anchors so the
%    numbers remain clickable.
% ------------------------------------------------------------------------------
\counterwithin*{section}{chapter}
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
\newcounter{kaanchor}

% TOC section number column: default is 2.3em, too narrow for the appendix
% codes like "(A1.5)" / "A1.11"; widen it so those entries do not overflow.
\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{3.4em}}

% --- chapter opening -----------------------------------------------------------
% \chapterhead{N}{Chapter title}
% Style = LaTeX `book' default (huge bold "Chapter N", then Huge bold title,
% ragged right), but the ORIGINAL number N is supplied explicitly (fidelity).
% Emits a level-0 bookmark and a TOC chapter entry.
\newcommand{\chapterhead}[2]{%
  \clearpage
  \thispagestyle{plain}%
  \phantomsection
  \edef\@currentlabel{#1}%
  \label{chap:#1}%
  \addcontentsline{toc}{chapter}{Chapter #1:\quad #2}%
  \vspace*{50\p@}%
  {\parindent\z@ \raggedright \normalfont
   \interlinepenalty\@M
   \huge\bfseries Chapter #1\par\nobreak
   \vskip 20\p@
   \Huge\bfseries #2\par\nobreak
   \vskip 40\p@}%
}

% --- appendix opening (TOP-LEVEL bookmark, not nested under the last chapter) --
% \apphead{Appendix 1}{Motivations}
\newcommand{\apphead}[2]{%
  \clearpage
  \thispagestyle{plain}%
  \phantomsection
  \edef\@currentlabel{#1}%
  \label{chap:#1}%
  \addcontentsline{toc}{chapter}{#1:\quad #2}%
  \vspace*{50\p@}%
  {\parindent\z@ \raggedright \normalfont
   \interlinepenalty\@M
   \huge\bfseries #1\par\nobreak
   \vskip 20\p@
   \Huge\bfseries #2\par\nobreak
   \vskip 40\p@}%
}

% --- section head --------------------------------------------------------------
% \sechead{1.1}{Modular forms of level 1}
% \sechead[alt-key]{A1.2}{title}  -- optional first arg overrides the hyperref
%   anchor key when the ORIGINAL prints the same number twice (appendix 1's
%   "A1.2" heads both "Homomorphy at ∞" and "Modular forms and de Rham
%   cohomology"), so the printed text stays faithful while the label is unique.
% Style = LaTeX `book' default (\Large\bfseries), but the ORIGINAL number is
% supplied explicitly.  \addcontentsline feeds both the TOC line and (via
% hyperref) the level-1 bookmark.
\newcommand{\sechead}[3][]{%
  \def\@kaseckey{#1}%
  \ifx\@kaseckey\@empty\def\@kaseckey{#2}\fi
  \par\addvspace{3.5ex \@plus 1ex \@minus .2ex}%
  \phantomsection
  \edef\@currentlabel{#2}%
  \label{sec:\@kaseckey}%
  \label{ka:\@kaseckey}%
  \addcontentsline{toc}{section}{\protect\numberline{#2}#3}%
  \noindent{\normalfont\Large\bfseries #2\quad #3}%
  \par\nobreak\addvspace{2.3ex \@plus .2ex}%
}
% appendix section head: code given explicitly ("A1.1")
\newcommand{\appsechead}[2]{\sechead{#1}{#2}}

% --- section mark (TOC + bookmark, NO printed head) ----------------------------
% The original's Table of Contents lists every section 3.1-3.13 / 4.1-4.5, but
% several of them (3.1, 3.2, 3.3, 3.5, 3.9, 4.3) appear in the body WITHOUT a
% printed section head -- their content opens directly as "Theorem 3.1", item
% "3.5.0", etc.  \secmark reproduces exactly that: it contributes the TOC line
% and the level-1 bookmark at the right place, but prints nothing.
\newcommand{\secmark}[3][]{%
  \def\@kaseckey{#1}%
  \ifx\@kaseckey\@empty\def\@kaseckey{#2}\fi
  \phantomsection
  \label{sec:\@kaseckey}%
  \addcontentsline{toc}{section}{\protect\numberline{#2}#3}%
}

% --- paragraph item "(N)" ------------------------------------------------------
% \kaitem{2.2.1}  text ...           prints "(2.2.1)"
% \kaitemb{4.2.0.} text ...          prints "4.2.0." verbatim (section openers,
%   and the few numbered items the original prints without parentheses)
% \kaitem[key]{N} / \kaitemb[key]{N}: optional first arg overrides the hyperref
%   anchor key when the ORIGINAL prints the same number twice.
\newcommand{\kaitem}[2][]{%
  \def\ka@key{#1}\ifx\ka@key\@empty\def\ka@key{#2}\fi
  \refstepcounter{kaanchor}%
  \protected@edef\@currentlabel{#2}%
  \label{ka:\ka@key}%
  \par\addvspace{0.7\baselineskip}\noindent(#2)\enspace\ignorespaces
}
\newcommand{\kaitemb}[2][]{%
  \def\ka@key{#1}\ifx\ka@key\@empty\def\ka@key{#2}\fi
  \refstepcounter{kaanchor}%
  \protected@edef\@currentlabel{#2}%
  \label{ka:\ka@key}%
  \par\addvspace{0.7\baselineskip}\noindent#2\enspace\ignorespaces
}

% --- numbered display equation, number in the left margin ----------------------
% \begin{kadisp}{2.2.10} <math> \end{kadisp}          (number prints "(2.2.10)")
% \begin{kadispb}{1.6.2.1} <math> \end{kadispb}       (number prints "1.6.2.1")
% amsmath's `leqno' already puts the tag in the left margin.
% \begin{kadisp}[key]{N} overrides the anchor key (duplicated original numbers).
\newenvironment{kadisp}[2][]{%
  \def\ka@key{#1}\ifx\ka@key\@empty\def\ka@key{#2}\fi
  \refstepcounter{kaanchor}%
  \protected@edef\@currentlabel{#2}%
  \begin{equation}\tag{#2}\label{ka:\ka@key}\begin{aligned}}%
  {\end{aligned}\end{equation}}
% display whose number the original prints WITHOUT parentheses
\newenvironment{kadispb}[2][]{%
  \def\ka@key{#1}\ifx\ka@key\@empty\def\ka@key{#2}\fi
  \refstepcounter{kaanchor}%
  \protected@edef\@currentlabel{#2}%
  \begin{equation}\tag*{#2}\label{ka:\ka@key}\begin{aligned}}%
  {\end{aligned}\end{equation}}
% unnumbered display
\newenvironment{kadispstar}{\begin{equation*}\begin{aligned}}{\end{aligned}\end{equation*}}

% --- theorem-like statements: default amsthm `plain' style ---------------------
% Head is bold ("Theorem 1.6.1."), body italic -- the LaTeX default.  The
% ORIGINAL number is supplied explicitly as #3 (some carry a trailing period,
% e.g. "Theorem 4.3."); the label key drops that period so in-text \ref/\eqref
% always resolve against "ka:<bare-number>".
\newcommand{\ka@stripdot}[1]{%
  \IfEndWith{#1}{.}{\StrGobbleRight{#1}{1}[\ka@clean]}{\def\ka@clean{#1}}%
}
\newenvironment{kathm}[3][]{%
  \ka@stripdot{#3}%
  \def\ka@key{#1}\ifx\ka@key\@empty\def\ka@key{\ka@clean}\fi
  \par\addvspace{0.9\baselineskip}%
  \refstepcounter{kaanchor}%
  \protected@edef\@currentlabel{\ka@clean}%
  \label{ka:\ka@key}%
  \noindent{\normalfont\bfseries #2\ #3}%
  \hspace{0.5em}\itshape\ignorespaces
}{\par\addvspace{0.5\baselineskip}}
% statement with an unnumbered head (Remark., Proof., etc.) -- default amsthm
% `remark' style: italic head, upright body.
% \begin{kathmstar}[key]{Head}  -- key (if given) makes the head ref-able.
\newenvironment{kathmstar}[2][]{%
  \def\ka@key{#1}%
  \par\addvspace{0.9\baselineskip}%
  \ifx\ka@key\@empty\else
    \refstepcounter{kaanchor}%
    \protected@edef\@currentlabel{\ka@key}%
    \label{ka:\ka@key}%
  \fi
  \noindent{\normalfont\itshape #2}%
  \hspace{0.5em}\upshape\ignorespaces
}{\par\addvspace{0.5\baselineskip}}

% --- proofs (default amsthm style: italic head, upright body, QED = \square) ---
\renewcommand{\qedsymbol}{$\square$}
\newenvironment{kaproof}[1][Proof]{%
  \par\addvspace{0.5\baselineskip}%
  \noindent{\normalfont\itshape #1.}\hspace{0.5em}\upshape\ignorespaces
}{%
  \hspace*{\fill}$\square$\par\addvspace{0.5\baselineskip}%
}
\newenvironment{kaproofstar}[1][Proof]{%
  \par\addvspace{0.5\baselineskip}%
  \noindent{\normalfont\itshape #1.}\hspace{0.5em}\upshape\ignorespaces
}{\par\addvspace{0.5\baselineskip}}

% ------------------------------------------------------------------------------
% 11. Math macros used throughout the text
% ------------------------------------------------------------------------------
\newcommand{\Z}{\mathbf{Z}}
\newcommand{\Q}{\mathbf{Q}}
\newcommand{\R}{\mathbf{R}}
\newcommand{\C}{\mathbf{C}}
\newcommand{\N}{\mathbf{N}}
\newcommand{\F}{\mathbf{F}}
\newcommand{\PP}{\mathbf{P}}
\newcommand{\W}{\mathbb{W}}
\newcommand{\Gm}{\mathbf{G}_m}
\newcommand{\Gmhat}{\widehat{\mathbf{G}}}
\newcommand{\Gahat}{\widehat{\mathbf{G}}}
\newcommand{\Spec}{\operatorname{Spec}}
\newcommand{\Spf}{\operatorname{Spf}}
\newcommand{\Proj}{\operatorname{Proj}}
\newcommand{\Aut}{\operatorname{Aut}}
\newcommand{\End}{\operatorname{End}}
\newcommand{\Hom}{\operatorname{Hom}}
\newcommand{\Isom}{\operatorname{Isom}}
\newcommand{\GL}{\operatorname{GL}}
\newcommand{\SL}{\operatorname{SL}}
\newcommand{\PGL}{\operatorname{PGL}}
\newcommand{\PSL}{\operatorname{PSL}}
\newcommand{\Gal}{\operatorname{Gal}}
\newcommand{\Ker}{\operatorname{Ker}}
\newcommand{\Coker}{\operatorname{Coker}}
\newcommand{\Image}{\operatorname{Im}}
\newcommand{\Lie}{\operatorname{Lie}}
\newcommand{\Der}{\operatorname{Der}}
\newcommand{\Sym}{\operatorname{Sym}}
\newcommand{\tr}{\operatorname{tr}}
\newcommand{\ord}{\operatorname{ord}}
\newcommand{\rank}{\operatorname{rank}}
\newcommand{\card}{\operatorname{card}}
\newcommand{\dR}{DR}
\newcommand{\w}{\underline{\omega}}
\newcommand{\cO}{\mathcal{O}}
\newcommand{\cL}{\mathcal{L}}
\newcommand{\cM}{\mathcal{M}}
\newcommand{\cF}{\mathcal{F}}
\newcommand{\cG}{\mathcal{G}}
\newcommand{\cH}{\mathcal{H}}
\newcommand{\cC}{\mathcal{C}}
\newcommand{\cD}{\mathcal{D}}
\newcommand{\cE}{\mathcal{E}}
\newcommand{\cI}{\mathcal{I}}
\newcommand{\cJ}{\mathcal{J}}
\newcommand{\cK}{\mathcal{K}}
\newcommand{\cP}{\mathcal{P}}
\newcommand{\cS}{\mathcal{S}}
\newcommand{\cT}{\mathcal{T}}
\newcommand{\cA}{\mathcal{A}}
\newcommand{\cB}{\mathcal{B}}
\newcommand{\cU}{\mathcal{U}}
\newcommand{\cV}{\mathcal{V}}
\newcommand{\cW}{\mathcal{W}}
\newcommand{\cX}{\mathcal{X}}
\newcommand{\cY}{\mathcal{Y}}
\newcommand{\cZ}{\mathcal{Z}}
\newcommand{\Mbar}{\overline{M}}
\newcommand{\Ebar}{\overline{E}}
\newcommand{\tens}{\otimes}
\newcommand{\dd}{\mathrm{d}}
\providecommand{\xlongequal}[1]{\overset{\mathrm{#1}}{=\joinrel=}}
\providecommand{\limleft}{\mathop{\varprojlim}\limits}
\providecommand{\limright}{\mathop{\varinjlim}\limits}
\newcommand{\et}{\'et}
\newcommand{\Ell}{\ensuremath{(\mathrm{Ell})}\xspace}
\newcommand{\Sets}{\ensuremath{(\mathrm{Sets})}\xspace}
\newcommand{\FLFG}{\ensuremath{(\mathrm{FLFG})}\xspace}

% tolerance.  The book is dense with long inline formulas (Tate(q^{n/\ell}),
% Z[1/n\ell,\zeta_{n\ell}]((q^{1/\ell})), ...) that TeX treats as single
% unbreakable atoms; let it break at relations/binary operators inside math and
% allow a generous amount of stretch so those paragraphs fit the measure.
\emergencystretch = 3em
\relpenalty   = 200
\binoppenalty = 200
\tolerance    = 2000

\endinput
