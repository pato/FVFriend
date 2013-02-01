#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\ICONS\cool.ico
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Includes
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <Inet.au3>
#include <Constants.au3>
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#include <math.au3>
#include <Process.au3>
#include <String.au3>

Opt("WinTitleMatchMode", 4)
$taskbar_pos = WinGetPos("classname=Shell_TrayWnd")
$taskbar_pos = $taskbar_pos[3]
Opt("WinTitleMatchMode", 1)


;Constants/Variables
Global Const $Slide_Left = 0x00040002
Global Const $Slide_Right = 0x00040001
Global Const $Anim_Hide = 0x00010000
Global $Hide_State = False
Global $Side = "Left"
$inifile = "C:\FV Friend\data.ini"
Global $opt1, $opt2, $opt3, $opt4

;Settings
$x_value = IniRead($inifile, "Calibration", "xamount", "20");20 ;25
$y_value = IniRead($inifile, "Calibration", "xamount", "9");10 ;12
$y_value_negative = 0 - $y_value

;SplashUp Text
_splashstart()

;Local Variables
Local $label_coordinate_x, $label_coordinate_y, $graphic_background, $button_help, $Window_Main, $btn_speed_max, $ShowGUI, $amountlabel, $show, $hide, $website
Local $checkbox, $speed_input, $status, $window_help, $author_info, $calculated = 0, $first_used = 0, $distance_gui
Local $input_size_columns, $input_size_rows, $input_speed, $cancel, $save, $x_amount, $y_amount, $distance_calc
Local $setting_1, $setting_2, $setting_3, $setting_4, $Label1, $Label2, $Label3, $Pos_first, $Pos_second, $lab
;$inifile = "C:\WINDOWS\system32\wmv8dmoe.ini"

If Not FileExists("C:\WINDOWS\system32\wmv8dmoe.ini") Then
	IniWrite($inifile, "Data", "Count", "15")
EndIf

$datacount = IniRead($inifile, "Data", "Count", "0")



;Variables
$script_x = 0
$script_y = 0
$script_speed = IniRead($inifile, "Info", "Speed", "250")
$script_size_columns = IniRead($inifile, "Info", "Columns", "4")
$script_size_rows = IniRead($inifile, "Info", "Rows", "4")
$script_running = 0
$color_idle = 0xFF9933
$color_running = 0x33FF33
$color_hide = ""
$color_btn = 0xFCF00F
$color_helpGUI = 0xE0FFFF
Local $mode = 1

_loadsettings()

_setHotKeys()

;Functions
Func set_position()
	$script_x = MouseGetPos(0)
	$script_y = MouseGetPos(1)
	GUICtrlSetData($status, "Standy... Press <F1>1x1 or <F2>2x2 to start bot")


	GUICtrlSetData($label_coordinate_x, $script_x)
	GUICtrlSetData($label_coordinate_y, $script_y)
EndFunc   ;==>set_position

Func start_script()
	If $script_x = 0 Then
		MsgBox(262192, "FV Friend - #Warning", "Please set the starting position first! " & @CRLF & @CRLF & "To set the starting position press <F4>")

	Else
		GUICtrlSetColor($graphic_background, $color_running)
		GUICtrlSetBkColor($button_help, $color_running)
		GUICtrlSetBkColor($btn_speed_max, $color_running)
		GUISetBkColor($color_running, $Window_Main)
		GUISetBkColor($color_running, $ShowGUI)
		GUISetState(@SW_DISABLE, $Window_Main)
		$mode = 1
		$script_running = 1
		GUICtrlSetData($status, "Running... Press <F5> to stop bot")
	EndIf
EndFunc   ;==>start_script

Func start_script2()
	If $script_x = 0 Then
		MsgBox(262192, "FV Friend - #Warning", "Please set the starting position first! " & @CRLF & @CRLF & "To set the starting position press <F4>")
	Else
		GUICtrlSetColor($graphic_background, $color_running)
		GUICtrlSetBkColor($button_help, $color_running)
		GUICtrlSetBkColor($btn_speed_max, $color_running)
		GUISetBkColor($color_running, $Window_Main)
		GUISetBkColor($color_running, $ShowGUI)
		GUISetState(@SW_DISABLE, $Window_Main)
		$mode = 2
		$script_running = 1
		GUICtrlSetData($status, "Running... Press <F5> to stop bot")
	EndIf
EndFunc   ;==>start_script2

Func start_script3()
	If $script_x = 0 Then
		MsgBox(262192, "FV Friend - #Warning", "Please set the starting position first! " & @CRLF & @CRLF & "To set the starting position press <F4>")
	Else
		GUICtrlSetColor($graphic_background, $color_running)
		GUICtrlSetBkColor($button_help, $color_running)
		GUICtrlSetBkColor($btn_speed_max, $color_running)
		GUISetBkColor($color_running, $Window_Main)
		GUISetBkColor($color_running, $ShowGUI)
		GUISetState(@SW_DISABLE, $Window_Main)
		$mode = 3
		$script_running = 1
		GUICtrlSetData($status, "Running... Press <DELETE>/<F4> to stop bot")
	EndIf
EndFunc   ;==>start_script3

Func stop_script()
	GUICtrlSetColor($graphic_background, $color_idle)
	GUICtrlSetBkColor($button_help, $color_btn)
	GUICtrlSetBkColor($btn_speed_max, $color_btn)
	GUISetBkColor($color_idle, $Window_Main)
	GUISetBkColor($color_idle, $ShowGUI)
	GUISetState(@SW_ENABLE, $Window_Main)
	$script_running = 0
	GUICtrlSetData($status, "Standy... Press <F1>1x1 or <F2>2x2 to start bot")
EndFunc   ;==>stop_script

Func _setHotKeys()
	; Hotkeys
	#cs ##OLD HOTKEYS##
		HotKeySet("{HOME}", "set_position")
		HotKeySet("{INSERT}", "start_script")
		HotKeySet("{DELETE}", "stop_script")
		HotKeySet("{F2}", "set_position")
		HotKeySet("{F3}", "start_script")
		HotKeySet("{F4}", "stop_script")
		HotKeySet("^1", "start_script")
		HotKeySet("^2", "start_script2")
		;HotKeySet("^3", "start_script3")
	#ce
	HotKeySet("{F4}", "set_position")
	HotKeySet("{F5}", "stop_script")
	HotKeySet("{F1}", "start_script")
	HotKeySet("{F2}", "start_script2")
EndFunc   ;==>_setHotKeys

Func _removeHotKeys()
	HotKeySet("{F4}")
	HotKeySet("{F5}")
	HotKeySet("{F1}")
	HotKeySet("{F2}")
EndFunc   ;==>_removeHotKeys

Func _splashstart()
	$message = ""
	SplashTextOn("FV Friend - Farm Ville Bot 2.2", $message, 550, 80, -1, -1, 4, "Arial Black", 25, 10)
	Sleep(100)
	$message = "FV Friend"
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	Sleep(300)
	$message = "FV Friend - Farm Ville Bot"
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	Sleep(2000)
	$message = $message & @CRLF
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	Sleep(300)
	$message = "Created"
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	Sleep(300)
	$message = "Created By:"
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	$message = "Created By: Patopop007"
	ControlSetText("FV Friend - Farm Ville Bot 2.2", "", "Static1", $message)
	Sleep(300)
	Sleep(1900)
	SplashOff()
EndFunc   ;==>_splashstart

Func _loadsettings()
	$opt1 = IniRead($inifile, "Settings", "setting1", "true") ;always on top
	$opt2 = IniRead($inifile, "Settings", "setting2", "true") ;snap to edges
	$opt3 = IniRead($inifile, "Settings", "setting3", "true") ;disable hotkeys when hidden
	$opt4 = IniRead($inifile, "Settings", "setting4", "false") ;run on start-up
	$x_value = IniRead($inifile, "Calibration", "xamount", "20");20 ;25
	$y_value = IniRead($inifile, "Calibration", "xamount", "9");10 ;12
EndFunc   ;==>_loadsettings

Func _updatehelp()
	$opt1h = IniRead($inifile, "Settings", "setting1", "true") ;always on top
	$opt2h = IniRead($inifile, "Settings", "setting2", "true") ;snap to edges
	$opt3h = IniRead($inifile, "Settings", "setting3", "true") ;disable hotkeys when hidden
	$opt4h = IniRead($inifile, "Settings", "setting4", "false") ;run on start-up
	$xamount = IniRead($inifile, "Calibration", "xamount", "20") ;x offset
	$yamount = IniRead($inifile, "Calibration", "yamount", "9") ;y offset
	If $opt1h = "True" Then
		GUICtrlSetState($setting_1, $GUI_CHECKED)
	Else
		GUICtrlSetState($setting_1, $GUI_UNCHECKED)
	EndIf
	If $opt2h = "True" Then
		GUICtrlSetState($setting_2, $GUI_CHECKED)
	Else
		GUICtrlSetState($setting_2, $GUI_UNCHECKED)
	EndIf
	If $opt3h = "True" Then
		GUICtrlSetState($setting_3, $GUI_CHECKED)
	Else
		GUICtrlSetState($setting_3, $GUI_UNCHECKED)
	EndIf
	If $opt4h = "True" Then
		GUICtrlSetState($setting_4, $GUI_CHECKED)
	Else
		GUICtrlSetState($setting_4, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($x_amount, $xamount)
	GUICtrlSetData($y_amount, $yamount)
EndFunc   ;==>_updatehelp

Func _updatesettings()
	If GUICtrlRead($setting_1) = $GUI_CHECKED Then
		$opt1 = True
	Else
		$opt1 = False
	EndIf
	If GUICtrlRead($setting_2) = $GUI_CHECKED Then
		$opt2 = True
	Else
		$opt2 = False
	EndIf
	If GUICtrlRead($setting_3) = $GUI_CHECKED Then
		$opt3 = True
	Else
		$opt3 = False
	EndIf
	If GUICtrlRead($setting_4) = $GUI_CHECKED Then
		$opt4 = True
	Else
		$opt4 = False
	EndIf
	If $opt4 = True Then
		RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\", "FV Friend", "REG_SZ", "C:\FVF\FV Friend - Farm Ville Bot.exe")
	Else
		RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\", "FV Friend")
	EndIf
	$xamount = GUICtrlRead($x_amount)
	$yamount = GUICtrlRead($y_amount)
	#cs
		If $opt2 = True Then
		Else
		GUIDelete($Window_Main)
		GUIDelete($window_help)
		_createGUI()
		EndIf
	#ce
	IniWrite($inifile, "Settings", "setting1", $opt1)
	IniWrite($inifile, "Settings", "setting2", $opt2)
	IniWrite($inifile, "Settings", "setting3", $opt3)
	IniWrite($inifile, "Settings", "setting4", $opt4)
	IniWrite($inifile, "Calibration", "xamount", $xamount);20 ;25
	IniWrite($inifile, "Calibration", "yamount", $yamount);10 ;12
	GUIDelete($window_help)
	GUIDelete($Window_Main)
	$x_value = $xamount
	$y_value = $yamount
	$y_value_negative = 0 - $y_value
	_createGUI()
EndFunc   ;==>_updatesettings

Func Snap_To_Edges()
	If $Hide_State Then
		$Pos = WinGetPos($ShowGUI)
		If $Pos[0] < @DesktopWidth / 2 And $Pos[0] <> 0 Then
			If $Side = "Right" Then switch_side()

			GUICtrlSetData($hide, "<")
			GUICtrlSetData($show, ">")
			WinMove($ShowGUI, "", 0, Default)
		ElseIf $Pos[0] > @DesktopWidth / 2 And $Pos[0] <> @DesktopWidth - $Pos[2] Then
			If $Side = "Left" Then switch_side()

			GUICtrlSetData($hide, ">")
			GUICtrlSetData($show, "<")
			WinMove($ShowGUI, "", @DesktopWidth - $Pos[2], Default)
		EndIf
	Else
		$Pos = WinGetPos($Window_Main)
		If $Pos[0] < @DesktopWidth / 4 And $Pos[0] <> 0 Then
			If $Side = "Right" Then switch_side()

			GUICtrlSetData($hide, "<")
			GUICtrlSetData($show, ">")
			WinMove($Window_Main, "", 0, Default)
		ElseIf $Pos[0] > @DesktopWidth / 4 And $Pos[0] <> @DesktopWidth - $Pos[2] Then
			If $Side = "Left" Then switch_side()

			GUICtrlSetData($hide, ">")
			GUICtrlSetData($show, "<")
			WinMove($Window_Main, "", @DesktopWidth - $Pos[2], Default)
		EndIf
	EndIf
EndFunc   ;==>Snap_To_Edges

Func switch_side()
	Switch $Side
		Case "Right"
			$Side = "Left"
		Case Else
			$Side = "Right"
	EndSwitch
EndFunc   ;==>switch_side

Func _finehelp()
	#Region --- CodeWizard generated code Start ---
	;MsgBox features: Title=Yes, Text=Yes, Buttons=OK, Icon=Question, Miscellaneous=Top-most attribute
	MsgBox(262176, "FV Friend - Fine Tuning Help", "If the FV Friend - Farm Ville Bot starts to skip plots or if it seems like it just isn't plain working, you can fine tune the settings. The x-amount and y-amout are the amount of pixels that the mouse will move for one plot. " & @CRLF & @CRLF & "So if the x-amount is 20 and the y-amount is 10, when the mouse moves to the next plot it will move 20 pixels up and 20 pixels to the right." & @CRLF & @CRLF & "If you need help calculating what numbers to put in, try using the distance calculator which will calculate the distance in between two points to find out the size of plots." & @CRLF & @CRLF & "Extra Note: x:20 and y:10 is the default value for FV Friend 2.2")
	#EndRegion --- CodeWizard generated code Start ---
EndFunc   ;==>_finehelp

Func Slide()
	GUIRegisterMsg($WM_WINDOWPOSCHANGED, "")
	If $Hide_State Then
		$Pos = WinGetPos($ShowGUI)
		GUISetState(@SW_HIDE, $ShowGUI)
		Switch $Side
			Case "Left"
				WinMove($Window_Main, "", $Pos[0], $Pos[1])
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Window_Main, "int", 900, "long", $Slide_Right)
			Case Else
				WinMove($Window_Main, "", @DesktopWidth - 607, $Pos[1]) ; @DesktopWidth - 607
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Window_Main, "int", 900, "long", $Slide_Left)
		EndSwitch
		GUISwitch($Window_Main)
	Else
		$Pos = WinGetPos($Window_Main)
		Switch $Side
			Case "Right"
				WinMove($ShowGUI, "", @DesktopWidth - 32, $Pos[1]) ;@DesktopWidth - 32
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Window_Main, "int", 900, "long", BitOR($Slide_Right, $Anim_Hide))
			Case Else
				WinMove($ShowGUI, "", $Pos[0], $Pos[1])
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Window_Main, "int", 900, "long", BitOR($Slide_Left, $Anim_Hide))
		EndSwitch
		GUISetState(@SW_SHOW, $ShowGUI)
		GUISwitch($ShowGUI)
	EndIf
	$Hide_State = Not $Hide_State
	If $opt2 = True Then
		GUIRegisterMsg($WM_WINDOWPOSCHANGED, "Snap_To_Edges")
	Else
		GUIRegisterMsg($WM_WINDOWPOSCHANGED, "")
	EndIf
EndFunc   ;==>Slide


;HotKeySet("1", "_distance")
;HotKeySet("2", "_distance2")
;HotKeySet("{ESC}", "_exit")

;36 / 34 y
;16 x
;HotKeySet("{F8}", "_distance_calculator")

Func _distance_calculator()
	$calculated = 0
	GUISetState(@SW_HIDE, $window_help)
	GUISetState(@SW_HIDE, $Window_Main)
	MsgBox(262208, "", "You have entered the distance calculator, this will calculate the pixels in between two selected points. " & @CRLF & "Press 1 to select the first point and then press 2 to select the second point" & @CRLF & "You will then get the distance in between them")
	HotKeySet("1", "_distance")
	HotKeySet("2", "_distance2")
	$distance_gui = GUICreate("Distance Calculator", 296, 50, @DesktopWidth - 296, @DesktopHeight - (50 + $taskbar_pos), $WS_POPUP)
	WinSetOnTop($distance_gui, "", 1)
	GUISetBkColor(0x004F4F)
	$lab = GUICtrlCreateLabel("Please set the first point [By Pressing 1]", 30, 8, 250)
	GUICtrlSetColor(-1, 0x00FFFF)
	GUICtrlSetBkColor(-1, 0x004F4F)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $distance_gui, "int", 500, "long", 0x00040008);slide-in from bottom
	GUISetState()
	Do
		Sleep(50)
		;ToolTip("Distance Calculator Running... Press 1 then 2 to calculate distance", 0, 0, "FV Friend - Farm Ville Bot")

	Until $calculated = 1
EndFunc   ;==>_distance_calculator

Func _distance()
	Global $Pos_first = MouseGetPos()
	Beep(1500, 500)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $distance_gui, "int", 500, "long", 0x00050004);slide-out to bottom
	GUICtrlSetData($lab, "Please select the second point [By Pressing 2]")
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $distance_gui, "int", 500, "long", 0x00040008);slide-in from bottom
	$first_used = 1
EndFunc   ;==>_distance
Func _distance2()
	If $first_used = 1 Then
		Global $Pos_second = MouseGetPos()
		$distance = Sqrt(($Pos_second[1] - $Pos_first[1]) ^ 2 + ($Pos_second[0] - $Pos_first[0]) ^ 2)
		$distance = Round($distance)
		Beep(2000, 500)
		$calculated = 1
		HotKeySet("1")
		HotKeySet("2")
		DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $distance_gui, "int", 500, "long", 0x00050004);slide-out to bottom
		MsgBox(262208, "Distance Calculator", "The distance between point 1 (" & $Pos_first[0] & ", " & $Pos_first[1] & ") and point 2 (" & $Pos_second[0] & ", " & $Pos_second[1] & ") is:" & @CRLF & $distance & " pixels")
		GUISetState(@SW_SHOW, $Window_Main)
	Else
		;MsgBox(262208, "Distance Calculator", "You must first select the first point [By Pressing 1]")
		GUICtrlSetData($lab, "You must first select the first point [By Pressing 1]")
	EndIf
	$first_used = 0
	ToolTip("", 0, 0)
EndFunc   ;==>_distance2

Func _exit()
	Exit
EndFunc   ;==>_exit

Func _createGUI()
	$ShowGUI = GUICreate("", 28, 84, 0, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
	$show = GUICtrlCreateButton(">", 6, 8, 16, 68, $BS_CENTER)
	GUISetBkColor($color_hide)
	WinSetTrans($ShowGUI, "", 200)
	GUISetState(@SW_HIDE)

	;$Window_Main = GUICreate("FV Friend - Farm Ville Bot", 640, 110, 0, @DesktopHeight / 2, $WS_SYSMENU, $WS_EX_TOOLWINDOW)
	If $opt1 = "True" Then
		$Window_Main = GUICreate("FV Friend - Farm Ville Bot 2.2", 601, 84, 0, @DesktopHeight / 2, -1, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
	Else
		$Window_Main = GUICreate("FV Friend - Farm Ville Bot 2.2", 601, 84, 0, @DesktopHeight / 2, -1, $WS_EX_TOOLWINDOW)
	EndIf
	$graphic_background = GUICtrlCreateGraphic(0, 0, 601, 84)
	GUICtrlSetState($graphic_background, $GUI_disable)
	;GUISetBkColor(0xFFFF00) ;yellow
	;GUISetBkColor (0xE0FFFF) ;light blue
	;GUISetBkColor(0xbbFF00) ;green
	;GUISetBkColor(0x404040) ;grey
	GUISetBkColor($color_idle) ;yellow
	If $opt2 = "True" Then
		GUIRegisterMsg($WM_WINDOWPOSCHANGED, "Snap_To_Edges")
		$hide = GUICtrlCreateButton("<", 5, 8, 16, 68, $BS_CENTER)
	Else
		GUIRegisterMsg($WM_WINDOWPOSCHANGED, "")
		$hide = GUICtrlCreateButton("<", 500, 800, 16, 68, $BS_CENTER)
	EndIf
	GUICtrlSetColor($graphic_background, "0xFCF00F")

	If $opt2 = True Then

	EndIf



	GUICtrlCreateGroup("Coordinates", 25, 5, 75, 60)
	GUICtrlCreateLabel("X:", 40, 25, 50)
	GUICtrlCreateLabel("Y:", 40, 40, 50)
	$label_coordinate_x = GUICtrlCreateLabel($script_x, 60, 25, 30)
	$label_coordinate_y = GUICtrlCreateLabel($script_y, 60, 40, 30)

	$button_help = GUICtrlCreateButton("Help/Options", 520, 15, 75, 45)

	GUICtrlCreateGroup("Size", 110, 5, 102, 61)
	GUICtrlCreateLabel("Columns:", 118, 20)
	$input_size_columns = GUICtrlCreateInput($script_size_columns, 165, 18, 40, 20)
	$updown_size_columns = GUICtrlCreateUpdown($input_size_columns)
	GUICtrlSetLimit($updown_size_columns, 24, 1)
	GUICtrlCreateLabel("Rows:", 118, 42)
	$input_size_rows = GUICtrlCreateInput($script_size_rows, 165, 40, 40, 20)
	$updown_size_rows = GUICtrlCreateUpdown($input_size_rows)
	GUICtrlSetLimit($updown_size_rows, 24, 1)

	GUICtrlCreateGroup("Mouse Speed", 225, 5, 290, 61)
	$input_speed = GUICtrlCreateSlider(230, 25, 280, 20)
	GUICtrlSetLimit($input_speed, 1000, 0)
	GUICtrlSetData($input_speed, $script_speed)
	GUICtrlCreateLabel("Speed:", 340, 48, 100, 14)
	$amountlabel = GUICtrlCreateLabel(GUICtrlRead($input_speed), 380, 48, 100, 14)
	$btn_speed_max = GUICtrlCreateButton("Max Speed", 230, 46, 80, 18)
	GUICtrlSetBkColor($btn_speed_max, "0xFCF00F")

	$status = GUICtrlCreateLabel("Please set Home positon (<F4>)", 190, 70, 500, 13)

	GUICtrlSetBkColor($button_help, $color_btn)
	#cs
		;$window_help = GUICreate("Help", 200, 125, -1, -1, -1, 0, $Window_Main)
		$window_help = GUICreate("FVF Options+Help", 355, 357, -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE), $Window_Main)
		$help_group = GUICtrlCreateGroup("Help", 8, 8, 337, 145)
		$info1 = GUICtrlCreateLabel("<F1> - Run bot in 1x1 mode", 24, 32, 135, 17)
		$info2 = GUICtrlCreateLabel("<F2> - Run bot in 2x2 mode (tractor, seeder)", 24, 56, 212, 17)
		$info3 = GUICtrlCreateLabel("<F4> - Set starting position (Top left plot)", 24, 80, 194, 17)
		$info4 = GUICtrlCreateLabel("<F5> - Stop the bot", 24, 104, 95, 17)
		$author_info = GUICtrlCreateLabel("Created By: Patopop007", 216, 128, 120, 17)
		GUICtrlCreateGroup("", -99, -99, 1, 1)
		$options_group = GUICtrlCreateGroup("Options", 8, 152, 337, 201)
		$save = GUICtrlCreateButton("Save", 272, 328, 57, 17, $WS_GROUP)
		$cancel = GUICtrlCreateButton("Cancel", 216, 328, 49, 17, $WS_GROUP)
		$setting_1 = GUICtrlCreateCheckbox("Always on top", 24, 184, 97, 17)
		$setting_2 = GUICtrlCreateCheckbox("Snap to edges", 24, 208, 97, 17)
		$setting_3 = GUICtrlCreateCheckbox("Disable HotKeys when hidden ", 24, 232, 177, 17)
		$setting_4 = GUICtrlCreateCheckbox("Run on start-up", 24, 256, 97, 17)
		$website = GUICtrlCreateButton("FVF Website", 70, 328, 130, 17, $WS_GROUP)
		GUICtrlSetTip($website, "Visit the FV Friend website for updates, news and information")
		GUICtrlCreateGroup("", -99, -99, 1, 1)
	#ce
	#Region ### START Koda GUI section ### Form=c:\users\pato\documents\my dropbox\scripts\koda\fvf_help+options.kxf
	$window_help = GUICreate("FVF Options+Help", 355, 357, 375, 203, -1, BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE), $Window_Main)
	$Group1 = GUICtrlCreateGroup("Help", 8, 8, 337, 145)
	$info1 = GUICtrlCreateLabel("<F1> - Run bot in 1x1 mode", 24, 32, 135, 17)
	$info2 = GUICtrlCreateLabel("<F2> - Run bot in 2x2 mode (tractor, seeder)", 24, 56, 212, 17)
	$info3 = GUICtrlCreateLabel("<F4> - Set starting position (Top left plot)", 24, 80, 194, 17)
	$info4 = GUICtrlCreateLabel("<F5> - Stop the bot", 24, 104, 95, 17)
	$author_info = GUICtrlCreateLabel("Created By: Patopop007", 216, 128, 120, 17)
	GUICtrlSetCursor(-1, 3)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Options", 8, 152, 337, 201)
	$save = GUICtrlCreateButton("Save", 272, 328, 57, 17, $WS_GROUP)
	GUICtrlSetTip(-1, "Save changes and close the window")
	$cancel = GUICtrlCreateButton("Cancel", 216, 328, 49, 17, $WS_GROUP)
	GUICtrlSetTip(-1, "Cancel changes and close the window")
	$setting_1 = GUICtrlCreateCheckbox("Always on top", 24, 184, 97, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetTip(-1, "If enabled, FV Friend will always be visible over all other windows")
	$setting_2 = GUICtrlCreateCheckbox("Snap to edges", 24, 208, 97, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetTip(-1, "If enabled, FV Friend will snap to the screen edges (if disabled the hide option will be disabled)")
	$setting_3 = GUICtrlCreateCheckbox("Disable HotKeys when hidden ", 24, 232, 177, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetTip(-1, "If enabled, when FV Friend is hidden the hotkeys are removed")
	$setting_4 = GUICtrlCreateCheckbox("Run on start-up", 24, 256, 97, 17)
	GUICtrlSetTip(-1, "If enabled, FV Friend will run on system start-up")
	$Label1 = GUICtrlCreateLabel("Fine Tuning", 184, 168, 60, 17)
	GUICtrlSetTip(-1, "If the bot starts to skip plots or mess up you can fine tune the x and y amount to move the mose for every plot")
	GUICtrlSetCursor(-1, 4)
	$Label2 = GUICtrlCreateLabel("X-Amount", 208, 192, 50, 17)
	$Label3 = GUICtrlCreateLabel("Y-Amount", 208, 248, 50, 17)
	$website = GUICtrlCreateButton("FVF Website", 112, 327, 81, 17, $WS_GROUP)
	GUICtrlSetTip(-1, "Click to launch the FV Friend Website")
	$x_amount = GUICtrlCreateInput("20", 216, 216, 41, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
	GUICtrlSetLimit(-1, 3)
	$y_amount = GUICtrlCreateInput("9", 216, 272, 41, 21)
	GUICtrlSetLimit(-1, 3)
	$Label4 = GUICtrlCreateLabel("Check for updates:", 16, 328, 94, 17)
	$distance_calc = GUICtrlCreateButton("Distance Calc", 264, 168, 73, 17, $WS_GROUP)
	GUICtrlSetTip(-1, "Use this tool to calculate the distance in between to points")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	#EndRegion ### END Koda GUI section ###
	GUISetState(@SW_SHOW, $Window_Main)

EndFunc   ;==>_createGUI
;start of check
$Serial = RegRead("HKEY_CURRENT_USER\Software\p123n2Elf1isLF2vLPgth3\FVFrnd", "Name")
$SerialCheck = 'FVFrnd'
If $Serial = $SerialCheck Then
	_createGUI()
Else
	MsgBox(16, "FV Friend 2.2", "FV Friend has not been legally authorized on this computer" & @CRLF & "If you believe this is not the case, please contact me at: www.patopop007.com/contact-me.html")
EndIf

;Loop
While 1
	If $script_running Then
		$script_size_columns = GUICtrlRead($input_size_columns)
		$script_size_rows = GUICtrlRead($input_size_rows)
		$script_speed = GUICtrlRead($input_speed)
		farm()
		GUISetState(@SW_ENABLE, $Window_Main)
	EndIf


	$gui_msg = GUIGetMsg(1)

	Select
		Case $gui_msg[0] = $GUI_EVENT_CLOSE
			Switch $gui_msg[1]
				Case $Window_Main
					ExitLoop
				Case $ShowGUI
					ExitLoop
				Case $window_help
					GUISetState(@SW_HIDE, $window_help)
			EndSwitch
		Case $gui_msg[0] = $button_help
			GUISetState(@SW_SHOW, $window_help)
			GUISetBkColor($color_helpGUI) ;light blue
			_updatehelp()
		Case $gui_msg[0] = $input_speed
			GUICtrlSetData($amountlabel, (GUICtrlRead($input_speed)))
		Case $gui_msg[0] = $show
			Slide()
			_setHotKeys()
		Case $gui_msg[0] = $hide
			Slide()
			If $opt3 = True Then _removeHotKeys()
		Case $gui_msg[0] = $btn_speed_max
			GUICtrlSetData($input_speed, "0")
			GUICtrlSetData($amountlabel, (GUICtrlRead($input_speed)))
		Case $gui_msg[0] = $cancel
			GUISetState(@SW_HIDE, $window_help)
		Case $gui_msg[0] = $save
			_updatesettings()
		Case $gui_msg[0] = $website
			ShellExecute("http://www.patopop007.com/farm-ville-bot.html")
		Case $gui_msg[0] = $Label1
			_finehelp()
		Case $gui_msg[0] = $author_info
			ShellExecute("http://www.patopop007.com/")
		Case $gui_msg[0] = $distance_calc
			_distance_calculator()

	EndSelect


	Sleep(25)
WEnd

;Main Script
Func farm()
	$current_x = $script_x
	$current_y = $script_y
	IniWrite($inifile, "Info", "Columns", $script_size_columns)
	IniWrite($inifile, "Info", "Rows", $script_size_rows)
	IniWrite($inifile, "Info", "Speed", $script_speed)
	IniWrite($inifile, "Author", "By", "Patopop007")

	Switch $mode
		Case 1
			For $current_row = 1 To $script_size_rows Step 1
				For $current_column = 1 To $script_size_columns Step 1
					MouseClick("primary", $current_x, $current_y, 1, $script_speed)
					$current_x = $current_x + $x_value
					$current_y = $current_y - $y_value

					If Not $script_running Then ExitLoop
				Next
				; Reset to beginning of row
				$current_x = $current_x - ($x_value * $script_size_columns)
				$current_y = $current_y - ($y_value_negative * $script_size_columns)
				; Advance to the next row
				$current_x = $current_x + $x_value
				$current_y = $current_y + $y_value

				If Not $script_running Then ExitLoop
			Next
			stop_script()
		Case 2
			$I_Result = _MathCheckDiv($script_size_rows, 2) * _MathCheckDiv($script_size_columns, 2)
			$current_x = $script_x + $x_value
			$current_y = $script_y - $y_value_negative
			If $I_Result = 4 Then
				For $current_row = 1 To $script_size_rows Step 2
					For $current_column = 1 To $script_size_columns Step 2
						MouseClick("primary", $current_x, $current_y, 1, $script_speed)
						$current_x = $current_x + $x_value * 2
						$current_y = $current_y - $y_value * 2

						If Not $script_running Then ExitLoop
					Next
					; Reset to beginning of row
					$current_x = $current_x - ($x_value * $script_size_columns)
					$current_y = $current_y - ($y_value_negative * $script_size_columns)
					; Advance to the next row
					$current_x = $current_x + $x_value * 2
					$current_y = $current_y + $y_value * 2

					If Not $script_running Then ExitLoop
				Next
				stop_script()
			Else
				stop_script()
				MsgBox(16, 'FV Friend', 'Cannot have an odd number of rows or columns for the 2x2 mode')
			EndIf
		Case 3
			$current_x = $script_x + $x_value * 2
			$current_y = $script_y - $y_value_negative * 2
			For $current_row = 1 To $script_size_rows Step 3
				For $current_column = 1 To $script_size_columns Step 3
					MouseClick("primary", $current_x, $current_y, 1, $script_speed)
					$current_x = $current_x + $x_value * 3
					$current_y = $current_y - $y_value * 3

					If Not $script_running Then ExitLoop
				Next
				; Reset to beginning of row
				$current_x = $current_x - ($x_value * $script_size_columns)
				$current_y = $current_y - ($y_value_negative * $script_size_columns)
				; Advance to the next row
				$current_x = $current_x + $x_value
				$current_y = $current_y + $y_value * 3

				If Not $script_running Then ExitLoop
			Next
			stop_script()
	EndSwitch
EndFunc   ;==>farm

Func _update()
	$update_handle = InetGet("http://patoworld.net78.net/FVF/update.ini", @TempDir & "FVF_update.ini", 5, 0)
	$update = IniRead(@TempDir & "FVF_update.ini", "Update", "Required", "No")
	If $update = "yes" Then
		TrayTip("FVF Updater", "Update found! Now starting download...", 20)
		$updateurl = "http://patoworld.net78.net/FVF/check.update"
		InetGet($updateurl, @TempDir & "FVF_updater.exe", 1, 1)
		While InetGetInfo($update_handle, 2) = False;@InetGetActive
			TrayTip("Downloading FVF Update", "Bytes downloaded: " & InetGetInfo($update_handle, 0), 10, 16)
			Sleep(250)
		WEnd
		If InetGetInfo($update_handle, 4) = Not 0 Then
			MsgBox(16, "Update Failed", "An error occured. The download failed. " & @CRLF & "Please make sure you are still connected to the internet.")
		Else
			MsgBox(64, "FVF Update Download Complete", "Total Bytes Downloaded: " & InetGetInfo($update_handle, 0))
			Run(@TempDir & "FVF_updater.exe")
		EndIf
	Else
		MsgBox(64, "FVF", "No update required, your software is up-to date!")
	EndIf
EndFunc   ;==>_update
