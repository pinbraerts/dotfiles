$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_UPDATECHECK_OPTOUT = 1
$env:POWERSHELL_UPDATECHECK = "Off"
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module PSReadLine
Set-PSReadLineOption -EditMode vi -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl+j -Function AcceptLine
Set-PSReadLineKeyHandler -Chord Ctrl+y -Function AcceptSuggestion

Set-Item -Path Env:RUSTC_WRAPPER -Value sccache

# Import-Module posh-git
# $GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::Magenta

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
Invoke-Expression (&starship init powershell)
