module RegExp where

open import Relation.Binary.PropositionalEquality as PropEq using (_≡_)
open import Relation.Binary.PropositionalEquality.Core
open import Relation.Nullary
open import Data.List hiding (_++_)
open import Data.String
open import Data.Char

data RegExp : Set where
  <_> : Char -> RegExp
  ⊥ : RegExp
  ε : RegExp
  _∘_ : RegExp -> RegExp -> RegExp
  _∪_ : RegExp -> RegExp -> RegExp
  _* : RegExp -> RegExp

data _¿_ : String -> RegExp -> Set where
  matchChar : (a : Char) ->  fromList [ a ] ¿ < a >
  matchEpsilon : "" ¿ ε
  matchUnion₁ : ∀ {l} {R₁ R₂} -> l ¿ R₁ -> l ¿ (R₁ ∪ R₂)
  matchUnion₂ : ∀ {l} {R₁ R₂} -> l ¿ R₂ ->  l ¿ (R₁ ∪ R₂)
  matchConcat : ∀ {R₁ R₂ l₁ l₂} -> l₁ ¿ R₁ -> l₂ ¿ R₂ -> (l₁ ++ l₂) ¿ (R₁ ∘ R₂) 
  matchStar₁ : ∀ {R} -> "" ¿ R *
  matchStar₂ : ∀ {R} {l₁ l₂} -> l₁ ¿ R -> l₂ ¿ R * -> (l₁ ++ l₂) ¿ (R *)

-- these are the matching rules for regular expressions, now let's try some examples

ex2 : "0" ¿ < '0' >
ex2 = matchChar '0'

ex1 : "01" ¿ (< '0' > ∘ ( < '1' > ∪ < '0' > ))
ex1 = matchConcat (matchChar '0') (matchUnion₁ (matchChar '1'))

ex3 : "000" ¿ (< '0' > *)
ex3 = matchStar₂ (matchChar '0') (matchStar₂ (matchChar '0') (matchStar₂ (matchChar '0') matchStar₁))

ex4 : "" ¿ (⊥ *)
ex4 = matchStar₁

data _=ᵣ_ (R₁ R₂ : RegExp) : Set where
 eqR : ((w : String) -> w ¿ R₁ -> w ¿ R₂) -> ((w : String) -> w ¿ R₂ -> w ¿ R₁) -> R₁ =ᵣ R₂

aux : (w : String) -> w ¿ ε -> w ≡ ""
aux ."" matchEpsilon = PropEq.refl

module Stuff where
  open import Data.List as L
  proof-thing : {A : Set} -> (l : List A) -> l L.++ [] ≡ l
  proof-thing [] = PropEq.refl
  proof-thing (x ∷ l) = PropEq.cong (λ ls → x ∷ ls) (proof-thing l)


aux' : (w : String) -> w ≡ w ++ ""
aux' w = {!!}
-- I just need to convert a decideable into the actual term, but this is all confusing because w ++ "" should be decidably equal to w but it seems like it's not necessarily?

ex5-1 : (R : RegExp) -> (w : String) -> w ¿ R -> w ¿ (R ∘ ε)
ex5-1 R w pf = subst (λ s → s ¿ (R ∘ ε)) (sym (aux' w)) (matchConcat {R} {ε} {w} {""} pf matchEpsilon)

ex5-2 : (R : RegExp) -> (w : String) -> w ¿ (R ∘ ε) -> w ¿ R
ex5-2 R .(l₁ ++ l₂) (matchConcat {.R} {.ε} {l₁} {l₂} pf pf₁) = subst (λ s → s ¿ R) blah pf
  where blah : l₁ ≡ l₁ ++ l₂
        blah = subst (λ s → l₁ ≡ l₁ ++ s) (sym (aux l₂ pf₁)) (aux' l₁)
ex5 : (R : RegExp) -> (R ∘ ε) =ᵣ R
ex5 R = eqR (ex5-2 R) (ex5-1 R)
