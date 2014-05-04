﻿<#
Get-ARPStack.ps1
Requires logparser.exe in path
Pulls frequency of ARP based on IpAddr

This script expects files matching the *Arp.tsv pattern to be in the
current working directory.
#>


if (Get-Command logparser.exe) {
    $lpquery = @"
    SELECT
        COUNT(IpAddr, Mac, Type) as ct,
        IpAddr,
        Mac,
        Type
    FROM
        *arp.tsv
    GROUP BY
        IpAddr,
        Mac,
        Type
    ORDER BY
        ct ASC
"@

    & logparser -i:tsv -dtlines:0 -fixedsep:on -rtp:50 "$lpquery"

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}
