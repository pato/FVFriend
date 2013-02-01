$NAME = "FVFrnd"
;
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Registry Modifier", 330, 68, 192, 124)
$Button1 = GUICtrlCreateButton("Activate FVF", 40, 16, 105, 33, $WS_GROUP)
$Button2 = GUICtrlCreateButton("Deavtivate FVF", 160, 16, 113, 33, $WS_GROUP)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			RegWrite("HKEY_CURRENT_USER\Software\p123n2Elf1isLF2vLPgth3\FVFrnd", "Name", "REG_SZ", $NAME)
			MsgBox(64, "", "Bot Activated")
		Case $Button2
			RegDelete("HKEY_CURRENT_USER\Software\p123n2Elf1isLF2vLPgth3\FVFrnd", "Name")
			MsgBox(64, "", "Bot De-Activated")
	EndSwitch
WEnd
