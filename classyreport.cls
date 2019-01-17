\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{classyreport}[2019/01/29 Classy Report]

%% Article options
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}}

%% Custom package options
%% Fallback
\DeclareOption*{
  \ClassWarning{classyreport}{Unknown option '\CurrentOption'}
}

%% Execute default options
\ExecuteOptions{11pt,oneside}

%% Process given options
\ProcessOptions\relax

%% Load base
\LoadClass[a4paper]{article}

%% Load additional packages and commands.
\RequirePackage{xcolor}
\RequirePackage{xspace}
\RequirePackage{hyperref}
\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{minted}
% \RequirePackage{beton}
% \RequirePackage{euler}
\RequirePackage{fontawesome}
\RequirePackage[in]{fullpage} % narrower margins
\RequirePackage{titlesec}
\RequirePackage{dashrule}
% \RequirePackage{fancyhdr}
% \RequirePackage[top=2cm,bottom=2cm,left=3cm,right=2cm,headheight=17pt,includehead,includefoot,heightrounded]{geometry}
\RequirePackage{applecolors}
\RequirePackage{flatbox}
\RequirePackage{codebox}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEFINITIONS START HERE
\hypersetup{colorlinks=true,urlcolor=iOS-blue,linkcolor=black}

\newcommand\@subtitle{}
\newcommand\subtitle[1]{\renewcommand\@subtitle{#1}}
\NewEnviron{frontmatter}{\global\let\@frontmatter\BODY}
\renewcommand\maketitle{%
  \begin{titlepage}
    \centering
    % \topskip0pt
    \vspace*{\fill}
    {\Huge\textsc{\@title}\par}
    \rule{12cm}{0.4pt}\par
    \vspace{0.75cm}
    {\huge\@subtitle\par}
    \vspace{1.75cm}
    {\large\@frontmatter\par}
    \vspace*{\fill}
    {\Large\@author\par}
    \vspace{0.5cm}
    {\normalsize\@date\par}
  \end{titlepage}
}

%% Already inside document after \maketitle and \tableofcontents
\AtEndDocument{%
  \clearpage%
  \titleformat{\section}{\Large\bf}{\thesection}{1em}{}%
  \listoffigures%
  \listoftables%
  \listoflistings}

%% Header
% \pagestyle{fancy}
% \fancyhf{}
% \fancyhead[LE,RO]{Share\LaTeX}
% \fancyhead[RE,LO]{Guides and tutorials}
% \fancyfoot[CE,CO]{\thepage}

\titleformat{\section}{\Large\bf\clearpage}{\thesection}{1em}{}[\color{gray!50!white}\titlerule]
% \titleformat{\subsection}[runin]{\large\bf}{\thesubsection}{.5em}{}[\color{gray}\rule{\fill}{1mm}]
% \titleformat{\subsubsection}{\normalsize\it}{\thesubsubsection}{.25em}{}[\color{gray}\titlerule]


%% Custom environments
\newenvironment{note}{\begin{noteffbox}{Note}\small}{\end{noteffbox}}
\newenvironment{ex}{\begin{exampleffbox}{Exemple}\small}{\end{exampleffbox}}

\newcommand{\bigquotemark}[1]{\begin{minipage}{.05\textwidth}\color{gray}\bf\Huge#1\end{minipage}}
\renewenvironment{quote}{%
  \begin{center}
    \bigquotemark{\og}
    \begin{minipage}{.75\textwidth}\small\it\color{gray!50!black}
    }{%
    \end{minipage}
    \bigquotemark{\fg}
  \end{center}}

\usemintedstyle{colorful}
\newminted{text}{}
\newminted{html}{}
\newminted{shell}{}
\newminted{ocaml}{}
\setmintedcodebox{textcode}{title=Text,icon=\faParagraph}
\setmintedcodebox{htmlcode}{title=HTML code}
\setmintedcodebox{shellcode}{title=Shell script,icon=\faTerminal}%,compact,headless,shadow=false}
\setmintedcodebox{ocamlcode}{title=OCaml code,icon=\(\mathbf{\lambda}\)}

\newcommand\asterismcolor{black!65}
\newcommand\asterism{\smallskip\noindent\textcolor{\asterismcolor}{\small\centerline{$\phantom{x}_{*\,\,\,*}^{\,\,\,*}$}}\smallskip}
\newcommand\asterismflat{\medskip\noindent\textcolor{\asterismcolor}{\small\centerline{*\,*\,*}}\smallskip}


\endinput