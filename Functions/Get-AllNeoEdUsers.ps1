function Get-AllNeoEdUser {
    <#
        .SYNOPSIS
            Gets all NeoEd users.
        .DESCRIPTION
        .EXAMPLE
           Get-AllNeoEdUser -token $token
    #>
    [CmdletBinding()]
    param(
        [parameter(mandatory = $true,
            ValueFromPipeline = $true)]
        [string]$token,
        [int]$Page = 1,
        [string]$url = 'https://api.neogov.com'
    )

    Begin {
        $headers = @{
            'Accept'        = 'application/json'
            'Authorization' = "Basic $token"
        }

        $Results = @()
    }

    process {
        while ($true) {
            $queryArgs = @{
                'Uri'     = "$url/rest/employees?perpage=20&pagenumber=$page"
                'Headers' = $headers
            }

            $QueryResponse = Invoke-RestMethod @queryArgs

            #Validating that the array isn't adding the same users over and over.
            if ($null -ne $Results -and (@() + $Results.employeenumber).Contains($QueryResponse[0].employeenumber)) {
                break;
            }
            $Results += $QueryResponse
            $page++;

            #Currently the NeoEd api returns a null value after the last page.
            if ($QueryResponse.lastPage -eq $true -or $null -eq $QueryResponse -or $QueryResponse.Length -eq 0) {
                break;
            }
        }
    }
    end {
        return $results
    }
}