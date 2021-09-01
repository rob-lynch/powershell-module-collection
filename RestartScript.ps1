<#
.SYNOPSIS
Self Referencial Script Restart

.DESCRIPTION
A script that can invoke itself and pass along user provided parameters values. This is a useful way to self-update (Ex: check for a newer version of the script remotely, download/apply it and restart using the latest version).
#>
[CmdletBinding()]
Param(
    [boolean] $RestartScript = (!(Test-Path .\restart_flag)),
    [string] $ExampleParameter
)

$ScriptInfo = $PSCmdlet

Import-Module .\Get-Modules.psm1
Get-Modules -ModulePath ".\Modules"

Write-Output $ExampleParameter

if ($RestartScript) {
    #Putting down a file to avoid an endless loop.
    New-Item -Path .\restart_flag -ItemType File
    Restart-Script -ScriptInfo $ScriptInfo
}