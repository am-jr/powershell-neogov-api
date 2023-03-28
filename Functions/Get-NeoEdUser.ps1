function Get-NeoEdUser {
    <#
        .SYNOPSIS
            Gets NeoEd user based on the Employee Numberprovided.
        .DESCRIPTION
            Returns a response containing all of the employee information currently associated with the EmployeeNumber.
        .EXAMPLE
           Get-NeoEdUser -employeeNumber $employeeNumber -token $token
    #>
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [int]$employeeNumber,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$token,
        [string]$url = 'https://api.neogov.com'
    )

    $headers = @{
        'Accept'        = 'application/json'
        'Authorization' = "Basic $token"
    }

    $restArgs = @{
        'Uri'     = "$url/rest/employees/employeenumber/$employeeNumber"
        'Headers' = $headers
        'Method'  = 'GET'
    }

    $response = Invoke-RestMethod @restArgs
    return $response
}