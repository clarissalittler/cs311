module DFALang where

import Text.Parsec
import qualified Text.Parsec.Token as T
import Text.Parsec.Char
import Text.Parsec.String
import Text.Parsec.Language


data Sym = Char Char | Under
type Final = Bool

data Exp = Cond [(Sym, Exp)] Final
         | Call Decl

type Decl = String

data Result = End | Fail

{- 
   There's a little bit of a problem with the translation from this language to DFAs. It's not a huge one but it is a little bit of a conceptual ugliness that I dislike: there's an implicit epsilon transition when we "call" another expression and that makes the translation a lot less straightfoward than one would like. On the other hand, we already don't have the simplest translation because of our choice to connect machines through ands and ors.

   The evaluations are straightforward and so is, I think, the syntax (not that it's written down here in this file) so perhaps that's good enough for helping students think of finite automata execution as a kind of very simple programming.

What we want is a fairly kind of simple programming language. Basically a program will look like

error := cond 
         _ -> error
         done

f := cond 
      a -> f,end
      _ -> error
     done
-}

evalExp :: [(String,Exp)] -> Exp -> String -> Result
evalExp ds (Call d) s = case lookup d ds of
                          Nothing -> Fail
                          Just e -> evalExp ds e s
evalExp ds "" (Cond rules True) = End
evalExp ds "" (Cond rules False) = Fail
evalExp ds (c : cs) (Cond rules _) = case evalRules c rules of
                                       Nothing -> Fail
                                       Just e -> evalExp ds cs e
    where evalRules c [] = Nothing
          evalRules c (( Under, e) : rs) = Just e
          evalRules c (( Char c', e) : rs) = if c == c' then Just e else evalRules c rs

data Dfa = DExp Exp | DAnd Dfa Dfa | DOr Dfa Dfa
                    
evalDfa :: [(String, Exp)] -> Dfa -> String -> Result
evalDfa ds (DExp e) s = evalExp ds e s
evalDfa ds (DAnd d d') s = case evalDfa ds d s of
                             End -> evalDfa ds d s
                             Fail -> Fail
evalDfa ds (DOr d d') s = case evalDfa ds d s of
                            End -> End
                            Fail -> evalDfa ds d' s

---- now we start our parsing
---- we could just use the haskell parsing for this

lang = haskell

identifier = T.identifier lang
reserved = T.reserved lang
symbol = T.symbol lang
comma = T.comma lang
semi = T.semi lang
whiteSpace = T.whiteSpace lang
reservedOp = T.reservedOp lang

idenChar = do
  i <- identifier
  if length i == 1 then return (head i) else mzero

parseSym :: Parser Sym
parseSym = (Char `mapM` idenChar) <|> (reservedOp "_" >> return Under)
  

parseDfa :: Parser Dfa
parseDfa = choice [DExp `mapM` try parseExp, parseOr, parseAnd]

parseOr :: Parser Dfa
parseOr = do
  e <- parseExp
  reservedOp "\\/"
  d <- parseDfa
  return $ DOr (DExp e) d

parseAnd :: Parser Dfa
parseAnd = do
  e <- parseExp
  reservedOp "/\\"
  d <- parseDfa
  return $ DAnd (DExp e) d
  
parseExp :: Parser Exp
parseExp = parseCall <|> parseCond

parseCall :: Parser Exp
parseCall = do
  i <- identifier
  return $ Call i

parseCond :: Parser Exp
parseCond = do
  reserved "cond"
  newline
  a <- parseSym
