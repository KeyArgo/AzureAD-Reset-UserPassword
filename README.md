# AzureAD User Password Reset Script

## Description

`AzureAD-UserPasswordReset.ps1` is a PowerShell script designed to streamline the process of resetting user passwords in Azure Active Directory (Azure AD). It comes with built-in logging, automated Azure AD connection, and a user-friendly interface.

**⚠️ Warning**: This script is powerful and will make changes to user accounts within your Azure AD organization. Use it responsibly and only if you have the necessary permissions.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements) 
- [Installation](#installation) 
- [Usage](#usage) 
- [License](#license) 
- [Contributing](#contributing)
## Features

- **Automatic Module Handling**: Checks for the required Azure AD and MSOnline PowerShell modules and installs them if missing.
- **Logging**: Logs all activities to a file, aiding in auditing and troubleshooting.
- **User Prompts**: Interactive prompts for entering user email and new temporary passwords.
- **Force Password Change**: Optional setting to require users to change their password upon the next login.
- **Multi-Account Handling**: Allows resetting passwords for multiple accounts in a single session.

## Requirements

- PowerShell v5.1 or higher
- Administrative permissions for Azure AD

## Installation

1. Download the `AzureAD-UserPasswordReset.ps1` script to your local machine.
2. Open PowerShell as an administrator.
3. Navigate to the directory where you've saved the script.

## Usage

1. Run the script:
    
```powershell
.\AzureAD-UserPasswordReset.ps1
```

    
2. You'll see a warning message. Read it carefully.
    
3. Follow the on-screen prompts to enter the user's email and new temporary password.
    
4. Optionally, you can require the user to change their password upon next login.
    
5. The script will log all activities in a `logs` folder in the script directory.
    

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/KeyArgo/AzureAD-Reset-UserPassword/LICENSE.md) file for details.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

---

For any issues, please [create an issue](https://github.com/KeyArgo/AzureAD-Reset-UserPassword/issues) or submit a Pull Request.