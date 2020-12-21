function Enable-XgVPNIPSecConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        $SophosCredential,

        [Parameter(Mandatory = $true)]
        [string]$SophosIP,
        $TunnelName
    )

$RequestBody = [xml] @"
<?xml version="1.0" encoding="UTF-8"?>
<Request>
<!-- API Authentication -->
<Login>
<Username>$($SophosCredential.UserName)</Username>
<Password>$($SophosCredential.GetNetworkCredential().Password)</Password>
</Login>
 
<Set operation="update">
  <!-- De-Activate the vpn connection -->
<VPNIPSecConnection>
<DeActive><Name>$($TunnelName)</Name></DeActive>
</VPNIPSecConnection>
</Set>

<Set operation="update">
  <!-- Activate the vpn connection -->
<VPNIPSecConnection>
<Connection>
<Name>$($TunnelName)</Name>
</Connection>
</VPNIPSecConnection>
</Set>
 
</Request>
"@

#

#

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy



#https://<Sophos IP>:<port>/webconsole/APIController?reqxml=<Add the XML request here>


Invoke-WebRequest -Uri https://$($SophosIP):4444/webconsole/APIController?reqxml=$($RequestBody.InnerXml) | Out-Null

}