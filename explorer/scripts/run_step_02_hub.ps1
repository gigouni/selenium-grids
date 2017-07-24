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
$JAVA_BIN_PATH = "C:\Program Files\Java\jre1.8.0_131\bin"
$JAVA_EXE_PATH = "$JAVA_BIN_PATH\java.exe"

# Selenium
$SELENIUM_JAR_PATH = "$SCRIPTS_FOLDER_PATH\bin\selenium-server-standalone-3.4.0.jar"
$SELENIUM_HUB_URL = "http://localhost"
$SELENIUM_HUB_PORT = "4444"
$SELENIUM_GRID_CONSOLE_URL = "/grid/console"
$SELENIUM_JAR_DL_URL = "http://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar"


# -----------------------------------------------------------------
#                             Script
# -----------------------------------------------------------------
If (Test-Path $JAVA_EXE_PATH) 
{
    Write-Host "Java is installed" -foregroundcolor green
    Write-Host "Let's try to run the Selenium hub now..."

    If (Test-Path $SELENIUM_JAR_PATH) 
    { 
        # Run browser to check grid console
        $IE=new-object -com internetexplorer.application
        $IE.navigate2("$SELENIUM_HUB_URL`:$SELENIUM_HUB_PORT$SELENIUM_GRID_CONSOLE_URL")
        $IE.visible=$true

        Invoke-Expression "java -jar $SELENIUM_JAR_PATH -port $SELENIUM_HUB_PORT -role hub"
    } 
    Else 
    { 
        Write-Host "The Selenium JAR hasn't been found. Please download it and move it here: $SCRIPTS_FOLDER_PATH\bin" -foregroundcolor red
        Write-Host "Note: you can find it here: $SELENIUM_JAR_DL_URL"
    }
} 
Else 
{ 
    Write-Host "Java hasn't been installed yet" -foregroundcolor red
    Write-Host "Run the step 01 script before"
}

Write-Host "`n`nThis window will automatically be closed in some seconds"
Start-Sleep -s 10