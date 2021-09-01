Function Get-Modules ([string] $ModulePath) {
    Get-Module -Name Get-Modules | Remove-Module
    Import-Module ..\Get-Modules.psm1
}

Describe 'TestGetModules' {
    It "Given a module path that doesn't exist, an exception should be thrown." {
        Get-Modules -ModulePath "..\INVALID" | Should Throw
    }

    It "Given a module that doesn't exist, an exception should be thrown." {
        $ModulePath = "TestDrive:"
        Set-Content "${ModulePath}Invalid.psm1" -Value "Invalid"
        {
            Get-Modules -ModulePath $ModulePath | Should Throw
        }
    }
    
    It "Given a valid module path, Start-TestModule will be loaded and availble for use." {
        Get-Modules -ModulePath "..\Modules"
        Get-Module Start-TestModule | Select-Object -ExpandProperty "Name" | Should Be "Start-TestModule"
    }   
}