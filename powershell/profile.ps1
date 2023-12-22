$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module PSReadLine
Set-PSReadLineOption `
    -EditMode vi `
    -ViModeIndicator Cursor
    # -ViModeChangeHandler $Function:OnViModeChange

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
    $cross = $([char]0x0058)
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

function prompt {
    $succeded = $?
    $command = Get-History -Count 1
    if ($command) {
        $time = $command.EndExecutionTime - $command.StartExecutionTime
        $color = if ($succeded) { 'DarkGreen' } else { 'Red' }
        $status = status $succeded $LastExitCode
		$format = format_duration $time
        $message = $time.ToString($format)
        right_align $($message.length + 5 + $status.length)
        Write-Host "$([char]0xe0b2)"  -NoNewLine -ForegroundColor $color
        Write-Host " $status"         -NoNewLine -BackgroundColor $color  -ForegroundColor 'White'
        Write-Host " $([char]0xe0b2)" -NoNewLine -BackgroundColor $color  -ForegroundColor 'Blue'
        Write-Host " $message"        -NoNewline -ForegroundColor 'White' -BackgroundColor 'Blue'
        realign
    }
    $dir = "$(Get-Location)".replace($Home, "~").replace('\', '/')
    Write-Host " $dir "         -NoNewLine -BackgroundColor 'Blue' -ForegroundColor 'White'
	$branch = git rev-parse --abbrev-ref HEAD 2>$null
	if ($? -and $branch) {
		Write-Host $([char]0xe0b0) -NoNewLine -ForegroundColor 'Blue' -BackgroundColor 'Magenta'
		Write-Host " $branch "     -NoNewLine -ForegroundColor 'White' -BackgroundColor 'Magenta'
		Write-Host $([char]0xe0b0) -NoNewLine -ForegroundColor 'Magenta'
	}
	else {
		Write-Host $([char]0xe0b0)  -NoNewLine -ForegroundColor 'Blue'
	}
    return " "
}
