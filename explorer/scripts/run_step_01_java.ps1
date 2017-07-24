<#
    _Description:_

        Check if Java is installed by checking the java.exe existence
        If true, check if the Selenium is present then run it

    _Author:_ Nicolas GIGOU
    _Date:_ 29th of June, 2017
    _Powershell version used:_ 2.0
#>

# -----------------------------------------------------------------
#                        File constants
# -----------------------------------------------------------------
$SCRIPTS_FOLDER_PATH = Split-Path $MyInvocation.MyCommand.Path -Parent

# Java
$JRE_PATH = "$SCRIPTS_FOLDER_PATH\bin\jre-8u131-windows-i586.exe"
$JAVA_BIN_PATH = "C:\Program Files\Java\jre1.8.0_131\bin"
$JAVA_EXE_PATH = "$JAVA_BIN_PATH\java.exe"


# -----------------------------------------------------------------
#                             Script
# -----------------------------------------------------------------
If (Test-Path $JAVA_EXE_PATH) 
{
    Write-Host "Java is installed" -foregroundcolor green
} 
Else 
{ 
    Write-Host "Java ins't install yet" -foregroundcolor red
    Write-Host "Running Java install executable..."

    If(Test-Path $JRE_PATH)
    {
        # Let the user see what's happening
        Write-Host "Run $JRE_PATH"
        Start-Sleep -s 2
        Invoke-Expression $JRE_PATH
	    Write-Host "Java is now ready to use"
    }
    Else
    {
        Write-Host "The JRE exe hasn't been found for the install. Please check path: $JRE_PATH" -foregroundcolor red
        Write-Host "Please download it and move it to the bin folder before run this script"
    }
}

Write-Host "`n`nThis window will automatically be closed in some seconds. The Java installation will process in another frame"
Start-Sleep -s 10