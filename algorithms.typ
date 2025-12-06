= Post Quantum Algorithms

== What Already Works

While it is true that with a sufficiently powerful computer, one could break algorithms whose security depends on the difficulty of factoring large integers or solving the discrete logarithm problem, such as RSA, we already have other algorithms that are not yet known to be broken by quantum algorithms @Bernstein2009. In fact, symmetric algorithms, or secret key cryptography, are generally accepted to not really be affected by quantum computers. Though there will be a need to increase the key size (which is more or less true across the board), today's best secret key algorithms will seem to also be the best secret key algorithms in a quantum world @Bernstein2009 #text(red)[find another source or two for this].

List of asymmetric algorithms that are (or can be made to be with large enough key sizes) quantum resistant:
- Merkle's hash-tree public-key signature system
- McEliece's hidden-Goppa-code public-key encryption system
- Hoffstein–Pipher–Silverman “NTRU” public-key-encryption system
- Patarin's $"HFE"^("v"-)$ public-key-signature system

All of the above are from prior to the year 2000.

== Quantum Networks?

Aside from just ensuring that we have classical cryptographic algorithms that can resist quantum computers, we can also potentially improve networking by taking advantage of quantum computing and quantum information in the implementation of networks @pq3x-cmw9.

Will this be feasible anytime soon? Probably not, given the infrastructure cost, but it might be possible to implement at smaller scales in the near future.

#cite(<Bernstein2009>, form: "author") also mentions quantum cryptography, which is much like a stream cipher, but using a direct fiber link over which q-bits can be transmitted. He does not, however, think it is a reasonable alternative to post quantum classical cryptography, and notes that at least one proponent of quantum cryptography is a company selling quantum networking hardware called Magiq (and indeed, I found another: Aliro).

#bibliography("citations.bib", style: "apa")