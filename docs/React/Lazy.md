## Module React.Lazy

#### `lazy`

``` purescript
lazy :: forall a. a -> (a -> ReactElement) -> ReactElement
```

A performance optimization that delays the building of ReactElements.

#### `lazy'`

``` purescript
lazy' :: forall a. a -> (a -> Array ReactElement) -> Array ReactElement
```

Like `lazy`, but for arrays of `ReactElements`.

#### `lazy2`

``` purescript
lazy2 :: forall a b. a -> b -> (a -> b -> ReactElement) -> ReactElement
```

Lifted version of `lazy` to two arguments. Useful when having to compare
more values at once - for example both `props` and `state`. Wrapping values
in `Tuples` would not help, since the reference equality check would fail.

#### `lazy2'`

``` purescript
lazy2' :: forall a b. a -> b -> (a -> b -> Array ReactElement) -> Array ReactElement
```

Like `lazy2`, but for arrays of `ReactElements`.


