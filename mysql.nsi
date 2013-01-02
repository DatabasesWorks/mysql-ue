; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "MySQL Simplified Installer"
!define PRODUCT_VERSION "5.5.28"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_DIR "$PROGRAMFILES\MySQL"

; MUI 1.67 compatible ------
!include "MUI.nsh"



; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
;!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
;!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
;!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
;!insertmacro MUI_PAGE_WELCOME

; Directory page
;!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
;!define MUI_FINISHPAGE_RUN 'msiexec /p "$INSTDIR\mysql-5.5.28-win32.msi"'
;!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
;!insertmacro MUI_UNPAGE_INSTFILES

; Language files
;!insertmacro MUI_LANGUAGE "English"
;!insertmacro MUI_LANGUAGE "Spanish"

; MUI end ------

!define MULTIUSER_EXECUTIONLEVEL Admin
!include MultiUser.nsh

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "build/MySQL-UE.exe"
InstallDir "$PROGRAMFILES\MySQL"
ShowInstDetails show
;ShowUnInstDetails show
Caption "MySQL Simplified Installer"
Function .onInit
         
         !insertmacro MULTIUSER_INIT


         !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "MySQL 5.5.28" SEC01
  SetOutPath "$PROGRAMFILES\MySQL\"
  SetOverwrite ifnewer
  File "mysql-5.5.28-win32.msi"
SectionEnd


Section -Post
  ExecWait "msiexec /i $\"$PROGRAMFILES\MySQL\mysql-5.5.28-win32.msi$\" /qb-"
  ExecWait '"$PROGRAMFILES\MySQL\MySQL Server 5.5\bin\MySQLInstanceConfig.exe" -i -q \
   "-l$PROGRAMFILES\MySQL\instance_creation_log.txt" "-p$PROGRAMFILES\MySQL\MySQL Server 5.5" \
    -v5.5.28 "-nMySQL Server 5.5" "-t$PROGRAMFILES\MySQL\MySQL Server 5.5\my-template.ini" \
    "-c$PROGRAMFILES\MySQL\MySQL Server 5.5\my.ini" ServerType=DEVELOPMENT \
    DatabaseType=MIXED ConnectionUsage=DSS Port=3306 StricMode=no Charset=Latin1 AddBinToPath=yes RootPassword=root'
SectionEnd

