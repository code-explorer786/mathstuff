if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="Favorites-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

\romannumeral \ifx \protect \@typeset@protect \expandafter \expandafter \expandafter \expandafter \expandafter \expandafter \expandafter \z@ \else \expandafter \z@ \expandafter \protect \fi \end  {asy}
\end{Center}
\end{problem}

\begin{problem}[This was from my homework smh]
Let \(M\) and \(N\) be distinct points on the plane of \(\triangle ABC\) such that
\[AM : BM : CM = AN : BN : CN\]
Prove that \(M - N - O\) (\(M\), \(N\) and \(O\) are collinear) where \(O\) is the circumcenter of \(\triangle ABC\).
\end{problem}

\subsection{\texttt{N} Number Theory}
\setcounter{problem}{0}

\begin{problem}[POTD 1782]
Let \(\mathbb N\) denote the set of positive integers. A function \(f\colon\mathbb N\to\mathbb N\) has the property that for all positive integers \(m\) and \(n\), exactly one of the \(f(n)\) numbers
\[f(m+1),f(m+2),\ldots,f(m+f(n))\]is divisible by \(n\). Prove that \(f(n)=n\) for infinitely many positive integers \(n\).
\end{problem}

\begin{problem}[POTD 831]
Find all integers \(n \ge 2\) for which there exists an integer \(m\) and a polynomial \(P(x)\) with integer coefficients satisfying the following three conditions:
\begin{itemize}
\item \(m > 1\) and \(\gcd(m,n) = 1\);
\item the numbers \(P(0)\), \(P^2(0)\), \(\ldots\), \(P^{m-1}(0)\) are not divisible by \(n\); and
\item \(P^m(0)\) is divisible by \(n\).
\end{itemize}
Here \(P^k\) means \(P\) applied \(k\) times, so \(P^1(0) = P(0)\), \(P^2(0) = P(P(0))\), etc.
\end{problem}

\begin{problem}[POTD 2104]
Let \(P(x)\) be a polynomial of degree \(n > 1\) with integer coefficients and let \(k\) be a positive integer. Consider the polynomial\[ Q(x) = P(P(\dots P(P(x)) \dots )) \] where \(P\) occurs \(k\) times. Prove that there are at most \(n\) integers \(t\) such that \(Q(t) = t\).
\end{problem}

\begin{problem}[POTD 627]
Consider a sequence \(a_1, a_2, \dots \) of non-zero integers such that \(a_{m + n} \mid a_{m} - a_{n}\) for all \(m, n \in \mathbb{N}.\)
\begin{enumerate}[label=(\alph*)]
\item Show that the sequence can be unbounded.
\item Do there necessarily exist \(i \neq j\) such that \(a_i = a_j\)?
\end{enumerate}
\end{problem}

\begin{problem}[POTD 1956]
Prove that, for any positive integers \(a,b,c\), there is a positive integer \(k\) such that \[\gcd(a^k+bc,b^k+ac,c^k+ab)>1\]
\end{problem}

\begin{problem}[POTD 1972]
Determine all pairs \((a,b)\) of positive integers for which there exist positive integers \(g\) and \(N\) such that \[\gcd (a^n+b,b^n+a)=g\]holds for all integers \(n\geqslant N.\) (Note that \(\gcd(x, y)\) denotes the greatest common divisor of integers \(x\) and \(y.\))
\end{problem}

\begin{problem}[POTD 711]
We say that a set \(S\) of integers is rootiful if, for any positive integer \(n\) and any \(a_0, a_1, \cdots, a_n \in S\), all integer roots of the polynomial \(a_0+a_1x+\cdots+a_nx^n\) are also in \(S\). Find all rootiful sets of integers that contain all numbers of the form \(2^a - 2^b\) for positive integers \(a\) and \(b\).
\end{problem}

\begin{problem}[POTD 2321]
Determine all sequences \(a_1, a_2, \dots\) of positive integers such that for any pair of positive integers \(m\leqslant n\), the arithmetic and geometric means
\[ \frac{a_m + a_{m+1} + \cdots + a_n}{n-m+1}\quad\text{and}\quad (a_ma_{m+1}\cdots a_n)^{\frac{1}{n-m+1}}\]
are both integers.
\end{problem}

\subsection{Auxillary/Other problems}
\setcounter{problem}{0}

\begin{problem}[POTD 1362, genre \texttt{ACN}]
Let \(n \geqslant 100\) be an integer. Ivan writes the numbers \(n, n+1, \ldots, 2 n\) each on different cards. He then shuffles these \(n+1\) cards, and divides them into two piles. Prove that at least one of the piles contains two cards such that the sum of their numbers is a perfect square.
\end{problem}

\newpage
\section*{After the dust settles}
\setcounter{problem}{0}

\hfill

Huh...? It's not over?

No.

Oh no.

No no no no no.

Reader, hide. HIDE.

...

It's here.

\vfill

\begin{figure}[h]
\begin{Center}
\begin{minipage}{0.6\linewidth}
\begin{problem}[\href{https://artofproblemsolving.com/community/c6h3780559p37328805}{\textcolor{red}{\textbf{Unsolved}}}] \hfill \\
Are there any functions \(f: \mathbb{N} \to \mathbb{N}\) such that
\[f(f(n)) = 2\varphi(n)\]
for all \(n \in \mathbb{N}\), where \(\varphi\) is Euler's totient function?
\end{problem}
\end{minipage}
\end{Center}
\end{figure}

\vfill

\end{document}
