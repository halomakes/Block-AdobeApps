function Block-All {
    param(
        [string]$RootPath
    )

    $count = 0;
    $executables = Get-ChildItem -Path $RootPath -Recurse -Filter "*.exe";
    $executables | ForEach-Object {
        $appName = $_.VersionInfo.FileDescription ?? $_.Name;
        $fullPath = $_.FullName;
        $ruleName = "Block Adobe App $appName ($fullPath)";
        if ($fullPath -notcontains "Plug-ins" -and $fullPath -notcontains "PlugIns") {
            Write-Progress -Activity "Blocking Apps" -Status "Blocking $fullPath" -PercentComplete ($count * 100 / $executables.Length);
    
            $existingRule = Get-NetFirewallRule | Where-Object { $_.DisplayName -eq $ruleName } | Select-Object -First 1
            if ($null -eq $existingRule) {
                New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Action Block -Program $fullPath | Out-Null
            }
        }
        $count++;
    }
}


Block-All -RootPath "$($env:ProgramFiles)\Adobe";
Block-All -RootPath "$(${env:ProgramFiles(x86)})\Adobe";
