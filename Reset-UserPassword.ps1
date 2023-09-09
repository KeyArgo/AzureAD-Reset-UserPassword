# Warning message
Write-Host "************************************************************" -ForegroundColor Yellow
Write-Host "WARNING: This script is designed to reset user passwords within the organization." -ForegroundColor Yellow
Write-Host "Use this script responsibly and ensure you have the necessary permissions." -ForegroundColor Yellow
Write-Host "************************************************************" -ForegroundColor Yellow

# Required modules
$requiredModules = @("AzureAD", "MSOnline")

# Check for and install missing modules
foreach ($module in $requiredModules) {
    if (-Not (Get-Module -ListAvailable -Name $module)) {
        Write-Host "The module $module is not installed. Installing now..."
        Install-Module -Name $module -Scope CurrentUser -Force -SkipPublisherCheck
    }
    Import-Module $module
}

# Connect to Azure AD the first time
Connect-AzureAD

# Initialize log file
$LogDir = Join-Path $PSScriptRoot "logs"
if (-not (Test-Path $LogDir)) {
    New-Item -Path $LogDir -ItemType Directory
}
$LogPath = Join-Path $LogDir "ResetPasswords.log"

# Function to log messages
function Log-Message {
    param (
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] $Message"
    $logEntry | Out-File $LogPath -Append
    Write-Host $logEntry
}

# Loop to reset passwords for multiple accounts
do {
    $Email = Read-Host -Prompt "Please enter the email address of the user whose password you want to reset"
    $NewPassword = Read-Host -Prompt "Please enter the new temporary password for the user"

    # Ask if the user should change their password upon next login
    $forceChange = Read-Host "Should the user be required to change their password upon next login? (Y/N)"
    $forceChange = if ($forceChange -eq "Y" -or $forceChange -eq "y") { $true } else { $false }

    $SecureNewPassword = ConvertTo-SecureString $NewPassword -AsPlainText -Force

    try {
        Log-Message "Attempting to find the user with email $Email."
        # Find the user
        $user = Get-AzureADUser -Filter "UserPrincipalName eq '$Email'"
        if ($null -eq $user) {
            Log-Message "No user found with the email address $Email."
            continue
        }
        
        Log-Message "User found. Attempting to reset password."
        # Reset the password
        Set-AzureADUserPassword -ObjectId $user.ObjectId -Password $SecureNewPassword -ForceChangePasswordNextLogin $forceChange
        Log-Message "Successfully reset the password for $Email. User must change their password upon next login."

    } catch {
        Log-Message "An error occurred: $_"
    }

    $continueResponse = Read-Host "Do you want to reset the password for another account? (Y/N)"
    if ($continueResponse -ne "Y" -and $continueResponse -ne "y") {
        break
    }

} while ($true)
