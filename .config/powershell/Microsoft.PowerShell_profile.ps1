$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_UPDATECHECK_OPTOUT = 1
$env:POWERSHELL_UPDATECHECK = "Off"
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module PSReadLine
Invoke-Expression (&starship init powershell)

function OnViModeChange
{
  if ($args[0] -eq 'Command')
  {
    Write-Host -NoNewLine "`e[2 q"
  } else
  {
    Write-Host -NoNewLine "`e[6 q"
  }
}

$PSReadLineOptions = @{
  EditMode = "vi"
  HistoryNoDuplicates = $true
  HistorySearchCursorMovesToEnd = $true
  ViModeIndicator = "Script"
  ViModeChangeHandler = $Function:OnViModeChange
}
Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl+j -Function AcceptLine
Set-PSReadLineKeyHandler -Chord Ctrl+y -Function AcceptSuggestion

Set-Item -Path Env:RUSTC_WRAPPER -Value sccache
Set-Item -Path Env:LC_ALL -Value "C"

# Import-Module posh-git
# $GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::Magenta

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
