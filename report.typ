

⁠
⁠
Ryan Offstein⁠#import "@preview/drafting:0.2.2": *


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


Many places in modern networking use complex mathematical algorithms and processes to generate secure keys, and encrypt our messages. #ryan-comment(side: left)[This is a note]  Some examples of these are the Diffie-Hellman key exchange, and RSA. #dashiell-comment[This is a note] TestNote


- RSA Used in X amount of things
- You break RSA by factor large number
- Diffie-Hellman break by discrete log


  - The security of elliptic curve cryptography relies on the hardness of computing discrete logarithms in elliptic curve groups,
  @roetteler2017quantumresourceestimatescomputing
  
= In Networking

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

On the hardware front, 

Finally, the battle against the ossification of the internet's backbone is a long but steady battle. One such trick for dealing with ossification is building in backwards compatibility at the protocol level: A similar practice was done with TLS, wherein a 1.3 handshake will masquerade as 1.2, including many of the old headers for the purpose of preventing crashes on legacy clients @Westerbaan2022Dedending. A similar approach is taken today with post-quantum cryptography, where hybrid or fallback schemes are typically provided. In addition, techniques like protocol "greasing", where random unused fields are deliberately sent in transmissions, can help detect and deter problematic implementations before they become widespread @Westerbaan2022Dedending. 

== Case Studies

== CECPQ1
In a 2016 experiment to investigate the feasibility of post-quantum cryptography on a large scale, Google announced that a small fraction of Google Chrome web browser's would temporarily switch to a post-quantum key exchange algorithm in addition to the typically used elliptic curve default @google2016. The algorithm selected for the experiment was "New Hope", a lattice-based key-exchange which uses a problem known as "Ring Learning With Errors", or "Ring-LWE" @cryptoeprint2015. To facilitate its use within TLS, Google developed CECPQ1, a key-agreement algorithm with X25519, the existing elliptic curve, as a backstop in case of failure. The stated goals for this experiment were to 

#set quote(block: true, quotes: true) 
#quote(attribution: [@langley2016])[a) provide the research community a target because it would be very useful to know whether the ring structure in R-LWE is a mistake sooner rather than later

b) to test the real-world impact on latency and compatibility with the larger handshake messages that any post-quantum scheme seems likely to need.]

After several months, Google announced plans to end the experiment and discontinue CECPQ1 support in Chrome. The results were somewhat promising: Despite anticipated compatibility issues with middle boxes, CECPQ1's deployment was reportedly seamless. In addition, the median connection latency only increased by 1 ms. The devices most affected were those with already slow connections, which took an additional hit due to CECPQ1's increased message sizes: The slowest 5% saw an increase in latency of 20 ms, and the bottom 1% experienced an average of 150 ms extra latency @langley2016results. Despite this increase in latency, Google's experiment with CECPQ1 demonstrated the feasibility of widespread deployment of post-quantum cryptography.
== CECPQ2
Building on the insights gained from the CECPQ1 experiment, Google collaborated up with Cloudflare to test CECPQ2, an altered version of its Q1 counterpart. The primary goal of CECPQ2 was to continue testing a combined elliptic curve/post-quantum key-exchange algorithm at scale while tuning CECPQ1 to perform better in TLS 1.3 handshakes. 

TLS 1.3 differs from 1.2 in that the client sends a set of unsolicited public s to the TLS server, whereas only one would be sent in 1.2. This is particularly relevant for post-quantum key-exchange algorithms, which already suffer from larger key sizes. To test their impact on TLS 1.3, Google injected a dummy TLS extension into the handshake based on three different algorithm families key size estimations: Supersingular isogenies at 400 bytes, structured lattices at 1,100, and unstructured lattices at 10,000. After probing 2,500 websites to observe how they were affected, it was revealed that 21 of these websites to failed under the 10,000 byte load @langley2018. Despite this, the algorithms with smaller key sizes (Supersingular isogenies) consistently were measured to have longer key derivation times. The question posed by the results of these experiments was clear: Does the faster key derivation of lattice-based algorithm outstrip the increased network overhead resulting from its larger key sizes?

To further investigate this tradeoff, Google tested two variations of CECPQ2: CECPQ2, and CECPQ2b. Whereas CECPQ2 employed HRSS, an algorithm of the structured lattice family, CECPQ2b utilized SIKE, an isogeny-based algorithm. After deploying both to Cloudflare's TLS stack, metrics for both were collected. After analysis, it was found that the HRSS-based CECPQ2 generally outperformed Q2b across the majority of connection types, although Q2b had a significant advantage for slower connections due to its smaller message size, although the report noted that improvements in hardware or algorithmic optimizations may change this in the future @Kwiatkowski2019TLSPostQuantum.

#bibliography("citations.bib")
