Scriptname dcc_sgo_QuestMenu extends SKI_ConfigBase
dcc_sgo_QuestController Property Furious Auto

;/*****************************************************************************
  _______             __                          _______                      
 |   _   .-----.--.--|  .-----.-----.--------.   |   _   .--.--.-----.-----.   
 |   1___|  _  |  |  |  |  _  |  -__|        |   |.  |   |  |  |  -__|     |   
 |____   |_____|_____|__|___  |_____|__|__|__|   |.  |   |\___/|_____|__|__|   
 |:  1   |              |_____|                  |:  1   |                     
 |::.. . |                                       |::.. . |                     
 `-------'                                       `-------'                     
  __   __              _______ __    __         __     ___ ___ _______ ___ ___ 
 |  |_|  |--.-----.   |       |  |--|__.----.--|  |   |   Y   |   _   |   Y   |
 |   _|     |  -__|   |.|   | |     |  |   _|  _  |   |.      |.  1___|.      |
 |____|__|__|_____|   `-|.  |-|__|__|__|__| |_____|   |. \_/  |.  |___|. \_/  |
                        |:  |                         |:  |   |:  1   |:  |   |
                        |::.|                         |::.|:. |::.. . |::.|:. |
                        `---'                         `--- ---`-------`--- ---'
                                                                               
*****************************************************************************/;

Int Function GetVersion()
	Return 1
EndFunction

Event OnGameReload()
{things to do when the game is loaded from disk.}

	parent.OnGameReload()

	;; ...

	Return
EndEvent

Event OnConfigInit()
{things to do when the menu initalises (is opening)}

	self.Pages = new String[6]
	
	self.Pages[0] = "General"
	;; info, enable/disable, uninstall.

	self.Pages[1] = "Pregnancy"
	;; fertility, filled, capacities, days

	self.Pages[2] = "Body Scales"
	;; min max scales, curves,

	self.Pages[3] = "Immersion"
	;; buffs/debuffs, texts

	self.Pages[4] = "Animations"
	;; birthing & milking animation selection

	self.Pages[5] = "Debug & Repair"
	;; debug msgs, reset.

	Return
EndEvent

Event OnConfigOpen()
{things to do when the menu actually opens.}

	self.OnConfigInit()
	Return
EndEvent

Event OnConfigClose()
{things to do when the menu closes.}

	Return
EndEvent

Event OnPageReset(string page)
{when a different tab is selected in the menu.}

	self.UnloadCustomContent()

	If(Page == "General")
		self.ShowPageGeneral()
	ElseIf(Page == "Pregnancy")
	ElseIf(Page == "Body Scales")
	ElseIf(Page == "Immersion")
	ElseIf(Page == "Animations")
	ElseIf(Page == "Debug & Repair")
	Else
		self.ShowPageIntro()
	EndIf

	Return
EndEvent

;/*****************************************************************************
  _______ __               __    __                
 |   _   |  |--.-----.----|  |--|  |--.-----.--.--.
 |.  1___|     |  -__|  __|    <|  _  |  _  |_   _|
 |.  |___|__|__|_____|____|__|__|_____|_____|__.__|
 |:  1   |    _______       __            __       
 |::.. . |   |   _   .-----|  .-----.----|  |_     
 `-------'   |   1___|  -__|  |  -__|  __|   _|    
             |____   |_____|__|_____|____|____|    
             |:  1   |                             
             |::.. . |                             
             `-------'                             
*****************************************************************************/;

Event OnOptionSelect(Int Item)
	Bool Val = FALSE

	;; ...

	self.SetToggleOptionValue(Item,Val)
	Return
EndEvent

;/*****************************************************************************
  _______ __ __    __                   
 |   _   |  |__.--|  .-----.----.       
 |   1___|  |  |  _  |  -__|   _|       
 |____   |__|__|_____|_____|__|         
 |:  1   |    _______                   
 |::.. . |   |   _   .-----.-----.-----.
 `-------'   |.  |   |  _  |  -__|     |
             |.  |   |   __|_____|__|__|
             |:  1   |__|               
             |::.. . |                  
             `-------'                  
*****************************************************************************/;

Event OnOptionSliderOpen(Int Item)
	Float Val = 0.0
	Float Min = 0.0
	Float Max = 0.0
	Float Interval = 0.0

	;; ...

	SetSliderDialogStartValue(Val)
	SetSliderDialogRange(Min,Max)
	SetSliderDialogInterval(Interval)
	Return
EndEvent

;/*****************************************************************************
  _______ __ __    __                            
 |   _   |  |__.--|  .-----.----.                
 |   1___|  |  |  _  |  -__|   _|                
 |____   |__|__|_____|_____|__|                  
 |:  1   |    _______                       __   
 |::.. . |   |   _   .----.----.-----.-----|  |_ 
 `-------'   |.  1   |  __|  __|  -__|  _  |   _|
             |.  _   |____|____|_____|   __|____|
             |:  |   |               |__|        
             |::.|:. |                           
             `--- ---'                           
*****************************************************************************/;

Event OnOptionSliderAccept(Int Item, Float Val)
	String Fmt = "{0}"

	;; ...

	SetSliderOptionValue(Item,Val,Fmt)
	Return
EndEvent

;/*****************************************************************************
  _______             __ __   __             
 |       .-----.-----|  |  |_|__.-----.-----.
 |.|   | |  _  |  _  |  |   _|  |  _  |__ --|
 `-|.  |-|_____|_____|__|____|__|   __|_____|
   |:  |                        |__|         
   |::.|                                     
   `---'                                     
*****************************************************************************/;

Event OnOptionHighlight(Int Item)

	self.SetInfoText("Soulgem Oven The Third")

	Return
EndEvent

;/*****************************************************************************
*****************************************************************************/;

Function ShowPageIntro()
	LoadCustomContent("dcc-soulgem-oven/splash.dds")
	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Function ShowPageGeneral()

	Return
EndFunction

