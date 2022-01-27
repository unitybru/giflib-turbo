@echo off

echo ************************************
echo Building lib
echo ************************************

REM Log OS x86 or x64
wmic os get osarchitecture
SET INSTALLDIR=%cd%\\..\\..\\com.unity.recorder\\Plugins\\x64
echo Install dir is:
echo %INSTALLDIR%

REM build
if exist build_win (
    rmdir /s /q build_win
)

REM Build the Release library
mkdir build_win
pushd build_win
echo.
echo ************************************
echo Prepare CMake project
echo ************************************
cmake .. ^
	-A x64 ^
    -DCMAKE_INSTALL_PREFIX=%INSTALLDIR%
IF %ERRORLEVEL% NEQ 0 ( 
	echo Failed to prepare CMake project
	REM exit 1 
)
echo ************************************
echo Build and install library
echo ************************************
cmake --build . ^
	--target INSTALL ^
	--config Release
IF %ERRORLEVEL% NEQ 0 ( 
	echo Failed to build and install GIF wrapper library
	REM exit 1 
)

popd REM build_win

REM To debug Yamato failures of the native wrapper build, comment out these files and look at Yamato artifacts
REM rmdir /s /q build_win

