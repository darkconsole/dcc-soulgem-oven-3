Scriptname dcc_sgo_QuestMenu extends SKI_ConfigBase

dcc_sgo_QuestController Property SGO Auto

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
		self.ShowPagePregnancy()
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

	If(Item == ItemEnabled)
		SGO.Enabled = FALSE
	ElseIf(Item == ItemUninstall)
		;; perform uninstall operation.
	ElseIf(Item == ItemGemFilled)
		Val = !SGO.OptGemFilled
		SGO.OptGemFilled = Val
	ElseIf(Item == ItemFertility)
		Val = !SGO.OptFertility
		SGO.OptFertility = Val
	EndIf

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

	If(Item == ItemGemMaxCapacity)
		Val = SGO.OptGemMaxCapacity
		Min = 1.0
		Max = 12.0
		Interval = 1.0
	ElseIf(Item == ItemGemMatureTime)
		Val = SGO.OptGemMatureTime
		Min = 1.0
		Max = 24.0
		Interval = 0.25
	ElseIf(Item == ItemMilkMaxCapacity)
		Val = SGO.OptMilkMaxCapacity
		Min = 1.0
		Max = 9.0
		Interval = 1.0
	ElseIf(Item == ItemMilkProduceTime)
		Val = SGO.OptMilkProduceTime
		Min = 1.0
		Max = 24.0
		Interval = 0.25
	ElseIf(Item == ItemSemenMaxCapacity)
		Val = SGO.OptSemenMaxCapacity
		Min = 1.0
		Max = 6.0
		Interval = 1.0
	ElseIf(Item == ItemSemenProduceTime)
		Val = SGO.OptSemenProduceTime
		Min = 1.0
		Max = 24.0
		Interval = 0.25
	ElseIf(Item == ItemPregChanceHumanoid)
		Val = SGO.OptPregChanceHumanoid
		Min = 0.0
		Max = 100.0
		Interval = 1.0
	ElseIf(Item == ItemPregChanceBeast)
		Val = SGO.OptPregChanceBeast
		Min = 0.0
		Max = 100.0
		Interval = 1.0
	ElseIf(Item == ItemFertilityDays)
		Val = SGO.OptFertilityDays
		Min = 7.0
		Max = 60.0
		Interval = 1.0
	ElseIf(Item == ItemFertilityWindow)
		Val = SGO.OptFertilityWindow
		Min = 1.0
		Max = 4.0
		Interval = 0.25
	EndIf

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

	If(Item == ItemGemMaxCapacity)
		SGO.OptGemMaxCapacity = Val as Int
		Fmt = "{0} Gems"
	ElseIf(Item == ItemGemMatureTime)
		SGO.OptGemMatureTime = (Val * 24)
		Fmt = "{2} Days"
	ElseIf(Item == ItemMilkMaxCapacity)
		SGO.OptMilkMaxCapacity = Val as Int
		Fmt = "{0} Bottles"
	ElseIf(Item == ItemMilkProduceTime)
		SGO.OptMilkProduceTime = Val
		Fmt = "{2} Hours"
	ElseIf(Item == ItemSemenMaxCapacity)
		SGO.OptSemenMaxCapacity = Val as Int
		Fmt = "{0} Bottles"
	ElseIf(Item == ItemSemenProduceTime)
		SGO.OptSemenProduceTime = Val
		Fmt = "{2} Hours"
	ElseIf(Item == ItemPregChanceHumanoid)
		SGO.OptPregChanceHumanoid = Val as Int
		Fmt = "{0}%"
	ElseIf(Item == ItemPregChanceBeast)
		SGO.OptPregChanceBeast = Val as Int
		Fmt = "{0}%"
	ElseIf(Item == ItemFertilityDays)
		SGO.OptFertilityDays = Val as Int
		Fmt = "{0} Days"
	ElseIf(Item == ItemFertilityWindow)
		SGO.OptFertilityWindow = Val
		Fmt = "{2}x"
	EndIf

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

	If(Item == ItemGemMaxCapacity)
		self.SetInfoText("Maximum number of gems that can be incubated at one time.")
	ElseIf(Item == ItemGemMatureTime)
		self.SetInfoText("How long it takes for 1 gem to go from nothing to black (in days).")
	Elseif(Item == ItemGemFilled)
		self.SetInfoText("If enabled will birth filled gems. Disabled will birth empty gems.")
	ElseIf(Item == ItemMilkMaxCapacity)
		self.SetInfoText("Maximum bottles of milk that can be carried before unable to produce more.")
	ElseIf(Item == ItemMilkProduceTime)
		self.SetInfoText("How long it takes to produce 1 bottle of milk (in hours).")
	Elseif(Item == ItemSemenMaxCapacity)
		self.SetInfoText("Maximum bottles of semen that can be carried before unable to produce more.")
	ElseIf(Item == ItemSemenProduceTime)
		self.SetInfoText("How long it takes to produce 1 bottle of semen (in hours).")
	ElseIf(Item == ItemPregChanceHumanoid)
		self.SetInfoText("Chances of becoming pregnant when engaging another humanoid.")
	ElseIf(Item == ItemPregChanceBeast)
		self.SetInfoText("Chances of becoming pregnant when engaging an animal or creature.")
	ElseIf(Item == ItemFertility)
		self.SetInfoText("Simulate a fertility cycle that modifies the pregnancy chances on a day-to-day basis.")
	ElseIf(Item == ItemFertilityDays)
		self.SetInfoText("How many days for a full fertility cycle (one revolution from barely fertile, to super fertile, and back again).")
	ElseIf(Item == ItemFertilityWindow)
		self.SetInfoText("How much to modify the pregnancy chances. A value of 2.0 means at max fertility, your chances of getting pregnant are double of what is set.")
	EndIf

	self.SetInfoText("Soulgem Oven: The Third")

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

Int ItemEnabled
Int ItemUninstall

Function ShowPageGeneral()
	self.SetTitleText("General Settings")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	self.AddHeaderOption("Mod Control")
		self.AddHeaderOption("")
	ItemEnabled = self.AddToggleOption("Mod Enabled",SGO.Enabled)
		ItemUninstall = self.AddToggleOption("Uninstall Mod",FALSE,OPTION_FLAG_DISABLED)

	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Int ItemPregChanceHumanoid
Int ItemPregChanceBeast
Int ItemGemMaxCapacity
Int ItemGemMatureTime
Int ItemGemFilled
Int ItemMilkMaxCapacity
Int ItemMilkProduceTime
Int ItemSemenMaxCapacity
Int ItemSemenProduceTime
Int ItemFertility
Int ItemFertilityDays
Int ItemFertilityWindow

Function ShowPagePregnancy()
	self.SetTitleText("Pregnancy Options")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	self.AddHeaderOption("Chances")
		self.AddHeaderOption("(o.O)?")
	ItemPregChanceHumanoid = self.AddSliderOption("Preg Chance w/ Humanoid",SGO.OptPregChanceHumanoid,"{0}%")
		ItemPregChanceBeast = self.AddSliderOption("Preg Chance w/ Beast",SGO.OptPregChanceBeast,"{0}%")

	self.AddheaderOption("Fertility")
		self.AddheaderOption("(;¬_¬)")
	ItemFertility = self.AddToggleOption("Enable Fertility Multiplier",SGO.OptFertility)
		ItemFertilityDays = self.AddSliderOption("Cycle Length",SGO.OptFertilityDays,"{0} Days")
	ItemFertilityWindow = self.AddSliderOption("Multiplier",SGO.OptFertilityWindow,"{2}x")
		self.AddEmptyOption()

	self.AddHeaderOption("Gem Options")
		self.AddHeaderOption("<===>")
	ItemGemMaxCapacity = self.AddSliderOption("Gem Max Capacity",SGO.OptGemMaxCapacity,"{0} Gems")
		ItemGemMatureTime = self.AddSliderOption("Gem Mature Time",(SGO.OptGemMatureTime / 24),"{2} Days")
	ItemGemFilled = self.AddToggleOption("Birth Filled Gems",SGO.OptGemFilled)
		self.AddEmptyOption()

	self.AddHeaderOption("Milk Options")
		self.AddHeaderOption("(. )( .)")
	ItemMilkMaxCapacity = self.AddSliderOption("Milk Max Capacity",SGO.OptMilkMaxCapacity,"{0} Bottles")
		ItemGemMatureTime = self.AddSliderOption("Milk Produce Time",SGO.OptMilkProduceTime,"{0} Hours")

	self.AddHeaderOption("Semen Options")
		self.AddHeaderOption("8==D~~")
	ItemSemenMaxCapacity = self.AddSliderOption("Semen Max Capacity",SGO.OptSemenMaxCapacity,"{0} Bottles")
		ItemSemenProduceTime = self.AddSliderOption("Semen Produce Time",SGO.OptSemenProduceTime,"{0} Hours")


	Return
EndFunction

