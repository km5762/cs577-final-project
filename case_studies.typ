= Adoption Case Studies
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



#bibliography("citations.bib", style: "apa")
