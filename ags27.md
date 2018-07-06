[]()

[![Contents](contents.gif)](ags.md) [![Up](up.gif)](ags12.md#topic20)
[![Previous](back.gif)](ags26.md#topic40)
[![Next](forward.gif)](ags28.md#topic41)

------------------------------------------------------------------------

Source Control integration
--------------------------

The AGS Editor supports integration with source control systems like
SourceSafe and Perforce.

**What is source control?**

Source Control allows you to easily keep copies of old versions of your
files, so that if you break something you can easily look back and see
what your script was like in previous versions.

AGS does not provide this functionality itself, but it is able to
integrate with Source Control applications such as SourceSafe and
Perforce in order to allow you to easily check things in and out.

**Which providers are supported?**

AGS supports any source control system that can integrate with Visual
Studio (this is called the MSCCI interface). Most source control systems
are quite heavyweight and designed for use by large teams, but there are
smaller systems like SourceSafe available which work well on a
standalone PC.

**How do I use it?**

If AGS detects an installed source control system, an extra option "Add
to source control" will appear on the File menu. Use this to add your
game to source control, and from then on whenever AGS attempts to edit a
file it will prompt you to check it out if necessary.

You can check in files by using the "Show Pending Checkins" option that
appears on the File menu once you've added your game to source control.

**Which files does AGS put under source control?**

AGS currently puts the main game file and your scripts, rooms, fonts and
translations under source control. Optionally, you can also add sound,
music and sprites by changing the setting in the General Settings pane.
