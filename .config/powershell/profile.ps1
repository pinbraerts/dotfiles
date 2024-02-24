$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module PSReadLine
Set-PSReadLineOption -EditMode vi -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl+j -Function AcceptLine
Set-PSReadLineKeyHandler -Chord Ctrl+Spacebar -Function AcceptSuggestion

Set-Item -Path Env:RUSTC_WRAPPER -Value sccache

# Import-Module posh-git
# $GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::Magenta

function right_align($l) {
	$w = $Host.UI.RawUI.windowsize.width
	if ($l -lt $w / 2) {
		$x = $w - $l
		$y = $Host.UI.RawUI.CursorPosition.Y
		$Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $x, $y
	}
}

function realign() {
	$y = $Host.UI.RawUI.CursorPosition.Y
	$Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, $y
}

function status($status, $exit_code) {
	$tick  = $([char]0x2713)
	$cross = $([char]0x2717)
	if ($exit_code -eq 0 -or $status) {
		return $tick
	}
	if ($null -ne $exit_code) {
		return "$cross $exit_code"
	}
	$LastExitCode = $null
	return $cross
}

function format_duration($time) {
	if ($time.Days) {
		return "d'd 'h'h 'm'm 's's 'fff'ms'"
	}
	if ($time.Hours) {
		return "h'h 'm'm 's's 'fff'ms'"
	}
	if ($time.Minutes) {
		return "m'm 's's 'fff'ms'"
	}
	if ($time.Seconds) {
		return "s's 'fff'ms'"
	}
	return "fff'ms'"
}

function vcs_info {
	$branch = git branch --show-current 2>$null
	if (!$branch) {
		$branch = git rev-parse --short HEAD 2>$null
	}
	if (!$branch) {
		return
	}
	Write-Host " $branch " -NoNewline -ForegroundColor Magenta
	$changes = git diff --shortstat 2>$null
	if ($changes) {
		Write-Host "* " -NoNewline -ForegroundColor Yellow
	}
}

function prompt {
	$succeded = $?
	$color = if ($succeded) { 'DarkGreen' } else { 'Red' }
	$command = Get-History -Count 1
	if ($command) {
		$time = $command.EndExecutionTime - $command.StartExecutionTime
		$status = status $succeded $LastExitCode
		$format = format_duration $time
		$message = $time.ToString($format)
		right_align $($message.length + $status.length + 1)
		Write-Host "$message " -NoNewline
		Write-Host $status -NoNewline -ForegroundColor $color
		realign
	}
	$dir = "$(Get-Location) ".replace($Home, "~").replace('\', '/')
	Write-Host $dir -NoNewline -ForegroundColor Cyan
	vcs_info
	if ($Host.UI.RawUI.windowsize.width -lt 80) { Write-Host }
	Write-Host % -NoNewLine -ForegroundColor $color
	return ' '
}

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
