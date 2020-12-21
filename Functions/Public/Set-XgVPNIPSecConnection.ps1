function Set-XgVPNIPSecConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Xml.XmlElement]$InputObject,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Update')]
        [string]$Operation = 'Update'
    )

    $xml = New-ApiSetMessage -InputObject $InputObject -Operation $Operation
$output
    $output = Write-ApiOutput -Object (New-ApiRequest -xml $xml)
    if ($output.Status.code -eq "200") {
        # Test what result is..
        $output.Status
    }
    else {
        $output.Status
    }
}