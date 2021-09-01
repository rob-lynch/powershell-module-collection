<#
.SYNOPSIS
Background Job Batching

.DESCRIPTION
A script that fires off concurrent background jobs to perform parallel tasks and waits for the collection to complete before continuing. This is useful when there's a need to run mutiple long running tasks that the rest of the script is dependent on (Ex: extracting muitple large archives, or performing a backup).
#>

Import-Module .\Get-Modules.psm1
Get-Modules -ModulePath ".\Modules"

$RequestedJobs = @()

$TestParameters= @{FirstParameter="foo"; SecondParameter=50}
$RequestedJobs += (Initialize-Job -ModulePath .\Modules -ModuleToCall "Start-TestModule" -ModuleParameters $TestParameters)

$TestParameters= @{FirstParameter="bar"; SecondParameter=50}
$RequestedJobs += (Initialize-Job -ModulePath .\Modules -ModuleToCall "Start-TestModule" -ModuleParameters $TestParameters)

if ($RequestedJobs) {
    Receive-JobThreads -Jobs $RequestedJobs
}

Write-Output "All Jobs Completed"
