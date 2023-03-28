function Set-NeoEdUser {
    <#
        .SYNOPSIS
            Updates NeoEd user information.
        .DESCRIPTION
            The function requires valid information and a valid employee number. The Employee Number is used to identify which user will be updated.
    #>
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [int]$employeeNumber,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$firstName,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$lastName,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$email,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [datetime]$employeeEvaluationCycle,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [String]$positionCode,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$positionTitle,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$departmentCode,
        $departmentName,
        $divisionName,
        $divisionCode,
        $classSpecificationCode ,
        $classSpecificationName,
        $directManagerFirstName,
        $directManagerLastName,
        $directManagerNumber,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [datetime]$hiredate,
        $address1,
        $address2,
        $seperationDate,
        $city,
        $state,
        $zipCode,
        $phone,
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$token,
        [string]$url = 'https://api.neogov.com'
    )

    $putParameters = @{
        'employeenumber'         = $employeeNumber
        'firstname'              = "$firstName"
        'lastname'               = "$lastName"
        'email'                  = "$email"
        'evaluationcycledate'    = "$employeeEvaluationCycle"
        'positioncode'           = "$positionCode"
        'positiontitle'          = "$positionTitle"
        'departmentcode'         = "$departmentCode"
        'departmentname'         = "$departmentName"
        'divisionname'           = "$divisionName"
        'divisioncode'           = "$divisionCode"
        'classspecificationcode' = "$classSpecificationCode"
        'classspecificationname' = "$classSpecificationName"
        'directmanagerfirstname' = "$directManagerFirstName"
        'directmanagerlastname'  = "$directManagerLastName"
        'directmanagernumber'    = "$directManagerNumber"
        'hiredate'               = $hireDate
        'address1'               = "$address1"
        'address2'               = "$address2"
        'separationdate'         = "$seperationDate"
        'city'                   = "$city"
        'state'                  = "$state"
        'zip'                    = $zipCode
        'phone'                  = "$phone"
    }

    @($putParameters.keys) | ForEach-Object { if (-not $putParameters[$_]) { $putParameters.Remove($_) } }


    $headers = @{
        'Accept'        = 'application/json'
        'Authorization' = "Basic $token"
    }

    $putParameters | ConvertTo-Json -Depth 4

    $restArgs = @{
        'Uri'     = "$url/rest/employees/employeenumber/$employeeNumber"
        'Headers' = $headers
        'Body'    = $body
        'Method'  = 'PUT'
    }

    $response = Invoke-RestMethod @restArgs
    return $response
}