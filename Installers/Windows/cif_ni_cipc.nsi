; CIF NI CIPC Windows installer
; Installs cif_cipc.dll to a fixed location under Program Files.

!include "MUI2.nsh"

!define PRODUCT_NAME "CIF NI CIPC"
!define PRODUCT_VERSION "0.1.1"
!define PACKAGE_NAME "cif-ni-cipc"
!define PRODUCT_PUBLISHER "Dome Automation"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\CIF_NI_CIPC"
!define INSTALL_DIR "$PROGRAMFILES64\CIF_Foundation\Libraries"
!define UNINSTALLER_NAME "${PACKAGE_NAME}-Uninstall.exe"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PACKAGE_NAME}-${PRODUCT_VERSION}.exe"
InstallDir "${INSTALL_DIR}"
RequestExecutionLevel admin
ShowInstDetails show
ShowUnInstDetails show

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_TEXT "Setup has successfully installed ${PRODUCT_NAME}.$\r$\n$\r$\nIf you are using CIPC from LabVIEW you should also install the CIF CIPC package using VIPM."
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath "${INSTALL_DIR}"
  File "resource\cif_cipc.dll"

  WriteUninstaller "${INSTALL_DIR}\${UNINSTALLER_NAME}"

  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "UninstallString" "$\"${INSTALL_DIR}\${UNINSTALLER_NAME}$\""
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "InstallLocation" "${INSTALL_DIR}"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoRepair" 1
SectionEnd

Section "Uninstall"
  Delete "${INSTALL_DIR}\cif_cipc.dll"
  Delete "${INSTALL_DIR}\${UNINSTALLER_NAME}"
  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"
SectionEnd
