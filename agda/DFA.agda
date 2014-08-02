module DFA where

open import Data.Nat
open import Data.Fin
open import Data.Bool
open import Data.Vec
open import Data.Product
open import Relation.Binary.PropositionalEquality as PropEq using (_≡_ ; refl)
open import Relation.Binary.PropositionalEquality.Core
open import Data.Char
open import Data.Empty

-- so we'll assume that the alphabet is Σ = Char, we'll also is always have q_0 = zero : Fin Q and we're letting
-- the number of states be Q+1
record DFA : Set where
  constructor dfa
  field
    Q : ℕ 
    δ : Fin (suc Q) -> Fin 2 -> Fin (suc Q)
    F : Fin (suc Q) -> Bool

record _¿_ {n : ℕ} (s : Vec (Fin 2) n) (D : DFA) : Set where
  constructor cpath
  field 
    path : Vec (Fin (suc (DFA.Q D))) (suc n)
    startCond : head path ≡ zero
-- it's a bit of an ugly hack, one could even say....it sucks....to have so many instances of suc floating around unnecesarily
    endCond : (DFA.F D (last path)) ≡ true
-- so what we're doing here is the requirement that each step in the sequence of states matches according to the δ
    δCond : (f : Fin n) -> lookup (suc f) path ≡ ((DFA.δ D) (lookup (inject₁ f) path) (lookup f s))
-- is there an easier way to do this?

uniq¿ : {n : ℕ} -> (d : DFA) -> (s : Vec (Fin 2) n) -> (p₁ : s ¿ d) -> (p₂ : s ¿ d) -> p₁ ≡ p₂
uniq¿ d s p₁ p₂ = {!!}

allDFA : DFA 
allDFA = dfa zero (λ x y → zero) (λ x → true)

allDFATest : [] ¿ allDFA
allDFATest = cpath [ zero ] PropEq.refl PropEq.refl (λ ()) -- cute!

allDFATest2 : (zero ∷ (zero ∷ [])) ¿ allDFA
allDFATest2 = cpath (zero ∷ zero ∷ zero ∷ []) PropEq.refl PropEq.refl aux
  where aux : (f : Fin (suc (suc zero))) → lookup (suc f) (zero ∷ zero ∷ zero ∷ []) ≡ DFA.δ allDFA (lookup (inject₁ f) (zero ∷ zero ∷ zero ∷ [])) (lookup f (zero ∷ zero ∷ []))
        aux zero = refl
        aux (suc zero) = refl
        aux (suc (suc ()))

allDFATest2' : (zero ∷ (zero ∷ [])) ¿ allDFA
allDFATest2' = cpath (zero ∷ zero ∷ zero ∷ []) refl refl ((λ {zero → refl ; (suc zero) → refl ; (suc (suc ())) }))
-- yay pattern matching lambdas

allDFATestAll : {n : ℕ} -> (c : Vec (Fin 2) n) -> c ¿ allDFA
allDFATestAll {zero} c = cpath (zero ∷ []) refl refl (λ ())
allDFATestAll {suc n} c = cpath (replicate zero) refl refl (λ f → lookupFact f)
  where lookupFact : {A : Set} {x : ℕ} {a : A} -> (i : Fin (suc x)) -> lookup i (replicate a) ≡ a
        lookupFact zero = refl
        lookupFact (suc zero) = refl
        lookupFact (suc (suc i)) = lookupFact (suc i)
        -- okay I need to clean the crap out of this one, but basically it was an annoying proof based on the fact that Agda didn't immediately know
        -- that lookups into a replicate are a constant map. Wompwomp. To be fair, it's not obvious is it?

emptyDFA : DFA
emptyDFA =  dfa zero (λ x y → zero) (λ x → false)

emptyDFATest : {n : ℕ} {c : Vec (Fin 2) n} -> c ¿ emptyDFA -> ⊥
emptyDFATest (cpath path startCond () δCond) -- looks mysterious, but it was actually a proof based on the fact that
                                             -- endCond would imply that false ≡ true because to /have/ a computational path
                                             -- implies that there's a way to have the F predicate return true, 
                                             -- when it's the constantly false function hence contradiction

-- let's have some operations on DFAs
_^- : DFA -> DFA
(dfa Q δ F) ^- = dfa Q δ (λ q -> not (F q))
{-
dfaCong : (D D' : DFA) 
       -> (pQ : DFA.Q D ≡ DFA.Q D')
       ->  (subst _ DFA.δ D ≡  -}

unitary : (d : DFA) -> (d ^-) ^- ≡ d
unitary (dfa Q δ F) = {!!} -- I want to at least start this proof but eventually show that you can't finish the last part without functional extensionality

complement1 : {n : ℕ} -> (d : DFA) -> (s : Vec (Fin 2) n) -> s ¿ d -> s ¿ (d ^-) -> ⊥
complement1 d s (cpath path startCond endCond δCond) (cpath path₁ startCond₁ endCond₁ δCond₁) = {!!} -- Oh shoot we need to show that if there is a path for a DFA then any other path is equal to it!!!!!!
