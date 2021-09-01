# powershell-module-collection

Some PowerShell Modules and Pester Tests

## Module Overview

* `Get-Modules` -  a module for dynamically loading other modules (used in all other examples)
* `Initialize-Job` - a way to simplify the payload for background jobs (see `BackgroundJobBatching.ps1` for usage)
* `Receive-JobThreads` - a listener for running background jobs (see `Initialize-Job` for usage)
* `Restart-Script` - for reloading a script while retaining user supplied parameters (see `RestartScript.ps1` for usage)
* `Start-TestModule` - for demoing `Initialize-Job` and `Receive-JobThreads`

## To Run the Tests

```
Set-Location .\Tests
Invoke-Pester
```
