module RegExp2 where

{- alternate file where we are buff babies who can dance like a man
  ...wait, no, sorry just had that part of adventure time stuck in my head

  this is a file where we abandon strings except for syntactic convenience in favor
  of lists of strings for the ability to, y'know, do induction and prove things with them more easily

-}

open import Relation.Binary.PropositionalEquality as PropEq using (_≡_)
open import Relation.Binary.PropositionalEquality.Core
open import Relation.Nullary
open import Data.List
open import Data.String hiding (_++_)
open import Data.Char

data RegExp : Set where
  <_> : Char -> RegExp
  ⊥ : RegExp
  ε : RegExp
  _∘_ : RegExp -> RegExp -> RegExp
  _∪_ : RegExp -> RegExp -> RegExp
  _* : RegExp -> RegExp

conjR : RegExp -> RegExp -> RegExp 
conjR < x > r2 = {!!}
conjR ⊥ r2 = ⊥
conjR ε < x > = ⊥
conjR ε ⊥ = ⊥
conjR ε ε = ε
conjR ε (r2 ∘ r3) = {!!}
conjR ε (r2 ∪ r3) = {!!}
conjR ε (r2 *) = ε
conjR (r1 ∘ r2) r3 = {!!}
conjR (r1 ∪ r2) r3 = {!!}
conjR (r1 *) r2 = {!!}

data _¿_ : List Char -> RegExp -> Set where
  matchChar : (a : Char) ->  [ a ] ¿ < a >
  matchEpsilon : [] ¿ ε
  matchUnion₁ : ∀ {l} {R₁ R₂} -> l ¿ R₁ -> l ¿ (R₁ ∪ R₂)
  matchUnion₂ : ∀ {l} {R₁ R₂} -> l ¿ R₂ ->  l ¿ (R₁ ∪ R₂)
  matchConcat : ∀ {R₁ R₂ l₁ l₂} -> l₁ ¿ R₁ -> l₂ ¿ R₂ -> (l₁ ++ l₂) ¿ (R₁ ∘ R₂) 
  matchStar₁ : ∀ {R} -> [] ¿ R *
  matchStar₂ : ∀ {R} {l₁ l₂} -> l₁ ¿ R -> l₂ ¿ R * -> (l₁ ++ l₂) ¿ (R *)

-- these are the matching rules for regular expressions, now let's try some examples

ex2 : (toList "0")  ¿ < '0' >
ex2 = matchChar '0'

ex1 : (toList "01") ¿ (< '0' > ∘ ( < '1' > ∪ < '0' > ))
ex1 = matchConcat (matchChar '0') (matchUnion₁ (matchChar '1'))

ex3 : (toList "000") ¿ (< '0' > *)
ex3 = matchStar₂ (matchChar '0') (matchStar₂ (matchChar '0') (matchStar₂ (matchChar '0') matchStar₁))

ex4 : [] ¿ (⊥ *)
ex4 = matchStar₁

data _=ᵣ_ (R₁ R₂ : RegExp) : Set where
 eqR : ((w : List Char) -> w ¿ R₁ -> w ¿ R₂) -> ((w : List Char) -> w ¿ R₂ -> w ¿ R₁) -> R₁ =ᵣ R₂

aux : (w : List Char) -> w ¿ ε -> w ≡ []
aux .[] matchEpsilon = PropEq.refl

aux' : (w : List Char) -> w ≡ w ++ []
aux' [] = PropEq.refl
aux' (x ∷ w) = PropEq.cong (λ s → x ∷ s) (aux' w)

ex5-1 : (R : RegExp) -> (w : List Char) -> w ¿ R -> w ¿ (R ∘ ε)
ex5-1 R w pf = subst (λ s → s ¿ (R ∘ ε)) (sym (aux' w)) (matchConcat {R} {ε} {w} {[]} pf matchEpsilon)

ex5-2 : (R : RegExp) -> (w : List Char) -> w ¿ (R ∘ ε) -> w ¿ R
ex5-2 R .(l₁ ++ l₂) (matchConcat {.R} {.ε} {l₁} {l₂} pf pf₁) = subst (λ s → s ¿ R) blah pf
  where blah : l₁ ≡ l₁ ++ l₂
        blah = subst (λ s → l₁ ≡ l₁ ++ s) (sym (aux l₂ pf₁)) (aux' l₁)
ex5 : (R : RegExp) -> (R ∘ ε) =ᵣ R
ex5 R = eqR (ex5-2 R) (ex5-1 R)

-- see, this all works way easier for actual proofs by keeping the inductive structure because there's no sheds left

