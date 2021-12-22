:start
@echo off
cls
$InputPath = ($((New-Object -ComObject "Shell.Application").BrowseForFolder(0,"Select Input folder:",0)).Self.Path)
$Files = Get-ChildItem $InputPath -Force -Recurse | Select Name,Directory,FullName | Out-GridView -PassThru
$OutputPath = "c:\test"
ForEach ($File in $Files)
{   Move-Item $File.FullName $OutputPath -WhatIf
}
pause
Exit