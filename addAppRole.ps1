# App Role Generator
# Jonathan Reynes - MISA - MCS 11/29/17


Connect-AzureAD
Class AppRole
{
    [String[]]$allowedMemberTypes = @("user"); 
    [String]$displayName;
    static [Boolean]$isEnabled = $true;
    [String]$id
    [String]$description;
    [String]$value;
}


Write-Host "     _                  ____       _         ____                           _             "
Write-Host "    / \   _ __  _ __   |  _ \ ___ | | ___   / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __ "
Write-Host "   / _ \ | '_ \| '_ \  | |_) / _ \| |/ _ \ | |  _ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|"
Write-Host "  / ___ \| |_) | |_) | |  _ < (_) | |  __/ | |_| |  __/ | | |  __/ | | (_| | || (_) | |   "
Write-Host " /_/   \_\ .__/| .__/  |_| \_\___/|_|\___|  \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|   "
Write-Host "         |_|   |_|                                                                        "
Write-Host "This App Role Generator will generate the App Role portion of the manifest when"
Write-Host "groups are needed to be added to expose role claims for those groups"
Write-Host "ACTIONS WILL BE DISPLAYED AT THE END"
Write-Host " "
Write-Host "Please enter the group names when prompted. Press ENTER when done"

[String[]]$groups;

$in_ = "#PLACEHOLDER";
while($in_ -ne ""){
    $in_ = Read-Host "Enter the Group Name"
    if ($in_ -ne ""){
        $groups.Add($in_)
    }
}


$roles = New-Object System.Collections.ArrayList
foreach ($g in $groups)  
{
    $temp_role = New-Object AppRole;
    $temp_role.displayName = $g;
    $temp_role.description = $g;
    $temp_role.value = $g;
    $temp_role.id = New-Guid

    $roles.Add($temp_role)
}


$roles | ConvertTo-Json | Write-Host

Write-Host "_________________________________________________________________________________"
Write-Host "ACTIONS: Once complete, "
Write-Host "1) copy and paste the json within the appRoles attribute"
Write-Host "2) task IAM to..."
Write-Host "Add groups to the application. Please input the values for each *display name* and *role assigned* respectively '"

foreach ($g in $groups) {
    Write-Host $g
}


$groups.Clear()
