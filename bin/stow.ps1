<#

.SYNOPSIS
manage farms of symbolic links

.DESCRIPTION
version 0.0.1

.EXAMPLE
.\stow.ps1 .

.EXAMPLE
.\stow.ps1 -r -t $(Get-Item -Path $PROFILE).directory -c .config/powershell

.EXAMPLE
.\stow.ps1 -r -NoFolding -t $env:LOCALAPPDATA -c .config nvim

#>

param(

	# Show version and exit
	[Parameter(Mandatory, ParameterSetName="version")]
	[switch]$Version,

	# Show help and exit
	[Parameter(Mandatory, ParameterSetName="help")]
	[Alias("h", "?")]
	[switch]$Help,

	# Source directory (cd into it before start)
	[Parameter(ParameterSetName="stow")]
	[Alias("c")]
	[string]$Directory = $pwd,

	# Target directory
	[Parameter(ParameterSetName="stow")]
	[Alias("t")]
	[string]$Target = "$pwd/..",

	# Do not perform any operations
	[Parameter(ParameterSetName="stow")]
	[Alias("n", "no")]
	[switch]$Simulate,

	# Remove packages from directory rather than installing them
	[Parameter(ParameterSetName="stow")]
	[Alias("d")]
	[switch]$Delete,

	# Restow: remove packages and add again
	[Parameter(ParameterSetName="stow")]
	[Alias("r")]
	[switch]$Restow,

	# Disable folding: remove target directory if exist
	# (oppose to stowing children recursively)
	[Parameter(ParameterSetName="stow")]
	[switch]$NoFolding,

	# File with ignore regexes
	[Parameter(ParameterSetName="stow")]
	[string]$IgnoreFile = ".stow-local-ignore",

	[Parameter(
		Mandatory,
		ParameterSetName="stow",
		ValueFromPipeline,
		ValueFromRemainingArguments,
		Position=0
	)]
	[string[]]$Packages
)

if ($help) {
	Get-Help $MyInvocation.MyCommand.Definition -Full
	return
}

if ($version) {
	Get-Help $MyInvocation.MyCommand.Definition
	return
}

Push-Location "$Directory"

$IgnoreList = @(
	Get-Content -Path "$IgnoreFile" -ErrorAction SilentlyContinue `
		| Where-Object {
			-not [string]::IsNullOrEmpty($_) `
			-and -not $_.StartsWith("#")
		}
)

function ShouldIgnore ($Item) {
	if ($Item -eq $IgnoreFile) {
		return $True
	}
	foreach ($regex in $IgnoreList) {
		Write-Debug "Matching '$Item' against '$regex'"
			if ($Item -match $regex) {
				return $true
			}
	}
	return $false
}

if ($Simulate) {
	Write-Verbose "Simulating stow"
	$Verbose = $True
	$VerbosePreference = 'Continue'
}

$Stow = $True
if ($Restow) {
	$Delete = $True
}
elseif ($Delete) {
	$Stow = $False
}

Add-Type -AssemblyName Microsoft.VisualBasic

function Trash ([string]$Item) {
	Write-Verbose "Moving '$Item' to the Recycle Bin"

	if ($Simulate) {
		return
	}

	if (Test-Path -Path $Item -PathType Container) {
		[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($Item, 'OnlyErrorDialogs', 'SendToRecycleBin')
	}
	else {
		[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($Item, 'OnlyErrorDialogs', 'SendToRecycleBin')
	}
}

function Link-Symbolic ([string]$Item, $Target) {
	Write-Verbose "Linking '$Target' to '$Item'"

	if ($Simulate) {
		return
	}

	New-Item `
		-Type SymbolicLink `
		-Path $Target `
		-Value $Item
}

function IsLink([string]$path) {
	$file = Get-Item $path -Force -ea SilentlyContinue
	return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

function stow ($Item) {

	if (ShouldIgnore $Item) {
		Write-Verbose "Ignoring '$Item'"
		return
	}

	$SourceItem = (Get-Item -Path $Item).FullName
	$TargetItem = Join-Path $Target $Item

	if (Test-Path -Path $TargetItem) {

		if (-not $NoFolding -and (Test-Path -Path $Item -PathType Container) -and -not (IsLink $TargetItem)) {
			if ((Test-Path -Path $TargetItem -PathType Container)) {
				Write-Verbose "directory '$TargetItem' exists, stowing recursive"
				Get-ChildItem $Item `
					| % Name
					| % { Join-Path $Item $_ } `
					| % { stow $_ }
			}
			else {
				Write-Warning "target '$TargetItem' is not a directory, while '$Item' is, not stowing"
			}
			return
		}

		if ($Delete) {
			Trash $TargetItem
		}
		else {
			Write-Warning "target '$TargetItem' already exists, not stowing"
			return
		}

	}

	if ($Stow) {
		Link-Symbolic $SourceItem $TargetItem
	}

}

foreach ($package in $Packages) {
	stow $package
}

Pop-Location
