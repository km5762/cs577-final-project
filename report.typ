

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
  
- Quantum break both



