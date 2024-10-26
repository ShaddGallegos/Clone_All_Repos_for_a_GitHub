# Prompt for folder path
$folderPath = Read-Host "Enter the path of the folder to be run against"

# Prompt for output format
$outputFormat = Read-Host "Would you like the inventory in HTML or Markdown?"

# Clean the folder path
$folderPath = $folderPath.Trim().TrimEnd('\')

# Get the base directory name
$baseDirName = Split-Path -Leaf $folderPath

# Run tree command to get directory structure
$treeOutput = & tree /F /A "$folderPath" | Out-String

# Convert tree output to desired format
if ($outputFormat -eq "HTML") {
    $htmlContent = "<html><head><title>Inventory of $baseDirName</title><style>body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; } a { text-decoration: none; color: #007bff; } a:hover { text-decoration: underline; }</style></head><body><h1>Inventory of $baseDirName</h1><pre>"
    foreach ($line in $treeOutput.Split("`n")) {
        if ($line -match '\|.*$') {
            $file = $line.TrimStart('|   ')
            $htmlContent += "<a href=""$folderPath\$file"">$line</a>`n"
        } else {
            $htmlContent += "$line`n"
        }
    }
    $htmlContent += "</pre></body></html>"
    $htmlContent | Set-Content "$folderPath\$baseDirName`_inventory.html"
}
# Generate links for Markdown
elseif ($outputFormat -eq "Markdown") {
    $mdContent = "# Inventory of $baseDirName`r`n`r`n"
    foreach ($line in $treeOutput.Split("`n")) {
        if ($line -match '\|.*$') {
            $file = $line.TrimStart('|   ')
            $mdContent += "[$line]($folderPath\$file)`r`n"
        } else {
            $mdContent += "$line`r`n"
        }
    }
    $mdContent += "`r`n---`r`n _Generated on $(Get-Date)_"
    $mdContent | Set-Content "$folderPath\$baseDirName`_inventory.md"
} else {
    Write-Host "Invalid output format. Please choose either 'HTML' or 'Markdown'."
}

# Inform the user of completion
Write-Host "Inventory created successfully in $outputFormat format."

