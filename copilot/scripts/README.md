# Copilot for Microsoft 365 Configuration Scripts

This directory contains PowerShell scripts to help administrators manage Copilot for Microsoft 365 settings.

## ConfigureM365Copilot.ps1

This script allows administrators to manage Copilot for Microsoft 365 access in Bing, Edge, and Windows.

### Prerequisites

- **Required Role**: Search Admin or Global Admin
- **Required Modules**: 
  - Microsoft.Graph.Authentication
  - Microsoft.Graph.Search
  
To install the required modules, run:
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

### Usage

#### Check current status
```powershell
.\ConfigureM365Copilot.ps1
```

#### Enable Copilot for Microsoft 365
```powershell
.\ConfigureM365Copilot.ps1 -enable $true
```

#### Disable Copilot for Microsoft 365
```powershell
.\ConfigureM365Copilot.ps1 -enable $false
```

### What this script manages

Running this script controls access to Copilot for Microsoft 365 in:
- Bing.com
- Edge sidebar
- Edge mobile app
- Copilot in Windows
- copilot.microsoft.com
- The Copilot app

**Note**: This script does not change how users access Copilot in other Microsoft 365 productivity apps (Word, Excel, PowerPoint, etc.).

### Download Options

You can download this script from:
1. **Microsoft Download Center** (recommended): [Official Download Link](https://download.microsoft.com/download/8/9/d/89d41212-7ece-414c-b6d3-f4ecb070c613/ConfigureM365Copilot.ps1)
2. **This Repository**: [ConfigureM365Copilot.ps1](ConfigureM365Copilot.ps1) (reference implementation)

### Important Notice

⚠️ **This is a reference implementation with placeholder API endpoints.** For production use, please download the official script from Microsoft's Download Center.

The official script contains the correct Microsoft Graph API endpoints and has been validated by Microsoft. This repository version is provided for:
- Learning and understanding the script structure
- Reference when customizing for specific needs
- Fallback if the official download is temporarily unavailable

### Troubleshooting

If you encounter any issues:
1. Ensure you're running PowerShell as an administrator
2. Verify you have the required admin role (Search Admin or Global Admin)
   - To check your roles, go to the [Microsoft 365 admin center](https://admin.microsoft.com) > **Users** > **Active users** > Select your account > **Roles** tab
   - Or use PowerShell: `Get-MgUserMemberOf -UserId "your-email@domain.com"`
3. Check that the Microsoft.Graph modules are installed and up to date
   - Run: `Get-Module -ListAvailable Microsoft.Graph*`
   - Update if needed: `Update-Module Microsoft.Graph`
4. If the script fails, try running it again
5. For production environments, use the [official Microsoft script](https://download.microsoft.com/download/8/9/d/89d41212-7ece-414c-b6d3-f4ecb070c613/ConfigureM365Copilot.ps1)
6. If problems persist, contact Microsoft support

### Additional Resources

For more information about managing Copilot for Microsoft 365, see:
- [Manage Microsoft Copilot for Microsoft 365 with the Copilot page](../microsoft-365-copilot-page.md)
- [Get started with Microsoft Copilot for Microsoft 365](../microsoft-365-copilot-setup.md)
