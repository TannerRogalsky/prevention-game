Prevention
===
A game by Tanner Rogalsky and Chris Baragar. Made with Moai and Lua.

Building requires the Android SDK installed.
Follow these instruction: http://getmoai.com/wiki/index.php?title=Building_Moai_Games_For_Android_Devices

-------------------------------------------------------------------------------
-- ALL PLATFORMS
-------------------------------------------------------------------------------

  - Use the "run-host.sh" script in the this directory to create the Android
    host once settings have been configured. This will create a directory
    called "build" which contains a full Android project (that can subsequently
    be imported into Eclipse if desired) and builds and launches the host, as
    configured, onto the default Android emulator or device.

-------------------------------------------------------------------------------
-- WINDOWS
-------------------------------------------------------------------------------

  - Ensure that Apache Ant is properly installed and configured. This includes
    installing a JDK, setting JAVA_HOME and ANT_HOME environment variables and
    adding the Ant bin/ directory to your PATH.
