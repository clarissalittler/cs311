<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Lecture 1: 9/30</a></li>
<li><a href="#sec-2">2. Lecture 2: 10/2</a></li>
<li><a href="#sec-3">3. Lecture 3: 10/7</a></li>
<li><a href="#sec-4">4. Lecture 4: 10/9</a></li>
<li><a href="#sec-5">5. Lecture 5: 10/14</a></li>
<li><a href="#sec-6">6. Lecture 6: 10/16</a></li>
<li><a href="#sec-7">7. Lecture 7: 10/21</a></li>
<li><a href="#sec-8">8. Lecture 8: 10/23</a></li>
<li><a href="#sec-9">9. Lecture 9: 10/28</a></li>
<li><a href="#sec-10">10. Lecture 10: 10/30</a></li>
<li><a href="#sec-11">11. Lecture 11: 11/4</a></li>
<li><a href="#sec-12">12. Lecture 12: 11/6</a></li>
<li><a href="#sec-13">13. Lecture 13: 11/13 (11/11 is Veteran's Day)</a></li>
<li><a href="#sec-14">14. Lecture 14: 11/18</a></li>
<li><a href="#sec-15">15. Lecture 15: 11/20</a></li>
<li><a href="#sec-16">16. Lecture 16: 11/25</a></li>
<li><a href="#sec-17">17. Lecture 17: 12/2 (Thanksgiving is 11/27)</a></li>
<li><a href="#sec-18">18. Lecture 18: 12/4</a></li>
<li><a href="#sec-19">19. Final Exam: 12/9 5:30-7:20pm</a></li>
</ul>
</div>
</div>

# Lecture 1: 9/30<a id="sec-1" name="sec-1"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 31 - 44
    -   Sipser 3rd ed - same
    -   Administrative Issues
    -   What is computation?
    -   Informal definition of computable function
    -   Informal introduction to DFAs
    -   Formal definition of DFAs + examples
    -   Worksheet 1: Basic DFAs and Proofs
-   Admin: 
    -   Introduction to course
    -   Goals of the course
    -   Grading policy
    -   Homeworks (plural) assigned

# Lecture 2: 10/2<a id="sec-2" name="sec-2"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 44 - 62
    -   Sipser 3rd ed pgs same
    -   More DFA examples
    -   Informal introduction to NFAs
    -   Formal definition of NFAs
    -   Examples of NFAs
    -   Definition of regular languages
    -   Construction of Union and Intersection for DFAs
    -   Worksheet 2: NFAs and Basic Constructions

# Lecture 3: 10/7<a id="sec-3" name="sec-3"></a>

-   Topics: 
    -   Equivalence between of NFAs and DFAs
    -   Constructions on NFAs and DFAs
        -   Union for NFAs (and why intersection is hard)
        -   Concatenation
        -   Complement
        -   Kleene star
    -   Worksheet 3: Equivalence of NFAs and DFAs

# Lecture 4: 10/9<a id="sec-4" name="sec-4"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 63 - 76
    -   Sipser 3rd ed pgs 63 - 76
    -   Introduction to RegExps
    -   Examples of RegExps
    -   Matching regexp as inductive predicate
    -   Sketch of equivalence between RegExps/NFAs
    -   Introducing examples of non-regular languages
    -   Worksheet 4: Regular Expressions

# Lecture 5: 10/14<a id="sec-5" name="sec-5"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 77 - 82, 99 - 106
    -   Sipser 3rd ed pgs 77 - 82, 101 - 111
    -   Definition of the pumping lemma
    -   Examples of using the pumping lemma
    -   Introduction to Context-Free Languages
    -   Introduction to context-free grammars
    -   Formal definition of context-free grammars
    -   Examples of CFGs
    -   Worksheet 5: Pumping Lemma

# Lecture 6: 10/16<a id="sec-6" name="sec-6"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 107 - 127
    -   Sipser 3rd ed pgs 111 - 129
    -   PDAs
    -   Chomsky Normal Form
    -   Examples of PDAs
    -   CFG to PDA conversion
    -   CFL Pumping Lemma
    -   Worksheet 6: Context Free Grammars

# Lecture 7: 10/21<a id="sec-7" name="sec-7"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 137 - 148
    -   Sipser 3rd ed pgs 165 - 175
    -   More CFL pumping lemma
    -   Introduction to Turing machines
    -   Discussion of informal descriptions vs. state machines
    -   First Examples of Turing machines
    -   Deciders vs. Recognizers
    -   Worksheet 7: Equivalence of CFGs and PDAs, CFL Pumping Lemma
-   Admin: 
    -   HW 1 due
    -   HW 1 solutions distributed

# Lecture 8: 10/23<a id="sec-8" name="sec-8"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 149 - 159, 165 - 172
    -   Sipser 3rd ed pgs 176 - 187, 193 - 201
    -   Examples of state machine descriptions for Turing machines
    -   Non-deterministic Turing machines/non-deterministic choice
    -   More examples of informal descriptions
        -   What is allowed in an informal description?
        -   Machines simulating other machines
    -   Examples of languages that are decidable
    -   Examples of decidable use of non-deterministic choice
    -   Worksheet 8: Turing Machines

# Lecture 9: 10/28<a id="sec-9" name="sec-9"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 173 - 182
    -   Sipser 3rd ed pgs 201 - 210
    -   Proving that there exists a recognizable, but not decidable language
        -   Russell's Paradox
        -   Halting problem
        -   <http://arxiv.org/abs/math/0305282> (please skim this before class!)
    -   Other examples of recognizable languages
    -   Languages that are neither recognizable nor decidable
        -   \overline{A<sub>TM</sub>}
        -   Proof that a recognizable, but not decidable language, has an unrecognizable complement
    -   Worksheet 9: Diagonalization and Non-determinism

# Lecture 10: 10/30<a id="sec-10" name="sec-10"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 206 - 211
    -   Sipser 3rd ed pgs 234 - 238
    -   Computable functions
    -   Computable functions as algorithms
    -   Computable reductions
    -   Examples of computable reductions
    -   Properties of computable reductions
    -   Worksheet 10: Computable Functions and Reductions

# Lecture 11: 11/4<a id="sec-11" name="sec-11"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 206 - 211
    -   Sipser 3rd ed pgs 234 - 238
    -   More examples of computable reductions
    -   Proving a language decidable with computable reductions
    -   Proving a language recognizable with computable reductions
    -   Proving a language undecidable
    -   Proving a language unrecognizable
-   Admin:
    -   HW 2 due

# Lecture 12: 11/6<a id="sec-12" name="sec-12"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 247 - 256
    -   Sipser 3rd ed pgs 275 - 284
    -   Even more computable reductions
    -   Intro to time complexity
    -   Counting time complexity for Turing machines
    -   O-notation
    -   Complexity class of P
    -   Examples of problems in P

# Lecture 13: 11/13 (11/11 is Veteran's Day)<a id="sec-13" name="sec-13"></a>

-   Topics: 
    -   Sipser 2nd ed pgs 256 - 294 (just skim 283 on)
    -   Sipser 3rd ed pgs 284 - 332 (just skim 311 on)
    -   NP complexity class
    -   Examples of problems in NP
    -   Polynomial-time reductions
    -   NP-hard
    -   NP-complete
    -   Proving a language is NP-complete
-   Admin:
    -   HW 3 due

# Lecture 14: 11/18<a id="sec-14" name="sec-14"></a>

-   Topics:
    -   Untyped lambda calculus
    -   Church encodings
    -   Y-combinator
    -   Programming with lambda calculus

# Lecture 15: 11/20<a id="sec-15" name="sec-15"></a>

-   Topics:
    -   Typed lambda calculus
    -   Statement of strong-normalization
    -   Argument that not every untyped term is typeable
    -   Connections of typed lambda calculus to logic
    -   Proofs-as-programs
    -   Consistency of the logic

# Lecture 16: 11/25<a id="sec-16" name="sec-16"></a>

-   Topics:
    -   Probably overflow lecture time for when we slow down
    -   Otherwise special topics in computability
-   Admin:
    -   HW 4 due

# Lecture 17: 12/2 (Thanksgiving is 11/27)<a id="sec-17" name="sec-17"></a>

-   Topics:
    -   Probably overflow lecture time for when we slow down
    -   Otherwise special topics in computability

# Lecture 18: 12/4<a id="sec-18" name="sec-18"></a>

-   Topics:
    -   Review of course
-   Admin: 
    -   HW 5 due

# Final Exam: 12/9 5:30-7:20pm<a id="sec-19" name="sec-19"></a>
