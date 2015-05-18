module NFALang where

data Sym = Char Char | Under | Eps
type Final = Bool

data Exp = Any [(Sym, Exp)] Final
         | Call Decl

type Decl = String

data Result = End | Fail

evalExp :: [(String, Exp)] -> Exp -> String -> Result
evalExp ds e s = undefined
