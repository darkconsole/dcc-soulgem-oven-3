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
		self.ShowPageScales()
	ElseIf(Page == "Immersion")
		self.ShowPageImmersion()
	ElseIf(Page == "Animations")
		self.ShowPageAnimations()
	ElseIf(Page == "Debug & Repair")
		self.ShowPageDebug()
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
		Val = !SGO.Enabled
		SGO.Enabled = Val
	ElseIf(Item == ItemUninstall)
		;; perform uninstall operation.
	ElseIf(Item == ItemGemFilled)
		Val = !SGO.OptGemFilled
		SGO.OptGemFilled = Val
	ElseIf(Item == ItemFertility)
		Val = !SGO.OptFertility
		SGO.OptFertility = Val
	ElseIf(Item == ItemImmersivePlayer)
		Val = !SGO.OptImmersivePlayer
		SGO.OptImmersivePlayer = Val
	ElseIf(Item == ItemImmersiveNPC)
		Val = !SGO.OptImmersiveNPC
		SGO.OptImmersiveNPC = Val
	ElseIf(Item == ItemEffectBreastInfluence)
		Val = !SGO.OptEffectBreastInfluence
		SGO.OptEffectBreastInfluence = Val
	ElseIf(Item == ItemEffectBellyEncumber)
		Val = !SGO.OptEffectBellyEncumber
		SGO.OptEffectBellyEncumber = Val
	ElseIf(Item == ItemCumInflation)
		Val = !SGO.OptCumInflation
		SGO.OptCumInflation = Val
	ElseIf(Item == ItemCumInflationHold)
		Val = !SGO.OptCumInflationHold
		SGO.OptCumInflationHold = Val
	ElseIf(Item == ItemDebug)
		Val = !SGO.OptDebug
		SGO.OptDebug = Val
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
		Val = SGO.OptGemMatureTime / 24
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
	ElseIf(Item == ItemScaleBellyMax)
		Val = SGO.OptScaleBellyMax
		Min = 1.0
		Max = 10.0
		Interval = 0.05
	ElseIf(Item == ItemScaleBellyCurve)
		Val = SGO.OptScaleBellyCurve
		Min = 0.5
		Max = 2.0
		Interval = 0.05
	ElseIf(Item == ItemScaleBreastMax)
		Val = SGO.OptScaleBreastMax
		Min = 1.0
		Max = 10.0
		Interval = 0.05
	ElseIf(Item == ItemScaleBreastCurve)
		Val = SGO.OptScaleBreastCurve
		Min = 0.5
		Max = 2.0
		Interval = 0.05
	ElseIf(Item == ItemScaleTesticleMax)
		Val = SGO.OptScaleTesticleMax
		Min = 1.0
		Max = 10.0
		Interval = 0.05
	ElseIf(Item == ItemScaleTesticleCurve)
		Val = SGO.OptScaleTesticleCurve
		Min = 0.5
		Max = 2.0
		Interval = 0.05
	ElseIf(Item == ItemProgressAlchFactor)
		Val = SGO.OptProgressAlchFactor
		Min = 0.0
		Max = 4.0
		Interval = 0.01
	ElseIf(Item == ItemProgressEnchFactor)
		Val = SGO.OptProgressEnchFactor
		Min = 0.0
		Max = 4.0
		Interval = 0.01
	ElseIf(Item == ItemAnimationBirthing)
		Val = SGO.OptAnimationBirthing
		Min = -1.0
		Max = 8.0
		Interval = 1.0
	Elseif(Item == ItemUpdateInterval)
		Val = SGO.OptUpdateInterval
		Min = 5.0
		Max = 128.0
		Interval = 1.0
	ElseIf(Item == ItemUpdateDelay)
		Val = SGO.OptUpdateDelay
		Min = 0.0
		Max = 2.0
		Interval = 0.005
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
	ElseIf(Item == ItemScaleBellyMax)
		SGO.OptScaleBellyMax = Val
		Fmt = "{2}"
	ElseIf(Item == ItemScaleBellyCurve)
		SGO.OptScaleBellyCurve = Val
		Fmt = "{2}"
	ElseIf(Item == ItemScaleBreastMax)
		SGO.OptScaleBreastMax = Val
		Fmt = "{2}"
	ElseIf(Item == ItemScaleBreastCurve)
		SGO.OptScaleBreastCurve = Val
		Fmt = "{2}"
	ElseIf(Item == ItemScaleTesticleMax)
		SGO.OptScaleTesticleMax = Val
		Fmt = "{2}"
	ElseIf(Item == ItemScaleTesticleCurve)
		SGO.OptScaleTesticleCurve = Val
		Fmt = "{2}"
	ElseIf(Item == ItemProgressAlchFactor)
		SGO.OptProgressAlchFactor = Val
		Fmt = "{2}x"
	ElseIf(Item == ItemProgressEnchFactor)
		SGO.OptProgressEnchFactor = Val
		Fmt = "{2}x"
	ElseIf(Item == ItemAnimationBirthing)
		SGO.OptAnimationBirthing = Val as Int
		Fmt = "{0}"
	ElseIf(Item == ItemUpdateInterval)
		SGO.OptUpdateInterval = Val
		Fmt = "{2}s"
	ElseIf(Item == ItemUpdateDelay)
		SGO.OptUpdateDelay = Val
		Fmt = "{3}s"
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

	;; ShowPagePregnancy()
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

	;; ShowPageScales()
	ElseIf(Item == ItemScaleBellyMax)
		self.SetInfoText("How big to make the belly at max pregnant.")
	ElseIf(Item == ItemScaleBellyCurve)
		self.SetInfoText("[Advanced] Value that modifies the math to simulate volume at higher scales.")
	ElseIf(Item == ItemScaleBreastMax)
		self.SetInfoText("How big to make the breasts at max milk.")
	ElseIf(Item == ItemScaleBreastCurve)
		self.SetInfoText("[Advanced] Value that modifies the math to simulate volume at higher scales.")
	ElseIf(Item == ItemScaleTesticleMax)
		self.SetInfoText("How big to make the testicles at max semen.")
	ElseIf(Item == ItemScaleTesticleCurve)
		self.SetInfoText("[Advanced] Value that modifies the math to simulate volume at higher scales.")

	;; ShowPageImmersion()
	ElseIf(Item == ItemImmersivePlayer)
		self.SetInfoText("Display witty little messages about the player when relevant.")
	ElseIf(Item == ItemImmersiveNPC)
		self.SetInfoText("Display witty little messages about other NPCs when relevant.")
	ElseIf(Item == ItemEffectBreastInfluence)
		self.SetInfoText("The more milk your breasts contain, the better prices you get buying and selling shit.")
	ElseIf(Item == ItemEffectBellyEncumber)
		self.SetInfoText("The more mature the gems in your belly, the slower you move.")
	ElseIf(Item == ItemCumInflation)
		self.SetInfoText("You will expand a little bit and squirt cum out slowly after sexy times.")
	ElseIf(Item == ItemCumInflationHold)
		self.SetInfoText("Instead of slowly leaking, you will hold all the cum in until you use the squirt lesser power.")
	ElseIf(Item == ItemProgressAlchFactor)
		self.SetInfoText("Level alchemy when milking. Set to 0 to disable. Set to 1 for normal rate.")
	ElseIf(Item == ItemProgressEnchFactor)
		self.SetInfoText("Level enchanting with birthing gems. Set to 0 to disable. Set to 1 for normal rate.")

	;; ShowPageAnimations()
	ElseIf(Item == ItemAnimationBirthing)
		self.SetInfoText("-1 = random each gem, 0 = random each set, 1-8 select specific animations.")

	;; ShowPageDebug()
	ElseIf(Item == ItemDebug)
		self.SetInfoText("Turn on/off debugging messages.")
	ElseIf(Item == ItemUpdateInterval)
		self.SetInfoText("Time between checking the tracked actors for update.")
	ElseIf(Item == ItemUpdateDelay)
		self.SetInfoText("Time between updating each actor.")

	;; bbq.
	Else
		self.SetInfoText("Soulgem Oven: The Third")
	EndIf

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
		self.AddHeaderOption("")
	ItemPregChanceHumanoid = self.AddSliderOption("Preg Chance w/ Humanoid",SGO.OptPregChanceHumanoid,"{0}%")
		ItemPregChanceBeast = self.AddSliderOption("Preg Chance w/ Beast",SGO.OptPregChanceBeast,"{0}%")

	self.AddHeaderOption("Fertility")
		self.AddHeaderOption("")
	ItemFertility = self.AddToggleOption("Enable Fertility Multiplier",SGO.OptFertility)
		ItemFertilityDays = self.AddSliderOption("Cycle Length",SGO.OptFertilityDays,"{0} Days")
	ItemFertilityWindow = self.AddSliderOption("Multiplier",SGO.OptFertilityWindow,"{2}x")
		self.AddEmptyOption()

	self.AddHeaderOption("Gem Options")
		self.AddHeaderOption("")
	ItemGemMaxCapacity = self.AddSliderOption("Gem Max Capacity",SGO.OptGemMaxCapacity,"{0} Gems")
		ItemGemMatureTime = self.AddSliderOption("Gem Mature Time",(SGO.OptGemMatureTime / 24),"{2} Days")
	ItemGemFilled = self.AddToggleOption("Birth Filled Gems",SGO.OptGemFilled)
		self.AddEmptyOption()

	self.AddHeaderOption("Milk Options")
		self.AddHeaderOption("")
	ItemMilkMaxCapacity = self.AddSliderOption("Milk Max Capacity",SGO.OptMilkMaxCapacity,"{0} Bottles")
		ItemMilkProduceTime = self.AddSliderOption("Milk Produce Time",SGO.OptMilkProduceTime,"{0} Hours")

	self.AddHeaderOption("Semen Options")
		self.AddHeaderOption("")
	ItemSemenMaxCapacity = self.AddSliderOption("Semen Max Capacity",SGO.OptSemenMaxCapacity,"{0} Bottles")
		ItemSemenProduceTime = self.AddSliderOption("Semen Produce Time",SGO.OptSemenProduceTime,"{0} Hours")


	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Int ItemScaleBellyCurve
Int ItemScaleBellyMax
Int ItemScaleBreastCurve
Int ItemScaleBreastMax
Int ItemScaleTesticleCurve
Int ItemScaleTesticleMax

Function ShowPageScales()
	self.SetTitleText("Body Scale Options")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	self.AddHeaderOption("Belly")
		self.AddHeaderOption("")
	ItemScaleBellyMax = self.AddSliderOption("Belly Max",SGO.OptScaleBellyMax,"{2}")
		ItemScaleBellyCurve = self.AddSliderOption("Belly Curve",SGO.OptScaleBellyCurve,"{2}")

	self.AddHeaderOption("Breasts")
		self.AddHeaderOption("")
	ItemScaleBreastMax = self.AddSliderOption("Breast Max",SGO.OptScaleBreastMax,"{2}")
		ItemScaleBreastCurve = self.AddSliderOption("Breast Curve",SGO.OptScaleBreastCurve,"{2}")

	self.AddHeaderOption("Testicles")
		self.AddHeaderOption("")
	ItemScaleTesticleMax = self.AddSliderOption("Testicle Max",SGO.OptScaleTesticleMax,"{2}")
		ItemScaleTesticleCurve = self.AddSliderOption("Testicle Curve",SGO.OptScaleTesticleCurve,"{2}")

	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Int ItemImmersivePlayer
Int ItemImmersiveNPC
Int ItemEffectBreastInfluence
Int ItemEffectBellyEncumber
Int ItemCumInflation
Int ItemCumInflationHold
Int ItemProgressAlchFactor
Int ItemProgressEnchFactor

Function ShowPageImmersion()
	self.SetTitleText("IMMERSIVE++")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	self.AddHeaderOption("Game Messages")
		self.AddHeaderOption("#")
	ItemImmersivePlayer = self.AddToggleOption("For Player",SGO.OptImmersivePlayer)
		ItemImmersiveNPC = self.AddToggleOption("For NPCs",SGO.OptImmersiveNPC)

	self.AddHeaderOption("Buffs / Debuffs")
		self.AddHeaderOption("")
	ItemEffectBreastInfluence = self.AddToggleOption("Breast Influence",SGO.OptEffectBreastInfluence)
		ItemEffectBellyEncumber = self.AddToggleOption("Belly Encumberment",SGO.OptEffectBellyEncumber)

	self.AddHeaderOption("Cum Inflation")
		self.AddHeaderOption("")
	ItemCumInflation = self.AddToggleOption("Enable",SGO.OptCumInflation)
		ItemCumInflationHold = self.AddToggleOption("Hold In",SGO.OptCumInflationHold)

	self.AddHeaderOption("Skill Leveling")
		self.AddHeaderOption("")
	ItemProgressAlchFactor = self.AddSliderOption("Alchemy Leveling",SGO.OptProgressAlchFactor,"{2}x")
		ItemProgressEnchFactor = self.AddSliderOption("Enchanting Leveling",SGO.OptProgressEnchFactor,"{2}x")

	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Int ItemAnimationBirthing

Function ShowPageAnimations()
	self.SetTitleText("Animation Options")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	ItemAnimationBirthing = self.AddSliderOption("Birthing Animation",SGO.OptAnimationBirthing,"{0}")

	Return
EndFunction

;/*****************************************************************************
*****************************************************************************/;

Int ItemDebug
Int ItemUpdateInterval
Int ItemUpdateDelay

Function ShowPageDebug()
	self.SetTitleText("Debugging")
	self.SetCursorFillMode(LEFT_TO_RIGHT)
	self.SetCursorPosition(0)

	self.AddHeaderOption("Performance")
		self.AddHeaderOption("")
	ItemUpdateInterval = self.AddSliderOption("Update Interval",SGO.OptUpdateInterval,"{2}s")
		ItemUpdateDelay = self.AddSliderOption("Update Delay",SGO.OptUpdateDelay,"{3}s")

	self.AddHeaderOption("Debugging")
		self.AddHeaderOption("")
	ItemDebug = self.AddToggleOption("Debugging Messages",SGO.OptDebug)
		self.AddEmptyOption()

	Return
EndFunction
