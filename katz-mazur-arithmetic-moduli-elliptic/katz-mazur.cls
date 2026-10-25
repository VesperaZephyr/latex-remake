% ==============================================================================
% katz-mazur.cls -- Document class for:
%   Arithmetic Moduli of Elliptic Curves (Nicholas M. Katz and Barry Mazur)
%   Annals of Mathematics Studies, Number 108, Princeton University Press, 1985.
% Retypesetting matching the original Princeton AMS book layout and typography.
%
% Numbering scheme (verified against the original printed book):
%   * Sections: (1.1), (1.2), ... (italic title, roman number)
%   * Paragraph items and theorem-like environments share ONE counter per section:
%       (1.1.1) item, then LEMMA 1.1.2, CAUTION 1.1.3, ...
%   * Displayed equations are numbered per ITEM and left-aligned (leqno):
%       (1.3.1.1), (1.4.1.2), ...
%   * Irregular nested numbers (e.g. PROPOSITION 1.1.5.1) use the custom* envs.
% ==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{katz-mazur}[2026/10/11 v1.1 Katz-Mazur Arithmetic Moduli Book Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,twoside,openright,final]{book}

% ------------------------------------------------------------------------------
% 1. Page geometry (measured from the original: page 370x554pt = 130.5x195.4mm;
%    text block ~100.5mm x 150mm)
% ------------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{
  paperwidth  = 130.5mm,
  paperheight = 195.4mm,
  inner       = 14mm,
  outer       = 16mm,
  top         = 22mm,
  bottom      = 23.4mm,
  headheight  = 13pt,
  headsep     = 8pt,
  footskip    = 14pt,
  heightrounded
}

% ------------------------------------------------------------------------------
% 2. Math & typography (default TeX font: Computer Modern)
% ------------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[leqno]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{microtype}
\RequirePackage{bm}

% ------------------------------------------------------------------------------
% 3. Colors & hyperlinks
% ------------------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{kmblue}{RGB}{0, 35, 125}
\definecolor{kmred}{RGB}{140, 20, 20}

\RequirePackage{hyperref}
% Cross-references and citations are colour-coded (per user request).
\definecolor{kmlink}{RGB}{0, 35, 125}   % internal refs: \ref, \eqref, TOC
\definecolor{kmcite}{RGB}{0, 102, 51}   % citations: \cite
\hypersetup{
  colorlinks = true,
  linkcolor  = kmlink,
  citecolor  = kmcite,
  urlcolor   = kmlink,
  filecolor  = kmlink,
  linktoc    = all,
  pdfauthor  = {Nicholas M. Katz and Barry Mazur},
  pdftitle   = {Arithmetic Moduli of Elliptic Curves},
  pdfsubject = {Mathematics - Arithmetic Algebraic Geometry},
  bookmarksnumbered = true
}

% ------------------------------------------------------------------------------
% 3b. Bibliography: biblatex + biber, reproducing the original book's layout.
%     The custom style file katz-mazur.bbx supplies the [A-K 1]-style labels
%     (from the `shorthand' field) and the uniform "Author, Title, tail" format.
% ------------------------------------------------------------------------------
\RequirePackage[backend=biber,style=katz-mazur,citestyle=alphabetic,giveninits=true]{biblatex}
\addbibresource{references.bib}

% ------------------------------------------------------------------------------
% 4. Graphics & diagrams (native TikZ only)
% ------------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{matrix,arrows,calc,decorations.pathreplacing,positioning}
\RequirePackage{tikz-cd}
\RequirePackage{rotating}
\RequirePackage{multirow}
\RequirePackage{array}

% ------------------------------------------------------------------------------
% 5. Chapter & section headings
% ------------------------------------------------------------------------------
\RequirePackage{titlesec}
\RequirePackage{titletoc}

% Chapter: centered, "Chapter N" then upper-cased title, regular weight
\titleformat{\chapter}[display]
  {\centering\normalfont\normalsize}
  {Chapter \thechapter}
  {10pt}
  {\normalsize\MakeUppercase}
\titlespacing*{\chapter}{0pt}{30pt}{26pt}

\titleformat{name=\chapter,numberless}[display]
  {\centering\normalfont\normalsize}
  {}
  {0pt}
  {\normalsize\MakeUppercase}
\titlespacing*{name=\chapter,numberless}{0pt}{30pt}{26pt}

% Section: (1.1) italic title, roman number
\titleformat{\section}[hang]
  {\normalfont\normalsize}
  {(\thesection)}
  {0.5em}
  {\itshape}
\titlespacing*{\section}{0pt}{11pt plus 3pt minus 2pt}{5pt plus 2pt}

\titleformat{\subsection}[hang]
  {\normalfont\normalsize}
  {(\thesubsection)}
  {0.5em}
  {\itshape}
\titlespacing*{\subsection}{0pt}{9pt plus 3pt minus 2pt}{4pt}

% ------------------------------------------------------------------------------
% 6. Running heads (original: odd = chapter title / folio; even = folio / book title)
% ------------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancyhead[LO]{\scriptsize\scshape\leftmark}
\fancyhead[RO]{\scriptsize\thepage}
\fancyhead[LE]{\scriptsize\thepage}
\fancyhead[RE]{\scriptsize\scshape Arithmetic Moduli of Elliptic Curves}

\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\small\thepage}%
}

\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ \MakeUppercase{#1}}{}}

% ------------------------------------------------------------------------------
% 7. Numbering scheme: shared per-section counter (items + theorems)
% ------------------------------------------------------------------------------
\counterwithin*{section}{chapter}
% Equation numbering restarts at every \section as well: in Chapter 3 the
% displayed equations of sections 3.1--3.4 sit directly under the section
% (there is no enclosing item), and the original numbers them (3.1.1), (3.2.1),
% ... restarting in each section.  Inside an item/theorem the kmitem reset
% (below) takes over, so Chapter 1/2 numbering is unaffected.
\counterwithin*{equation}{section}

\newcounter{kmitem}[section]
\renewcommand{\thekmitem}{\thesection.\arabic{kmitem}}

% Paragraph item "(c.s.i)": starts a new unindented paragraph, resets equation counter
\newcommand{\kmitem}{%
  \refstepcounter{kmitem}%
  \setcounter{equation}{0}%
  \par\addvspace{6pt plus 2pt minus 1pt}\noindent(\thekmitem)\enspace\ignorespaces
}

% Equations numbered by their ENCLOSING numbered unit, left-aligned (leqno):
%   * inside a \kmitem paragraph or a theorem-like env : (1.3.1.1), (3.5.1.1)
%   * directly inside a section (no item yet)          : (3.1.1), (3.2.1)
% The kmitem counter is reset at each \section, so value(kmitem)=0 marks the
% "directly under the section" case (Chapter 3 sections 3.1--3.4).
\renewcommand{\theequation}{%
  \ifnum\value{kmitem}=0 \thesection\else\thekmitem\fi.\arabic{equation}%
}

% Chapter 4: the numbered PARAGRAPH ITEMS and the numbered DISPLAYS of sections
% 4.1--4.14 share ONE per-section sequence -- (4.3.1) display, (4.3.2) item,
% (4.3.3) display, (4.3.4) item, (4.3.5) item -- so those items are numbered by
% the equation counter (the kmitem counter stays at 0 in those sections, hence
% \theequation reduces to \thesection.\arabic{equation}).
\newcommand{\kmeqitem}{%
  \par\addvspace{6pt plus 2pt minus 1pt}%
  \noindent\refstepcounter{equation}(\theequation)\enspace\ignorespaces
}

% ------------------------------------------------------------------------------
% 7c. Chapter appendices: a centred "APPENDIX" heading followed by a section
%     numbered (A.<chapter>) -- e.g. (A.4) in Chapter 4 -- inside which the
%     ordinary nesting applies: (A.4.1), (A.4.1.1), ...  The table of contents
%     records the appendix as a single chapter-level entry, as in the original.
% ------------------------------------------------------------------------------
\newcounter{kmappchapter}
\setcounter{kmappchapter}{-1}
% Label printed for the appendix section ("A.4", "A7", ...); reset by each
% appendix-opening command.  The default reproduces the Chapter 4 style.
\newcommand{\kmapplabel}{A.\arabic{chapter}}
\renewcommand{\thesection}{%
  \ifnum\value{chapter}=\value{kmappchapter}\relax
    \kmapplabel
  \else
    \arabic{chapter}.\arabic{section}%
  \fi
}
\newcommand{\kmappendix}[1]{%
  \par\addvspace{20pt plus 6pt minus 4pt}%
  {\centering\normalfont APPENDIX\par}%
  \addvspace{8pt plus 3pt minus 2pt}%
  \setcounter{kmappchapter}{\value{chapter}}%
  \renewcommand{\kmapplabel}{A.\arabic{chapter}}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}%
  \setcounter{section}{0}%
  \section{#1}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{2}}%
  \addcontentsline{toc}{chapter}{\texorpdfstring{APPENDIX: \MakeUppercase{#1}}{APPENDIX: #1}}%
}

% Chapter 7 style appendix: the book prints it as an ordinary section
% "(A7) Appendix: Base-change for rings of invariants" -- NO centred
% "APPENDIX" line -- and records it in the contents as a chapter-level
% "APPENDIX: ..." entry.
%   #1 = section label ("A7"), #2 = section title, #3 = contents title.
\newcommand{\kmappendixA}[3]{%
  \par\addvspace{20pt plus 6pt minus 4pt}%
  \setcounter{kmappchapter}{\value{chapter}}%
  \renewcommand{\kmapplabel}{#1}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}%
  \setcounter{section}{0}%
  \section{#2}%
  \addtocontents{toc}{\protect\setcounter{tocdepth}{2}}%
  \addcontentsline{toc}{chapter}{#3}%
}

% Theorem styles: head in small caps, "." after number
%   kmplain -- italic body  (Theorem, Proposition, Lemma, Corollary)
%   kmdef   -- roman body   (Caution, Remark, Definition, Example)
\newtheoremstyle{kmplain}%
  {8pt plus 2pt minus 2pt}% space above
  {8pt plus 2pt minus 2pt}% space below
  {\itshape}% body font
  {0pt}% indent
  {\scshape}% head font
  {.}% punctuation after head
  {0.5em}% space after head
  {\thmname{#1}\thmnumber{ #2}\thmnote{ \upshape(#3)}}% head: NAME number (note upright)

\newtheoremstyle{kmdef}%
  {8pt plus 2pt minus 2pt}%
  {8pt plus 2pt minus 2pt}%
  {\normalfont}%
  {0pt}%
  {\scshape}%
  {.}%
  {0.5em}%
  {\thmname{#1}\thmnumber{ #2}\thmnote{ \upshape(#3)}}

\theoremstyle{kmplain}
\newtheorem{theorem}[kmitem]{Theorem}
\newtheorem*{theorem*}{Theorem}
\newtheorem{lemma}[kmitem]{Lemma}
\newtheorem{keylemma}[kmitem]{Key Lemma}
\newtheorem{proposition}[kmitem]{Proposition}
\newtheorem*{proposition*}{Proposition}
\newtheorem{corollary}[kmitem]{Corollary}
\newtheorem{conjecture}[kmitem]{Conjecture}
% "CAUTIONARY REMARK n.m.k" (italic body, no "A", no parentheses) -- e.g. 13.10.5
\newtheorem{kcautrem}[kmitem]{Cautionary Remark}

\theoremstyle{kmdef}
\newtheorem{caution}[kmitem]{Caution}
\newtheorem{remark}[kmitem]{Remark}
\newtheorem{keyremark}[kmitem]{Key Remark}
\newtheorem{definition}[kmitem]{Definition}
\newtheorem{example}[kmitem]{Example}

% Irregular / nested numbers (e.g. PROPOSITION 1.1.5.1) -- explicit number argument
\newtheorem{innercustomthm}{Theorem}
\newenvironment{customthm}[1]{\renewcommand\theinnercustomthm{#1}\innercustomthm}{\endinnercustomthm}
\newtheorem{innercustomlem}{Lemma}
\newenvironment{customlem}[1]{\renewcommand\theinnercustomlem{#1}\innercustomlem}{\endinnercustomlem}
\newtheorem{innercustomprop}{Proposition}
\newenvironment{customprop}[1]{\renewcommand\theinnercustomprop{#1}\innercustomprop}{\endinnercustomprop}
\newtheorem{innercustomcor}{Corollary}
\newenvironment{customcor}[1]{\renewcommand\theinnercustomcor{#1}\innercustomcor}{\endinnercustomcor}

% ------------------------------------------------------------------------------
% 7b. Chapter 3 ("Sorites"): sections 3.5 and 3.6 number their results inside
%     PARENTHESES -- LEMMA (3.5.1), THEOREM (3.6.0), REMARK (3.6.2.1), ... --
%     while section 3.7 reverts to the ordinary unparenthesised style.  The
%     explicit numbers ("3.6.0", "3.6.2.1") are irregular, so those environments
%     take the number as an argument.
% ------------------------------------------------------------------------------
\newtheoremstyle{kmplainparen}%
  {8pt plus 2pt minus 2pt}%
  {8pt plus 2pt minus 2pt}%
  {\itshape}%
  {0pt}%
  {\scshape}%
  {.}%
  {0.5em}%
  {\thmname{#1}\thmnumber{ (#2)}\thmnote{ \upshape(#3)}}

\newtheoremstyle{kmdefparen}%
  {8pt plus 2pt minus 2pt}%
  {8pt plus 2pt minus 2pt}%
  {\normalfont}%
  {0pt}%
  {\scshape}%
  {.}%
  {0.5em}%
  {\thmname{#1}\thmnumber{ (#2)}\thmnote{ \upshape(#3)}}

% (3.5.1): auto-numbered lemma sharing the kmitem counter (so its numbered
% equations restart from 1 and read (3.5.1.1), (3.5.1.2), ...).
\theoremstyle{kmplainparen}
\newtheorem{pleminner}[kmitem]{Lemma}
\newenvironment{plem}{\setcounter{equation}{0}\pleminner}{\endpleminner}

% Explicitly-numbered, parenthesised environments (section 3.6).
\newtheorem{innerpthm}{Theorem}
\newenvironment{pthm}[1]{\renewcommand\theinnerpthm{#1}\innerpthm}{\endinnerpthm}
\newtheorem{innerprelrep}{Relative Representability Theorem}
\newenvironment{prelrep}[1]{\renewcommand\theinnerprelrep{#1}\innerprelrep}{\endinnerprelrep}
\newtheorem{innerpprop}{Proposition}
\newenvironment{pprop}[1]{\renewcommand\theinnerpprop{#1}\innerpprop}{\endinnerpprop}
\newtheorem{innerpcor}{Corollary}
\newenvironment{pcor}[1]{\renewcommand\theinnerpcor{#1}\innerpcor}{\endinnerpcor}
\theoremstyle{kmdefparen}
\newtheorem{innerprem}{Remark}
\newenvironment{prem}[1]{\renewcommand\theinnerprem{#1}\innerprem}{\endinnerprem}

% Chapter 4: SCHOLIE (4.7.0), LEMMA (4.10.0), LEMMA (4.12.1) -- parenthesised,
% with the (irregular) number supplied explicitly.
\theoremstyle{kmplainparen}
\newtheorem{innerpscholie}{Scholie}
\newenvironment{pscholie}[1]{\renewcommand\theinnerpscholie{#1}\innerpscholie}{\endinnerpscholie}
\newtheorem{innerplemnum}{Lemma}
\newenvironment{plemnum}[1]{\renewcommand\theinnerplemnum{#1}\innerplemnum}{\endinnerplemnum}

% ------------------------------------------------------------------------------
% 7d. Chapter 5 ("Regularity Theorems"): the numbered PARAGRAPH ITEMS and the
%     theorem-like results of sections 5.1--5.6 again share ONE per-section
%     sequence -- LEMMA 5.3.1, THEOREM 5.3.2, (5.3.5), (5.3.6) -- so the items
%     are numbered by the kmitem counter (already per-section) and are set off
%     as "(5.3.5)" exactly like \kmitem.  The numbered DISPLAYS of section 5.3
%     are nested inside their item ((5.3.2.1) ...), which the global
%     \theequation already produces once the equation counter is reset at each
%     new item/theorem; see the \counterwithin*{equation}{kmitem} below.
% ------------------------------------------------------------------------------
\newenvironment{pitem}%
  {\refstepcounter{kmitem}\setcounter{equation}{0}%
   \par\addvspace{6pt plus 2pt minus 1pt}\noindent(\thekmitem)\enspace\ignorespaces}%
  {\par}

% Nested, explicitly-numbered paragraph item: the rigidity assertions
% (5.3.2.1), (5.3.2.2), (5.3.2.3) sit inside THEOREM 5.3.2 and carry a
% four-part number, so they take their number as an argument and leave the
% kmitem counter untouched.  \@currentlabel is set by hand so that a \label
% inside the environment records the full four-part number.  (Note: inside a
% .cls file "@" is already a letter, so NO \makeatletter/\makeatother here --
% adding \makeatother would break every later \p@ / \@plus in this file.)
\newenvironment{pitemnum}[1]%
  {\par\addvspace{6pt plus 2pt minus 1pt}\noindent(#1)\enspace\def\@currentlabel{#1}\ignorespaces}%
  {\par}

% The theorem-like environments of Chapter 5 take their number from the same
% kmitem counter (so a "Caution" between two theorems shifts the numbering),
% and reset the equation counter so that nested displays read (5.3.2.1) ...
% NOTE: the active \theoremstyle at this point is kmplainparen (set above for
% the parenthesised Chapter 4 environments), so it MUST be reset here --
% otherwise these would render as "Theorem (5.3.2)" and the Caution / Remark /
% Terminology would wrongly receive the italic (kmplain) body.
\theoremstyle{kmplain}
\newtheorem{kthm}[kmitem]{Theorem}
\newtheorem{klem}[kmitem]{Lemma}
\newtheorem{kprop}[kmitem]{Proposition}
\newtheorem{kcor}[kmitem]{Corollary}

\theoremstyle{kmdef}
\newtheorem{krem}[kmitem]{Remark}
\newtheorem{kterm}[kmitem]{Terminology}
\newtheorem{kcaut}[kmitem]{Caution}

% Chapter 5 special headings: FIRST MAIN THEOREM 5.1.1, AXIOMATIC REGULARITY
% THEOREM 5.2.1 -- these carry a full author-supplied name; they share the
% kmitem counter so the numbering stays in step with the other results.
\theoremstyle{kmplain}
\newtheorem{fmt}[kmitem]{First Main Theorem}
\newtheorem{art}[kmitem]{Axiomatic regularity Theorem}

% ------------------------------------------------------------------------------
% 7f. Chapter 6 ("Cyclicity"): the two named theorems of sections 6.1 and 6.2 --
%     MAIN THEOREM ON CYCLIC GROUPS (6.1.1) and AXIOMATIC ISOMORPHISM THEOREM
%     (6.2.1) -- are set with a PARENTHESISED, explicitly supplied number, like
%     the Chapter 3/4 environments.  All the remaining results of the chapter
%     share the per-section kmitem counter and are unparenthesised (THEOREM
%     6.4.1, LEMMA 6.4.2, ...), so they reuse the Chapter 5 environments except
%     for the four that carry an author-supplied name.
% ------------------------------------------------------------------------------
\theoremstyle{kmplainparen}
\newtheorem{innermtcg}{Main Theorem on Cyclic Groups}
\newenvironment{mtcg}[1]{\renewcommand\theinnermtcg{#1}\innermtcg}{\endinnermtcg}
\newtheorem{innerait}{Axiomatic Isomorphism Theorem}
\newenvironment{ait}[1]{\renewcommand\theinnerait{#1}\innerait}{\endinnerait}

\theoremstyle{kmplain}
\newtheorem{kusefullem}[kmitem]{Useful lemma}
\newtheorem{backingup}[kmitem]{Backing-up Theorem}
\newtheorem{stdorder}[kmitem]{Standard Order Criterion}
\newtheorem{afft}[kmitem]{Axiomatic Finite Flatness Theorem}

% ------------------------------------------------------------------------------
% 7g. Chapter 7 appendix ("Base-change for rings of invariants"): its results
%     are numbered by SUB-SECTION -- THEOREM A7.1.1, COROLLARY A7.1.2,
%     PROPOSITION A7.2.1, ... -- the appendix's sub-sections (A7.1), (A7.2)
%     playing the role that sections play in the body of the book.
% ------------------------------------------------------------------------------
\newcounter{kmappitem}[subsection]
\renewcommand{\thekmappitem}{\thesubsection.\arabic{kmappitem}}
\theoremstyle{kmplain}
\newtheorem{appthm}[kmappitem]{Theorem}
\newtheorem{appprop}[kmappitem]{Proposition}
\newtheorem{appcor}[kmappitem]{Corollary}

% Chapter 7 ("Quotients by finite groups"): the two author-named results of
% section 7.5, which share the per-section kmitem counter like the rest.
\theoremstyle{kmplain}
\newtheorem{arqt}[kmitem]{Axiomatic Regularity of Quotients Theorem}
\newtheorem{kvar}[kmitem]{Variant}

% Chapter 13: CROSSINGS THEOREM 13.1.3
\newtheorem{crossingsthm}[kmitem]{Crossings Theorem}

% ------------------------------------------------------------------------------
% 7h. Chapter 7 extras.
% ------------------------------------------------------------------------------
% The one numbered display of section 7.1 -- (7.1.1.1) -- is printed by the
% book WITHOUT the surrounding parentheses, unlike every other numbered display
% of the chapter.  \baretagnumber suppresses amsmath's \tagform@ for the current
% equation, so the (dynamically computed) number is emitted bare.
\newcommand{\baretagnumber}{\def\tagform@##1{##1}}

% Indented sub-paragraph: the (Q1)/(Q2) conditions of 7.1.2, the axioms
% (G-1)--(G-3) of 7.5.1, and the "for (4)/(5)/(6)" arguments of the
% Construction-proof are all set in a narrower measure, flush left.
\newenvironment{kmindent}%
  {\par\addvspace{4pt plus 1pt minus 1pt}\begingroup
   \leftskip=1.8em \rightskip=1.2em \parindent=0pt \parskip=4pt plus 1pt}%
  {\par\endgroup\addvspace{2pt plus 1pt minus 1pt}}

% The book's picture of an object of (Sch/R-Sch): a vertical morphism X -> S,
% with the base S repeated to the right of a short ticked horizontal arrow.
%   \kmobj{X}{S}
\newcommand{\kmobj}[2]{%
  \begin{tikzpicture}[baseline=(kmoT.base), x=1em, y=1em,
                      every node/.style={inner sep=1pt}]
    \node (kmoT) at (0,0) {$#1$};
    \draw[->] (0,-0.5) -- (0,-2.5);
    \node at (0,-2.85) {$#2$};
    \draw[line width=0.4pt] (0.55,-1.95) -- (0.55,-1.65);
    \draw[->] (0.55,-1.8) -- (2.0,-1.8);
    \node at (2.3,-1.8) {$#2$};
  \end{tikzpicture}%
}

% The book's picture of a base-preserving functor on objects: X over S on the
% left, Y over S on the right, joined by a horizontal arrow.
%   \kmfobj{X}{Y}{S}
\newcommand{\kmfobj}[3]{%
  \begin{tikzpicture}[baseline=(kmfT.base), x=1em, y=1em,
                      every node/.style={inner sep=1pt}]
    \node (kmfT) at (0,0) {$#1$};
    \node at (3.6,0) {$#2$};
    \draw[->] (0,-0.45) -- (0,-2.35);
    \node at (0,-2.7) {$#3$};
    \draw[->] (3.6,-0.45) -- (3.6,-2.35);
    \node at (3.6,-2.7) {$#3$};
    \draw[->] (0.35,-0.2) -- (3.25,-0.2);
  \end{tikzpicture}%
}

% A pair of dual isogenies as the book draws it in section 7.9: two separate
% horizontal arrows, the upper one pointing right (label above it) and the lower
% one pointing left (label below it), as in
%       pi
%   E_0 ===> E_n
%       <===        (lambda = pi^t)
% Used for (7.9.1.1), (7.9.1.5) and the diagrams of 7.9.2--7.9.4.
%   \kmdual{<upper label>}{<lower label>}
\newcommand{\kmdual}[2]{%
  \mathrel{%
    \mathop{\overset{\,#1\,}{\longrightarrow}}%
    \limits_{\underset{\,#2\,}{\longleftarrow}}%
  }%
}

% Equation numbering for Chapter 5: nested under the enclosing numbered unit.
\counterwithin*{equation}{kmitem}

% Proof: "Proof." in italic, uniform \square as QED symbol (right-aligned via amsthm)
\renewcommand{\proofname}{Proof}
\renewcommand{\qedsymbol}{\ensuremath{\square}}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont\topsep6\p@\@plus3\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}

% Same as {proof} but WITHOUT the \square marker.  Used when the argument of a
% result is deliberately continued into the following statement (e.g. the proof
% of Theorem 6.7.2, which is completed by the Useful Lemma 6.7.3) and the book
% therefore prints no Q.E.D. at that point.
\newenvironment{proof*}[1][\proofname]{\par
  \normalfont\topsep6\p@\@plus3\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \endtrivlist\@endpefalse
}

% ------------------------------------------------------------------------------
% 8. Common algebraic-geometry & number-theory macros
% ------------------------------------------------------------------------------
\newcommand{\A}{\mathbb{A}}
% The affine line A^1_R (and affine n-space): the book prints a BOLD UPRIGHT A,
% distinct from the italic A used for rings.  Verified by page image, book p. 235.
\newcommand{\Aff}{\mathbf{A}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\F}{\mathbb{F}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\PP}{\mathbb{P}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\NZ}{\N\Z}

% long equals with a symbol above (e.g. \xlongequal{dfn})
\providecommand{\xlongequal}[1]{\overset{\mathrm{#1}}{=\joinrel=}}

\newcommand{\cO}{\mathcal{O}}
\newcommand{\cL}{\mathcal{L}}
\newcommand{\cE}{\mathcal{E}}
\newcommand{\cF}{\mathcal{F}}
\newcommand{\cG}{\mathcal{G}}
\newcommand{\cM}{\mathcal{M}}
\newcommand{\cH}{\mathcal{H}}
\newcommand{\cI}{\mathcal{I}}
\newcommand{\cK}{\mathcal{K}}
\newcommand{\cJ}{\mathcal{J}}

% Fraktur M: the scheme M(P) representing a moduli problem
\newcommand{\Mfrak}{\mathfrak{M}}

% Roman M: the COARSE moduli scheme M(P) attached to a moduli problem P
% (as opposed to the fine moduli scheme \Mfrak(P)).  Introduced in Chapter 8;
% the book prints this M upright, paired with the fraktur \Mfrak.
\newcommand{\Mcoarse}{\mathrm{M}}

% The graded ring MF(R) of level one modular forms (Chapter 8, section 8.1.7);
% the book prints the abbreviation upright.
\newcommand{\MF}{\mathrm{MF}}

% Category names: (Ell), (Sets), (FLFG).  These are used both in running text
% and inside formulas, hence \ensuremath; \xspace restores the interword space
% that TeX swallows after a control word (in math mode it adds nothing).
\RequirePackage{xspace}
\newcommand{\Ell}{\ensuremath{(\mathrm{Ell})}\xspace}
% The category of elliptic curves over R-schemes, printed (Ell/R).  The book
% writes (Ell/R) throughout sections 7.1--7.3 (it fixes a ring R at the start
% of 7.1) and reverts to (Ell) from 7.4 on; \EllR mirrors that distinction.
\newcommand{\EllR}{\ensuremath{(\mathrm{Ell}/R)}\xspace}
% (Ell/Z): the base case used in section 8.1.7 ("the moduli problem [omega]
% on (Ell/Z)"), where the ground ring is Z.
\newcommand{\EllZ}{\ensuremath{(\mathrm{Ell}/\Z)}\xspace}
\newcommand{\Sets}{\ensuremath{(\mathrm{Sets})}\xspace}
\newcommand{\FLFG}{\ensuremath{(\mathrm{FLFG})}\xspace}

\DeclareMathOperator{\Spec}{Spec}
\DeclareMathOperator{\Spf}{Spf}
\DeclareMathOperator{\Sch}{Sch}
\DeclareMathOperator{\Proj}{Proj}
\DeclareMathOperator{\Ker}{Ker}
\DeclareMathOperator{\Coker}{Coker}
\DeclareMathOperator{\Image}{Im}
\DeclareMathOperator{\Aut}{Aut}
\DeclareMathOperator{\End}{End}
\DeclareMathOperator{\Hom}{Hom}
% NOTE: the book prints "Isom" in ITALIC (unlike Hom/Aut/Ker/Spec, which are
% upright).  Verified by page image at book pp. 26, 108, 235, 236.
\newcommand{\Isom}{\mathit{Isom}}
\DeclareMathOperator{\Incl}{Incl}
\DeclareMathOperator{\Ext}{Ext}
\DeclareMathOperator{\Tor}{Tor}
\DeclareMathOperator{\Lie}{Lie}
\DeclareMathOperator{\Pic}{Pic}
\DeclareMathOperator{\Gal}{Gal}
\DeclareMathOperator{\GL}{GL}
\DeclareMathOperator{\SL}{SL}
\DeclareMathOperator{\PGL}{PGL}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\trace}{trace}
\DeclareMathOperator{\Norm}{Norm}
\DeclareMathOperator{\ord}{ord}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\chark}{char}

\newcommand{\dd}{\mathrm{d}}

% tensor product with the subscript set BELOW the symbol (as in the original)
\newcommand{\tens}[1]{\underset{#1}{\otimes}}

% fiber product with the subscript set BELOW the times sign (as in the original)
\newcommand{\fib}[1]{\underset{#1}{\times}}

% Lists
\RequirePackage[shortlabels]{enumitem}
\setlist{nosep}

% Tolerant paragraph breaking
\emergencystretch = 2em

% ------------------------------------------------------------------------------
% 8a. Chapter 8, section 8.8 ("Relation to the Tate curve").  The four
%     properties of the Tate curve are labelled T.1--T.4 -- NOT by the (8.8.x)
%     scheme -- and the book cross-references them as "(8.8, T.<n>)".
%     \tateprop prints the next such label with a hanging indent (the book sets
%     "T.n" flush with the body margin and indents the following text by the
%     same amount); put \label{tate:<n>} immediately after it so that
%     \tateref{<n>} can reproduce the "(8.8, T.n)" form dynamically.
% ------------------------------------------------------------------------------
\newcounter{tateprop}
\renewcommand{\thetateprop}{T.\arabic{tateprop}}
\newcommand{\tateprop}{%
  \par\addvspace{6pt plus 2pt minus 1pt}%
  \refstepcounter{tateprop}%
  \noindent\hangindent=2.9em\hangafter=1
  \makebox[2.9em][l]{\thetateprop}\ignorespaces}
\newcommand{\tateref}[1]{(\ref{sec:8.8}, \ref{tate:#1})}

% The Tate curve is printed upright, like Spec/Hom (cf. \Spec).
\newcommand{\Tate}{\mathrm{Tate}}
% The canonical invariant one-form omega_can of the Tate curve.
\newcommand{\wcan}{\omega_{\mathrm{can}}}

% ------------------------------------------------------------------------------
% 8b. Chapter 8, section 8.10 ("Other universality properties of the groups
%     T[N]").  The two conditions defining a "strongly alternating" bilinear
%     pairing are labelled S.A.1 and S.A.2 -- letter labels, NOT by the (8.10.x)
%     scheme -- set flush with the body margin with the following text
%     hanging-indented by the width of the label (the book's layout).
% ------------------------------------------------------------------------------
\newlength{\sapropindent}
\settowidth{\sapropindent}{S.A.1\enspace}
\newcommand{\saprop}[1]{%
  \par\addvspace{6pt plus 2pt minus 1pt}%
  \noindent\hangindent=\sapropindent\hangafter=1
  \makebox[\sapropindent][l]{S.A.#1}\ignorespaces}

% ------------------------------------------------------------------------------
% 8c. Chapter 10 & 12: \HomSurj, \Fix, \discrim, \cusps, \mapsfrom, \longmapsfrom
% ------------------------------------------------------------------------------
\newcommand{\HomSurj}{\mathrm{Hom\,Surj}}
\DeclareMathOperator{\Fix}{Fix}
\DeclareMathOperator{\discrim}{discrim}
\DeclareMathOperator{\cusps}{cusps}
\DeclareMathOperator{\Cusps}{Cusps}
\newcommand{\mapsfrom}{\mathrel{\reflectbox{$\mapsto$}}}
\newcommand{\longmapsfrom}{\mathrel{\reflectbox{$\longmapsto$}}}

\endinput
