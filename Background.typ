#set par(first-line-indent: (all: true, amount: 2em))





= So how do we find our factors P and Q?

Modern computers basically just Guess, but Shor proposes something different. Lets take a guess $g$. see if it has a gcd with $N$. If not, lets try to make the guess better. Since $g$ and $N$ are co-prime we know that there must exist some r such that:

$ g^r=1 mod N $
$ x = a mod n $

- Must repeat eventually

To make a better guess we will factor it out to be 

$ (g^{r/2}+1) * (g^{r/2}-1)=0 mod N $

This looks like two numbers multiply to N!

- Either factor, or gcd factor, or $a*N$

So how do we find $r$?

This is where quantum computing comes in well.
One of those quantum gates is called the quantum Fourier transform. By applying that gate on multiple bits, it can reveal to us this $r$ value. This is the order finding problem.

This $r$ values is the repeating period of the powers. 

Then working back up the chain. Since we find $r$. We find 
$ (g^{r/2}+1) * (g^{r/2}-1)=0 mod N $
Which are better guesses.  (Repeat till succes)
Still might be wrong.
Which allow us to factor large numbers
which allow us to break RSA

- Hey didn't many of those problems look like the discrete log problem Also breaks Discrete log

#bibliography("citations.bib", style: "apa")




