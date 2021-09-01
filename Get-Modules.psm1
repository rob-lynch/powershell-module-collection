Function Get-Modules {
    Param(
        [Parameter(Mandatory=$True)] [string] $ModulePath
    )
    if (Test-Path -Path $ModulePath) {
        try {
            Write-Output "Loading Modules"
            $ModulesToLoad = Get-ChildItem $ModulePath -Filter *.psm1
            $ModulesToLoad | ForEach-Object {
                $ModuleName = $_.Name.Replace(".psm1","")

                if (Get-Module $ModuleName) {
                    Write-Information "Removing module ${ModuleName} so it can be re-imported"
                    Remove-Module $ModuleName
                }

                Write-Information "Importing module ${ModuleName} so it can be re-imported"
                Import-Module -Name (Join-Path -Path $ModulePath -ChildPath $_.Name) -Global
            }
            Write-Output "All Modules in ${ModulePath} Loaded"
            Write-Output ""
        } catch {
            Write-Error "$_"
            Break
        }
    } else {
        Write-Error "${ModulePath} directory not found."
    }
}