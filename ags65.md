[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags28.md#topic41)
[![Previous](back.gif)](ags64.md#topic60)
[![Next](forward.gif)](ags66.md#topic62)

------------------------------------------------------------------------

Maths functions and properties
------------------------------

[FloatToInt](#FloatToInt)\
[IntToFloat](#IntToFloat)\
[ArcCos](#Maths.ArcCos)\
[ArcSin](#Maths.ArcSin)\
[ArcTan](#Maths.ArcTan)\
[ArcTan2](#Maths.ArcTan2)\
[Cos](#Maths.Cos)\
[Cosh](#Maths.Cosh)\
[DegreesToRadians](#Maths.DegreesToRadians)\
[Exp](#Maths.Exp)\
[Log](#Maths.Log)\
[Log10](#Maths.Log10)\
[RadiansToDegrees](#Maths.RadiansToDegrees)\
[RaiseToPower](#Maths.RaiseToPower)\
[Sin](#Maths.Sin)\
[Sinh](#Maths.Sinh)\
[Sqrt](#Maths.Sqrt)\
[Tan](#Maths.Tan)\
[Tanh](#Maths.Tanh)\
[Pi property](#Maths.Pi)\

------------------------------------------------------------------------

[]()

### FloatToInt

    int FloatToInt(float value, optional RoundDirection)

Converts the supplied floating point value into an integer.

This function is necessary because implicit conversions in the script
are not supported.

RoundDirection can be either *eRoundDown* (the default), *eRoundUp* or
*eRoundNearest*, which specifies what direction to round the floating
point number in.

Example:

    Display("Round down: %d", FloatToInt(10.7));
    Display("Round up: %d", FloatToInt(10.7, eRoundUp));
    Display("Round nearest: %d", FloatToInt(10.7, eRoundNearest));

displays the integer value of 10.7, rounded in the three different ways.

*See Also:* [IntToFloat](ags65.md#IntToFloat)

------------------------------------------------------------------------

[]()

### IntToFloat

    float IntToFloat(int value)

Converts the supplied integer value into a floating point number.

This function is necessary because implicit conversions in the script
are not supported.

Example:

    float number = IntToFloat(10);

loads 10.0 into the variable *number*.

*See Also:* [FloatToInt](ags65.md#FloatToInt)

------------------------------------------------------------------------

[]()

### ArcCos

    float Maths.ArcCos(float value)

Calculates the arc-cosine, in radians, of the specified value.

To convert an angle in radians to degrees, use
[Maths.RadiansToDegrees](ags65.md#Maths.RadiansToDegrees).

Example:

    float angle = Maths.ArcCos(1.0);

calculates the arc-cosine of 1.0 and places it into variable *angle*.

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),

------------------------------------------------------------------------

[]()

### ArcSin

    float Maths.ArcSin(float value)

Calculates the arc-sine, in radians, of the specified value.

To convert an angle in radians to degrees, use
[Maths.RadiansToDegrees](ags65.md#Maths.RadiansToDegrees).

Example:

    float angle = Maths.ArcSin(0.5);

calculates the arc-sine of 0.5 and places it into variable *angle*.

*See Also:* [Maths.Sin](ags65.md#Maths.Sin),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),

------------------------------------------------------------------------

[]()

### ArcTan

    float Maths.ArcTan(float value)

Calculates the arc-tan, in radians, of the specified value.

To convert an angle in radians to degrees, use
[Maths.RadiansToDegrees](ags65.md#Maths.RadiansToDegrees).

Example:

    float angle = Maths.ArcTan(0.5);

calculates the arc-tan of 0.5 and places it into variable *angle*.

*See Also:* [Maths.ArcTan2](ags65.md#Maths.ArcTan2),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### ArcTan2

    float Maths.ArcTan2(float y, float x)

Calculates the arctangent of y/x. This is well defined for every point
other than the origin, even if x equals 0 and y does not equal 0. The
result is returned in radians.

To convert an angle in radians to degrees, use
[Maths.RadiansToDegrees](ags65.md#Maths.RadiansToDegrees).

Example:

    float angle = Maths.ArcTan2(-862.42, 78.5149);

calculates the arc-tan of -862.42 / 78.5149 and places it into variable
*angle*.

*See Also:* [Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.ArcTan](ags65.md#Maths.ArcTan)

------------------------------------------------------------------------

[]()

### Cos

    float Maths.Cos(float radians)

Calculates the cosine of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float cosine = Maths.Cos(Maths.DegreesToRadians(360.0));

calculates the cosine of 360 degrees (which is 1.0) and places it into
variable *cosine*.

*See Also:* [Maths.ArcCos](ags65.md#Maths.ArcCos),
[Maths.Cosh](ags65.md#Maths.Cosh),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Sin](ags65.md#Maths.Sin), [Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### Cosh

    float Maths.Cosh(float radians)

Calculates the hyperbolic cosine of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float hcos = Maths.Cosh(Maths.DegreesToRadians(360.0));

calculates the hyperbolic cosine of 360 degrees and places it into
variable *hcos*.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Sinh](ags65.md#Maths.Sinh), [Maths.Tanh](ags65.md#Maths.Tanh)

------------------------------------------------------------------------

[]()

### DegreesToRadians

    float Maths.DegreesToRadians(float degrees)

Converts the supplied angle in degrees, to the equivalent angle in
radians.

Since the trigonometric functions such as Sin, Cos and Tan work in
radians, this function is handy if you know the angle you want in
degrees.

Example:

    float cosine = Maths.Cos(Maths.DegreesToRadians(360.0));

calculates the cosine of 360 degrees (which is 1.0) and places it into
variable *cosine*.

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.RadiansToDegrees](ags65.md#Maths.RadiansToDegrees),
[Maths.Sin](ags65.md#Maths.Sin), [Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### Exp

    float Maths.Exp(float x)

Returns the exponential value of the floating-point parameter, x

The result is e to the power x, where e is the base of the natural
logarithm. On overflow, the function returns infinite and on underflow,
returns 0.

Example:

    float expValue = Maths.Exp(2.302585093);

calculates Exp of 2.302585093 (which should be 10) and places it into
the variable.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.Log](ags65.md#Maths.Log),
[Maths.Log10](ags65.md#Maths.Log10)

------------------------------------------------------------------------

[]()

### Log

    float Maths.Log(float x)

Returns the natural logarithm (base e) of x.

x must be a positive non-zero number.

Example:

    float logVal = Maths.Log(9000.0);

calculates Log of 9000 (which should be 9.104980) and places it into the
variable.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.Exp](ags65.md#Maths.Exp),
[Maths.Log10](ags65.md#Maths.Log10)

------------------------------------------------------------------------

[]()

### Log10

    float Maths.Log10(float x)

Returns the base-10 logarithm of x.

x must be a positive non-zero number.

Example:

    float logVal = Maths.Log(9000.0);

calculates Log10 of 9000 (which should be 3.954243) and places it into
the variable.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.Exp](ags65.md#Maths.Exp),
[Maths.Log](ags65.md#Maths.Log)

------------------------------------------------------------------------

[]()

### RadiansToDegrees

    float Maths.RadiansToDegrees(float radians)

Converts the supplied angle in radians, to the equivalent angle in
degrees.

Since the trigonometic functions such as Sin, Cos and Tan work in
radians, this function is handy to convert the results of one of those
functions back to degrees.

Example:

    float halfCircle = Maths.RadiansToDegrees(Maths.Pi);

converts *PI* radians into degrees (which is 180).

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Sin](ags65.md#Maths.Sin), [Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### RaiseToPower

    float Maths.RaiseToPower(float base, float exponent)

Calculates the value of *base* raised to the power *exponent*.

This means that *base* is multiplied by itself *exponent* times.

Example:

    float value = Maths.RaiseToPower(4.0, 3.0);

calculates 4 to the power 3 (which is 64).

*See Also:* [Maths.Sqrt](ags65.md#Maths.Sqrt)

------------------------------------------------------------------------

[]()

### Sin

    float Maths.Sin(float radians)

Calculates the sine of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float sine = Maths.Sin(Maths.DegreesToRadians(360.0));

calculates the sine of 360 degrees (which is 0) and places it into
variable *sine*.

*See Also:* [Maths.ArcSin](ags65.md#Maths.ArcSin),
[Maths.Sinh](ags65.md#Maths.Sinh),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Cos](ags65.md#Maths.Cos), [Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### Sinh

    float Maths.Sinh(float radians)

Calculates the hyperbolic sine of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float hsine = Maths.Sinh(Maths.DegreesToRadians(360.0));

calculates the hyperbolic sine of 360 degrees and places it into
variable *hsine*.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.ArcSin](ags65.md#Maths.ArcSin),
[Maths.Sin](ags65.md#Maths.Sin),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Cosh](ags65.md#Maths.Cosh), [Maths.Tanh](ags65.md#Maths.Tanh)

------------------------------------------------------------------------

[]()

### Sqrt

    float Maths.Sqrt(float value)

Calculates the square root of the supplied value.

The square root is the number which, when multiplied by itself, equals
*value*.

Example:

    Display("The square root of 4 is %d!", FloatToInt(Maths.Sqrt(4.0)));

displays the square root of 4 (rounded down to the nearest integer).

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.RaiseToPower](ags65.md#Maths.RaiseToPower),
[Maths.Sin](ags65.md#Maths.Sin), [Maths.Tan](ags65.md#Maths.Tan)

------------------------------------------------------------------------

[]()

### Tan

    float Maths.Tan(float radians)

Calculates the tangent of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float tan = Maths.Tan(Maths.DegreesToRadians(45.0));

calculates the tan of 45 degrees (which is 1.0) and places it into
variable *tan*.

*See Also:* [Maths.ArcTan](ags65.md#Maths.ArcTan),
[Maths.Tanh](ags65.md#Maths.Tanh),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Cos](ags65.md#Maths.Cos), [Maths.Sin](ags65.md#Maths.Sin)

------------------------------------------------------------------------

[]()

### Tanh

    float Maths.Tanh(float radians)

Calculates the hyperbolic tangent of the specified angle (in radians).

To convert an angle in degrees to radians, use
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians).

Example:

    float htan = Maths.Tanh(Maths.DegreesToRadians(45.0));

calculates the hyperbolic tan of 45 degrees and places it into variable
*htan*.

*Compatibility:* Supported by **AGS 3.2.0** and later versions.

*See Also:* [Maths.ArcTan](ags65.md#Maths.ArcTan),
[Maths.Tan](ags65.md#Maths.Tan),
[Maths.DegreesToRadians](ags65.md#Maths.DegreesToRadians),
[Maths.Cos](ags65.md#Maths.Cos), [Maths.Sin](ags65.md#Maths.Sin)

------------------------------------------------------------------------

[]()

### Pi property

    readonly float Maths.Pi

Gets the value of Pi (defined as 3.14159265358979323846).

Example:

    Display("Pi is %f!", Maths.Pi);

displays the value of Pi.

*See Also:* [Maths.Cos](ags65.md#Maths.Cos),
[Maths.Sin](ags65.md#Maths.Sin), [Maths.Tan](ags65.md#Maths.Tan)


