%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   {Användning av klassen:
%   Görs som \documentclass{rapport}
%   Språk kan specificeras genom options, \documentclass[english/swedish]{rapport}
%   }
%
%   {Inställningar för försättsblad:
%   Obligatoriska:  \title - Sätter huvudtitel
%                   \author - Sätter författare, flera författare separeras med \\
%   
%   Frivilliga:     \email - Sätter författares epost, separera flera med \\
%                   \supervisor - Sätter handledare
%                   \date - Sätter datum, standard är \today
%                   \toptext - Sätter överrubrik
%                   \subtext - Lägger till extra text under allt annat
%                   \conducted - Ändrar försättsbladet så datumet delas i två fält, Lab Conducted: ### och Report Submitted: \date (Om inte definerad \today)
%                   \resubmitted - Kräver att \conducted används, lägger tilll ett fält Report Resubmitted: ###
%                   \logo - En bild som kommer läggas på försättsbladet
% 
%   }
%   
%   {Globala macros:
%   \paran - Streamlinar \right( \left), \paran{#} = \right( # \left) 
%   \header - Ger header till alla sidor. Optional arguments [left text]<centre text>=right text=.
%   
%   Listings för Python: använd [language=PythonPlus]
%
%
%   }
%
%   {Till Gustav:
%   Lunds Universitet i vänstra hörnet kan ändras genom \@uni token.
%   }
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\ProvidesClass{rapport}[24.02.11]
\NeedsTeXFormat{LaTeX2e}

%Processing class options
\DeclareOption{swedish}{\def\lang{swedish}}
\DeclareOption{english}{\def\lang{english}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{xparse} %Ger NewDocumentCommand
\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper,top=2cm,bottom=2cm,left=1in,right=1in,marginparwidth=1.75cm]{geometry}
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,amscd}
\RequirePackage{graphicx}
\RequirePackage{xcolor} %Fler färger
\RequirePackage[colorlinks=false, allcolors=blue]{hyperref}
\RequirePackage{parskip} %% Tillåter vanligt radbyte
\RequirePackage{esvect} %Vektortecken
\RequirePackage{siunitx} %Eneheter i math environment
\RequirePackage{lipsum}%http://ctan.org/pkg/lipsum
\RequirePackage[outline]{contour}% http://ctan.org/pkg/contour
\RequirePackage{float} %Allows using H in tables in figures
\RequirePackage[export]{adjustbox}
\RequirePackage{mathtools}
\RequirePackage{nicefrac} %Allows 1/2 style fracs
\RequirePackage{hyperref} %Enables \href
\RequirePackage{caption, subcaption} %Allows for subfigure
\RequirePackage{listings} %allows code listing \begin{lstlisting}[language=Python] ... \end{lstlisting}
\RequirePackage{diagbox}
\RequirePackage{expl3} %Wrapper for LaTeX3
\RequirePackage{csquotes}
\RequirePackage{fancyhdr} % Paket för headern

% ===============
%%% Table formating
% ===============

\RequirePackage{booktabs}
    \setlength\heavyrulewidth{0.20ex}
    \setlength\cmidrulewidth{0.10ex}
    \setlength\lightrulewidth{0.10ex}

\RequirePackage[font=normalsize,labelfont={bf}]{caption} % Makes Figure x.x / Table x.x in captions bf
    \captionsetup[table]{aboveskip=3pt}
    \captionsetup[figure]{aboveskip=3pt}

\RequirePackage{siunitx} % Allows for S as tabular alignment, begin{tabular}{lSSS}, for aligning the decimal points.

% ===============
%%% Counts figures within sections
% ===============
\counterwithin{figure}{section}
\counterwithin{equation}{section}
\counterwithin{table}{section}


% ===============
%%% Defining universal macros %%%
% ===============
%\paran - Puts nice brackets around things
\NewDocumentCommand\paran{m}{\left(#1\right)}


%\header - Adds header to all pages
% [] sets left text, <> sets centre text, == sets left text, 
% if more than one is given they must be given in the correct order
\NewDocumentCommand{\header}{od<>d==}{
\pagestyle{fancy}
    \IfNoValueTF{#1}{
        \fancyhead[HL]{\author}
    }{
        \fancyhead[HL]{#1}
    }
    \IfNoValueTF{#2}{
        \fancyhead[HC]{\title}
    }{
        \fancyhead[HC]{#2}
    }
    \IfNoValueTF{#3}{
        \fancyhead[HR]{\date}
    }{
        \fancyhead[HR]{#3}
    }

}


% ===============
%%% Handlig language options %%%
% ===============
%Catching the case when no option is used
\ifx\lang\undefined
\def\lang{english}
\fi

%Defining words used on the titlepage
\def\empty{}
\def\@svenska{swedish}
\def\@engelska{english}

\ifx\lang\@svenska
\def\@by{Av}
\def\@contact{E-post}
\def\@suprvsr{Handledare}
\def\@uni{Lunds Universitet}
\def\@cond{Labboration Genomförd}
\def\@subm{Rapport Inlämnad}
\def\@resubm{Rapport Inlämnad Pånytt}
\else
\ifx\lang\@engelska
\def\@by{by}
\def\@contact{E-mail}
\def\@suprvsr{Supervisor}
\def\@uni{Lund University}
\def\@cond{Lab Conducted}
\def\@subm{Report Submitted}
\def\@resubm{Report Resubmitted}
\else
\def\@by{\textcolor{red}{undef}}
\def\@suprvsr{\textcolor{red}{undef}}
\def\@suprvsr{\textcolor{red}{undef}}
\fi
\fi

%Importing the babel package
\RequirePackage[\lang]{babel}

% ===============
%%% Creating the titlepage %%%
% ===============

%Provide commands for the variable parts of the titlepage
\def\title#1{\def\title{#1}}
\def\author#1{\def\author{#1}}
\def\email#1{\def\email{#1}}
\def\supervisor#1{\def\supervisor{#1}}
\def\date#1{\def\date{#1}}
\def\toptext#1{\def\toptext{#1}}
\def\subtext#1{\def\subtext{#1}}
\def\conducted#1{\def\conducted{#1}}
\def\resubmitted#1{\def\resubmitted{#1}}
\def\logo#1{\def\logo{#1}}



%Inputting the title page at the start of the document
\AtBeginDocument{

%Handling date
\if\date\empty
    \renewcommand\date{\today}
\fi

\begin{titlepage}
 \begin{center}
         \noindent
        \begin{minipage}{.35\textwidth}
            \Large \@uni 

        \end{minipage}
        \begin{minipage}{.55\textwidth}
            \begin{flushright}
            \if\conducted\undefined
            \Large \date
            \fi
            \end{flushright}  
        \end{minipage}

        
        \vspace*{4cm}
        \text{\LARGE \if\toptext\undefined \else\toptext \fi}
        

       \Large
        \rule{14cm}{0.2mm}
        \vspace*{0.2cm}
        
       \Huge
       \textbf{\if\title\undefined $\backslash title$ \else \title \fi}
        \Large
        \rule{14cm}{0.5mm}
       
        \vspace{1cm}
        \noindent
        \begin{minipage}{.45\textwidth}
            \textit{\@by} 

            \textbf{\Large \if\author\undefined $\backslash author$ \else\author \fi}
        \end{minipage}
        \begin{minipage}{.45\textwidth}
            \begin{flushright}
            \if\email\undefined\else
                \textit{\@contact}

                            \email
            \fi
            \end{flushright}  
        \end{minipage}

       
        \vspace{2cm}


        \if\supervisor\undefined\else
        \@suprvsr : \supervisor
        \fi

        \if\subtext\undefined\else
        \subtext
        \fi

        \if\conducted\undefined\else
        \large
        \vspace{1cm}
        \@cond: \conducted

        \@subm: \if\date\undefined{\today} \else{\date} \fi \\
        \if\resubmitted\undefined\else
        \vspace{.5cm}
        \@resubm: \resubmitted
        \fi
        \vspace{1.5cm}
        \fi
        
        \if\logo\empty
        \else
        \begin{figure}[H]
        \centering
        \includegraphics[width = .5\linewidth]{\logo}
        \end{figure}
        \fi
        \vfill
   \end{center}
\end{titlepage}

}

% ===============
%%% Listings for python code
% ===============

%%% Packages %%%
\RequirePackage{listings}
\RequirePackage[dvipsnames]{xcolor}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}
\renewcommand{\lstlistingname}{\textbf{Code Listing}} % Makes label bf
%%% Defining new version of the python language %%%
\lstdefinelanguage{PythonPlus}[]{Python}{
    %
    %%% general listing options %%%
    xrightmargin=1cm,
    xleftmargin=1cm,
    aboveskip=1em,
    breaklines=true,
    abovecaptionskip=6pt,
    captionpos=b,
    escapeinside={(¤}{¤)},
    frame=single,
    numbers=left,
    numbersep=6pt,
    numberstyle=\scriptsize,
    showstringspaces=false,
    deletekeywords={,print,},
    %
    %%% Adding python keywords %%%
    %
    % Python builtin
    morekeywords=[1]{,as,assert,nonlocal,with,yield,True,False,None,},
    %
    % Common functions
    morekeywords=[2]{,object,type,isinstance,copy,deepcopy,zip,enumerate,reversed,list,set,len,dict,tuple,range,xrange,append,execfile,real,imag,reduce,str,repr,print, any,all,abs, min, max, },
    %
    % Magic methods
    morekeywords=[3]{,__abs__,__add__,__and__,__bool__,__ceil__,__class__,__delattr__,
    __dir__,__divmod__,__doc__,__eq__,__float__,__floor__,__floordiv__,
    __format__,__ge__,__getattribute__,__getnewargs__,__gt__,__hash__,
    __index__,__init__,__init_subclass__,__int__,__invert__,__le__,
    __lshift__,__lt__,__mod__,__mul__,__ne__,__neg__,__new__,__or__,
    __pos__,__pow__,__radd__,__rand__,__rdivmod__,__reduce__,__reduce_ex__,
    __repr__,__rfloordiv__,__rlshift__,__rmod__,__rmul__,__ror__,__round__,
    __rpow__,__rrshift__,__rshift__,__rsub__,__rtruediv__,__rxor__,__setattr__,
    __sizeof__,__str__,__sub__,__subclasshook__,__truediv__,__trunc__,__xor__,bit_length,
    conjugate,denominator,from_bytes,imag,numerator,real,to_bytes,},
    %
    % Errors
    morekeywords=[4]{,Exception,NameError,IndexError,SyntaxError,TypeError,ValueError,OverflowError,ZeroDivisionError,},
    %
    % Numpy/module functions
    morekeywords=[5]{,ode,fsolve,sqrt,exp,sin,cos,arctan,arctan2,arccos,pi,array,norm,solve,dot,arange,isscalar,max,sum,flatten,shape,reshape,find,plot,linspace,legend,quad,polyval,polyfit,hstack,concatenate,vstack,column_stack,empty,zeros,ones,rand,vander,grid,pcolor,eig,eigs,eigvals,svd,qr,tan,det,logspace,roll,mean,cumsum,cumprod,diff,vectorize,lstsq,cla,eye,squeeze,
    % Add module functions
    },
    %
    % self
    morekeywords=[6]{,self,},
}

%%% Color theme %%%
\lstdefinestyle{colorEX}{
basicstyle=\ttfamily,
backgroundcolor=\color{backcolour},
commentstyle=\color{gray}\slshape, % Comments
keywordstyle=[1]\color{violet}, % Builtin
keywordstyle=[2]\color{Orange}, % Common functions
keywordstyle=[3]\color{Cyan}, % Magic methods
keywordstyle=[4]\color{OrangeRed}, % Errors
keywordstyle=[5]\color{NavyBlue}, % Numpy
keywordstyle=[6]\color{Maroon}, % Self
stringstyle=\color{ForestGreen}, % Strings
emphstyle=\color{Blue}\underbar,
literate=% Digit color
    *
    {0}{{{\color{Emerald}0}}}1
    {1}{{{\color{Emerald}1}}}1
    {2}{{{\color{Emerald}2}}}1
    {3}{{{\color{Emerald}3}}}1
    {4}{{{\color{Emerald}4}}}1
    {5}{{{\color{Emerald}5}}}1
    {6}{{{\color{Emerald}6}}}1
    {7}{{{\color{Emerald}7}}}1
    {8}{{{\color{Emerald}8}}}1
    {9}{{{\color{Emerald}9}}}1
    {@}{{{\color{Maroon}@}}}1 % Decorators
}

%%% Setting the created style %%%
\lstset{style=colorEX}


% Ska macros som \atom{1}{H} användas i rubriker ska det skrivas \texorpdfstring{\atom{1}{H}}

% \begin{figure}
%      \centering
%      \begin{subfigure}[b]{0.3\textwidth}
%          \centering
%          \includegraphics[width=\textwidth]{graph1}
%          \caption{}
%          \label{}
%      \end{subfigure}
%      \hfill
%      \begin{subfigure}[b]{0.3\textwidth}
%          \centering
%          \includegraphics[width=\textwidth]{graph2}
%          \caption{}
%          \label{}
%      \end{subfigure}
% \end{figure}
