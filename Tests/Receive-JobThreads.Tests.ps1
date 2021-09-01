Import-Module ..\Get-Modules.psm1
Get-Modules -ModulePath "..\Modules"

Describe 'Test Receive-JobThreads' {
    It "Given a valid job, Write-Error should not be called" {
        Mock Write-Error {} -ModuleName Receive-JobThreads
        $RequestedJobs = @()
        $RequestedJobs += (Start-Job -ScriptBlock {Start-Sleep -Seconds 1})

        Receive-JobThreads -Jobs $RequestedJobs
        Assert-MockCalled Write-Error -ModuleName "Receive-JobThreads" -Times 0
    }

    It "Given no valid jobs, an exception should be thrown" {
        Mock Write-Error {} -ModuleName Receive-JobThreads
        $RequestedJobs = @()
        Receive-JobThreads -Jobs $RequestedJobs | Should Throw
    }

}