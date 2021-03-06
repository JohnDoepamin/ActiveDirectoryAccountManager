﻿Function Get-OffboardingAccounts()
{
    $syncHash.statusBarText.Text = "Searching offboarding accounts."
    $syncHash.statusBarProgress.IsIndeterminate = $true
    $syncHash.statusBarProgress.Value = 50

    # Take user name from text box and disable it
    $user = $syncHash.userBoxDisable.Text
    $syncHash.editDB = $false
    $syncHash.userBoxDisable.IsEnabled = $false
    $Global:btnDisable.IsEnabled = $false
    $taskSet = $false

    foreach ($domain in $Global:dbOffboarding)
    {
        # Skip domain entries that are not selected
        If ($domain.isChecked -eq $true)
        {
            Set-RunSpaceOffboarding -offboardingListView $Global:offboardingListView -dbOffboarding $Global:dbOffboarding -syncHash $syncHash -adminAccount $env:USERNAME -userAccount $user -dc $domain.dc -domainName $domain.domainName -domainBase $domain.domainBase -officeDomain $domain.officeDomain -task search
            $taskSet = $true
        }
    }
    If($taskSet -eq $false)  
    {
        $syncHash.statusBarProgress.IsIndeterminate = $false
        $syncHash.statusBarProgress.Value = 0
    }
}