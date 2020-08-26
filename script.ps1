# Connect-PnPOnline

$ScriptStartTime = $(get-date)
#  New-PnPList -Title "TestFolderStructure" -Template DocumentLibrary -OnQuickLaunch

$GROUP_LIST = Import-Csv -Path "list.csv"
$paths = @(
    "1. Project Proposal"
    "2. Status Document 1"
    "3. Progress Presentation - 1"
    "4. Research Paper"
    "5. Progress Presentation - 2"
    "6. Final Report & Presentation"
    "7. Status Document 2"
    "8. Website"
    "Marking Schemes"
    "Project Registration Documents"
    "1. Project Proposal\Presentation"
    "1. Project Proposal\Report"
    "5. Progress Presentation - 2\Poster_JPG"
    "5. Progress Presentation - 2\PP2_PPT"
    "6. Final Report & Presentation\Final Presentation PPT"
    "6. Final Report & Presentation\Final Reports"
    "Marking Schemes\1 - Proposal"
    "Marking Schemes\2 - PP I"
    "Marking Schemes\3 and  7 - Status Documents"
    "Marking Schemes\4 - Research Paper"
    "Marking Schemes\5 - PP II"
    "Marking Schemes\6 - Final & Viva"
    "Marking Schemes\7 - Log Book"
    "Marking Schemes\8 - Web site"
    "Project Registration Documents\GitLab_Screenshots"
    "Project Registration Documents\Project Charter"
    "Project Registration Documents\Project Cover Sheet"
    "Project Registration Documents\Teams Creation"
    "Project Registration Documents\Topic Assesment Form"
)

foreach ($group in $GROUP_LIST) {
 
    $StartTime = $(get-date)

    Write-Host ""
    Write-Host "--------------------------------------------------------------" -ForegroundColor Green 
    Write-Host "Creating the folder structure for : $($group.group)" -ForegroundColor Green 
    Write-Host "--------------------------------------------------------------" -ForegroundColor Green  
    Write-Host ""


    $file = Add-PnPFolder -Name $group.group -Folder "/TestFolderStructure/Test-cdap"
    

    foreach ($item in $paths) {
        Write-Host "Creating directory: $(${item})" -ForegroundColor Cyan 
        Copy-PnPFile -SourceUrl ("TestFolderStructure\sample\" + $item) -TargetUrl ('TestFolderStructure\Test-cdap\' + $group.group) -Force
    }

    Write-Host "Adding permission to contribution : $($group.group)" -ForegroundColor Magenta  

    Set-PnPFolderPermission -List 'TestFolderStructure' -Identity "TestFolderStructure\Test-cdap\$($group.group)" -User $group.mem1 -AddRole 'Contribute'
    Set-PnPFolderPermission -List 'TestFolderStructure' -Identity "TestFolderStructure\Test-cdap\$($group.group)" -User $group.mem2 -AddRole 'Contribute'
    Set-PnPFolderPermission -List 'TestFolderStructure' -Identity "TestFolderStructure\Test-cdap\$($group.group)" -User $group.mem3 -AddRole 'Contribute'
    Set-PnPFolderPermission -List 'TestFolderStructure' -Identity "TestFolderStructure\Test-cdap\$($group.group)" -User $group.mem4 -AddRole 'Contribute'
  
    
    $elapsedTime = $(get-date) - $StartTime
    $totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
    Write-Host "Successfully created the folder for : $($group.group). Time Elapsed : $totalTime" -ForegroundColor yellow  
}

$ScriptelapsedTime = $(get-date) - $ScriptStartTime
$ScripttotalTime = "{0:HH:mm:ss}" -f ([datetime]$ScriptelapsedTime.Ticks)


Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "--------------------------------------------------------------" -ForegroundColor blue 
Write-Host "Successfully Completed the Script. Time Elapsed : $ScripttotalTime" -ForegroundColor blue 
Write-Host "--------------------------------------------------------------" -ForegroundColor blue  
Write-Host ""
Write-Host ""
Write-Host ""
