Get-Help *resolve* 
Get-Command *resolve* 
Get-Command -Verb resolve 

Get-Help *adapter* 
Get-Command *adapter* 
Get-Command -Noun *adapter*
Get-Command -Verb Set -Noun *adapter* 

Get-Help Set-NetAdapter 

Set-NetAdapter

Get-Help *sched* 
Get-Command *sched* 
Get-Module *sched* -ListAvailable

Get-Command -Verb Block 

Get-Help *branch*

Get-Help *cache* 
Get-Command *cache* 
Get-Command -Verb clear

Get-Help *firewall*
Get-Command *firewall* 
Get-Help *rule*
Get-Command *rule* 

Get-Help Get-NetFirewallRule -Full
Get-Help Get-NetFirewallRule -ShowWindow

Get-Help *address* 

Get-Command -Verb suspend

Get-Alias Type
Get-Command -Noun *content* 
Get-Alias -Definition Get-Content

Get-NetFirewallRule -Enabled True

get-command *address*
Get-NetIPAddress -AddressFamily IPv4

Get-Command -noun service
set-Service -Name BITS -StartupType automatic

Get-Command -Verb test
Test-NetConnection -ComputerName lon-dc1 -InformationLevel Quiet

get-command *eventlog*
Get-EventLog -LogName Security -Newest 10

Get-Help about*
Get-Help about*env*
$env:computername
Get-Help about*sign* -ShowWindow

Get-Service | Get-Member
Get-service | select-object -property *
Get-Service -name a* | Select-Object 

$serviceinfo = Get-Service -name bits
$serviceinfo.start()

Get-EventLog -logname System -newest 5 | Format-table -Wrap

Get-Verb
Get-Verb | Format-Wide -Property verb -autosize
Get-EventLog -logname System -newest 5 | Format-table -Wrap [Use format cmd last]

Get-Service | Sort-Object -Property status
Get-Service | gm
$service = get-service
$service.Status
$service.status.value__
$service.status | gm

Get-Service | Sort-Object -Property status,name
Get-Service | Sort-Object -Property status,name | Format-Table -GroupBy status

change to c: drive 
Get-ChildItem -file | Measure-Object -property lenght -Average -Maximum -Minimum -Sum

get-process | Sort-Object -descending -property vm | Select-Object -First 10
get-process | Sort-Object -property cpu -Descending | Select-Object -first 10 [Select object manipulates output of object]
get-process | Sort-Object -descending -property vm | Select-Object -First 10 -Property name,id,vm

Get-Volume
Get-Volume -DriveLetter c,e
Get-Volume -DriveLetter c,e | gm
Get-Volume -DriveLetter c,e | Select-Object driveletter,size,sizeremaining,@{n='SizeUsed';e={($_.Size - $_.SizeRemaining)}}  [$_ utilises c,e]
Get-Volume -DriveLetter c,e | Select-Object driveletter,size,sizeremaining,@{n='SizeUsed (GB)';e={($_.Size - $_.SizeRemaining) / 1gb}}
Get-Volume -DriveLetter c,e | Select-Object driveletter,size,sizeremaining,@{n='SizeUsed (GB)';e={[math]::round(($_.Size - $_.SizeRemaining) / 1gb,3)}}


LAB 3

get-command *date*
Get-Command -noun *date*
Get-Date
get-date | gm
get-date | select-object -property dayofyear
get-date | select-object -property dayofyear | format-list

get-command *hotfix*
get-hotfix | gm
Get-HotFix | select-object -Property hotfixid,installby,installedon
Get-HotFix | select-object -Property *

$currentdate = get-date
Get-HotFix | select-object -Property hotfixid,installby,@{n='DaysSinceInstalled';e={($currentdate - $_.installedon).days}}
$currentdate | gm
$currentdate.adddays(10)

Use gm before calculating

Get-Command get*scope*
Get-DhcpServerv4scope -computername lon-dc1
Get-DhcpServerv4scope -computername lon-dc1 | Select-Object -Property scopeid,subnetmask,name | Format-List

get-command *rule*
Get-NetFirewallRule

Get-NetFirewallRule -enabled True | Format-Table -Wrap
Get-NetFirewallRule -enable true | Sort-Object -Property Profiles,DisplayName
Get-NetFirewallRule -enable true | Sort-Object -Property Profiles,DisplayName | Format-Table -GroupBy profile

get-command *neighbor*
Get-NetNeighbor
Get-NetNeighbor | Sort-Object -Property State
Get-NetNeighbor | Sort-Object -Property State | Select-Object -Property IPAddress,State | Format-Wide -groupby state -AutoSize

Test-NetConnection -ComputerName lon-dc1
Test-NetConnection -ComputerName lon-svr1
Get-Command *dns*
Get-DnsClientCache
Get-DnsClientCache | Select-Object -Property recordname,recordtype,timetolive
Get-DnsClientCache | gm
recordname,recordtype are not in gm
Get-DnsClientCache | Select-Object -Property name,type,timetolive | Format-List



get-service | Where-Object {$_.status -eq 'running'}
get-service | Where-Object {$_.status -ne 'running'}
get-service | Where-Object {$_.status -ne 'running' -and $_.name -like 'a*'}
get-service | Where-Object {$_.status -ne 'running' -or $_.name -like 'a*'}

get-service | Where-Object {$_.Name.lenght -gt 10}


get-command *user*
get-aduser -filter *
get-help get-aduser -ShowWindow
get-aduser -filter * | Format-Table
get-aduser -filter * -SearchBase "cn=Users,dc=adatum,dc=com"


Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4624}
(Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4624}).count
$events = Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4624}
$events.count
Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4624} | Select-Object TimeWritten,EventID,Message
Get-EventLog -LogName Security | Where-Object {$_.EventID -eq 4624} | Select-Object TimeWritten,EventID,Message -Last 10 | Format-List

Get-ChildItem -Path cert: -Recurse
Get-ChildItem -Path cert: -Recurse | gm
Get-ChildItem -Path cert: -Recurse | Where-Object {$_.HasPrivateKey -eq $false} 
$now = get-date
Get-ChildItem -Path cert: -Recurse | Where-Object {$_.HasPrivateKey -eq $false -and $_.NotBefore -lt $now -and $_.NotAfter -gt $now} | 
   Select-Object -Property FriendlyName,NotBefore,NotAfter

get-volume
get-volume | gm
Get-Volume | Where-Object {$_.SizeRemaining -gt 0} | Format-List
Get-Volume | Where-Object {$_.SizeRemaining -gt 0} | 
    Select-Object -Property *, @{n='PercentFree';e={$_.sizeremaining / $_.size * 100}} |
    where-object {$_.PercentFree -lt 99} |
    Select-Object -Property driveletter,@{n='Size (MB)';e={[math]::round($_.size / 1MB,0)}}
Get-Volume | Where-Object {$_.SizeRemaining -gt 0} | 
    Select-Object -Property *, @{n='PercentFree';e={$_.sizeremaining / $_.size * 100}} |
    where-object {$_.PercentFree -lt 10} |
    Select-Object -Property driveletter,@{n='Size (MB)';e={[math]::round($_.size / 1MB,0)}}


1..10 | ForEach-Object {get-random}
1..10 | ForEach-Object {Write-Host $_.}
Get-ChildItem -Path e:\ -recurse
Get-ChildItem -Path e:\ -recurse -Directory |
    ForEach-Object {$_.getfiles()}

1..100 | foreach-object {get-random}
1..10 | ForEach-Object {Get-Random -SetSeed $_}

Get-Command *csv
Get-Command *xml
get-command *json


get-service -Name a* |
    Select-Object -Property Status,StartType,Name |
    ConvertTo-Html |
    out-file e:\service.html


get-aduser -filter *  -Properties city,department | Where-Object {$_.city -eq "london" -and $_.department -eq 'IT'} |
    sort-object -Property name |
    select-object -Property name,city,department
get-aduser -filter *  -Properties city,department | Where-Object {$_.city -eq "london" -and $_.department -eq 'IT'} |
    set-aduser -Office "LON-A/1000"
get-aduser -filter *  -Properties city,department | Where-Object {$_.city -eq "london" -and $_.department -eq 'IT'} |
    sort-object -Property name |
    select-object -Property name,city,department,office



