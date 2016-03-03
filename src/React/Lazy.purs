module React.Lazy (lazy, lazy', lazy2, lazy2') where

import React (ReactClass, ReactElement, createElement, createClass, getProps, spec)
import React.DOM (div)

import Prelude (bind, return, ($), not, unit)

-- | Internal reference equality function.
foreign import req :: forall a. a -> a -> Boolean

-- | Don't need Data.Tuple.
data StF a = StF (a -> ReactElement) a

-- | ReactClass with shouldComponentUpdate based on refernce equality.
lazyClass :: forall a. ReactClass (StF a)
lazyClass = createClass $ (spec unit render) { shouldComponentUpdate = suRefEq }
  where
    render this = do
      StF f st <- getProps this
      return (f st)
    suRefEq this (StF _ new) _ = do
      StF _ old <- getProps this
      return $ not (req old new)

-- | A performance optimization that delays the building of ReactElements.
lazy :: forall a. a -> (a -> ReactElement) -> ReactElement
lazy st f = createElement lazyClass (StF f st) []

-- | Like `lazy`, but for arrays of `ReactElements`.
lazy' :: forall a. a -> (a -> Array ReactElement) -> Array ReactElement
lazy' st f = [lazy st (\st -> div [] (f st))]

-- | Lifted version of `lazy` to two arguments. Useful when having to compare
-- | more values at once - for example both `props` and `state`. Wrapping values
-- | in `Tuples` would not help, since the reference equality check would fail.
lazy2 :: forall a b. a -> b -> (a -> b -> ReactElement) -> ReactElement
lazy2 st1 st2 f = lazy st1 \st1 -> lazy st2 \st2 -> f st1 st2

-- | Like `lazy2`, but for arrays of `ReactElements`.
lazy2' :: forall a b. a -> b -> (a -> b -> Array ReactElement) -> Array ReactElement
lazy2' st1 st2 f = lazy' st1 \st1 -> lazy' st2 \st2 -> f st1 st2
