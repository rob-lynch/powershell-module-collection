Function Initialize-Job {
    Param(
        [string] $ModuleToCall,
        [hashtable] $ModuleParameters,
        [string] $ModuleLoader = (Join-Path -Path (Get-Location) -ChildPath "Get-Modules.psm1"),
        [string] $ModulePath = ".\Modules"
    )

    try {
        $Job = {
            Import-Module $args[0]
            Get-Modules -ModulePath $args[1]
            $func = $args[2]
            $mParams = $args[3]
            Invoke-Expression "$func @mParams"
        }

        $RequestedJob = (Start-Job -Init ([scriptblock]::Create("Set-Location '$pwd'")) $Job -Name $ModuleToCall -ArgumentList @($ModuleLoader, $ModulePath, $ModuleToCall, $ModuleParameters))

        return $RequestedJob
    }
    catch {
        $ExceptionLine = $_.InvocationInfo.ScriptLineNUmber
        $ExceptionMessage = $_.Exception

        Write-Error "Caught Exception (${ExceptionLine}): ${ExceptionMessage}"
    }
}