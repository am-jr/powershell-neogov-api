<#
.SYNOPSIS
A simple module that uses dot sourcing to load the functions.
.DESCRIPTION
When this module is imported, the functions are loaded using dot sourcing.
#>

$functionpath = $PSScriptRoot + '\Functions\'
$functionlist = Get-ChildItem -Path $functionpath -Name

foreach ($function in $functionlist) {
    . ($functionpath + $function)
}