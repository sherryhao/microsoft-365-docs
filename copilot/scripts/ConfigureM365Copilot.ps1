<#
.SYNOPSIS
    Configure Microsoft 365 Copilot access in Bing, Edge, and Windows.

.DESCRIPTION
    This PowerShell script helps administrators manage Copilot for Microsoft 365 
    access in Bing, Edge, and Windows. It can:
    - Get the current status of Copilot for Microsoft 365 in your tenant
    - Turn on Copilot for Microsoft 365 in Bing, Edge, and Windows
    - Turn off Copilot for Microsoft 365 in Bing, Edge, and Windows

.PARAMETER enable
    Optional boolean parameter to enable ($true) or disable ($false) Copilot for Microsoft 365.
    If not specified, the script displays the current status.

.EXAMPLE
    .\ConfigureM365Copilot.ps1
    Gets the current status of Copilot for Microsoft 365 in Bing, Edge, and Windows

.EXAMPLE
    .\ConfigureM365Copilot.ps1 -enable $true
    Turns on Copilot for Microsoft 365 in Bing, Edge, and Windows

.EXAMPLE
    .\ConfigureM365Copilot.ps1 -enable $false
    Turns off Copilot for Microsoft 365 in Bing, Edge, and Windows

.NOTES
    You must be a Search Admin or Global Admin to run this script.
    This script requires the Microsoft.Graph PowerShell modules.
    
    IMPORTANT: This is a reference implementation. The actual Microsoft Graph API 
    endpoints for managing Copilot settings may differ. For the official, production-ready 
    script, download from: https://download.microsoft.com/download/8/9/d/89d41212-7ece-414c-b6d3-f4ecb070c613/ConfigureM365Copilot.ps1
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [bool]$enable
)

# Function to check if required modules are installed
function Test-RequiredModules {
    $requiredModules = @(
        'Microsoft.Graph.Authentication',
        'Microsoft.Graph.Search'
    )
    
    $missingModules = @()
    foreach ($module in $requiredModules) {
        if (-not (Get-Module -ListAvailable -Name $module)) {
            $missingModules += $module
        }
    }
    
    if ($missingModules.Count -gt 0) {
        Write-Host "The following required modules are not installed:" -ForegroundColor Yellow
        $missingModules | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
        Write-Host "`nTo install the missing modules, run:" -ForegroundColor Cyan
        Write-Host "  Install-Module Microsoft.Graph -Scope CurrentUser" -ForegroundColor Green
        return $false
    }
    
    return $true
}

# Function to connect to Microsoft Graph
function Connect-ToGraph {
    try {
        Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan
        
        # Required permissions for managing Copilot settings
        $scopes = @(
            "SearchConfiguration.ReadWrite.All"
        )
        
        Connect-MgGraph -Scopes $scopes -NoWelcome -ErrorAction Stop
        
        $context = Get-MgContext
        Write-Host "Successfully connected as: $($context.Account)" -ForegroundColor Green
        
        return $true
    }
    catch {
        Write-Host "Failed to connect to Microsoft Graph: $_" -ForegroundColor Red
        return $false
    }
}

# Function to get current Copilot configuration
function Get-CopilotConfiguration {
    try {
        Write-Host "`nRetrieving current Copilot for Microsoft 365 configuration..." -ForegroundColor Cyan
        
        # IMPORTANT: This endpoint is a placeholder for reference purposes only.
        # The actual Microsoft Graph API endpoint for Copilot configuration may differ.
        # For production use, download the official script from Microsoft:
        # https://download.microsoft.com/download/8/9/d/89d41212-7ece-414c-b6d3-f4ecb070c613/ConfigureM365Copilot.ps1
        
        Write-Host "`nWARNING: This is a reference implementation with placeholder endpoints." -ForegroundColor Yellow
        Write-Host "For production use, please download the official script from Microsoft." -ForegroundColor Yellow
        
        # NOTE: The endpoint below is a PLACEHOLDER and not a real Microsoft Graph API endpoint.
        # The actual endpoint for Copilot configuration is only available in the official Microsoft script.
        $uri = "https://graph.microsoft.com/v1.0/admin/PLACEHOLDER_CopilotConfiguration"
        
        $config = Invoke-MgGraphRequest -Method GET -Uri $uri -ErrorAction Stop
        
        if ($config -and ($config.PSObject.Properties.Name -contains 'copilotEnabled')) {
            $status = if ($config.copilotEnabled) { "Enabled" } else { "Disabled" }
            Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is currently: $status" -ForegroundColor $(if ($config.copilotEnabled) { "Green" } else { "Yellow" })
            return $config.copilotEnabled
        }
        else {
            Write-Host "Unable to retrieve current configuration." -ForegroundColor Yellow
            return $null
        }
    }
    catch {
        Write-Host "Error retrieving configuration: $_" -ForegroundColor Red
        Write-Host "`nThis reference implementation may not have the correct API endpoints." -ForegroundColor Yellow
        Write-Host "Please use the official Microsoft script for production environments." -ForegroundColor Yellow
        return $null
    }
}

# Function to set Copilot configuration
function Set-CopilotConfiguration {
    param([bool]$enableCopilot)
    
    try {
        $action = if ($enableCopilot) { "Enabling" } else { "Disabling" }
        Write-Host "`n$action Copilot for Microsoft 365 in Bing, Edge, and Windows..." -ForegroundColor Cyan
        
        # IMPORTANT: This endpoint and payload structure are placeholders for reference purposes only.
        # The actual Microsoft Graph API endpoint and request format may differ.
        # For production use, download the official script from Microsoft:
        # https://download.microsoft.com/download/8/9/d/89d41212-7ece-414c-b6d3-f4ecb070c613/ConfigureM365Copilot.ps1
        
        Write-Host "`nWARNING: This is a reference implementation with placeholder endpoints." -ForegroundColor Yellow
        Write-Host "For production use, please download the official script from Microsoft." -ForegroundColor Yellow
        
        # NOTE: The endpoint below is a PLACEHOLDER and not a real Microsoft Graph API endpoint.
        # The actual endpoint for Copilot configuration is only available in the official Microsoft script.
        $uri = "https://graph.microsoft.com/v1.0/admin/PLACEHOLDER_CopilotConfiguration"
        $body = @{
            copilotEnabled = $enableCopilot
        } | ConvertTo-Json
        
        $result = Invoke-MgGraphRequest -Method PATCH -Uri $uri -Body $body -ErrorAction Stop
        
        $status = if ($enableCopilot) { "enabled" } else { "disabled" }
        Write-Host "Successfully $status Copilot for Microsoft 365 in Bing, Edge, and Windows." -ForegroundColor Green
        
        Write-Host "`nNote: It may take some time for the changes to propagate across all services." -ForegroundColor Yellow
        
        return $true
    }
    catch {
        Write-Host "Error updating configuration: $_" -ForegroundColor Red
        Write-Host "`nThis reference implementation may not have the correct API endpoints or payload structure." -ForegroundColor Yellow
        Write-Host "Please use the official Microsoft script for production environments." -ForegroundColor Yellow
        return $false
    }
}

# Main script execution
function Main {
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "  Configure Microsoft 365 Copilot" -ForegroundColor Cyan
    Write-Host "  Manage Copilot in Bing, Edge, and Windows" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Check for required modules
    if (-not (Test-RequiredModules)) {
        Write-Host "`nExiting due to missing modules." -ForegroundColor Red
        exit 1
    }
    
    # Import required modules
    try {
        Import-Module Microsoft.Graph.Authentication -ErrorAction Stop
        Import-Module Microsoft.Graph.Search -ErrorAction Stop
    }
    catch {
        Write-Host "Error importing modules: $_" -ForegroundColor Red
        exit 1
    }
    
    # Connect to Microsoft Graph
    if (-not (Connect-ToGraph)) {
        Write-Host "`nExiting due to connection failure." -ForegroundColor Red
        exit 1
    }
    
    try {
        # If enable parameter is not specified, just show current status
        if ($PSBoundParameters.ContainsKey('enable')) {
            # Set the configuration
            $success = Set-CopilotConfiguration -enableCopilot $enable
            
            if ($success) {
                # Verify the change
                Start-Sleep -Seconds 2
                Get-CopilotConfiguration | Out-Null
            }
        }
        else {
            # Just get and display current status
            Get-CopilotConfiguration | Out-Null
        }
    }
    finally {
        # Disconnect from Microsoft Graph
        try {
            Disconnect-MgGraph -ErrorAction SilentlyContinue | Out-Null
            Write-Host "`nDisconnected from Microsoft Graph." -ForegroundColor Cyan
        }
        catch {
            # Ignore disconnect errors
        }
    }
    
    Write-Host "`nScript completed." -ForegroundColor Green
}

# Run the main function
Main
