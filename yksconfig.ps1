<#
	.SYNOPSIS
		 Securely configures Yubikey
	.DESCRIPTION
		 Uses secure settings and parameters to apply a default
		 configuration to Yubikey 4/5.
	.OUTPUTS
		Text file containing configuration details.
#>
Param
	(
    	[parameter(Position = 0, Mandatory = $False)]
		[Alias('dryrun')]
		[Switch] $NoDisable
	)
# ykman Location
$ykmanPath="C:\Program Files\Yubico\YubiKey Manager\ykman.exe"
# USB Interface Settings
$config_usb=@{
	OTP = "disable";
	U2F = "disable";
	OPGP = "disable";
	PIV = "enable";
	OATH = "disable";
	FIDO2 = "disable"
}
# NFC Interface Settings
$config_nfc=@{
	OTP = "disable";
	U2F = "disable";
	OPGP = "disable";
	PIV = "disable";
	OATH = "disable";
	FIDO2 = "disable"
}
function Get-YKSerial {
	$CMDYKSerial = (ykman.exe list) | Out-String
	$YKSerial = $CMDYKSerial.Split(': ',2)[-1]
}
function Set-LockCode { # Set Configuration Lock Code
$CMDLockCode = (ykman.exe config set-lock-code -g -f)  | Out-String
$LockCode = $CMDLockCode.Split(': ',2)[-1]
}
