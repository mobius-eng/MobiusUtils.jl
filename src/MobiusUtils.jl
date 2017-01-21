__precompile__()
module MobiusUtils

using Dierckx

export bisection, falseposition, interpolate

"""
Simple bisection method to solve nonlinear equation
f(x)=0for f: ℝ → ℝ  on the interval (a,b). The result
is the solution c such that f(c-ϵ/2)×f(c+ϵ/2) < 0, i.e.
is the centre of the interval of the length ϵ over
which f(x) changes the sign.
"""
function bisection(f,a,b,ϵ)
    fa = f(a)
    fb = f(b)
    while abs(a-b)≥ ϵ
        c = (a+b)/2
        fc = f(c)
        (a,fa) = fc*fb ≤ 0? (c,fc) : (a,fa)
        (b,fb) = fa*fc ≤ 0? (c,fc) : (b,fb)
    end
    (a+b)/2
end

"""
Algorithm of false position to solve nonlinear
equation f(x)=0 for f: ℝ → ℝ on the interval x∈(a,b)
with the correction for functions that change from
"almost flat" to "rapid growth" type (see Hamming for
    more details).
"""
function falseposition(f,a,b,ϵ)
    fa = f(a)
    fb = f(b)
    keptabefore = false
    kepta = false
    while abs(a-b)≥ ϵ
        c = a - fa*(b-a)/(fb-fa)
        fc = f(c)
        keptabefore = kepta
        if fc*fb ≤ 0
            a,fa = c,fc
            kepta = false
        end
        if fa*fc ≤ 0
            b,fb = c, fc
            kepta = true
        end
        if keptabefore && kepta
            fa = fa/2
        elseif (!keptabefore) && (!kepta)
            fb = fb/2
        end
    end
    a - fa*(b-a)/(fb-fa)
end

"""
Interpolates the data between the points (x,y). Produces
the function of x.

Parameters:
- **order**: order of interpolation(1-5), defualts to 1
- **outside**: what to do when argument is outside of
  interpolation region: "extrapolate" (default), "error",
  "zero", "nearest"
- **spline**: if `false` (default) returns a function, otherwise
  returns the spline object of Dierckx (can be used as a function
  but is not always recognised as such).
"""
function interpolate(x, y, order = 1, outside = "extrapolate", spline = false)
    spl = Spline1D(x, y, k = order, bc = outside)
    spine? spl : z -> spl(z)
end

end # module
