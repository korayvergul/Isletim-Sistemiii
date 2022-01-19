
$cores = (Get-WmiObject Win32_Processor).NumberOfLogicalProcessors

    $tmp = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process | 
    select-object  -Property Name, @{Name = "CPU"; Expression = {($_.PercentProcessorTime)}}, @{Name = "PID"; Expression = {$_.IDProcess}} |
    Where-Object {$_.Name -notmatch "^(idle|_total|system)$"} |
    Sort-Object -Property CPU -Descending
    cls
    $tmp | Format-Table -Autosize -Property Name, CPU;
    


Set-Content C:\ps\task.log -Value (Get-Date),$tmp;
