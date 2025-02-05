%%%%%%%%%%%%%%%%%%%%
%%% i1thesis.cls %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Based on work by Johannes Goetzfried, Vincent Haupert and Andreas Hammer.   %
% Is able to generate a thesis, exposee and project report.                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{i1thesis}[2024/01/16 Universal class for i1 student documents]

\DeclareOption{thesis}{\def\documentType{thesis}}
\DeclareOption{exposee}{\def\documentType{exposee}}
\DeclareOption{report}{\def\documentType{report}}

\DeclareOption{bachelor}{\def\thesisType{bachelor}}
\DeclareOption{master}{\def\thesisType{master}}

\DeclareOption{english}{\def\documentLanguage{english}}
\DeclareOption{german}{\def\documentLanguage{german}}

\ProcessOptions

\RequirePackage{ifthen}

% construct the subject (and also check if all arguments are given)

\@ifundefined{documentType}{
    \PackageError{i1thesis}{Document type missing! One of thesis, exposee or report.}{Valid arguments:
thesis german|english bachelor|master
exposee german|english bachelor|master
report german|english}
}

\ifthenelse{\equal{\documentType}{thesis}}
{
    \@ifundefined{thesisType}{
        \PackageError{i1thesis}{Thesis type missing! Either bachelor or master.}{Valid arguments:
    thesis german|english bachelor|master
    exposee german|english bachelor|master
    report german|english}
    }
    \ifthenelse{\equal{\thesisType}{master}}
    {
        \@ifundefined{documentLanguage}{
            \PackageError{i1thesis}{Language missing! Either german or english.}{Valid arguments:
        thesis german|english bachelor|master
        exposee german|english bachelor|master
        report german|english}
        }
        \ifthenelse{\equal{\documentLanguage}{english}}
        {
            \def\thesubject{Master's Thesis}
        }{}
        \ifthenelse{\equal{\documentLanguage}{german}}
        {
            \def\thesubject{Masterarbeit}
        }{}
    }{}
    \ifthenelse{\equal{\thesisType}{bachelor}}
    {
        \@ifundefined{documentLanguage}{
            \PackageError{i1thesis}{Language missing! Either german or english.}{Valid arguments:
        thesis german|english bachelor|master
        exposee german|english bachelor|master
        report german|english}
        }
        \ifthenelse{\equal{\documentLanguage}{english}}
        {
            \def\thesubject{Bachelor's Thesis}
        }{}
        \ifthenelse{\equal{\documentLanguage}{german}}
        {
            \def\thesubject{Bachelorarbeit}
        }{}
    }{}
}{}
\ifthenelse{\equal{\documentType}{exposee}}
{
    \@ifundefined{thesisType}{
        \PackageError{i1thesis}{Thesis type missing! Either bachelor or master.}{Valid arguments:
    thesis german|english bachelor|master
    exposee german|english bachelor|master
    report german|english}
    }
    \ifthenelse{\equal{\thesisType}{master}}
    {
        \@ifundefined{documentLanguage}{
            \PackageError{i1thesis}{Language missing! Either german or english.}{Valid arguments:
        thesis german|english bachelor|master
        exposee german|english bachelor|master
        report german|english}
        }
        \ifthenelse{\equal{\documentLanguage}{english}}
        {
            \def\thesubject{Master's Thesis - Exposé}
        }{}
        \ifthenelse{\equal{\documentLanguage}{german}}
        {
            \def\thesubject{Masterarbeit - Exposé}
        }{}
    }{}
    \ifthenelse{\equal{\thesisType}{bachelor}}
    {
        \@ifundefined{documentLanguage}{
            \PackageError{i1thesis}{Language missing! Either german or english.}{Valid arguments:
        thesis german|english bachelor|master
        exposee german|english bachelor|master
        report german|english}
        }
        \ifthenelse{\equal{\documentLanguage}{english}}
        {
            \def\thesubject{Bachelor's Thesis - Exposé}
        }{}
        \ifthenelse{\equal{\documentLanguage}{german}}
        {
            \def\thesubject{Bachelorarbeit - Exposé}
        }{}
    }{}
}{}
\ifthenelse{\equal{\documentType}{report}}
{
    \@ifundefined{documentLanguage}{
        \PackageError{i1thesis}{Language missing! Either german or english.}{Valid arguments:
    thesis german|english bachelor|master
    exposee german|english bachelor|master
    report german|english}
    }
    \ifthenelse{\equal{\documentLanguage}{english}}
    {
        \def\thesubject{Project report}
    }{}
    \ifthenelse{\equal{\documentLanguage}{german}}
    {
        \def\thesubject{Projektbericht}
    }{}
}{}


\@ifundefined{thesubject}{
    \PackageError{i1thesis}{Invalid combination of (or missing) arguments.}{Valid arguments:
thesis german|english bachelor|master
exposee german|english bachelor|master
report german|english}
}


% Load the basic document class

\ifthenelse{\equal{\documentType}{thesis}}{
    \LoadClass[11pt,twoside,a4paper,bibliography=totoc]{scrbook}
}{}

\ifthenelse{\equal{\documentType}{exposee}}{
    \LoadClass[11pt,a4paper,bibliography=totoc]{scrartcl}
}{}

\ifthenelse{\equal{\documentType}{report}}{
    \LoadClass[11pt,twoside,a4paper,bibliography=totoc]{scrartcl}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LANGUAGE STUFF                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{polyglossia}

\ifthenelse{\equal{\documentLanguage}{english}}
{
    % English
    \setmainlanguage{english}
    \setotherlanguage[babelshorthands=true,spelling=new,latesthyphen=true]{german}
}{
    % German
    \setmainlanguage[babelshorthands=true,spelling=new,latesthyphen=true]{german}
    \setotherlanguage{english}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAYOUT STUFF                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\equal{\documentType}{exposee}}{

    \RequirePackage[margin=3cm,top=3cm,bottom=3cm]{geometry}

}{}

\ifthenelse{\equal{\documentType}{thesis}}{

    \RequirePackage[margin=2.5cm,top=3cm,bottom=3cm]{geometry}

    % For title page background seal
    \RequirePackage[firstpageonly=true]{draftwatermark}

    % Fancy header and footer
    \RequirePackage{fancyhdr}

    % Fancy chapter page
    \makeatletter
    \def\@makechapterhead#1{
      \vspace*{110\p@}
      {
        \parindent \z@ 
        {\raggedleft
          \fontsize{15ex}{15ex}
          \textsf\thechapter\par\nobreak}
        \par\nobreak
        \interlinepenalty\@M
        %\vspace{-2ex}
        {\raggedright \Huge \textsf{\textsc{#1}} \par}
        \par\nobreak
        \leavevmode \leaders \hrule height 0.65ex \hfill \kern \z@
        \par\nobreak
        \vskip 100\p@
      }
    }

    % Fancy header / footer for chapter pages
    \fancypagestyle{plain}{
	    \fancyhf{}
	    \renewcommand{\headrulewidth}{0pt}
	    \fancyfoot[LE,RO]{\thepage}
    }

    % Fancy header / footer for normal pages
    \pagestyle{fancy}
    \fancyhf{}
    \fancyfoot[LE,RO]{\thepage}
    \fancyhead[LO]{\leftmark}
    \fancyhead[RE]{\rightmark}
}{}

\ifthenelse{\equal{\documentType}{report}}{

    \RequirePackage[margin=2.5cm,top=3cm,bottom=3cm]{geometry}

    % Fancy header and footer
    \RequirePackage{fancyhdr}

    % Fancy chapter page
    \makeatletter
    \def\@makechapterhead#1{
      \vspace*{110\p@}
      {
        \parindent \z@ 
        {\raggedleft
          \fontsize{15ex}{15ex}
          \textsf\thechapter\par\nobreak}
        \par\nobreak
        \interlinepenalty\@M
        %\vspace{-2ex}
        {\raggedright \Huge \textsf{\textsc{#1}} \par}
        \par\nobreak
        \leavevmode \leaders \hrule height 0.65ex \hfill \kern \z@
        \par\nobreak
        \vskip 100\p@
      }
    }

    % Fancy header / footer for chapter pages
    \fancypagestyle{plain}{
	    \fancyhf{}
	    \renewcommand{\headrulewidth}{0pt}
	    \fancyfoot[LE,RO]{\thepage}
    }

    % Fancy header / footer for normal pages
    \pagestyle{fancy}
    \fancyhf{}
    \fancyfoot[LE,RO]{\thepage}
    \fancyhead[LO]{\leftmark}
    \fancyhead[RE]{\rightmark}
}{}

% No indent for paragraphs
\setlength{\parskip}{1.3ex plus 0.2ex minus 0.2ex}
\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VARIOUS STUFF                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[hidelinks]{hyperref}

\AtBeginDocument{           % this is important as the title and author vars will only be available then
\hypersetup{
    pdftitle={\thetitle},
    pdfauthor={\theauthor},
    pdfsubject={\thesubject},
	breaklinks=true,
	bookmarksnumbered=true,
}
}

% for sample text, can be removed in production version
\usepackage{kantlipsum,blindtext}

% Bibliography
\RequirePackage[style=numeric,backend=biber,natbib,maxnames=20]{biblatex}
% A maximum of 20 names seems reasonable...
\addbibresource{references.bib}
\RequirePackage{url}
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{8000}

% to force "et al." instead of "u.a.":
\DefineBibliographyStrings{german}{
   andothers = {{et\,al\adddot}},
}

\RequirePackage[babel,autostyle=true]{csquotes}  %Quote design, use \textquote{}
\RequirePackage{setspace} %For different interline distances

% For more exotic color names
\RequirePackage[dvipsnames]{xcolor}

% Code listings
\RequirePackage{listings}
\lstset{basicstyle=\footnotesize\ttfamily, %
        breaklines=true, %
        numbers=left, %
        commentstyle=\color{Gray}, %
        keywordstyle=\color{RoyalBlue}, %
        stringstyle=\color{BurntOrange}, %
}

% Graphics
\RequirePackage{graphicx}
\RequirePackage{float}

% Captions and Subfigures
\RequirePackage{subfig}
\RequirePackage{caption}

% Math stuff
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{nicefrac}

\RequirePackage[nameinlink]{cleveref} % Use Cref and cref commands to include section/figure/etc.

% Figure captions
\RequirePackage{caption}
\captionsetup{font=small,labelfont=bf}

% Description style
\renewcommand{\descriptionlabel}[1]{\hspace{\labelsep}\textsf{\textsc{#1}}}

% Advanced enumerations
\usepackage[inline]{enumitem}
% Less space
\setlist{nosep}

% Better tables
\usepackage{booktabs,tabu,multirow,multicol,tabularx}

% A few commands
\newcommand{\term}[1]{\textit{#1}}
\newcommand{\code}[1]{\texttt{#1}}

%%%% FORMAT COMMAND %%%%%
\newcommand{\eg}{e.\,g.,\ }
\newcommand{\ie}{i.\,e.,\ }

\newcommand{\emdash}[1]{\unskip\,---\,{#1}\,---\,\ignorespaces}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONT STUFF                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fontspec}

% FiraSans
% Make sure to install the `fira` LaTex package: https://www.ctan.org/tex-archive/fonts/fira/
\usepackage[%
    book,%
    scaled=0.9%
]{FiraSans}

% Font, because lmodern sucks as much as times
\RequirePackage[libertine,cmintegrals,cmbraces,vvarbb]{newtxmath}
% Use Fira as a Monospace font
\RequirePackage[scaled=0.85]{FiraMono}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITLE MACRO                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These are placeholders for custom terms to be set in the document:
\ifthenelse{\equal{\documentLanguage}{english}}
{
    \def\textauthor{Author}
    \def\textadvisor{Advisor}
    \def\textexaminer{Examiner}
}
{
    \def\textauthor{Autor}
    \def\textadvisor{Betreuer}
    \def\textexaminer{Prüfer}
}

\newcommand{\makethetitle}{
    \ifthenelse{\equal{\documentType}{thesis}}{
        \thispagestyle{empty}
        \begin{titlepage}

        \SetWatermarkText{\includegraphics{images/fau-seal.pdf}}
        \SetWatermarkScale{2.12}
        %\SetWatermarkLightness{0.50}
        \SetWatermarkAngle{0}

        \titlehead{
	        \centering
	        \begin{tabular}[ht]{lcr}
		        \parbox{3cm}{
			        \centering
			        \includegraphics[width=3cm]{images/fau-logo.pdf}
		        } &
            \ifthenelse{\equal{\documentLanguage}{english}}
            {
                % English:
		        \parbox{5.4cm}{
			        \centering
			        IT Security Infrastructures Lab\\
			        Department of Computer Science\\
			        Friedrich-Alexander University Erlangen-Nürnberg\\
		        } &
            }{
                % German:
		        \parbox{5.4cm}{
			        \centering
			        Lehrstuhl für IT-Sicherheitsinfrastrukturen\\
			        Department Informatik\\
		        } &
            }
		        \parbox{3cm}{
			        \centering
			        \includegraphics[width=2.5cm]{images/i1-logo.pdf}
		        }
	        \end{tabular}
	        \vspace{4em}
        }

        \subject{\normalfont{\textsc{\thesubject{}}}}

        \title{\thetitle{}}

        \author{%
	        \vspace*{4em}%
	        \theauthor{}%
        }

        \date{
	        \theplace, \thedate
        }

        \publishers{
	        \begin{tabular}{rl}
                \textexaminer: & \theexaminer{} \\
		        \textadvisor:  & \theadvisor{}
	        \end{tabular}
        }

        \maketitle
        \end{titlepage}
        \cleardoublepageusingstyle{empty}
    }{}
    \ifthenelse{\equal{\documentType}{exposee}}{
        \begin{center}

        \makeatletter

        {\Huge \textbf{\thetitle} \par}
        \vspace{1.5em}
        \large \emph{\thesubject \hspace{1em} \@date}

        \vspace{1em}

        \begin{tabular}{rl}
            \textauthor:   & \theauthor \\
            \textadvisor:  & \theadvisor \\
            \textexaminer: & \theexaminer
        \end{tabular}

        \makeatother

        \end{center}
    }{}
    \ifthenelse{\equal{\documentType}{report}}{
        \thispagestyle{plain}
        \begin{center}

        \makeatletter

        {\Huge \textbf{\thetitle} \par}
        \vspace{1.5em}
        \large \emph{\thesubject \hspace{1em} \@date}

        \vspace{1em}

        \begin{tabular}{rl}
            \textauthor:   & \theauthor \\
            \textadvisor:  & \theadvisor \\
            \textexaminer: & \theexaminer
        \end{tabular}

        \makeatother

        \end{center}
    }{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECLARATION MACRO                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\makedeclaration}{
\pagenumbering{roman}
\chapter*{\ }


\vspace*{\fill}

{
\setlength{\parskip}{1.3ex plus 0.2ex minus 0.2ex}
\setlength{\parindent}{0pt}

% Header
\begin{Large}
	\textsf{\textbf{Eidesstattliche Versicherung / Affidavit}}
\end{Large}
\vspace{1.5em}


%\noindent\hrule

% German (always required)
\begin{german}
Ich, \theauthor{}, versichere, dass ich die Arbeit ohne fremde Hilfe und ohne Benutzung anderer als der angegebenen Quellen angefertigt habe und dass die Arbeit in gleicher oder ähnlicher Form noch keiner anderen Prüfungsbehörde vorgelegen hat und von dieser als Teil einer Prüfungsleistung angenommen wurde. Alle Ausführungen, die wörtlich oder sinngemäß übernommen wurden, sind als solche gekennzeichnet.
\end{german}

% English (also keep this if your thesis is written in English)
\textit{%
I, \theauthor{}, hereby declare formally that I have developed and written the enclosed thesis entirely by myself and have not used sources or means without declaration in the text. Any thoughts or quotations which were inferred from the sources are marked as such. This thesis was not submitted in the same or a substantially similar version to any other authority to achieve an academic grading.%
}

\vspace{2em}

\begin{german}
\begin{Large}
	\textsf{\textbf{Nutzungsrecht / Right of Use}}
\end{Large}
\vspace{1.5em}

Der Friedrich-Alexander-Universität Erlangen-Nürnberg, vertreten durch den Lehrstuhl für IT-Infrastrukturen, wird für Zwecke der Forschung und Lehre ein einfaches, kostenloses, zeitlich und örtlich unbeschränktes Nutzungsrecht an den Ergebnissen der Arbeit einschließlich etwaiger Schutz- und Urheberrechte eingeräumt.
\end{german}

\textit{%
The Friedrich-Alexander University Erlangen-Nürnberg, represented by the IT Security Infrastructures Lab of the Department of Computer Science, is entitled to use the results of this thesis non-exclusively, indefinitely and locally unrestricted for the purpose of research and teaching including any intellectual property right or copyright.%
}

\vspace{3em}

% Always print the date the German way
\begin{german}
\parbox{6cm}{%
\theplace{}, \thedate\\
\vspace{4ex}
\phantom{miau}%
}%
\hfill%
\parbox{5cm}{%
\centering%
\theauthor{}\\
\vspace{4ex}
\underline{\hspace{5cm}}%
}%
\end{german}

% Sign
%\docPlace{}, \today \hfill \underline{\hspace{5cm}}\\
%\vspace{4ex}
%\phantom{a} \hfill \small{(\docAuthors{})} \hspace{1.2cm}
%
%
}
\pagebreak
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ABSTRACT MACRO                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\makeabstract}[2]{
    \ifthenelse{\equal{\documentType}{report}}{
        \begin{large}
	        \sffamily\noindent
		    \textbf{Zusammenfassung}
	    \end{large}
        \vspace{0.75em}

        \begin{german}\noindent
            #1
        \end{german}

        \vspace{0.75em}

	    \begin{large}
	        \sffamily\noindent
		    \textbf{Abstract}
	    \end{large}
        \vspace{0.75em}

        \begin{english}\noindent
            #2
        \end{english}
    }{}

    \ifthenelse{\equal{\documentType}{thesis}}{
        \cleardoublepageusingstyle{plain}
        \chapter*{\ }

        \begingroup%
        \makeatletter%
        \let\clearpage\relax% Stop LaTeX from going to a new page; and
        \vspace*{\fill}%
        \vspace*{\dimexpr-50\p@-\baselineskip}% Remove the initial (default) 50pt gap (plus 1 line

        % You ALWAYS need a German abstract

        \begin{center}
	        \begin{large}
	            \sffamily
		        \textbf{Zusammenfassung}
	        \end{large}
        \end{center}
        \vspace{0.75em}

        \begin{german}
            #1
        \end{german}
        \vspace*{\fill}%
        \endgroup
        \cleardoublepageusingstyle{plain}
        \chapter*{\ }

        \begingroup%
        \makeatletter%
        \let\clearpage\relax% Stop LaTeX from going to a new page; and
        \vspace*{\fill}%
        \vspace*{\dimexpr-50\p@-\baselineskip}% Remove the initial (default) 50pt gap (plus 1 line

        \begin{center}
	        \begin{large}
	            \sffamily
		        \textbf{Abstract}
	        \end{large}
        \end{center}
        \vspace{0.75em}

        \begin{english}
            #2
        \end{english}


        \vspace*{\fill}%
        \endgroup
        \cleardoublepageusingstyle{plain}
    }

}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TOC AND BIB MACROS                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\maketoc}{
    \ifthenelse{\equal{\documentType}{thesis}}{
        \cleardoublepageusingstyle{plain}
    }{}
    \begin{spacing}{1.16}
    \tableofcontents
    \end{spacing}
    \ifthenelse{\equal{\documentType}{thesis}}{
        \cleardoublepageusingstyle{plain}
    }{}
    \pagenumbering{arabic}
}

\newcommand{\makebib}{
    \ifthenelse{\equal{\documentType}{thesis}}{
        \cleardoublepageusingstyle{plain}
    }{}
    \ifdef{\thechapter}{
        \addtocounter{chapter}{1}
    }{
        \addtocounter{section}{1}
    }
    \printbibliography
}
