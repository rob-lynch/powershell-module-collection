Import-Module ..\Get-Modules.psm1
Get-Modules -ModulePath "..\Modules"

Describe 'Test Initialize-Job' {
    $ModuleToCall = "Start-TestModule"
    $ModulePath = "..\Modules"
    $ModuleLoader = (Join-Path -Path (Get-Location) -ChildPath "..\Get-Modules.psm1")
    $TestParameters= @{FirstParameter="foo"; SecondParameter=0}
    
    It "Given valid parameters, it shoud not throw an exception and return 'Foo - 0'" {
        $RequestedJobs = @()
        $RequestedJobs += (Initialize-Job -ModuleLoader $ModuleLoader -ModulePath $ModulePath -ModuleToCall $ModuleToCall -ModuleParameters $TestParameters)
        $JobThreads = (Receive-JobThreads $RequestedJobs)
        $JobResults = Get-Job $JobThreads.Id | Select-Object -ExpandProperty ChildJobs | Select-Object -ExpandProperty Information
        
        $JobResults[-1] | Should Be "Foo - 0"
    }
}