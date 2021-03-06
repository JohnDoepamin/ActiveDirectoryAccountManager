Function Disable-OffboardingAccounts()
{
    $syncHash.statusBarText.Text = "Diabling offboarding accounts."
    $syncHash.statusBarProgress.IsIndeterminate = $true
    $syncHash.statusBarProgress.Value = 50
    $syncHash.editDB = $false

    $Global:userBoxTicket.IsEnabled = $false
    $Global:btnOffboard.IsEnabled = $false
    $syncHash.ticketNumber = $userBoxTicket.Text
    $taskSet = $false

    foreach ($userObject in $Global:dbOffboarding)
    {
        # Skip blanks
        if($userObject.domainName -eq "")
        {continue}
        # Only disable accounts that are checked and the password has been verified
        If ($userObject.isChecked -eq $true -and ($userObject.pswdVer) -and $userObject.userAccount)
        {
            Set-RunSpaceOffboarding -offboardingListView $Global:offboardingListView -dbOffboarding $Global:dbOffboarding -syncHash $syncHash -adminAccount $userObject.samAccount -pswd $userObject.pswdVer -userAccount $userObject.userAccount -dc $userObject.dc -domainName $userObject.domainName -domainBase $userObject.domainBase -officeDomain $userObject.officeDomain -task disable -userDistName $userObject.userDistName -offboardingResults $userObject.offboardingResults[0] -btnOffboardToClip $Global:btnOffboardToClip
            $taskSet = $true
        }
        else
        {
            Write-Host "Skipped" $userObject.domainBase"\"$userObject.userAccount
        }
    }
    If($taskSet -eq $false)  
    {
        $syncHash.statusBarProgress.IsIndeterminate = $false
        $syncHash.statusBarProgress.Value = 0
    }
}