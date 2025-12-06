#import "@preview/drafting:0.2.2": *

#let dashiell-comment = margin-note.with(stroke: orange)

#let ryan-comment = margin-note.with(stroke: green)

#set par(first-line-indent: (all: true, amount: 2em), leading: 1.5em, spacing: 2em)
#set page(numbering: "i")

#outline()

#set page(numbering: "1")
#context counter(page).update(1)

#set heading(numbering: "I.A.1")
#show heading: set block(above: 2em, below: 1.5em)

= Introduction
== Problem Statement
== Motivation
== Scope of the Paper


= Background/Intro

The emergence of quantum computers into the minds of mainstream media will lead towards a shift in how computation is thought about and done from now into the future. Quantum computers are like regular computers except instead of storing their informations a 1 or a 0, they store quantum q-bits, which can represent a wide variety of complex states. Using complex and specific arrangements of these q-bits and logic gates, one can perform operations that can be very fast, and can break common number theory problems like the discrete logarithm problem, and the factorization of a large number. By completing these tasks efficiently, they can undermine the security of many modern crypto systems we use today.

Since security is always a back and forth, arms race between the attacker and the defender, the next step is to create a new generation of post-quantum cryptographic algorithms, that are resistant to attacks by quantum computers. Thankfully, some algorithms we have in place already, such as symmetric key cryptography can be very secure against quantum computers given a large key size. Furthermore, NIST, the National Institute of Standards and Technology, has standardized algorithms that help secure and are resistant to threats in a quantum-computing world. Standardizing things like Key Encapsulation Mechanisms (KEM)'s to make keys secure, and using special Digital Signature Algorithms to authenticate who you are comminating with. 

There is already work being done to implement many of these systems into real world use cases, as we know, there is never a one size fits all solution to cryptography. A big barrier to widespread post-quantum crypto adoption are the infrastructure/hardware costs of implementing these new algorithms. Since modern quantum computers aren't and won't be on the scale to break any security for years to come, it might seem like there is no need to rush or worry, however, attackers can employ strategies such as harvest now, decrypt later, which could mean sensitive information not encrypted properly even today could be at risk. Not all is lost, as Google and other companies have already started testing and experiments changing algorithms over to post-quantum resistant ones with good amounts of success. 

This paper goes over the current landscape of quantum computers, and its relation to networking and security, understanding how they operate and break modern cryptography, as well as the current successes and barriers to keeping information safe in a post-quantum world.

== So what are Quantum Computers?

Starting at the very core of a computer we find the key difference between regular computers and quantum computers that causes the differences everywhere else. In classical computers, the smallest unit of storage and computation is a bit. Either 1 or 0, on or off. In quantum computers their smallest unit is called a q bit. @Chae2024ElementaryReviewQubits

Just like a regular bit can be in a state of 0 or 1, the two possible states a Q-bit can be in are $|0 chevron.r$ and $|0 chevron.r$. This "$| space chevron.r$" is called a _ket_ or Dirac notation, and is commonly used to describe q-bits and their state @Nielsen_Chuang_2010. What makes the q-bits different than regular bits is that they can exist as linear combinations @Nielsen_Chuang_2010 of these two states $|0 chevron.r$ and $|1 chevron.r$, such as
$ |x chevron.r = alpha|0 chevron.r + beta|1 chevron.r $. 

A good way of understanding these Q-bits is to understand them similar to how we understand probabilistic algorithms. In probabilistic algorithms, instead of being in a specified state, the algorithm describes a probabilistic distribution which lays out the possible states the system can be in, and through steps, the chance of bein in each state changes @Shor1997PolynomialTimeAlgorithms. 

Q-Bits act similarly. Instead of being in a state of 1 or 0, their linear combination of $|0 chevron.r$ and $|1 chevron.r$ helps define the probability of being in the $|0 chevron.r$ or $|1 chevron.r$ state when measured. 

Diving in further, we can look into the common analogy of Schrodinger cat. In the experiment, a cat is in a sealed box with a bottle of some poisonous gas. After a certain amount of time, there is a 50% chance that the bottle gets broken (usually by measuring random radioactivity), releasing the gas and killing the cat. It is almost as if the cat is both dead and alive, 50% dead, 50% chance alive, until we are able to open the box and confirm which one is the case. 

By observing or measuring the system, we force it to collapse to one of the two final states. You can thing about q-bits in this same way where measurement of the q-bit collapses the bit "With a probability determined by the squared magnitude of the coefficients _a_ and _b_ in the superposition"  @Chae2024ElementaryReviewQubits. 

Because of this collapse, you can think of all possible states the q-bit could be in as points along a sphere, all one unit away from the origin, and when you measure the q-bit, it will collapse into either $|0 chevron.r$ or $|1 chevron.r$.

So regardless of where the metaphorical arrow points on the circle, we will only get a measurement of 0 or 1 probabilistically, meaning, further steps are needed to make guaranteed outputs which is where logic gates come into play.

== Computing Gates

In classical computing we manipulate bits by passing them through gates that act like functions. By combining these gates, we can create complex behaviors such as adders, flip-flops, all the way up to the hardware structure found inside modern computers. Quantum computing follows a similar idea of applying operations on our quantum bits by passing them through _quantum gates_, however in the world of quantum, we need to take into account the probabilistic nature of the q-bits superposition.

The goal of quantum gates is to transform q-bits such that when we measure them at the end of our series of gates, the output contains useful information we can make judgments based on. Depending on the algorithm, this could mean manipulating our bit so that its final state measures as $|0 chevron.r$ or $|1 chevron.r$ with near-certainty, or taking repeating measurements of our q-bit after a set of operations, to "sample" from the probability distribution the q-bit represents. 

One example of how powerful the right combination of these quantum gates is the example of Grover's algorithm. Grover's algorithm applies a clever sequence of these gates to improve runtime of the the "Database search" problem. In this problem one is searching through a database of $N$ items for a single marked item. On classical computers, you have to search through the database one by one. The marked item could be the first you check or the last. On average you have to search over $N/2$ items to find your marked item. Since this scales polynomially with a factor of N we give it O(N) polynomial runtime. Grover's Algorithm uses quantum gates to  reduce this problem to O($ sqrt(n)$), which is a quadratic speed up over the classical algorithm @grover1996fastquantummechanicalalgorithm. 

== Cryptographic Theory

In 1994 Peter Shor showed one of the most famous applications of quantum gates and quantum computing: solving "Two number theory problems which have been studied extensively but for which no polynomial-time algorithms have yet been discovered are finding discrete logarithms and factoring integers" @Shor1997PolynomialTimeAlgorithms.

Because there are no polynomial-time methods to solve these problems, if we increase the size of the input, the complexity grows exponentially making large examples of these problems computationally infeasible on modern computers.

For example, RSA as its security, bases its strength off of the inability to factor large integers, and Diffie-Hellman key exchange bases its strength on the discrete logarithm problem. Shor showed that these problems can be solved in polynomial time on a quantum computer which effectively breaks the security assumptions of their security @Shor1997PolynomialTimeAlgorithms.

To illustrate, consider RSA. The system defines two types of keys: a public key $(N,e)$ and a private key $(p,q,d)$ where $p$ and $q$ are large prime factors of N.

$ "pk" = (N,e) $
$ "sk" = (p,q,d) $

To encrypt our message $m$ we compute our cipher text $c$ as follows. 
$ c := m^e mod N $

then to decrypt $c$ back into $m$ we compute
$ m := c^d mod N $

Further more, $e$ and $d$ are modular inverses of each other in a new modulus $phi(N)$. This $phi(N)$ is also directly related to $p$ and $q$ which are our 2 big factors of $N$.
$ e dot d = 1 mod phi(N) $
$ (p−1)(q−1) = phi(N) $

We could find d if we knew $phi(N)$ by using the extended euclidean algorithm to compute the modular inverse. So we need to find the factors $p * q = N$

Because $phi(N)$ can be directly calculated based on the factors $p$ and $q$, an attacker who can efficiently factor $N$ can compute $phi(N)$ and with that compute the private key $d$ (by using the extended euclidean algorithm to compute the modular inverse).

=== Prime Factorization

So how do we find our factors $p$ and $q$? The best approach on modern computers is to use brute force and guess and check, 

Lets start with an initial take a guess for a factor of N called $g$. If $gcd(g,N) != 1$ we already found a non-trivial factor of N. If not, lets try another guess. Shor's insight is a process of creating better guesses for factors of N. This problem of finding a better guess can be reduced down to the problem of order finding: a problem quantum computers can solve in polynomial time @Amico2019ExperimentalStudyShorIBMQ. 

It all starts with this equation.

$ g^r=1 mod N $

This $r$ is called the order, or the period, of this modular base $N$, because, as we multiply $g$ by itself, we get a sequence of numbers mod $N$. What this equation is saying is that these powers of $g$ will repeat after $r$ successive multiplication.

Since $g$ and $N$ are co-prime we know that there must exist some r such that the equation is true. (Or we could say since $g^0 = 1$ and there are only N possible values, by the pidgenhole principle they must repeat, and therefore 1 must repeat.) (OR For every prime $p$, the multiplicative group (mod p) is cyclic,@AnIntroductionToTheTheoryOfNumbers) Finding this particular r is the computational order solving problem, and it turns out quantum computers are great at solving it. 

The equation from the order solving problem is used to create two better guesses for our prime factors by factoring the left side into two numbers as follows.
$ g^r=1 mod N $

$ (g^(r/2)+1) * (g^(r/2)-1)=0 mod N $

This expression appears like two numbers multiply to $N$! The key problem is computing $r$. This is where quantum computing gates can be applied. 

Shor’s algorithm uses a quantum logic gate called the Quantum Fourier Transform. When this gate is applied over multiple q-bits that represent the powers of $g$. This gate extract the "order", our $r$ value, with high probability. Once we get this $r$ value, we still need to run a quick sanity check. $r$ needs to be even if we plan to raise $g^(r/2)$, and we also need to check that $g^(r/2) plus.minus 1$, isn't just some multiple of $N$ @Amico2019ExperimentalStudyShorIBMQ. If we are trying to factor $N$, a guess of $2N$ isn't very helpful at all! By repeating those steps till we get a $r$ that satisfies those conditions, we have created a number that shares factors with $N$, which we can use to break the RSA Crypto System.


=== Discrete Log Problem

Similar to integer factorization, the discrete logarithm problem is a hard mathematical problem that forms the backbone of certain crypto systems such as the Diffie-Hellman key exchange. The discrete logarithm problem is the problem of finding an exponent $k$ such that $b^k=a$ in some $mod m$.

By choosing your modulo "group" effectively, the difficulty of solving this equation for k is strong enough that public-key encryption algorithms like ElGamal (which is based on Diffie-Hellman) base their security on its hardness @menezes1997handbook.

One might observe that many of the steps in our previous section look like the discrete log problem—so it’s no surprise that Shor was also able to break the discrete logarithm problem with quantum computers in a similar way.

The fastest algorithm known for finding discrete logarithms is discussed in @DiscreteLog which runs sub-exponential time, which is good, but not polynomial like in @Shor1997PolynomialTimeAlgorithms that showed how to find discrete logarithms on a quantum computer with two modular exponentiations and two quantum Fourier transform.

== Quantum Computers
=== Background
=== Cryptographic Applications

= Current Landscape
== Families of Post Quantum Algorithms
=== Algorithms that Aren't Broken
While it is true that with a sufficiently powerful computer, one could break algorithms whose security depends on the difficulty of factoring large integers or solving the discrete logarithm problem, such as RSA, we already have other algorithms that are not yet known to be broken by quantum algorithms @Bernstein2009. In fact, symmetric algorithms, or secret key cryptography, are generally accepted to not really be affected by quantum computers. Though there will be a need to increase the key size (which is more or less true across the board), today's best secret key algorithms will seem to also be the best secret key algorithms in a quantum world @Bernstein2009. Work has been done to show exactly how much of an impact quantum computing will have on AES, for example, and while quantum computers will still do better than classical ones in theory, AES remains a useful post quantum algorithm, given an increase in key size @quantum-aes.

List of asymmetric algorithms that are (or can be made to be with large enough key sizes) quantum resistant:
- Merkle's hash-tree public-key signature system
- McEliece's hidden-Goppa-code public-key encryption system
- Hoffstein–Pipher–Silverman “NTRU” public-key-encryption system
- Patarin's $"HFE"^("v"-)$ public-key-signature system

All of the above are from prior to the year 2000 @Bernstein2009.

List of new post quantum algorithms:
- CRYSTALS-KYBER
  - Learning-with-errors module lattice based @learning-with-errors
  - encryption system
- CRYSTALS-DILITHIUM
  - Fiat-Shamir with aborts @fiat-shamir
  - signature system

=== New Developments

== NIST Standards
The future of technology is in quantum computing and with that comes many security risks to the cryptosystems already in place such as public key cryptography and digital signatures. These current systems rely on mathematical schemes, such as integer factorization or discrete logs, that are difficult to break but with quantum computing could be broken. In 2016 the National Institute of Standards and Technology (NIST) established a public post quantum cryptography standardization process where other people and companies can suggest and propose new algorithms for public key cryptography and digital signatures that are quantum computing resistant. In August 13, 2024, NIST finally published three Federal Information Processing Standards (FIPS) regarding post quantum cryptography with these proposed new algorithms. The three new standards are specifically about new security algorithms for public key cryptography and digital signatures.

=== FIPS 203
The first of three standards is FIPS 203 which is a module lattice based key encapsulation mechanism standard (ML-KEM). A key encapsulation mechanism (KEM) is a “set of algorithms that under certain conditions can be used by two parties to establish a shared secret key over a public channel” @FIPS203. This key along with a symmetric key cryptographic algorithm can be used to secure communication with encryption and authentication. There are three algorithms used in KEM, the probabilistic key generation algorithm, the probabilistic encapsulation algorithm, and the deterministic decapsulation algorithm. The standard denotes the algorithms by KeyGen, Encaps, and Decaps respectively.

The KeyGen algorithm produces both an encapsulation key and a decapsulation key using complete randomness internally. The encapsulation key is made public and the decapsulation key is kept private for the user running the KeyGen algorithm. The KeyGen algorithm can be seen in @fig-ML_KEM_KeyGen. Other users of the public key can perform seed consistency, encapsulation key, decapsulation key, or pair-wise consistency checks, but none of them “guarantee that the key pair was properly generated” @FIPS203. 
 
#figure(image("ML_KEM_KeyGen.png"),caption:[ML_KEM KeyGen Algorithm @FIPS203],) <fig-ML_KEM_KeyGen>

Basically, the algorithm is creating two random strings of 32 bytes and passing that into the KeyGen_internal algorithm which then outputs the encapsulation key, denoted ek, and the decapsulation key, denoted dk. The KeyGen_internal involves the K-PKE.KeyGen algorithm which is a much longer and more in-depth algorithm. The algorithm takes one of the random 32-byte strings and outputs what will eventually become the decapsulation key. PKE is a public key encryption scheme which is an asymmetric encryption scheme to send secret data over a public channel. Both PKE and KEM are used because the PKE is not approved to be a stand-alone scheme for protection against quantum cryptography. The PKE KeyGen algorithm also uses randomness to generate the encapsulation and decapsulation keys and the algorithm can be seen in @fig-K_PKE_KeyGen. 

#figure(image("K_PKE_KeyGen.png"),caption:[K_PKE KeyGen Algorithm @FIPS203],) <fig-K_PKE_KeyGen>

The Encaps algorithm uses the encapsulation key generated from the KeyGen algorithm and generates a copy of the shared public key and ciphertext using randomness. The user using the public encapsulation key is the one who runs this algorithm, but they must first check the encapsulation key. Once that has been done, they can run the Encaps algorithm which can be seen in @fig-ML_KEM_Encaps.

#figure(image("ML_KEM_Encaps.png"),caption:[ML_KEM Encaps Algorithm @FIPS203],) <fig-ML_KEM_Encaps>

The algorithm creates a random string of 32 bytes and passes that into the Encaps_internal algorithm which then outputs the shared secret key, denoted K, and the ciphertext, denoted c, using the checked encapsulation key from the KeyGen algorithm. The random string becomes the plaintext which after passing through the algorithm becomes the ciphertext. The Encaps_internal involves the K-PKE.Encrypt algorithm which takes the plaintext string, the checked encapsulation key and another random string. It then outputs what will eventually become the ciphertext. The K-PKE.Encrypt algorithm can be seen in @fig-K_PKE_Encrypt.

#figure(image("K_PKE_Encrypt.png"),caption:[K_PKE Encrypt Algorithm @FIPS203],) <fig-K_PKE_Encrypt>

The Decaps algorithm uses the decapsulation key generated from the KeyGen algorithm and generates a copy of the shared secret key. The user using the private decapsulation key is the one who runs this algorithm, but they must first check the decapsulation key and the ciphertext. Once that has been done, they can run the Decaps algorithm which can be seen in @fig-ML_KEM_Decaps.

#figure(image("ML_KEM_Decaps.png"),caption:[ML_KEM Decaps Algorithm @FIPS203],) <fig-ML_KEM_Decaps>

The algorithm takes the checked decapsulation key and ciphertext and passes them into the Decaps_internal algorithm which then outputs a shared secret key, denoted K’. The Decaps_internal involves the K-PKE.Decrypt algorithm which takes the decryption key, and the checked ciphertext. It then outputs what will eventually become the shared secret key. This algorithm also uses the K_PKE.Encrypt algorithm once again to check the correctness of the ciphertext. The K-PKE.Decrypt algorithm can be seen in @fig-K_PKE_Decrypt.

#figure(image("K_PKE_Decrypt.png"),caption:[K_PKE Decrypt Algorithm @FIPS203],) <fig-K_PKE_Decrypt>

The steps to run all these algorithms between two parties, let’s call Alice and Bob, are as follows. Alice runs the KeyGen algorithm to produce a decapsulation key, which Alice keeps private, and an encapsulation key, which is made public and available to Bob. Bob now takes this encapsulation key and runs the Encaps algorithm to generate a copy of the shared secret key along with the associated ciphertext. Bob sends the ciphertext to Alice who uses it as well as the decapsulation key to run the Decaps algorithm. Alice now has her own copy of the shared secret key and assuming the two copies are the same, Alice and Bob can now communicate and send information privately and be secure from quantum computers. 

There are three parameter sets for ML-KEM, those being ML_KEM-512, ML_KEM-768, and ML_KEM-1024. They are in order of increasing security strength but decreasing efficiency. 512 is defined as security category 1, 768 as security category 3, and 1024 as security category 5, which just means higher security as category number increases. 512 has a decapsulation failure rate of 2^(-138.8), 768 of 2^(-164.8), and 1024 of 2^(-174.8). It is a trade-off between security and performance and since it is available to both private and commercial organizations the scope is broad in terms of whether security or performance is preferred. ML_KEM can be implemented in hardware, firmware, or software and is based on the CRYSTALS-Kyber algorithm mentioned earlier. As of now ML-KEM is secure against quantum computers. 

=== FIPS 204
The second standard is FIPS 204 which is a module lattice based digital signature algorithm (ML-DSA). A digital signature algorithm (DSA) is a “set of algorithms that can be used to generate and verify digital signatures” @FIPS204. A digital signature is used to confirm the user signing the information, and to detect unauthorized modifications. Once the digital signature has been applied, it is non-repudiation since the user who signed the information cannot later claim to not be associated with the information. A digital signature appears as a sting of bits and is either on transmitted or stored data. There are three algorithms used in DSA, the key generation algorithm, the signing algorithm, and the verification algorithm. The standard denotes the algorithms by KeyGen, Sign, and Verify respectively.

The KeyGen algorithm works a little differently than in the previous standard. The algorithm produces a public key and a private key using a completely random seed. The KeyGen algorithm can be seen in @fig-ML_DSA_KeyGen. The algorithm creates a random 32-byte string and then passes that into a different KeyGen_internal algorithm. This algorithm creates the public key, denoted pk, and the private key denoted sk. PKE is not needed in ML-DSA, so the public private key pair is less complicated. The sign algorithm uses the private key from the KeyGen algorithm, a given message containing the information wishing to be signed, and another dummy random string of 32 bytes. The sign algorithm can be seen in @fig-ML_DSA_Sign. The message is formatted and then along with the dummy string and private key is passed into the sign_internal algorithm. The sign_internal algorithm creates the signature used on the message. The verify algorithm uses the public key from the KeyGen algorithm, the same given message, and the signature from the sign algorithm. The verify algorithm can be seen in @fig-ML_DSA_Verify. The message is formatted like before and then along with the public key and signature is passed into the verify_internal algorithm. The verify_internal algorithm returns a Boolean to verify the validity of the signature. 

#figure(image("ML_DSA_KeyGen.png"),caption:[ML_DSA KeyGen Algorithm @FIPS204],) <fig-ML_DSA_KeyGen>

#figure(image("ML_DSA_Sign.png"),caption:[ML_DSA Sign Algorithm @FIPS204],) <fig-ML_DSA_Sign>

#figure(image("ML_DSA_Verify.png"),caption:[ML_DSA Verify Algorithm @FIPS204],) <fig-ML_DSA_Verify>

The steps to run all these algorithms between two parties, let’s call Alice and Bob, are as follows. Alice in this case is the user who wishes to sign the information and Bob is the user receiving the information and verifying that the information is signed by the right user and has not been altered with. Alice runs the KeyGen algorithm to produce a public and private key. Alice keeps the private key and makes the public key available to Bob. Alice uses the private key and a message and runs the sign algorithm to produce a signature used on the message. Alice sends this message with the signature to Bob. Bob now takes the public key and the signed message and runs the verify algorithm. If the algorithm results in true then Bob has an unaltered message from Alice, and it is verified that Alice is the one who signed it. These three steps are called commitment, challenge, and response. 

The public key is made public so anyone who can get access to it can verify the message and signatory. The private key is needed to generate the signature, so only the person who owns it can sign, which makes faking a signature very hard. Digital signatures are required for all sorts of applications such as electronic mail, transfers of funds, data exchange and storage, and distribution. ML_DSA can be implemented in hardware, firmware, or software and is based on the CRYSTALS-Dilithium algorithm mentioned earlier. As of now ML_DSA is secure against quantum computers. 

=== FIPS 205

=== Applications
The standards have been published so there are already companies designing with these standards in mind. A few examples of companies doing so are Terra Quantum, Nexus Public Key Infrastructure (PKI), Microsoft, and Amazon Web Services (AWS). Terra Quantum added all three new FIPS standards to their open source TQ42 cryptography library. They did this to “ensure that [their] users are equipped with cryptographic tools that are not only cutting-edge but also recognized and vetted by one of the world’s leading authorities technology standards” @TerraQuantum2024. Anyone can now view these algorithms along with hundreds of others in the library to build their network and protect it from all sorts of threats by quantum and non-quantum computers. The TQ42 library also includes the FALCON algorithm which is what the next FIPS post quantum cryptography standard is based on. When that standard is finalized, TQ42 will already be prepared to add it to their library.

Nexus PKI provides public key infrastructure services and has already updated them in compliance with the new FIPS standards. They also offer the opportunity to test their services against FIPS 203, 204, and 205, to offer a better understanding of not only their services but also the standards as well. Nexus PKI uses these standards to “provide a solid security foundation for strong authentication, email encryption, digital signing, and securing IoT devices and applications” for all their users @Nexus2024. Microsoft has added FIPS 204 to their SymCrypt library to also protect their users from quantum cryptography. This will give their users the ability to test the standard out in their own applications @Thipsay2024. Microsoft is working on developing new DSA algorithms and is a part of the team that developed FIPS 203, 204, and 205 for NIST. AWS has done the same thing with FIPS 203. AWS incorporated all three parameter sets of ML-KEM. AWS has successfully used this algorithm in Hybrid Post-Quantum TLS in AWS KMS, Hybrid Post-Quantum TLS in AWS Secrets Manager, and AWS Transfer Family @Anastasova2025. AWS has also used FIPS 203 to update their secure file transfer protocol @AWS2025. 


=== Future Directions
The future of post quantum cryptography standards is more standards for stronger and more efficient algorithms. Quantum computers will become more powerful, so security measures need to be able to counter these advances. NIST is already ahead in this area having released FIPS 203, 204, and 205. NIST also has a couple more standards in the draft stages and are planned to be released soon. One being FIPS 206: Fast-Fourier Transform (FFT) over NTRU-Lattice Digital Signature Algorithm (FN-DSA). FIPS 206 will provide a third option for digital signatures that are secure against quantum computers. FN-DSA will be based on the FALCON algorithm which is a lattice-based signature scheme that uses FFTs and NTRU lattices. FIPS 206 will have smaller signatures and public keys but as of now is “difficult to implement” @Perlner2024. The private and public key generation will be performed by a lattice basis row rotation, and the signing will be done by a FFT and LDL tree @Perlner2024. There are many similarities when compared to FIPS 204 and 205, but the main differences are that FIPS 206 will only allow randomized signing, forbid export of seeds, and discourage the export of FFT basis and LDL tree @Perlner2024. FIPS 206 might be the recommended DSA for smaller signatures. 

The other planned FIPS standard to be released is FIPS 207: hamming quasi-cyclic key encapsulation mechanism (HQC-KEM). Right now, the plan for FIPS 207 is to serve as a backup KEM to ML-KEM @Townsend2025. Some of the predicted benefits of HQC-KEM is that it has long term keys so that allows for small ciphertexts and fast encapsulation and decapsulation @Robinson2025. HQC is also already being used by Mullvad VPN, Rosenpass VPN, and Crypto4A-HSMs so it has been tested for security purposes @Robinson2025. The concern surrounding FIPS 207 is the large public key size and whether it will be widely used. FIPS 206 is much closer to being drafted and passed, FIPS 207 was just introduced in the 6th PQC Standardization Conference in September of 2025. 

= In Networking
== Applications
=== Quantum Cryptography
Aside from just ensuring that we have classical cryptographic algorithms that can resist quantum computers, we can also potentially improve networking by taking advantage of quantum computing and quantum information in the implementation of networks @quantum-routing.

Will this be feasible anytime soon? Probably not, given the infrastructure cost, but it might be possible to implement at smaller scales in the near future.

#cite(<Bernstein2009>, form: "author") also mentions quantum cryptography, which is much like a stream cipher, but using a direct fiber link over which q-bits can be transmitted. He does not, however, think it is a reasonable alternative to post quantum classical cryptography, and notes that at least one proponent of quantum cryptography is a company selling quantum networking hardware called Magiq (and indeed, I found another: Aliro).

=== Quantum Physical Layer

=== Quantum Routers and Routing Algorithms (?)

== The Post-Quantum Threat Model

Before considering the best way to prepare for quantum computing in computer networks, one must understand the *threat model* in a post-quantum world; That is, what attackers might exist, what capabilities they might possess, what assets they may target, and what kinds of network traffic are at risk. All these questions must be fully fleshed out before any semblance of standards or "best-practices" can be established. As quantum computing is still in its infancy, it is difficult to provide answers to all these questions with a large degree of clarity. However, given past and current technological trends, a few conclusions can be drawn.

Firstly, accessibility to quantum computers, at least initially, is likely to be limited. The latest in quantum computing is that there are a number of issues with affordably scaling quantum computers @Kolodziejczyk2023. Recent estimates, for example, calculate that an "estimated 20 million noisy qubits with error rates below 10#super[-3], operating for several hours" @Erol2025 would be required to break RSA-2048, which would suggest that access might be limited to well-funded nation-states or organizations. As previously discussed, the existence of quantum computing is an existential threat to classical public-key cryptography. This means that, without sufficient preparation, these "early-adopters" of quantum computing might have a first-mover advantage @Kolodziejczyk2023, wherein existing public-key infrastructure might be rendered obsolete overnight. An attacker in this scenario would be able to forge certificates, impersonate websites, derive secret keys, decrypt network traffic, and wreak all manner of havoc on previously secure networks. A full impact assessment of all effected algorithms is shown in @fig-impact-assessment.

#figure(
  image("impact_assessment.png"),
  caption: [
    An impact assessment of post-quantum computing on classical cryptographic algorithms @Erol2025.
  ],
) <fig-impact-assessment>

If this is the case, the current outlook is not optimistic: Without sufficient preparation for post-quantum computing, critical network infrastructure could be compromised, sensitive communications exposed, and trust in existing PKI and secure protocols undermined. However, even if a widespread switch to post-quantum cryptography is made with haste, the threat against existing data remains: So-called "harvest now, decrypt later" attacks could occur which slowly amass a collection of encrypted data today, with the intention of decrypting it once quantum-capable machines become available @Moody2024. This means that any sensitive information transmitted or stored under pre-quantum cryptographic standards could remain compromised for years or even decades. Intellectual property, government documents, and healthcare information could all be targets of such an attack. As such, any data requiring long-term secrecy should not be transmitted using cryptographic schemes that remain vulnerable to future quantum attacks. 

In summary, attacks such as HNDL (Harvest Now Decrypt Later) demonstrate that quantum computing is not merely a distant threat in the future, but an active, present-day risk that requires immediate mitigation. While only a small number of well-funded adversaries are likely to possess quantum capabilities in the near future, the systems they would target, including government communications and long-lived sensitive data, represent critical components of modern infrastructure. Furthermore, protocols that rely on public key cryptography such as TLS are particularly vulnerable given their dependance on primitives which are broken by quantum computing. 

== Implications and Considerations

Post-quantum cryptographic algorithms pose a number of novel challenges to the network designer. To provide a point of comparison, the average ECDH (Elliptic-Curve Diffie-Hellman) key size is on the scale of tens of bytes; Post-quantum algorithms, on the other hand, range from hundreds to even thousands of bytes @marin2023. In the context of networking, these larger key sizes mean more packet fragmentation. The immediate impact of this is additional round trips, but an increase in the number of packets places more load on routers and switches and raises the likelihood of packet loss or retransmission, further compounding delays. While this may not be noticeable degradation in performance on the fastest of connections, the added latency on slower connections can rapidly accumulate. This effect is particularly evident in TLS, where larger key sizes may introduce multiple extra round trips per handshake, potentially crippling performance on slower connections.

Beyond the increase in network traffic, post-quantum algorithms also demand far more computational resources than traditional cryptography. Similar to network overhead, a "feast or famine" scenario can arise: performance degradation may be negligible on high-end hardware but becomes a significant challenge in resource-constrained environments. For example, one study comparing post-quantum algorithms found that while high-performance servers incurred less than 5% additional latency, certain algorithms on low-power devices required up to 12× more computation to achieve equivalent NIST security levels @cryptography9020032. So, while the backbone of the internet may handle post-quantum cryptography with minimal impact, consumer devices and IoT hardware could face substantial performance bottlenecks.

Another challenge with post-quantum cryptography in networking is its integration with protocols that don't support fragmentation: UDP, for example, has no such mechanism for packet reassembly. If the key sized produced by an algorithm exceeds the MTU, then it is completely unusable. As such, any application of key-exchange over UDP cannot simply "drop in" post-quantum algorithms as a replacement without utilizing a higher level protocol that runs on top of UDP such as QUIC. Even with such a protocol, however, many firewalls or NAT policies block fragmented UDP packets as an anti-DOS measure @rfc8085. 

Much of the discussion around post-quantum cryptography has centered around TLS and the internet, but this is not the only domain which relies on strong cryptographic algorithms: IPsec, WPA/WPA2, and VPNs are all examples of technologies which utilize cryptography to ensure confidentiality, integrity, and authenticity. Should classical cryptographic algorithms be proven insecure, these protocols would require a full redesign, contending with both previously identified issues and entirely new challenges. 

Finally, as with any advancements that require changes in the internet's backbone, post-quantum cryptography would undoubtedly face deployment issues on ossified infrastructure. Despite the native hardware support for classical cryptography, post-quantum algorithms face slow adoption, even on cutting-edge hardware. In addition, the lagging pace of infrastructure upgrades means that even as post-quantum algorithms mature, deployment will be uneven. Larger keys and certificates increase memory usage, which may be trivial on modern servers but can exceed the limitations of older hardware: An experiment by Cloudflare, for example, found that "there are clients or middleboxes that break when certificate chains grow by more than 10kB or 30kB" @westerbaan2024state_of_the_post_quantum_internet.

== Transition Strategies

While post-quantum computing completely breaks classical public-key cryptography, most symmetric algorithms are affected far less, typically experiencing only a reduction in effective security. As such, the current migration strategy for many symmetric cryptography algorithms, such as AES, is to simply increase the key size @Erol2025.

Despite this, strengthening symmetric cryptography is only one piece of the puzzle: Even if the encryption itself is resistant to quantum computers, this resistance means nothing if the key itself can be derived, or the recipient can be impersonated. This is why effective post-quantum public key schemes play a crucial role in preventing HNDL (Harvest Now Decrypt Later) and other such attacks. However, for many of the reasons outlined, transitioning to quantum-resistant algorithms is a challenging process with dedicated mitigation strategies.

As discussed, one of the primary concerns when switching to post-quantum algorithms is key size. If the key-establishment handshake becomes too large, packet fragmentation can compound with network latency to result in a massive decrease in performance. However, several networking protocols are flexible, and can be tuned to optimize for larger handshakes. In TCP, for instance, one such parameter is the initial congestion window size, or `initcwnd`, which controls how many packets the sender can transmit before receiving an ACK. In @inproceedings, it was found that the total handshake duration using post-quantum algorithms could be reduced by up to 50% by increasing `initcwnd`. Their results are shown in @fig-initcwnd:

#figure(
  image("initcwnd.png"),
  caption: [
    The impact of `initcwnd` on TLS 1.3 and SSH total handshake duration @inproceedings.
  ],
) <fig-initcwnd>

Other protocols contain similar levers, such as DTLS's max handshake size. In addition, more aggressive session reuse or caching mechanisms could greatly expedite the total handshake duration.

Beyond protocol-level tuning, algorithm selection also plays a role in performance. Similar to classical cryptography, not all quantum-resistant algorithms have the same characteristics, with each varying in strength, computational cost, and key size. An overview of the most common algorithm categories and their advantages and disadvantages is shown in @fig-pros-cons.

#figure(
  image("pros-cons.png"),
  caption: [
    The advantages and disadvantages of various categories of post-quantum cryptographic algorithms @cryptoeprint2024.
  ],
) <fig-pros-cons>

As such, there is no "one-size-fits-all" category of algorithm; Choosing the right type for a specific deployment scenario can help mitigate performance issues. In TLS, for instance, lattice-based algorithms are typically chosen, as they typically produce smaller outputs which are less prone to fragmentation and more suitable for networking environments.

On the hardware front, although not as mature as classical cryptography, advancements have been made in specialized accelerators to offset the computational overhead of post-quantum algorithms. Lattice-based algorithms, in particular, rely heavily on polynomial multiplication which accounts for nearly a third of the executed instructions @ZENG2024103782. Using dedicated hardware accelerators for NTT, an algorithm used for polynomial multiplication, as much as a 56% performance improvement has been observed for ML-KEM, the NIST standard post-quantum key-exchange algorithm @NTT2025. 

Finally, the battle against the ossification of the internet's backbone is a long but steady battle. One such trick for dealing with ossification is building in backwards compatibility at the protocol level: A similar practice was done with TLS, wherein a 1.3 handshake will masquerade as 1.2, including many of the old headers for the purpose of preventing crashes on legacy clients @Westerbaan2022Dedending. A similar approach is taken today with post-quantum cryptography, where hybrid or fallback schemes are typically provided. In addition, techniques like protocol "greasing", where random unused fields are deliberately sent in transmissions, can help detect and deter problematic implementations before they become widespread @Westerbaan2022Dedending. 

== Case Studies
=== CECPQ1
In a 2016 experiment to investigate the feasibility of post-quantum cryptography on a large scale, Google announced that a small fraction of Google Chrome web browser's would temporarily switch to a post-quantum key exchange algorithm in addition to the typically used elliptic curve default @google2016. The algorithm selected for the experiment was "New Hope", a lattice-based key-exchange which uses a problem known as "Ring Learning With Errors", or "Ring-LWE" @cryptoeprint2015. To facilitate its use within TLS, Google developed CECPQ1, a key-agreement algorithm with X25519, the existing elliptic curve, as a backstop in case of failure. The stated goals for this experiment were to 

#set quote(block: true, quotes: true) 
#quote(attribution: [@langley2016])[a) provide the research community a target because it would be very useful to know whether the ring structure in R-LWE is a mistake sooner rather than later

b) to test the real-world impact on latency and compatibility with the larger handshake messages that any post-quantum scheme seems likely to need.]

After several months, Google announced plans to end the experiment and discontinue CECPQ1 support in Chrome. The results were somewhat promising: Despite anticipated compatibility issues with middle boxes, CECPQ1's deployment was reportedly seamless. In addition, the median connection latency only increased by 1 ms. The devices most affected were those with already slow connections, which took an additional hit due to CECPQ1's increased message sizes: The slowest 5% saw an increase in latency of 20 ms, and the bottom 1% experienced an average of 150 ms extra latency @langley2016results. Despite this increase in latency, Google's experiment with CECPQ1 demonstrated the feasibility of widespread deployment of post-quantum cryptography.
=== CECPQ2
Building on the insights gained from the CECPQ1 experiment, Google collaborated up with Cloudflare to test CECPQ2, an altered version of its Q1 counterpart. The primary goal of CECPQ2 was to continue testing a combined elliptic curve/post-quantum key-exchange algorithm at scale while tuning CECPQ1 to perform better in TLS 1.3 handshakes. 

TLS 1.3 differs from 1.2 in that the client sends a set of unsolicited public s to the TLS server, whereas only one would be sent in 1.2. This is particularly relevant for post-quantum key-exchange algorithms, which already suffer from larger key sizes. To test their impact on TLS 1.3, Google injected a dummy TLS extension into the handshake based on three different algorithm families key size estimations: Supersingular isogenies at 400 bytes, structured lattices at 1,100, and unstructured lattices at 10,000. After probing 2,500 websites to observe how they were affected, it was revealed that 21 of these websites to failed under the 10,000 byte load @langley2018. Despite this, the algorithms with smaller key sizes (Supersingular isogenies) consistently were measured to have longer key derivation times. The question posed by the results of these experiments was clear: Does the faster key derivation of lattice-based algorithm outstrip the increased network overhead resulting from its larger key sizes?

To further investigate this tradeoff, Google tested two variations of CECPQ2: CECPQ2, and CECPQ2b. Whereas CECPQ2 employed HRSS, an algorithm of the structured lattice family, CECPQ2b utilized SIKE, an isogeny-based algorithm. After deploying both to Cloudflare's TLS stack, metrics for both were collected. After analysis, it was found that the HRSS-based CECPQ2 generally outperformed Q2b across the majority of connection types, although Q2b had a significant advantage for slower connections due to its smaller message size, although the report noted that improvements in hardware or algorithmic optimizations may change this in the future @Kwiatkowski2019TLSPostQuantum.

= Conclusion

With the creation of better and better quantum computers, we don't just get a new technology to play around with, we get a device capable of challenging the very structure of network security we rely on, by cracking down on problems that modern computers just cant solve.

To address risks quantum computers will have on security, many real-world approaches have been devised to "Shor" up holes in security algorithms like ElGamal, but they have been slowed due to deployment and infrastructure costs. The transition of global infrastructure toward quantum-resistant security wont be as easy as a one size fits all algorithm or approach though, many systems will have to change, and we will have to monitor tradeoffs of this security with tradeoffs of performance or complexity. 

Ultimately, the transition to post-quantum cryptography is one that many modern companies and industries like NIST and Google are showing promising steps in, in order to shape and better secure the data of tomorrow.

#pagebreak()

#set par(leading: 1em, spacing: 1em)
#bibliography("citations.bib", style: "apa")
