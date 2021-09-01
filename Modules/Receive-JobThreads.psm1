Function Receive-JobThreads {
    Param (
        [Parameter(Mandatory=$True)] [System.Object] $Jobs
    )
    try {
        Receive-Job -Job $Jobs -Wait -WriteEvents -WriteJobInResults
        $JobsWithErrors = $Jobs.ChildJobs | Where-Object {$_.Error}

        $JobsWithErrors | ForEach-Object {
            $Job = $_
            $JobErrors += ($Job | Select-Object -ExpandProperty Error)
        }

        if($JobErrors) {
            throw [System.Exception] "One or more of the requested jobs returned an error."
        }
    } catch {
        $ExceptionLine = $_.InvocationInfo.ScriptLineNUmber
        $ExceptionMessage = $_.Exception

        Write-Error "Caught Exception (${ExceptionLine}): ${ExceptionMessage}"
    }
}