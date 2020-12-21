function Get-XgVPNIPSecConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet('Equals', 'NotEquals', 'Like')]
        [string]$FilterCriteria,

        [Parameter(Mandatory = $false)]
        [string]$FilterValue
    )

    $xml = New-XgApiMessage -ActionType Get -Entity VPNIPSecConnection @PSBoundParameters
    $output = Write-ApiOutput -Object (New-ApiRequest -xml $xml) # | select -ExpandProperty Configuration
    return $output
}