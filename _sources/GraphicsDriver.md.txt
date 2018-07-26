Graphics driver selection
-------------------------

AGS has three available graphics drivers when run on Windows --
DirectDraw, Direct3D and OpenGL.

DirectDraw is the 'classic' software graphics driver, that AGS has used
ever since the initial Windows version was released. It's perfectly fine
for simple games that don't use many large sprites, tinting or alpha
blending. It's also quite fast at doing RawDrawing to the screen.

Direct3D is a newer, hardware accelerated graphics driver. It uses the
Direct3D 9.0 to render the game in a fully hardware-accelerated
environment. This means that the game will run a lot faster if you use
features such as alpha blending and tinting, which are quite slow to
perform in software mode. However, with Direct3D doing RawDraw
operations can be quite slow, and the driver won't work on all graphics
cards.

It should be noted that DirectDraw and Direct3D 9 drivers are know to
sometimes fail to work on latest versions of the Windows because of
compatibility issues.

OpenGL is another hardware accelerated graphics driver, and because it
is not strictly linked to particular version of DirectX, it may work
where Direct3D failed. Other than that, it should not have any
significant perfomance differences from the former.

No matter which you choose as your default graphics driver, the player
can always run the Setup program and switch to using the other driver if
they are having problems on their PC.

**System Requirements**

**DirectDraw**: any Windows-based PC with DirectX 5 or later installed<br>
**Direct3D**: any Windows-based PC with DirectX 9.0 installed and a
graphics card designed for DirectX 8.1 or later (most cards manufactured
from 2003 onwards)<br>
**OpenGL**: your graphics card drivers should provide support for
OpenGL 3.0 or higher for the game visuals to have full functionality.

If you are running with Direct3D 9 selected and get the error message
"Graphics card does not support Pixel Shader 1.4" on startup, this
indicates that your graphics card is too old to run with the Direct3D
driver. You should try one of the other two drivers instead.

See Also: [System.HardwareAcceleration
property](System#hardwareacceleration)
