#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\ICONS\cool.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_File_Add=bot.exe
#AutoIt3Wrapper_Res_File_Add=read
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;#AutoIt3Wrapper_Res_File_Add=bot(x64).exe

$USERQUICKLAUNCHPATH = "L:\Documents and Settings\Asw\Application Data\Microsoft\Internet Explorer\Quick Launch"

	ProgressOn("FV Friend - Farm Ville Bot 2.2", "Installing FV Friend - Farm Ville Bot 2.2", "Created by: Patopop007")
	ProgressSet(10)
	Sleep(350)
	ProgressSet(20)
	Sleep(350)
	ProgressSet(30)
	Sleep(350)
	ProgressSet(40)
	Sleep(350)
	ProgressSet(50)
	Sleep(350)
	ProgressSet(60)
	Sleep(350)
	ProgressSet(70)
	Sleep(350)
	ProgressSet(80)
	Sleep(350)
	ProgressSet(90)
	Sleep(350)
	ProgressSet(99)
	Sleep(350)
	$NAME = "FVFrnd"
	RegWrite("HKEY_CURRENT_USER\Software\p123n2Elf1isLF2vLPgth3\FVFrnd", "Name", "REG_SZ", $NAME)
	DirCreate("C:\FV Friend\")
	FileDelete("C:\FV Friend\FV Friend - Farm Ville Bot.exe")
	FileDelete("C:\FV Friend\FV Friend - Farm Ville Bot(x64).exe")
	FileDelete("C:\FV Friend\README.txt")
	FileInstall("bot.exe", "C:\FV Friend\FV Friend - Farm Ville Bot.exe")
	;FileInstall("bot(x64).exe", "C:\FV Friend\FV Friend - Farm Ville Bot(x64).exe")
	FileInstall("read", "C:\FV Friend\README.txt")
	FileCreateShortcut("C:\FV Friend\FV Friend - Farm Ville Bot.exe", @DesktopDir & "\FV Friend - Farm Ville Bot.lnk")
	;FileCreateShortcut("C:\FV Friend\FV Friend - Farm Ville Bot(x64).exe", @DesktopDir & "\FV Friend - Farm Ville Bot(x64).lnk")
	FileCreateShortcut("C:\FV Friend\FV Friend - Farm Ville Bot.exe", $USERQUICKLAUNCHPATH & "\FV Friend - Farm Ville Bot.lnk")

	#Region --- CodeWizard generated code Start ---
	;MsgBox features: Title=Yes, Text=Yes, Buttons=Yes and No, Icon=Info, Miscellaneous=Top-most attribute
	If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
	$iMsgBoxAnswer = MsgBox(262212, "FV Friend - Farm Ville Bot 2.2", "The installation was succesfully completed! You can now start using the FV Friend! " & @CRLF & "A shortcut has been placed on your desktop for your convenience directing you straight to your bot!" & @CRLF & @CRLF & "Would you like to open the Readme file with instructions on how to use the bot?")
	Select
		Case $iMsgBoxAnswer = 6 ;Yes
			Run("notepad.exe C:\FV Friend\readme.txt")
			Run("C:\FV Friend\FV Friend - Farm Ville Bot.exe")
		Case $iMsgBoxAnswer = 7 ;No
			Run("C:\FV Friend\FV Friend - Farm Ville Bot.exe")
	EndSelect
	#EndRegion --- CodeWizard generated code Start ---

	;self destruct
	Local $CMDFILE
	FileDelete(@TempDir & "\scratch.cmd")
	$CMDFILE = ":loop" & @CRLF & 'del "' & @ScriptFullPath & '"' & @CRLF & 'if exist "' & @ScriptFullPath & '" goto loop' & @CRLF & "del " & @TempDir & "\scratch.cmd"
	FileWrite(@TempDir & "\scratch.cmd", $CMDFILE)
	Run(@TempDir & "\scratch.cmd", @TempDir, @SW_HIDE)
