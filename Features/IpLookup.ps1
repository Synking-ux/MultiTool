function Print-GradientBanner {
    $lines = @(
        "                                                                                                             ",
        "                                                                                                             ",
        " 	 ██╗██████╗     ██╗      ██████╗  ██████╗ ██╗  ██╗██╗   ██╗██████╗     ████████╗ ██████╗  ██████╗ ██╗     ",
        " 	 ██║██╔══██╗    ██║     ██╔═══██╗██╔═══██╗██║ ██╔╝██║   ██║██╔══██╗    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ",
        " 	 ██║██████╔╝    ██║     ██║   ██║██║   ██║█████╔╝ ██║   ██║██████╔╝       ██║   ██║   ██║██║   ██║██║     ",
        " 	 ██║██╔═══╝     ██║     ██║   ██║██║   ██║██╔═██╗ ██║   ██║██╔═══╝        ██║   ██║   ██║██║   ██║██║     ",
        " 	 ██║██║         ███████╗╚██████╔╝╚██████╔╝██║  ██╗╚██████╔╝██║            ██║   ╚██████╔╝╚██████╔╝███████╗",
        " 	 ╚═╝╚═╝         ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝            ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝",
        "                                                                                                             "
    )
    $startColor = 196 # Red
    $endColor = 226   # Yellow
    $totalColored = ($lines | Where-Object { $_.Trim() -ne "" }).Count
    $colorLine = 0

    foreach ($line in $lines) {
        if ($line.Trim() -eq "") {
            Write-Host $line
        } else {
            $colorIndex = [math]::Round($startColor + ($endColor - $startColor) * ($colorLine / ($totalColored - 1)))
            Write-Host "$([char]27)[38;5;${colorIndex}m$line$([char]27)[0m"
            $colorLine++
        }
    }
    Write-Host ""
}

# Print banner once
Print-GradientBanner

while ($true) {
    # Prompt the user to enter an IP or "exit"
    $ip = Read-Host "Ip Address:>>> "

    if ($ip -eq "exit") {
        Write-Host "Launching mt.bat..." -ForegroundColor Cyan
        Start-Process -FilePath "$PSScriptRoot\..\Main.bat"
        break
        exit 0
    }

    # Check for private IP
    if ($ip -match '^10\.|^172\.(1[6-9]|2[0-9]|3[0-1])\.|^192\.168\.') {
        Write-Host "[!] Private IP detected. Public lookup not possible." -ForegroundColor Yellow
        continue
    }

    try {
        $response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
        if ($response.status -eq "success") {
            $infoLines = @(
                "------| IP Address: $($response.query)",
                "------| Country   : $($response.country)",
                "------| Region    : $($response.regionName)",
                "------| City      : $($response.city)",
                "------| ZIP Code  : $($response.zip)",
                "------| Latitude  : $($response.lat)",
                "------| Longitude : $($response.lon)",
                "------| ISP       : $($response.isp)",
                "------| Org       : $($response.org)",
                "------| Timezone  : $($response.timezone)",
                "------| Google Maps: https://www.google.com/maps?q=$($response.lat),$($response.lon)"
            )

            $steps = $infoLines.Count - 1
            $startColor = 40  # Green start for info block
            $endColor = 220   # Orange/yellow

            for ($i = 0; $i -lt $infoLines.Count; $i++) {
                $colorIndex = [math]::Round($startColor + ($endColor - $startColor) * ($i / $steps))
                Write-Host "$([char]27)[38;5;${colorIndex}m$($infoLines[$i])$([char]27)[0m"
            }
        }
        else {
            Write-Host "Error: Unable to retrieve location data." -ForegroundColor Red
        }
    }
    catch {
        Write-Host "Request failed: $_" -ForegroundColor Red
    }

    Write-Host ""
}
