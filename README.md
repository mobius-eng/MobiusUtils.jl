# MobiusUtils

Collection of some functions that are used quite often. So far it includes:
- `bisection` simple and slightly inefficient method to solve nonlinear
equations. Works for scalar equations `f(x)=0` when the root is known to lie in
the interval `(a, b)`.
- `falseposition` slightly more advanced version of `bisection`. Includes
correction for faster conversion for fast growing functions like `f(x)=exp(x)`.
- `interpolate` is a simplified interface to `Dierckx.jl` interpolation
function.
