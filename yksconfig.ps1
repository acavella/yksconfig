<#
	.SYNOPSIS
		 Disables inactive AD accounts
	.DESCRIPTION
		 Disables AD accounts that have been inactive for a specified period of time.
	.PARAMETER Days
		Specify the number of days an account has been inactive.
	.INPUTS
		Comma Seperated Values (CSV) containing account details.
		Format:
		username,firstname,lastname,password
		<string>,<string>,<string>,<string>
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
function LockConfig { # Set Configuration Lock Code
$GenerateLockCode = (ykman.exe config set-lock-code -g -f)  | Out-String
$LockCode = $GenerateLockCode.Split(': ',2)[-1]
}
