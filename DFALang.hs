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

f := cond (end) 
      a -> f
      _ -> error
     done

we need a kind of guardedness condition in order to avoid bad infinite loops, all infinite loops in this language will have to be a kind of recursive call like

f := g
g := f

if at any point there's a 'cond' then we know some portion of the string will be consumed and everything is going to be okay

There's two easy ways we can do this: the first is to assert that /all/ declarations must start with a 'cond', in which case we know that every time that we make a call to another function then it's obvious that we're progressing towards termination.

That's definitely the easiest way, another slightly more complicated way is that we can really traverse the tree and just check to make sure that there's not going to be a self-referential call without having a 'cond' in place. That's going to end up being a little redundant since, in this incredibly simple language, there's really no reason to /not/ start your declaration with a cond. So we need to install a syntactic check for that when it comes to a declaration 
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
parens = T.parens lang

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
  isFinal <- option False (parens (reserved "end") >> return True) 
  newline
  cs <- many1 parseCase
  return $ Cond isFinal cs

parseCase :: Parser (Sym, Exp)
parseCase = do
  s <- parseSym
  reservedOp "->"
  e <- parseExp
  return $ (s,e)

parseDecl :: Parser (Decl, Exp)
parseDecl = do
  i <- identifier
  reservedOp ":="
  e <- parseCond
  return $ (i , e)
  
