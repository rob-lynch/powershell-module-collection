Function Restart-Script {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)] $ScriptInfo
    )

    $BoundParameters = $ScriptInfo.MyInvocation.BoundParameters.GetEnumerator()
    $ParametersToPass = @{}

    
    $BoundParameters | ForEach-Object {

        $ParametersToPass = $ParametersToPass + @{$_.Key = $_.Value}
    }

    $Script = $ScriptInfo.MyInvocation.MyCommand.Path
    Write-Output "Reloading ${Script} with the following user provided values:"
    Write-Output $ParametersToPass
    Write-Output ""
    Write-Output ""

    Invoke-Expression "$Script @ParametersToPass"
}