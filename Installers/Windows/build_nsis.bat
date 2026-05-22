@echo off
setlocal

set "NSIS=%ProgramFiles(x86)%\NSIS\makensis.exe"
if not exist "%NSIS%" (
  echo Error: NSIS not found at "%NSIS%"
  exit /b 1
)

pushd "%~dp0"
"%NSIS%" "cif_ni_cipc.nsi"
if errorlevel 1 (
  popd
  exit /b 1
)

echo Successfully created cif_ni_cipc-0.1.1.exe
popd
endlocal
