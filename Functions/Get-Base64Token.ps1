function Get-Base64Token {
    <#
        .SYNOPSIS
            This function creates a base64 encoded version of the User Credentials.
        .DESCRIPTION
            The base64 encoded username and password are necessary in order to interact with the api.
        .EXAMPLE
            Get-Base64Token -username $username -password $password
    #>
    [CmdletBinding()]
    param (
        [String]$username,
        [securestring]$password
    )

    $pairedCredentials = "$($username):$([Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)))"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pairedCredentials)
    $base64 = [System.Convert]::ToBase64String($bytes)

    Return $base64
}