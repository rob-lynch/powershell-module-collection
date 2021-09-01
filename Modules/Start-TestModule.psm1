Function Start-TestModule {
    Param(
        [string] $FirstParameter,
        [int32] $SecondParameter
    )

    $a = 0
    
    do {
        Write-Host "${FirstParameter} - ${a}"    
    } while (++$a -le $SecondParameter)
}