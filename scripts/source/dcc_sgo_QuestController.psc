Scriptname dcc_sgo_QuestController extends Quest
{The main API controlpoint for Soulgem Oven 3.}

;/*****************************************************************************
  _______             __                          _______                   
 |   _   .-----.--.--|  .-----.-----.--------.   |   _   .--.--.-----.-----.
 |   1___|  _  |  |  |  |  _  |  -__|        |   |.  |   |  |  |  -__|     |
 |____   |_____|_____|__|___  |_____|__|__|__|   |.  |   |\___/|_____|__|__|
 |:  1   |              |_____|                  |:  1   |                  
 |::.. . |                                       |::.. . |                  
 `-------'                                       `-------'                  
     __   __              _______ __    __         __                       
    |  |_|  |--.-----.   |       |  |--|__.----.--|  |                      
    |   _|     |  -__|   |.|   | |     |  |   _|  _  |                      
    |____|__|__|_____|   `-|.  |-|__|__|__|__| |_____|                      
                           |:  |                                            
                           |::.|                                            
                           `---'                                            

*****************************************************************************/;

;; >
;; THERE ARE ONLY 6 SOULGEM
;; MODELS.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Global) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FormList SGO.ActorList.Gem - list all actors currently growing gems.
;; FormList SGO.ActorList.Milk - list all actors currently producing milk.
;; FormList SGO.ActorList.Semen - list all the actors producing semen.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Actor) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Float    SGO.Actor.Time.Gem - the last time actor's gem data updated.
;; Float    SGO.Actor.Time.Milk - the last time actor's milk data updated.
;; Float    SGO.Actor.Time.Semen - the last time actor semen data was updated.
;; Float    SGO.Actor.Time.Fertility - the last time actor's fertility updated.
;; Float[]  SGO.Actor.Data.Gem - the gem data for this actor.
;; Float    SGO.Actor.Data.Milk - the milk data for this actor.
;; Float    SGO.Actor.Data.Semen - the semen data for this actor.
;; Float    SGO.Actor.Data.Fertility - the fertility data for this actor.
;; String[] SGO.Actor.Mod.ScaleBelly
;; String[] SGO.Actor.Mod.ScaleBellyMax
;; String[] SGO.Actor.Mod.ScaleBreast
;; String[] SGO.Actor.Mod.ScaleBreastMax
;; String[] SGO.Actor.Mod.ScaleTesticle
;; String[] SGO.Actor.Mod.ScaleTesticleMax
;; String[] SGO.Actor.Mod.GemCapacity (multiply %)
;; String[] SGO.Actor.Mod.GemRate (multiply %)
;; String[] SGO.Actor.Mod.MilkCapacity (multiply %)
;; String[] SGO.Actor.Mod.MilkRate (multiply %)
;; String[] SGO.Actor.Mod.MilkProduce (install 1 to force without preg)
;; String[] SGO.Actor.Mod.SemenCapacity (multiply %)
;; String[] SGO.Actor.Mod.SemenRate (multiply %)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Method List ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; these are the methods which have been designed to be used by mods that wish
;; to integrate with soulgem oven.

;; Int   SGO.ActorGemGetCapacity(Actor Who)
;; Float SGO.ActorGemGetTime(Actor Who)
;; Float SGO.ActorGemGetWeight(Actor Who)
;; Int   SGO.ActorMilkGetCapacity(Actor Who)
;; Float SGO.ActorMilkGetTime(Actor Who)
;; Float SGO.ActorMilkGetWeight(Actor Who)
;; Int   SGO.ActorSemenGetCapacity(Actor Who)
;; Float SGO.ActorSemenGetTime(Actor Who)
;; Float SGO.ActorSemenGetWeight(Actor Who)

;; Float SGO.ActorGetTimeSinceUpdate(Actor Who, String What)
;; Void  SGO.ActorSetTimeUpdated(Actor Who, String What[, Float When])

;; Void  SGO.ActorTrackForGems(Actor Who, Bool Enabled)
;; Void  SGO.ActorTrackForMilk(Actor who, Bool Enabled)
;; Void  SGO.ActorTrackForSemen(Actor who, Bool Enabled)

;; Float SGO.ActorModGetTotal(Actor Who, String What)
;; Float SGO.ActorModGetValue(Actor Who, String What, String ModKey)
;; Void  SGO.ActorModSetValue(Actor Who, String What, String ModKey)
;; Void  SGO.ActorModUnsetValue(Actor Who, String What, String ModKey)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Event List ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; events emitted by this mod that can be watched for by mods that wish to
;; integrate with soulgem oven.

;; SGO.OnGemProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int No, Int Pet, Int Les, Int Com, Int Gre, Int Gra, Int Bla
;; This event describes the number of gems the specified actor is carrying in
;; the various states of development. It is emitted any time a gem crosses
;; into the next stage.

;; SGO.OnMilkProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int Amount
;; This event describes how many bottles of milk the specified actor is
;; carrying. It is emitted any time another whole bottle is ready.

;; SGO.OnSemenProgress ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Int Amount
;; This event describes how many bottles of semen the specified actor is
;; carrying. It is emitted any time another whole bottle is ready.

;; SGO.OnBirthed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just birthed from the specified
;; actor.

;; SGO.OnMilked ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just milked from the specific actor.

;; SGO.OnWanked ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actor Who, Form What
;; This event describes an object that was just wanked from the specific actor.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NiOverride Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; SGO.Scale on NPC Belly
;; SGO.Scale on NPC L Breast
;; SGO.Scale on NPC R Breast
;; SGO.Scale on NPC GenitalsScrotum [GenScrot]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Forcing Milk Production ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; so you want to make a mod that forces an actor to produce milk without being
;; pregnant? the following TWO lines of code are what you need to make it start
;; happening.
;;
;; SGO.ActorModSetValue(Who,"MilkProduce","YourModName",1.0)
;; SGO.ActorTrackForMilk(Who,TRUE)
;;
;; at some point, your mod will need to make it stop. the following ONE line of
;; code is what you need to stop it.
;;
;; SGO.ActorModUnsetValue(Who,"MilkProduce","YourModName")
;; 
;; note - when you want to stop generating milk do not undo the tracking for
;; milk. SGO will automatically stop tracking as soon as all mods have removed
;; their desire for production.
;;


;/*****************************************************************************
                                    __   __             
 .-----.----.-----.-----.-----.----|  |_|__.-----.-----.
 |  _  |   _|  _  |  _  |  -__|   _|   _|  |  -__|__ --|
 |   __|__| |_____|   __|_____|__| |____|__|_____|_____|
 |__|             |__|                                  

*****************************************************************************/;

Bool Property Enabled = TRUE Auto hidden
{if the mod should be allowed to do things.}

Bool Property OK = FALSE Auto Hidden
{this will be set to true if everything this mod needs to run has been found
and accessible during startup or reset.}

Actor Property Player Auto
{maintain a pointer to player. set via ck.}

SexLabFramework Property SexLab Auto Hidden
{the sexlab framework scripting. it will be set by the dependency checker.}

;/*****************************************************************************
                    __      ___                           
 .--------.-----.--|  |   .'  _.-----.----.--------.-----.
 |        |  _  |  _  |   |   _|  _  |   _|        |__ --|
 |__|__|__|_____|_____|   |__| |_____|__| |__|__|__|_____|

*****************************************************************************/;

dcc_sgo_QuestController_UpdateLoop Property UpdateLoop Auto
{the script that will handle the update queue. set via ck.}

Perk Property dcc_sgo_PerkCannotProduceGems Auto
{prevent an actor from producing gems if it normally could.}

Perk Property dcc_sgo_PerkCanProduceGems Auto
{allow an actor to produce gems if it normally could not.}

Perk Property dcc_sgo_PerkCannotProduceMilk Auto
{prevent an actor from producing milk if it normally could.}

Perk Property dcc_sgo_PerkCanProduceMilk Auto
{allow an actor to produce milk if it normally could not}

Perk Property dcc_sgo_PerkCannotInseminate Auto
{prevent an actor from inseminating others if it normally could.}

Perk Property dcc_sgo_PerkCanInseminate Auto
{allow an actor to inseminate others if it normally could not.}

FormList Property dcc_sgo_ListMilkItems Auto
{form list of milks. this list needs to line up with the two race lists.}

FormList Property dcc_sgo_ListSemenItems Auto
{form list of semens. it needs to line up with the race lists.}

FormList Property dcc_sgo_ListRaceNormal Auto
{form list of normal races. this list needs to line up with the milk list.}

FormList Property dcc_sgo_ListRaceVampire Auto
{form list of vampire races. this list needs to line up with the milk list.}

FormList Property dcc_sgo_ListGemEmpty Auto
{form list of full gems.}

FormList Property dcc_sgo_ListGemFull Auto
{form list of empty gems.}

FormList Property dcc_sgo_ListGemFragment Auto
{form list of gem fragments.}

Package Property dcc_sgo_PackageDoNothing Auto
{a package to force an actor to do nothing.}

Spell Property dcc_sgo_SpellBellyEncumber Auto
{spell that emcumbers you with belly size.}

Spell Property dcc_sgo_SpellBreastInfluence Auto
{spell that increases barter ability with boob size.}

Spell Property dcc_sgo_SpellDeflate Auto
{the cum deflation effect.}

Spell Property dcc_sgo_SpellDeflateTrigger Auto
{manual trigger for deflation.}

Spell Property dcc_sgo_SpellInflate Auto
{the cum inflation effect.}

Spell Property dcc_sgo_SpellMenuMain Auto
{the spell to trigger the main menu.}

ImageSpaceModifier Property dcc_sgo_ImodMenu Auto
{to tint the screen the classic sgo shade of purple on menus.}

Armor Property dcc_sgo_ArmorSquirtingCum Auto
{fx object for squirting.}

;/*****************************************************************************
                    __                       ___ __       
 .--------.-----.--|  |   .----.-----.-----.'  _|__.-----.
 |        |  _  |  _  |   |  __|  _  |     |   _|  |  _  |
 |__|__|__|_____|_____|   |____|_____|__|__|__| |__|___  |
                                                   |_____|

*****************************************************************************/;

;; gem options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptGemMatureTime = 144.0 Auto Hidden ;; mcm
{how many hours for a gem to mature. default 144 = 6 days.}

Int Property OptGemMaxCapacity = 6 Auto Hidden ;; mcm
{how many gems can be carried at one time.}

Bool Property OptGemFilled = TRUE Auto Hidden ;; mcm
{if we should give filled gems or empty gems.}

;; milk options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptMilkProduceTime = 8.0 Auto Hidden ;; mcm
{how many hours for milk to produce. default 8 = 3 per day.}

Int Property OptMilkMaxCapacity = 3 Auto Hidden ;; mcm
{how many bottles of milk can be carried at one time.}

;; semen options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptSemenProduceTime = 12.0 Auto Hidden ;; mcm
{how many hours for semen to produce.}

Int Property OptSemenMaxCapacity = 2 Auto Hidden ;; mcm
{how many bottles of semen can be carried at a time.}

;; body scaling options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptScaleBellyCum = 2.0 Auto Hidden
{how much to scale with cum inflation.}

FLoat Property OptScaleBellyCurve = 1.75 Auto Hidden ;; mcm 
{the value that tweaks the curve for bellies.}

Float Property OptScaleBellyMax = 5.0 Auto Hidden ;; mcm
{the maximum size of the belly when full up.}

Float Property OptScaleBreastCurve = 1.5 Auto Hidden ;; mcm
{the value that tweaks the curve for breasts.}

Float Property OptScaleBreastMax = 2.0 Auto Hidden ;; mcm
{the maximum size of the breasts when filled up.}

Float Property OptScaleTesticleCurve = 1.25 Auto Hidden ;; mcm
{the value that scales the curve for testicles.}

Float Property OptScaleTesticleMax = 2.0 Auto Hidden ;; mcm
{the maximum size of the testicles when filled up.}

;; pregnancy options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Int Property OptPregChanceHumanoid = 50 Auto Hidden ;; mcm
{preg chance on encounters with people.}

Int Property OptPregChanceBeast = 10 Auto Hidden ;; mcm
{preg chance on encounters with beasts.}

Bool Property OptFertility = TRUE Auto Hidden ;; mcm
{if to enable fertility multiplier or not.}

Int Property OptFertilityDays = 28 Auto Hidden ;; mcm
{how many days for a complete cycle. 0 to disable fertility.}

Float Property OptFertilityWindow = 2.0 Auto Hidden ;; mcm
{this is how wide the fertility is. 2.0 = twice as likely.}

;; immersion options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bool Property OptImmersivePlayer = TRUE Auto Hidden ;; mcm
{if we should show messages about the player state.}

Bool Property OptImmersiveNPC = TRUE Auto Hidden ;; mcm
{if we should show messages about npc states.}

Bool Property OptEffectBreastInfluence = TRUE Auto Hidden ;; mcm
{if the breast influence buff/debuffs should be applied.}

Bool Property OptEffectBellyEncumber = TRUE Auto Hidden ;; mcm
{if the belly encumberment buff/debuff should be applied.}

Bool Property OptCumInflation = TRUE Auto Hidden ;; mcm
{if to enable cum inflation or not.}

Bool Property OptCumInflationHold = TRUE Auto Hidden ;; mcm
{if cum should be held in or leaked out.}

Int Property OptAnimationBirthing = -1 Auto Hidden ;; mcm
{-1 = random animation every gem. 0 = random animation every birthing set. other
values stand for the configured animations.}

;; leveling options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptProgressAlchFactor = 1.0 Auto Hidden ;; mcm
{how fast alchemy should level by milking.}

Float Property OptProgressEnchFactor = 1.0 Auto Hidden ;; mcm
{how fast enchanting should level by birthing.}

;; mod options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bool  Property OptDebug = TRUE Auto Hidden ;; mcm
{print debugging information out to the console}

Float Property OptUpdateInterval = 20.0 Auto Hidden ;; mcm
{how long to wait before beginning the calculation queue again.}

Float Property OptUpdateDelay = 0.125 Auto Hidden ;; mcm
{how long to delay the update loop each iteration.}

;; constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Int Property BioProduceGems = 1  AutoReadOnly
Int Property BioProduceMilk = 2  AutoReadOnly
Int Property BioInseminate  = 4  AutoReadOnly
Int Property BioIsBeast     = 8  AutoReadOnly
Int Property BioInflate     = 16 AutoReadOnly

;/*****************************************************************************
                     __                      __              __ 
 .--------.-----.--|  |   .----.-----.-----|  |_.----.-----|  |
 |        |  _  |  _  |   |  __|  _  |     |   _|   _|  _  |  |
 |__|__|__|_____|_____|   |____|_____|__|__|____|__| |_____|__|

*****************************************************************************/;

Function ResetMod()
{perform a quest (and ergo mod) reboot. quest RunOnce is disabled so that we
trigger OnInit() to finish the deal.}

	self.Reset()
	Utility.Wait(0.25)
	self.Stop()
	Utility.Wait(0.25)
	self.Start()

	Return
EndFunction

Function ResetMod_Prepare()
{check that everything this mod needs to run exists and is ready.}

	If(!self.IsInstalledNiOverride())
		Return
	EndIf

	If(!self.IsInstalledUIExtensions())
		Return
	EndIf

	If(!self.IsSexLabInstalled())
		Return
	EndIf

	If(!self.IsPapyrusUtilInstalled())
		Return
	EndIf

	self.OK = TRUE
	Return
EndFunction

Function ResetMod_Values()
{force reset settings to default values.}

	self.OptGemMatureTime = 144.0
	self.OptGemMaxCapacity = 6
	self.OptGemFilled = TRUE
	self.OptMilkProduceTime = 8.0
	self.OptMilkMaxCapacity = 3
	self.OptSemenProduceTime = 12.0
	self.OptSemenMaxCapacity = 2
	self.OptScaleBellyCurve = 1.75
	self.OptScaleBellyMax = 5.0
	self.OptScaleBreastCurve = 1.50
	self.OptScaleBreastMax = 2.0
	self.OptScaleTesticleCurve = 1.25
	self.OptScaleTesticleMax = 2.0
	self.OptProgressEnchFactor = 1.0
	self.OptProgressAlchFactor = 1.0
	self.OptFertility = TRUE
	self.OptFertilityWindow = 2.0
	self.OptFertilityDays = 28
	self.OptCumInflation = TRUE
	self.OptCumInflationHold = FALSE
	self.OptEffectBreastInfluence = TRUE
	self.OptEffectBellyEncumber = TRUE
	self.OptPregChanceHumanoid = 75
	self.OptPregChanceBeast = 10
	self.OptImmersivePlayer = TRUE
	self.OptImmersiveNPC = TRUE
	self.OptDebug = TRUE
	self.OptUpdateInterval = 20.0
	self.OptUpdateDelay = 0.125

	Return
EndFunction

Function ResetMod_Spells()
{force refresh of the spells.}

	self.Player.RemoveSpell(self.dcc_sgo_SpellMenuMain)
	self.Player.AddSpell(self.dcc_sgo_SpellMenuMain,TRUE)

	Return
EndFunction

Function ResetMod_Events()
{cleanup and reinit of any event handling things.}

	self.UnregisterForModEvent("OrgasmStart")
	self.UpdateLoop.UnregisterForUpdate()

	If(!self.OK)
		;; we allowed this method to do a cleanup, but if the mod is not
		;; satisified we will not re-engage events.
		Return
	EndIf

	self.RegisterForModEvent("OrgasmStart","OnEncounterEnding")
	self.UpdateLoop.RegisterForSingleUpdate(self.OptUpdateInterval)
	Return
EndFunction

;/*****************************************************************************
        __   __ __ __ __              ___                  
 .--.--|  |_|__|  |__|  |_.--.--.   .'  _.--.--.-----.----.
 |  |  |   _|  |  |  |   _|  |  |   |   _|  |  |     |  __|
 |_____|____|__|__|__|____|___  |   |__| |_____|__|__|____|
                          |_____|                          
                                                           
*****************************************************************************/;

String Function ChooseRandomString(String[] What)
{given an array choose a random string from it. we will use this for things
like printing random messages or choosing random animations.}
	
	Return What[Utility.RandomInt(0,(What.Length - 1))]
EndFunction

Function Print(String Msg)
{send a message to the notification area.}

	Debug.Notification("[SGO] " + Msg)
	Return
EndFunction

Function PrintDebug(String Msg)
{send a message to the console.}

	If(!self.OptDebug)
		Return
	EndIf

	MiscUtil.PrintConsole("[SGO] " + Msg)
	Return
EndFunction

Function PrintRandom(String[] MsgList)
{print a random one of the strings from a given array.}

	self.Print(self.ChooseRandomString(MsgList))
	Return
EndFunction

String Function GetGemName(Float Value)
{based on the gem value, return its short name. doing it here for intl later.}

	If(Value < 1)
		Return "Fragment"
	ElseIf(Value < 2)
		Return "Petty"
	ElseIf(Value < 3)
		Return "Lesser"
	ElseIf(Value < 4)
		Return "Common"
	ElseIf(Value < 5)
		Return "Greater"
	ElseIf(value < 6)
		Return "Grand"
	Else
		Return "Black"
	EndIf
EndFunction

Int Function GetGemValue(Form What)
{get the value of a gem, which also equals its formlist offset plus one.}

	FormList List
	Int Value

	If(self.OptGemFilled)
		List = self.dcc_sgo_ListGemFull
	Else
		List = self.dcc_sgo_ListGemEmpty
	EndIf

	Value = List.Find(What)
	If(Value == -1)
		Return 0
	EndIf

	Return (Value + 1)
EndFunction

Int Function GetGemStageCount()
{count how many things are in the gem list. we will (eventually) use this to
support dynamic stages depending on if the list has been modified.}

	If(self.OptGemFilled)
		Return self.dcc_sgo_ListGemFull.GetSize()
	Else
		Return self.dcc_sgo_ListGemEmpty.GetSize()
	EndIf
EndFunction

Float Function GetLeveledValue(Float Level, Float Value, Float Factor = 1.0)
{modify a value based on a level 100 system. this means at level 100 the input
value will be doubled.}
	
	;; scale 1 at level 0
	;; ((0 / 100) * 1) + 1 = 1

	;; scale 1 at level 1
	;; ((1 / 100) * 1) + 1 = 1.01

	;; scale 1 at level 50
	;; ((50 / 100) * 1) + 1 = 1.5

	;; scale 1 at level 100
	;; ((100 / 100) * 1) + 1 = 2.0

	Return (((level / 100.0) * (value * factor)) + value) as Float
EndFunction

;; skeleton manipulation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Function BoneCurveValue(Actor Who, String Bone, Float Value)
{curve the given Value based on the actors current value and the curve.}

	Float Curve = 2.0

	If(Bone == "NPC Belly")
		Curve = self.OptScaleBellyCurve
	ElseIf(Bone == "NPC L Breast" || Bone == "NPC R Breast")
		Curve = self.OptScaleBreastCurve
	ElseIf(Bone == "NPC GenitalsScrotum [GenScrot]")
		Curve = self.OptScaleTesticleCurve
	EndIf

	If(Curve == 2.0)
		;; the math works out such that 2.0 is no curving so skip the math.
		Return Value
	EndIf

	;; http://i.imgur.com/tHUAaME.png
	;; this curve was designed to accelerate visual response at lower scalings
	;; while dampening it at higher scalings to provide a more consistant
	;; feeling of volume, however it has curve pairity at 2.0 for all settings.
	;; curve of 2.0 = no curve. reasonable minimum is 0.5.
	;; Return Math.Sqrt(Math.Pow((Value - 1),Curve)) + 1

	;; http://i.imgur.com/Ylelmrr.png
	;; this curve lessens the ramp-up of the values and dampens sooner than
	;; the previous curve. curve of 2.0 = no curve. reasonable minimum is 1.0.
	;; belly - max 5.0 curve 1.75 1.75 = ~4 @ 5.0
	;; breast - max 2.0 curve 1.5 = ~1.75 @ 2.0
	;; testicle - max 2.0 curve 1.25 
	Return (Math.Sqrt(Math.Pow((Value - 1),Curve)) * (Curve / 2)) + 1
EndFunction

Bool Function BoneHasScale(Actor Who, String Bone, String ModKey)
{wrap nioverride, test if a bone scale exists.}

	Return NiOverride.HasNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetActorBase().GetSex() == 1),Bone,ModKey)
EndFunction

Float Function BoneGetScale(Actor Who, String Bone, String ModKey)
{wrap nioverride, get a bone scale.}

	Float Value = NiOverride.GetNodeTransformScale((Who as ObjectReference),False,(Who.GetActorBase().GetSex() == 1),Bone,ModKey)

	If(Value != 0.0)
		Return Value
	Else
		Return 1.0
	EndIf
EndFunction

Function BoneSetScale(Actor Who, String Bone, String ModKey, Float Value)
{wrap nioverride, set a bone scale.}

	If(Value != 1.0)
		NiOverride.AddNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetActorBase().GetSex() == 1),Bone,ModKey,self.BoneCurveValue(Who,Bone,Value))
	Else
		NiOverride.RemoveNodeTransformScale((Who as ObjectReference),FALSE,(Who.GetActorBase().GetSex() == 1),Bone,ModKey)
	EndIf

	NiOverride.UpdateNodeTransform((Who as ObjectReference),FALSE,(Who.GetActorBase().GetSex() == 1),Bone)

	;;self.PrintDebug(Bone + " NiO: " + self.BoneGetScale(Who,Bone,ModKey))
	;;self.PrintDebug(Bone + " NetImm: " + NetImmerse.GetNodeScale((Who as ObjectReference),"NPC Belly",FALSE))

	Return
EndFunction

;/*****************************************************************************
     __                            __                        
 .--|  .-----.-----.-----.-----.--|  .-----.-----.----.--.--.
 |  _  |  -__|  _  |  -__|     |  _  |  -__|     |  __|  |  |
 |_____|_____|   __|_____|__|__|_____|_____|__|__|____|___  |
             |__|                                     |_____|
                                                             
*****************************************************************************/;

Bool Function IsInstalledNiOverride(Bool Popup=TRUE)
{make sure NiOverride is installed and active.}

	If(SKSE.GetPluginVersion("NiOverride") == -1)
		If(Popup)
			Debug.MessageBox("NiOverride not installed. Install it by installing RaceMenu or by installing it standalone from the Nexus.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

Bool Function IsInstalledUIExtensions(Bool Popup=TRUE)
{make sure UIExtensions is installed and active.}

	If(Game.GetModByName("UIExtensions.esp") == 255)
		If(Popup)
			Debug.MessageBox("UIExtensions not installed. Install it from the Nexus.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

Bool Function IsSexLabInstalled(Bool Popup=TRUE)
{make sure SexLab is installed and active.}

	If(Game.GetModByName("SexLab.esm") == 255)
		If(Popup)
			Debug.MessageBox("SexLab not installed. Install it from LoversLab.")
		EndIf
		Return FALSE
	EndIf

	self.SexLab = Game.GetFormFromFile(0xD62,"SexLab.esm") as SexLabFramework
	Return TRUE
EndFunction

Bool Function IsPapyrusUtilInstalled(Bool Popup=TRUE)
{make sure papyrus util is a version we need. if we test this after sexlab we
can basically promise it will be there. we need to make sure that shlongs of
skyrim though didn't fuck it up again with an older version, that will break
the use of AdjustFloatValue and the like.}

	If(PapyrusUtil.GetVersion() < 30)
		If(Popup)
			Debug.MessageBox("Your PapyrusUtil is too old or has been overwritten by something like SOS. Install PapyrusUtil 3.0 from LoversLab and make sure it dominates the load order.")
		EndIf
		Return FALSE
	EndIf

	Return TRUE
EndFunction

;/*****************************************************************************
                          __         
 .-----.--.--.-----.-----|  |_.-----.
 |  -__|  |  |  -__|     |   _|__ --|
 |_____|\___/|_____|__|__|____|_____|
                                                             
*****************************************************************************/;

Event OnInit()
{handler for installing and resetting}

	self.OK = FALSE
	self.ResetMod_Prepare()
	self.ResetMod_Values()
	self.ResetMod_Spells()
	self.ResetMod_Events()

	self.Print("Mod Installed.")
	If(self.OK)
		self.Print("Mod Active.")
	Else
		self.Print("Mod Inactive - Go fix missing dependencies.")
	EndIf
	
	Return
EndEvent

Event OnEncounterEnding(String EventName, String Args, Float Argc, Form From)
{handler for sexlab encounters ending.}

	self.PrintDebug("OnEncounterEnding Fired")

	Actor[] ActorList = SexLab.HookActors(Args)
	Int[] ActorBio = PapyrusUtil.IntArray(ActorList.Length)
	sslBaseAnimation Animation = SexLab.HookAnimation(Args)
	Int PartyBio = 0
	Int MaleCount = 0
	Int BeastCount = 0
	Bool Preg = 0
	Int x

	;;;;;;;;
	;;;;;;;;

	;; check if the animation type even included penetration.

	If(!Animation.IsVaginal && !Animation.IsAnal)
		self.PrintDebug("Encounter did not have penetration (vag/anal).")
		Return
	EndIf


	;;;;;;;;
	;;;;;;;;

	;; we need to go through the party and determine which biological
	;; features they are capable of providing to the mix. because of the way
	;; SexLab animations and just how you play the game in general works,
	;; all characters able to recieve bounties will get them if there is at
	;; least one character able to produce them. we cannot really reliably
	;; trust who is the pitcher and who is the catcher with the animations
	;; even more so when there is more than two actors.

	x = 0
	While(x < ActorList.Length)
		ActorBio[x] = self.ActorGetBiologicalFunctions(ActorList[x])
		PartyBio = Math.LogicalOr(PartyBio,ActorBio[x])

		;; determine what pitchers we have for determining which preg
		;; chance to use.
		If(Math.LogicalAnd(ActorBio[x],self.BioIsBeast) > 0)
			BeastCount += 1
		ElseIf(Math.LogicalAnd(ActorBio[x],self.BioInseminate) > 0)
			MaleCount += 1
		EndIf

		x += 1
	EndWhile

	If(Math.LogicalAnd(PartyBio,5) != 5)
		;; if we didn't have a winning combination of fuel and ovens
		;; available there is no point in proceeeding.
		self.PrintDebug("Encounter did not have a viable combo (" + PartyBio + ").")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	x = 0
	While(x < ActorList.Length)
		If(MaleCount > 0)
			Preg = (self.OptPregChanceHumanoid <= (Utility.RandomInt(0,100) * self.ActorFertilityGetMod(ActorList[x])))
		Else
			Preg = (self.OptPregChanceBeast <= (Utility.RandomInt(0,100) * self.ActorFertilityGetMod(ActorList[x])))
		EndIf

		If(Preg)
			self.PrintDebug("Preg Chance Success for " + ActorList[x].GetDisplayName())
		Else
			self.PrintDebug("Preg Chance Fail for " + ActorList[x].GetDisplayName())
		EndIf

		If(Math.LogicalAnd(ActorBio[x],self.BioProduceGems) > 0)
			If(Preg)
				self.PrintDebug(ActorList[x].GetDisplayname() + " will produce gems.")
				self.ActorGemAdd(ActorList[x])
			EndIf

			If(self.OptCumInflation)
				ActorList[x].AddSpell(self.dcc_sgo_SpellInflate)
			EndIf
		EndIf

		x += 1
	EndWhile

	Return
EndEvent

Function EventSend_OnGemProgress(Actor Who, Int[] Progress)
{emit an event listing the current state of the gems being carried.}

	Int e = ModEvent.Create("SGO.OnGemProgress")

	;; fml, you cannot push an array into mod events.

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress[0]) ;; unready gems
		ModEvent.PushInt(e,Progress[1]) ;; petty gems
		ModEvent.PushInt(e,Progress[2]) ;; lesser gems
		ModEvent.PushInt(e,Progress[3]) ;; common gems
		ModEvent.PushInt(e,Progress[4]) ;; greater gems
		ModEvent.PushInt(e,Progress[5]) ;; grand gems
		ModEvent.PushInt(e,Progress[6]) ;; black gems
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnMilkProgress(Actor Who, Int Progress)
{emit an event stating the current amount of milk being carried.}

	Int e = ModEvent.Create("SGO.OnMilkProgress")

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress)
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnSemenProgress(Actor Who, Int Progress)
{emit an event when an actor gains another bottle of semen.}

	Int e = ModEvent.Create("SGO.OnSemenProgress")

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress)
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

Function EventSend_OnBirthed(Actor Who, Form What)
{emit an event stating the gem an actor just birthed.}

	Int e = ModEvent.Create("SGO.OnBirthed")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnMilked(Actor Who, Form What)
{emit an event stating a bottle of milk was just milked.}

	Int e = ModEvent.Create("SGO.OnMilked")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

Function EventSend_OnWanked(Actor Who, Form What)
{emit an event stating a bottle of semen was just wanked.}

	Int e = ModEvent.Create("SGO.OnWanked")
	If(!e)
		Return
	EndIf

	ModEvent.PushForm(e,Who)
	ModEvent.PushForm(e,What)
	ModEvent.Send(e)
	Return
EndFunction

;/*****************************************************************************
             __                     __       __         
 .---.-.----|  |_.-----.----.   .--|  .---.-|  |_.---.-.
 |  _  |  __|   _|  _  |   _|   |  _  |  _  |   _|  _  |
 |___._|____|____|_____|__|     |_____|___._|____|___._|
                                                        
*****************************************************************************/;

Int Function ActorGetBiologicalFunctions(Actor Who)
{determine what this actor's body is able to accomplish. returns a bitwised
integer that defines the capaiblities of this actor.}

	Int Value = 0
	Int Sex = SexLab.GetGender(Who)

	If(Sex == 2)
		Value += self.BioIsBeast
	EndIf

	If((Sex != 1 || Who.HasPerk(self.dcc_sgo_PerkCanInseminate)) && !Who.HasPerk(self.dcc_sgo_PerkCannotInseminate))
		Value += self.BioInseminate
	EndIf

	If((Sex == 1 || Who.HasPerk(self.dcc_sgo_PerkCanProduceGems)) && !Who.HasPerk(self.dcc_sgo_PerkCannotProduceGems))
		Value += self.BioProduceGems
	EndIf

	If((Sex == 1 || Who.HasPerk(self.dcc_sgo_PerkCanProduceMilk)) && !Who.HasPerk(self.dcc_sgo_PerkCannotProduceMilk))
		Value += self.BioProduceMilk
	EndIf

	Return Value
EndFunction

Function ActorSetBiologicalFunction(Actor Who, Int Func, Bool Enable)
{set this actor's biological functions. this function does not do bitwise so
you must do each function individually.}

	;; todo - re-engineer the inner workings of this method to allow
	;; for a bitwise operation instead.

	Perk ToEnable
	Perk ToDisable

	If(Func == self.BioProduceGems)
		ToEnable = self.dcc_sgo_PerkCanProduceGems
		ToDisable = self.dcc_sgo_PerkCannotProduceGems
	ElseIf(Func == self.BioProduceMilk)
		ToEnable = self.dcc_sgo_PerkCanProduceMilk
		ToDisable = self.dcc_sgo_PerkCannotProduceMilk
	ElseIf(Func == self.BioInseminate)
		ToEnable = self.dcc_sgo_PerkCanInseminate
		ToDisable = self.dcc_sgo_PerkCannotInseminate
	EndIf

	If(Enable)
		Who.RemovePerk(ToDisable)
		Who.AddPerk(ToEnable)

		If(Func == self.BioInseminate)
			self.ActorTrackForSemen(Who,TRUE)
		EndIf
	Else
		Who.RemovePerk(ToEnable)
		Who.AddPerk(ToDisable)

		If(Func == self.BioInseminate)
			self.ActorTrackForSemen(Who,FALSE)
		EndIf
	EndIf

	Return
EndFunction

Function ActorToggleBiologicalFunction(Actor Who, Int Func)
{toggle this actor's biological functions. this method does not work in
bitwise so you must do each function indivdually.}

	If(Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),Func) == Func)
		self.ActorSetBiologicalFunction(Who,Func,FALSE)
	Else
		self.ActorSetBiologicalFunction(Who,Func,TRUE)
	EndIf

	Return
EndFunction

Float Function ActorGetTimeSinceUpdate(Actor Who, String What)
{return how many game hours have passed since this actors specified data has
been updated. the string value is the storageutil name for the data you want.}

	Float Current = Utility.GetCurrentGameTime()
	Float Last = StorageUtil.GetFloatValue(Who,What,0.0)

	If(Last == 0.0)
		;; when this is the first time report the first time was more than an
		;; hour ago so that things like fertility initialise on new games.
		Last = Current - (1.5 / 24)
		StorageUtil.SetFloatValue(Who,What,Last)
	EndIf

	Return (Current - Last) * 24.0
EndFunction

Function ActorSetTimeUpdated(Actor Who, String What, Float When=0.0)
{set the current time to mark this actor having been updated. the string value
is the storageutil name for the data you want.}

	If(When == 0.0)
		When = Utility.GetCurrentGameTime()
	EndIf

	StorageUtil.SetFloatValue(Who,What,When)
	Return
EndFunction

Function ActorRemoveChestpiece(Actor who)
{remove an actor's chestpiece.}

	If(Who.GetWornForm(0x00000004) != None)
		StorageUtil.SetFormValue(Who,"SGO.Actor.Armor.Chest",Who.GetWornForm(0x00000004))
		Who.UnequipItemSlot(32)
		Who.QueueNiNodeUpdate()
	EndIf
EndFunction

Function ActorReplaceChestpiece(Actor Who)
{replace an actor's chestpiece.}

	If(StorageUtil.GetFormValue(Who,"SGO.Actor.Armor.Chest"))
		Who.EquipItem(Storageutil.GetFormValue(Who,"SGO.Actor.Armor.Chest"),FALSE,TRUE)
		StorageUtil.SetFormValue(who,"SGO.Actor.Armor.Chest",None)
	EndIf
EndFunction

Function ActorProgressAlchemy(Actor Who, Float ItemValue=1.0)
{progress the alchemy skill for the specified actor. for most things we will
leave ItemValue at the default of 1.0.}

	If(Who != self.Player)
		;; not possible to level npcs at this time.
		Return
	EndIf

	If(self.OptProgressAlchFactor == 0.0)
		;; do not process when disabled.
		Return
	EndIf

	;; http://www.uesp.net/wiki/Skyrim:Leveling#Skill_XP

	;; xp/btl gained at x btl/day at level 0.
	;; double this at level 100 with 1.0 progress factor.
	;; 1 = 100xp
	;; 2 = 50xp
	;; 3 = 33xp (default)

	Float Level = Who.GetLevel()
	Float Value = (100 / (24 / self.OptMilkProduceTime)) * ItemValue

	;; if its progressing retarded fast, manipulate the 24 to be smaller.
	;; if too slow manipulate the 24 larger.
	;; once this calc feels good to me at default, users can tweak it via the factor.

	Game.AdvanceSkill("Alchemy",self.GetLeveledValue(Level,Value,self.OptProgressAlchFactor))
	Return
EndFunction

Function ActorProgressEnchanting(Actor Who, Float ItemValue=6.0)
{progress the enchanting skill for the specified actor. it works on a base 6
system because it will primarily be used on soulgems birthing.}

	If(Who != self.Player)
		;; not possible to level npcs at this time.
		Return
	EndIf

	If(self.OptProgressEnchFactor == 0.0)
		;; do not process when disabled.
		Return
	EndIf

	;; http://www.uesp.net/wiki/Skyrim:Leveling#Skill_XP
	;; normal enchanting works as 1xp per item enchanted and it seems enchanting levels fast
	;; so we will use small numbers here.

	Float Level = Who.GetLevel()
	Float Value = ((ItemValue / 6.0) / 2.0)

	;; if enchanting levels too slow manipulate the /2.0 smaller.
	;; if too fast, manipulate the /2.0 larger.
	;; once this calc feels good to me at default, users can tweak it via the factor.

	Game.AdvanceSkill("Enchanting",self.GetLeveledValue(Level,Value,self.OptProgressEnchFactor))
	Return
EndFunction

Float Function ActorFertilityGetMod(Actor Who, float Vmod=0.0)
{fetch the current multiplier for the fertility value using science and shit.}

	;; the x value of the wave.
	Float Fval = StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Fertility",missing=0.0)
	Fval += Vmod


	;; the period offset is used to crank the amplitude and vertical offset of
	;; the wave.
	Float Poff = self.OptFertilityWindow / 2

	;; the period length.
	Int Plen = self.OptFertilityDays

	;;  /     /          \      \
	;; |     | 2[pi]      |      |
	;; | sin | ----- fval | poff | + poff
	;; |     | plen       |      |
	;;  \     \          /      /
	;;           period    amp    y-offset

	;; SINEWAVESMOTHERFUCKER.

	Return (Math.Sin(Math.RadiansToDegrees(((2*3.14159) / Plen) * Fval)) * Poff) + Poff
EndFunction

Function ActorFertilityUpdateData(Actor Who, Bool Force=FALSE)
{this function will keep a running loop of time from 0 to 28.}

	;; 1 2 3... 27 28 0 1 2 3...

	If(!self.OptFertility)
		;; no need to process if disabled.
		Return
	EndIf

	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Fertility")
	If(Time < 1.0 && !Force)
		;; no need to process if too soon.
		Return
	EndIf

	;; get our current values. if this actor has not yet ever been calculated
	;; then we set them at a random point in the cycle to try and avoid having
	;; all the females in skyrim synced up.
	Float Fval = StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Fertility",missing=Utility.RandomFloat(0.0,self.OptFertilityDays))
	Float Nval = Fval + (Time / 24)

	;; attempt to sync up cycles with any followers currently following lololol.
	;; for starters we will try just making followers run hotter until they
	;; are synced up.
	;;If(self.OptFertilitySync && SexLab.GetGender(self.Player) == 1)
	;;	If(Who != self.Player && SexLab.GetGender(Who) == 1 && self.Player.GetDistance(Who) <= 250)
	;;		If(Math.abs(self.ActorFertilityGetMod(Who)-self.ActorFertilityGetMod(self.Player)) / self.OptFertilityWindow > 0.1)
	;;			Nval += (self.OptFertilityDays * 0.01) * Time
	;;		EndIf
	;;	EndIf
	;;EndIf

	;;If(Nval > self.OptFertilityDays)
		;; reset the period if this actor is over a cycle.
	;;	Nval = Nval - (Math.Floor(Nval / self.OptFertilityDays) * self.OptFertilityDays)
	;;EndIf
	Nval = PapyrusUtil.WrapFloat(Nval,self.OptFertilityDays,1.0)

	;; update our fertile value.
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Fertility")
	StorageUtil.SetFloatValue(who,"SGO.Actor.Data.Fertility",Nval)

	;; todo: immersive messages comparing fval and nval.

	;; todo: more research on blood splattering actors. i seem to be able to
	;; splatter everything except the actor. the lol was gonna be bleeding on
	;; people while sexing while at the low point of the fertility cycle.
	;; who.PlayImpactEffect(Game.GetFormFromFile(0xF457B,"Skyrim.esm") as ImpactDataSet,"SchlongMagic",0.0,0.0,1.0,0.0)

	Return
EndFunction

Function ActorApplyBreastInfluence(Actor Who)
{this function will re-calculate the breast influence for barter and refresh it
when needed.}

	Who.RemoveSpell(self.dcc_sgo_SpellBreastInfluence)

	If(!self.OptEffectBreastInfluence || self.ActorMilkGetWeight(Who) == 0)
		;; allow the above to clean up but not progress if disabled.
		Return
	EndIf

	Float Multi = self.ActorModGetTotal(Who,"BreastInfluence") + 1

	self.dcc_sgo_SpellBreastInfluence.SetNthEffectMagnitude(0,((self.ActorMilkGetPercent(Who) / 4) * Multi))
	self.dcc_sgo_SpellBreastInfluence.SetNthEffectMagnitude(1,((self.ActorMilkGetPercent(Who) / 8) * (Multi / 2)))
	Who.AddSpell(self.dcc_sgo_SpellBreastInfluence,FALSE)
	Return
EndFunction

Function ActorApplyBellyEncumber(Actor Who)
{this function will re-calculate the belly encumberment and refresh it when
needed.}

	Who.RemoveSpell(self.dcc_sgo_SpellBellyEncumber)

	If(!self.OptEffectBellyEncumber || self.ActorGemGetCount(Who) == 0)
		;; allow the above to clean up but not progress if disabled.
		Return
	EndIf

	self.dcc_sgo_SpellBellyEncumber.SetNthEffectMagnitude(0,((self.ActorGemGetPercent(Who) / 4) * -1))
	Who.AddSpell(self.dcc_sgo_SpellBellyEncumber,FALSE)
	Return
EndFunction

;/*****************************************************************************
             __                              __                       __       
 .---.-.----|  |_.-----.----.   .--.--.---.-|  |   .--------.-----.--|  .-----.
 |  _  |  __|   _|  _  |   _|   |  |  |  _  |  |   |        |  _  |  _  |__ --|
 |___._|____|____|_____|__|      \___/|___._|__|   |__|__|__|_____|_____|_____|

*****************************************************************************/;

Float Function ActorModGetTotal(Actor Who, String What)
{fetch the sum of all the mods so.}

	What = "SGO.Actor.Mod." + What

	Int x
	Int Count = StorageUtil.StringListCount(Who,What)
	String ModKey
	Float Value = 0.0
	
	x = 0
	While(x < Count)
		ModKey = StorageUtil.StringListGet(Who,What,x)
		Value += StorageUtil.GetFloatValue(Who,ModKey)
		x += 1
	EndWhile

	Return Value
EndFunction

Float Function ActorModGetValue(Actor Who, String ModKey)
{fetch the specified actor mod.}

	ModKey = "SGO.ActorModValue." + ModKey

	Return StorageUtil.GetFloatValue(Who,ModKey,0.0)
EndFunction

Function ActorModSetValue(Actor Who, String What, String ModKey, Float Value=0.0)
{set a specified actor mod.}

	What = "SGO.Actor.Mod." + What
	ModKey = "SGO.ActorModValue." + ModKey

	StorageUtil.StringListAdd(Who,What,ModKey,FALSE)
	StorageUtil.SetFloatValue(Who,ModKey,Value)

	Return
EndFunction

Function ActorModUnsetValue(Actor Who, String What, String ModKey)
{remove a specified actor mod.}

	What = "SGO.Actor.Mod." + What
	ModKey = "SGO.ActorModValue." + ModKey

	StorageUtil.StringListRemove(Who,What,ModKey,TRUE)
	StorageUtil.UnsetFloatValue(Who,ModKey)

	Return
EndFunction

;/*****************************************************************************
             __                                   __              __ 
 .---.-.----|  |_.-----.----.   .----.-----.-----|  |_.----.-----|  |
 |  _  |  __|   _|  _  |   _|   |  __|  _  |     |   _|   _|  _  |  |
 |___._|____|____|_____|__|     |____|_____|__|__|____|__| |_____|__|

*****************************************************************************/;

Function BehaviourApply(Actor Who, Package Pkg)
{have an actor begin a specific package.}

	self.BehaviourClear(Who)

	StorageUtil.SetFormValue(Who,"SGO.Actor.Package",Pkg)
	ActorUtil.AddPackageOverride(Who,Pkg,100)
	Who.EvaluatePackage()

	Return
EndFunction

Function BehaviourClear(Actor Who, Bool Full=False)
{have an actor clear their ruling overwrite package.}

	Package Pkg = StorageUtil.GetFormValue(Who,"SGO.Actor.Package",missing=None) as Package

	If(Pkg != None)
		StorageUtil.UnsetFormValue(Who,"SGO.Actor.Package")
		ActorUtil.RemovePackageOverride(Who,Pkg)
		Who.EvaluatePackage()
	EndIf

	If(Full)
		ActorUtil.RemovePackageOverride(Who,self.dcc_sgo_PackageDoNothing)
		who.EvaluatePackage()

		If(Who == self.Player)
			Game.SetPlayerAIDriven(FALSE)
		EndIf
	EndIf

	Return
EndFunction

Function BehaviourDefault(Actor Who)
{enforece the default ai behaviour of do nothing.}

	self.BehaviourClear(Who,TRUE)

	If(Who == self.Player)
		Game.SetPlayerAIDriven(TRUE)
	EndIf

	ActorUtil.AddPackageOverride(Who,self.dcc_sgo_PackageDoNothing,99)
	Who.EvaluatePackage()

	Return
EndFunction

;/*****************************************************************************
  __                   __    __                             __ 
 |  |_.----.---.-.----|  |--|__.-----.-----.   .---.-.-----|__|
 |   _|   _|  _  |  __|    <|  |     |  _  |   |  _  |  _  |  |
 |____|__| |___._|____|__|__|__|__|__|___  |   |___._|   __|__|
                                     |_____|         |__|      

*****************************************************************************/;

Function ActorTrackForGems(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors who are growing gems}

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioProduceGems) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Gem",Who,False)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Gem")
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",Who,True)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Time.Gem")
		StorageUtil.FloatListClear(Who,"SGO.Actor.Data.Gem")
	EndIf

	Return
EndFunction

Function ActorTrackForMilk(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating milk.}

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioProduceMilk) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Milk",Who,FALSE)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Milk")
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",Who,TRUE)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Time.Milk")
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Data.Milk")
	EndIf

	Return
EndFunction

Function ActorTrackForSemen(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating semen.}

	If(Enabled && Math.LogicalAnd(self.ActorGetBiologicalFunctions(Who),self.BioInseminate) != 0)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Semen",Who,FALSE)
		self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Semen")
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Semen",Who,FALSE)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Time.Semen")

		;; StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Data.Semen")
		;; we want to keep the actual data so we can still use it for scale
		;; computations later. we just want to stop iterating over them every
		;; loop after they are full.

	EndIf

	Return
EndFunction

;/*****************************************************************************
  __             __                       __ 
 |  |--.-----.--|  .--.--.   .---.-.-----|__|
 |  _  |  _  |  _  |  |  |   |  _  |  _  |  |
 |_____|_____|_____|___  |   |___._|   __|__|
                   |_____|         |__|      

*****************************************************************************/;

Function ActorBodyUpdate(Actor Who)
{push the updated visual data into NiOverride. cheers to Groovtama for helping
witht he NiO stuffs.}

	self.ActorBodyUpdate_BellyScale(Who)
	self.ActorBodyUpdate_BreastScale(Who)
	self.ActorBodyUpdate_TesticleScale(Who)
	Return
EndFunction

Function ActorBodyUpdate_BellyScale(Actor Who)
{handle the physical representation of the belly.}

	Float Belly = self.ActorModGetTotal(Who,"ScaleBelly")
	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem")

	;; with a max of six gems, max of 300% more visual
	;; depending on how the visual results look we may want to curve this value.
	;; to scale less at higher volumes.
	;; 0 gems (( 0 / 36) * 3.0) + 1 == 1.0
	;; 6 gems ((36 / 36) * 3.0) + 1 == 4.0

	Belly = ((self.ActorGemGetWeight(Who,FALSE) / (6 * self.ActorGemGetCapacity(Who))) * (self.OptScaleBellyMax + self.ActorModGetTotal(Who,"ScaleBellyMax"))) + 1

	self.BoneSetScale(Who,"NPC Belly","SGO.Scale",Belly)
	Return
EndFunction

Function ActorBodyUpdate_BreastScale(Actor Who)
{handle the physical representation of the breasts.}
	
	Float Breast = self.ActorModGetTotal(Who,"ScaleBreast")

	;; with a max of 3 bottles, max of 200% more visual
	;; 0 milk ((0 / 3) * 2.0) + 1 == 1.0
	;; 3 milk ((3 / 3) * 2.0) + 1 == 3.0

	Breast += ((self.ActorMilkGetWeight(Who) / self.OptMilkMaxCapacity) * (self.OptScaleBreastMax + self.ActorModGetTotal(Who,"ScaleBreastMax"))) + 1

	self.BoneSetScale(Who,"NPC L Breast","SGO.Scale",Breast)
	self.BoneSetScale(Who,"NPC R Breast","SGO.Scale",Breast)
	Return
EndFunction

Function ActorBodyUpdate_TesticleScale(Actor Who)
{handle the physical representation of the breasts.}
	
	Float Testicle = self.ActorModGetTotal(Who,"ScaleTesticle")

	;; with a max of 2 bottles, max of 200% more visual
	;; 0 semen ((0 / 2) * 2.0) + 1 == 1.0
	;; 2 semen ((2 / 2) * 2.0) + 1 == 3.0

	Testicle += ((self.ActorSemenGetWeight(Who) / self.OptSemenMaxCapacity) * (self.OptScaleTesticleMax + self.ActorModGetTotal(Who,"ScaleTesticleMax"))) + 1

	self.BoneSetScale(Who,"NPC GenitalsScrotum [GenScrot]","SGO.Scale",Testicle)
	Return
EndFunction

;/*****************************************************************************
                                       __ 
 .-----.-----.--------.   .---.-.-----|__|
 |  _  |  -__|        |   |  _  |  _  |  |
 |___  |_____|__|__|__|   |___._|   __|__|
 |_____|                        |__|      
                                          
*****************************************************************************/;

Bool Function ActorGemAdd(Actor Who, Float Value=0.0)
{add another gem to this actor's pipeline.}

	If(StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem") < self.ActorGemGetCapacity(Who))
		StorageUtil.FloatListAdd(Who,"SGO.Actor.Data.Gem",Value,TRUE)
		self.Print(Who.GetDisplayName() + " is incubating another gem. (" + StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem") + ")")	
		self.ActorTrackForGems(Who,TRUE)
		self.ActorTrackForMilk(Who,TRUE)
		Return TRUE
	EndIf

	Return FALSE
EndFunction

Function ActorGemGiveTo(Actor Source, Actor Dest, Int Count=1)
{transfer a gem from one actor's oven to another actors inventory. both actors
can be the same. this will mainly be used for a lulz transfer animation if
i can find a lesbian one that is suitable or get an animator to make me one.}

	Int x
	Form GemType

	x = 0
	While(x < Count)
		GemType = self.ActorGemRemove(Source)
		If(GemType == None)
			self.Print(Source.GetDisplayName() + " has no more gems to give.")
			Return
		EndIf

		self.ActorProgressEnchanting(Source,self.GetGemValue(GemType))

		If(Dest == None)
			;; without a destination drop the gem the ground.
			ObjectReference o = Source.PlaceAtMe(GemType,1,FALSE,TRUE)
			o.MoveToNode(Source,"NPC Pelvis [Pelv]")
			o.SetActorOwner(self.Player.GetActorBase())
			o.Enable()
			Utility.Wait(0.25)
			o.ApplyHavokImpulse((Source.GetAngleX()-Math.sin(Source.GetAngleZ())),(Source.GetAngleY()-Math.cos(Source.GetAngleZ())),2.0,20.0)
		Else
			;; else put it in the bag.
			Dest.AddItem(GemType,1)
		EndIf

		self.EventSend_OnBirthed(Source,GemType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorGemRemove(Actor Who, Int ValueOfGem=-1)
{remove the next gem from the specified actor. returns a form describing
what object we should spawn in the world. this will be used mostly by the
gem place and gem give functions. if the value is provided it will only
remove the gem if it is that.}

	If(self.ActorGemGetCount(Who) == 0)
		;; an empty form if no gems.
		Return None
	EndIf

	Float Value = StorageUtil.FloatListGet(Who,"SGO.Actor.Data.Gem",0)
	StorageUtil.FloatListRemoveAt(Who,"SGO.Actor.Data.Gem",0)

	If(Value < 1.0)
		;; return a random fragment if less than a gem.
		Return self.dcc_sgo_ListGemFragment.GetAt(Utility.RandomInt(0,(self.dcc_sgo_ListGemFragment.GetSize() - 1))) as Form
	EndIf

	If(Value > 6.0)
		;; cap the value for overtimed gems.
		Value = 6
	EndIf

	If(self.OptGemFilled)
		Return self.dcc_sgo_ListGemFull.GetAt(Value as Int - 1)
	Else
		Return self.dcc_sgo_ListGemEmpty.GetAt(Value as Int - 1)
	EndIf
EndFunction

Form Function ActorGemRemoveFromInventory(Actor Who, Int Size)
{remove a gem or fragment of type from the specified actor's inventory. for
actual gems it will prefer unfilled over filled.}

	Form What
	Int x

	If(Size == 0)
		;; handle the removal of various fragments.

		x = 0
		While(x < self.dcc_sgo_ListGemFragment.GetSize())
			If(Who.GetItemCount(self.dcc_sgo_ListGemFragment.GetAt(x)) > 0)
				Who.RemoveItem(self.dcc_sgo_ListGemFragment.GetAt(x),1,FALSE)
				Return self.dcc_sgo_ListGemFragment.GetAt(x)
			EndIf
			x += 1
		EndWhile
	Else
		;; handle the removal of gems. prefer unfilled first.

		If(Who.GetItemCount(self.dcc_sgo_ListGemEmpty.GetAt(Size - 1)) > 0)
			Who.RemoveItem(self.dcc_sgo_ListGemEmpty.GetAt(Size - 1),1,FALSE)
			Return self.dcc_sgo_ListGemEmpty.GetAt(Size - 1)
		EndIf

		If(Who.GetItemCount(self.dcc_sgo_ListGemFull.GetAt(Size - 1)) > 0)
			Who.RemoveItem(self.dcc_sgo_ListGemFull.GetAt(Size - 1),1,FALSE)
			Return self.dcc_sgo_ListGemFull.GetAt(Size - 1)
		EndIf
	EndIf

	Return None
EndFunction

;;;;;;;;

Int Function ActorGemGetCapacity(Actor Who)
{determine how many gems this actor should be able to carry.}

	;; no mods return 0. a mod total of 1.5 means i want to
	;; be able to carry 150% more gems.
	Return (self.OptGemMaxCapacity * (self.ActorModGetTotal(Who,"GemCapacity") + 1)) as Int
EndFunction

Int Function ActorGemGetCount(Actor Who)
{get how many gems are currently brewing.}
	
	Return StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem")
EndFunction

Int[] Function ActorGemGetInventory(Actor Who)
{get the state of gems from the actors inventory. returns a length 7 array.}

	Int[] Result = new Int[7]
	Int x

	x = 0
	While(x < Result.Length)
		If(x == 0)
			Result[x] = self.ActorGemGetInventory_GetFragments(Who)
		Else
			Result[x] = self.ActorGemGetInventory_GetGems(Who,(x - 1))
		EndIf

		x += 1
	EndWhile

	Return Result
EndFunction

Int Function ActorGemGetInventory_GetFragments(Actor Who)
{how many of the various fragments do we have?}

	Int Count = 0
	Int x = 0

	While(x < self.dcc_sgo_ListGemFragment.GetSize())
		Count += Who.GetItemCount(self.dcc_sgo_ListGemFragment.GetAt(x))
		x += 1
	EndWhile

	Return Count
EndFunction

Int Function ActorGemGetInventory_GetGems(Actor Who, Int Offset)
{how many of a specific gem offset we have?}

	Int Count = Who.GetItemCount(self.dcc_sgo_ListGemEmpty.GetAt(Offset))
	Count += Who.GetItemCount(self.dcc_sgo_ListGemFull.GetAt(Offset))

	Return Count
EndFunction

Float Function ActorGemGetTime(Actor Who)
{determine how fast gems should be generating for this actor.}

	;; the mod is 0 when empty. if we have a total of 1.5 that means i want
	;; 150% more time spent to mature the gem.
	Return self.OptGemMatureTime * (self.ActorModGetTotal(Who,"GemRate") + 1)
EndFunction

Float Function ActorGemGetPercent(Actor Who)

	Return (self.ActorGemGetWeight(Who,FALSE) / (self.ActorGemGetCapacity(Who) * 6)) * 100
EndFunction

Float Function ActorGemGetWeight(Actor Who, Bool Overflow=FALSE)
{find the current gem weight being carried.}

	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem")
	Float Weight = 0.0
	Float Current = 0.0
	Int x = 0

	While(x < Count)
		Current = StorageUtil.FloatListGet(Who,"SGO.Actor.Data.Gem",x)
		If(!Overflow && Current > 6)
			Current = 6
		EndIf

		Weight += Current
		x += 1
	EndWhile

	Return Weight
EndFunction

Function ActorGemUpdateData(Actor Who, Bool Force=FALSE)
{cause this actor to have its gem data recalculated. it will generate an array
that is a snapshot of the current gem states, and that snapshot will be emitted
in a mod event if a gem reached the next stage. this is probably the heaviest
function in this mod, as data is flying in and out of papyrusutil constantly.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Gem")
	Int Count = self.ActorGemGetCount(Who)

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == 0)
		;; no need to recalculate someone who cant produce gems.
		self.ActorTrackForGems(Who,FALSE)
		Return
	EndIf

	If(Count == 0)
		;; no need to recalculate someone who has no gems.
		self.ActorTrackForGems(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; we allow gems to grow larger than 6 for a mechanic later where we
	;; will force labour if you wait too long. bodyscaling will clamp it
	;; to six for the scales though.

	Int[] Progress = new Int[7]
	Bool Progressed = FALSE
	Float Total = 0.0

	Float Gem
	Float Before
	Int x = 0

	While(x < Count)
		Gem = StorageUtil.FloatListGet(Who,"SGO.Actor.Data.Gem",x)
		Before = Gem

		;; if mature time = 24hr, processed once an hour
		;; 1 / 24 = 0.0416666/hr * 24 = 1 = one level per day = wrong
		;; (1 / 24) * 6 = 0.25/hr * 24 = 6 = six level per day = right

		;; if mature time = 144hr (6d), processed once an hour
		;; (1 / 144) * 6 = 0.0416/hr * 24 = 1 = one level per day = right

		Gem += ((Time / self.ActorGemGetTime(Who)) * 6)
		Gem = PapyrusUtil.ClampFloat(Gem,0.0,12.0)

		Progress[PapyrusUtil.ClampInt(Gem as Int,0,6)] = Progress[PapyrusUtil.ClampInt(Gem as Int,0,6)] + 1
		Total += Gem

		If(Before as Int < Gem as Int)
			;; if the gem reached the next stage then mark it down
			;; so we can emit an event listing the progression.
			Progressed = TRUE
		EndIf
		
		StorageUtil.FloatListSet(Who,"SGO.Actor.Data.Gem",x,Gem)
		x += 1
	EndWhile

	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Gem")
	self.ActorBodyUpdate_BellyScale(Who)

	;;;;;;;;
	;;;;;;;;

	Float Capacity = self.ActorGemGetCapacity(Who)

	If(Progressed)
		self.Immersive_OnGemProgress(Who,Progress)
		self.EventSend_OnGemProgress(Who,Progress)
	Else
		If(Progress[6] >= Capacity)
			self.Immersive_OnGemFull(Who)
		EndIf
	EndIf

	Return
EndFunction

;/*****************************************************************************
           __ __ __                    __ 
 .--------|__|  |  |--.   .---.-.-----|__|
 |        |  |  |    <    |  _  |  _  |  |
 |__|__|__|__|__|__|__|   |___._|   __|__|
                                |__|      

*****************************************************************************/;

Function ActorMilkGiveTo(Actor Source, Actor Dest, Int Count=1)
{transfer a bottle of milk from one actor to another. both actors can be the
same.}

	Form MilkType
	Int x

	x = 0
	While(x < Count)
		MilkType = self.ActorMilkRemove(Source)
		If(MilkType == None)
			self.Print(Source.GetDisplayName() + " is not ready to give milk.");
			Return
		EndIf

		self.ActorProgressAlchemy(Source)

		If(Dest == None)
			;; without a destination drop the milk the ground.
			ObjectReference o = Source.PlaceAtMe(MilkType,1,FALSE,TRUE)
			o.MoveToNode(Source,"Breast")
			o.SetActorOwner(self.Player.GetActorBase())
			o.Enable()
			o.ApplyHavokImpulse((Source.GetAngleX()-Math.sin(Source.GetAngleZ())),(Source.GetAngleY()-Math.cos(Source.GetAngleZ())),2.0,10.0)
		Else
			;; else put it in their bag.
			Dest.AddItem(MilkType,1)
		EndIf

		self.EventSend_OnMilked(Source,MilkType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorMilkRemove(Actor Who)
{remove a bottle of milk from the specified actor. returns a form describing
the type of milk that we should spawn in the world.}

	If(self.ActorMilkGetWeight(Who) < 1.0)
		Return None
	EndIf

	Int Index

	StorageUtil.AdjustFloatValue(Who,"SGO.Actor.Data.Milk",-1.0)

	;; give a milk for normal races.
	Index = self.dcc_sgo_ListRaceNormal.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListMilkItems.GetAt(Index)
	EndIf

	;; give a milk for vampire races that match normal races.
	Index = self.dcc_sgo_ListRaceVampire.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListMilkItems.GetAt(Index)
	EndIf

	;; give the generic milk that sucks.
	Return self.dcc_sgo_ListMilkItems.GetAt(0)
EndFunction

;;;;;;;;

Int Function ActorMilkGetCapacity(Actor Who)
{figure out how much milk this actor can carry.}

	;; no mods return a default of 0. a mod of 1.5 means i want to be able to
	;; carry 150% more milks.
	Return (self.OptMilkMaxCapacity * (self.ActorModGetTotal(Who,"MilkCapacity") + 1)) as Int
EndFunction

Int Function ActorMilkGetCount(Actor Who)
{get the current whole bottle count.}

	Return self.ActorMilkGetWeight(Who) as Int
EndFunction

Float Function ActorMilkGetTime(Actor Who)
{figure out how fast this actor is generating milk.}

	Return (self.OptMilkProduceTime * (self.ActorModGetTotal(Who,"MilkRate") + 1))
EndFunction

Float Function ActorMilkGetPercent(Actor Who)
{find the current mik percentage of fullness. returns a float between 0 and
100.}

	Return (self.ActorMilkGetWeight(Who) / self.ActorMilkGetCapacity(Who)) * 100
EndFunction

Float Function ActorMilkGetWeight(Actor Who)
{find the current milk weight being carried.}

	Return StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Milk")
EndFunction

Function ActorMilkUpdateData(Actor Who, Bool Force=FALSE)
{cause this actor to have its milk data recalculated. if we have gained another
full bottle then emit a mod event saying how many bottles are ready to go.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Milk")

	If(Math.LogicalAnd(Bio,self.BioProduceMilk) == 0)
		;; no need to recalculate someone who cant make milk.
		;; self.PrintDebug(Who.GetDisplayName() + " stopping milk (no produce)")
		self.ActorTrackForMilk(Who,FALSE)
		Return
	EndIf

	If(self.ActorGemGetCount(Who) == 0 && self.ActorModGetTotal(Who,"MilkProduce") == 0.0)
		;; no need to recalculate someone who doesn't need to make milk.
		;; self.PrintDebug(Who.GetDisplayName() + " stopping milk (no need)")
		self.ActorTrackForMilk(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		;; self.PrintDebug(Who.GetDisplayName() + " skipping milk (not time)")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	Float Capacity = self.ActorMilkGetCapacity(Who)
	Float Milk = StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Milk",0.0)
	Float Before = Milk

	;; produce time 8hr (3/day), once an hour
	;; 1 / 8 = 0.125/hr * 24 = 3 = three per day = right

	Milk += (Time / self.ActorMilkGetTime(Who))
	If(Milk > Capacity)
		self.Immersive_OnMilkFull(Who)
		Milk = Capacity
	EndIf

	StorageUtil.SetFloatValue(Who,"SGO.Actor.Data.Milk",Milk)
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Milk")
	self.ActorBodyUpdate_BreastScale(Who)

	;;;;;;;;
	;;;;;;;;

	If(Before as Int < Milk as Int)
		self.Immersive_OnMilkProgress(Who)
		self.EventSend_OnMilkProgress(Who,(Milk as Int))
	EndIf

	Return
EndFunction

;/*****************************************************************************
                                                   __ 
 .-----.-----.--------.-----.-----.   .---.-.-----|__|
 |__ --|  -__|        |  -__|     |   |  _  |  _  |  |
 |_____|_____|__|__|__|_____|__|__|   |___._|   __|__|
                                            |__|      

*****************************************************************************/;

Function ActorSemenGiveTo(Actor Source, Actor Dest, Int Count=1)
{transfer a bottle of semen from one actor to another. both actors can be the
same.}

	Form SemenType
	Int x

	x = 0
	While(x < Count)
		SemenType = self.ActorSemenRemove(Source)
		If(SemenType == None)
			self.Print(Source.GetDisplayName() + " is not ready to give semen.");
			Return
		EndIf

		self.ActorProgressAlchemy(Source,0.75)

		If(Dest == None)
			;; without a destination drop the semen on the ground from the
			;; tip of the penis for the lulz.
			ObjectReference o = Source.PlaceAtMe(SemenType,1,FALSE,TRUE)
			o.MoveToNode(Source,"NPC Genitals06 [Gen06]")
			o.SetActorOwner(self.Player.GetActorBase())
			o.Enable()
			o.ApplyHavokImpulse((Source.GetAngleX()-Math.sin(Source.GetAngleZ())),(Source.GetAngleY()-Math.cos(Source.GetAngleZ())),2.0,10.0)
		Else
			;; else put it in their bag.
			Dest.AddItem(SemenType,1)
		EndIf

		self.EventSend_OnWanked(Source,SemenType)
		x += 1
	EndWhile

	Return
EndFunction

Form Function ActorSemenRemove(Actor Who)
{remove a bottle of semen from the specified actor. returns a form describing
the type of semen that we should spawn in the world.}

	If(self.ActorSemenGetWeight(Who) < 1.0)
		Return None
	EndIf

	Int Index

	StorageUtil.AdjustFloatValue(Who,"SGO.Actor.Data.Semen",-1.0)

	;; give a semen for normal races.
	Index = self.dcc_sgo_ListRaceNormal.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListSemenItems.GetAt(Index)
	EndIf

	;; give a semen for vampire races that match normal races.
	Index = self.dcc_sgo_ListRaceVampire.Find(Who.GetRace())
	If(Index != -1)
		Return self.dcc_sgo_ListSemenItems.GetAt(Index)
	EndIf

	;; give the generic semen that sucks.
	Return self.dcc_sgo_ListSemenItems.GetAt(0)
EndFunction

;;;;;;;;

Int Function ActorSemenGetCapacity(Actor Who)
{figure out how much semen this actor can carry.}

	;; no mods return a default of 0. a mod of 1.5 means i want to be able to
	;; carry 150% more milks.
	Return (self.OptSemenMaxCapacity * (self.ActorModGetTotal(Who,"SemenCapacity") + 1)) as Int
EndFunction

Float Function ActorSemenGetTime(Actor Who)
{figure out how fast this actor is generating semen.}

	Return (self.OptSemenProduceTime * (self.ActorModGetTotal(Who,"SemenRate") + 1))
EndFunction

Float Function ActorSemenGetPercent(Actor Who)
{find the current semen percentage of fullness.}

	Return (self.ActorSemenGetWeight(Who) / self.OptSemenMaxCapacity) * 100
EndFunction

Float Function ActorSemenGetWeight(Actor Who)
{find the current semen weight being carried.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Int FirstTime = 0
	Float Semen = StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Semen",-1.0)

	;; trick it a bit so that when wanked the first time ever they report as
	;; being full if they are a semen producer.

	If(Semen == -1.0)
		If(Math.LogicalAnd(Bio,self.BioInseminate))
			Semen = self.ActorSemenGetCapacity(Who)
			StorageUtil.SetFloatValue(Who,"SGO.Actor.Data.Semen",Semen)
		Else
			Semen = 0.0
		EndIf
	EndIf

	Return Semen
EndFunction

Function ActorSemenUpdateData(Actor Who, Bool Force=FALSE)
{cause this actor to have its milk data recalculated. if we have gained another
full bottle then emit a mod event saying how many bottles are ready to go.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)
	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Semen")
	Float Capacity = self.ActorSemenGetCapacity(Who)
	Float Semen = self.ActorSemenGetWeight(Who)
	Float Before = Semen

	If(Math.LogicalAnd(Bio,self.BioInseminate) == 0)
		;; no need to recalculate someone who cant inseminate.
		;; self.PrintDebug(Who.GetDisplayName() + " does not need semen")
		self.ActorTrackForSemen(Who,FALSE)
		Return
	EndIf

	If(Semen >= Capacity)
		;; no need to recalculate someone who is full. for semen we will
		;; unregister them since wanking will rereg. (this logic does not
		;; apply to gems or milk.)
		self.ActorTrackForSemen(Who,FALSE)
		Return
	EndIf

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		;; self.PrintDebug(Who.GetDisplayName() + " semen calc too soon")
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; produce time 12hr (2/day), once an hour
	;; 1 / 12 = 0.083/hr * 24 = 2 = two per day = right

	Semen += (Time / self.ActorSemenGetTime(Who))
	If(Semen > Capacity)
		self.Immersive_OnSemenFull(Who)
		Semen = Capacity
	EndIf

	StorageUtil.SetFloatValue(Who,"SGO.Actor.Data.Semen",Semen)
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Semen")

	;;;;;;;;
	;;;;;;;;

	If(Before as Int < Semen as Int)
		self.Immersive_OnSemenProgress(Who)
		self.EventSend_OnSemenProgress(Who,(Semen as Int))
	EndIf

	If(Semen >= Capacity)
		self.ActorTrackForSemen(Who,FALSE)
	EndIf

	self.ActorBodyUpdate_TesticleScale(Who)
	Return
EndFunction

;/*****************************************************************************
             __                             __   __                   
 .---.-.----|  |_.-----.----.   .---.-.----|  |_|__.-----.-----.-----.
 |  _  |  __|   _|  _  |   _|   |  _  |  __|   _|  |  _  |     |__ --|
 |___._|____|____|_____|__|     |___._|____|____|__|_____|__|__|_____|

*****************************************************************************/;

Function ActorActionBirth(Actor Source, Actor Dest)
{perform the full birthing sequence.}

	If(self.ActorGemGetCount(Source) == 0)
		self.Print(Source.GetDisplayName() + " is not ready for labour.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionBirth_Solo(Source)
	Else
		self.ActorActionBirth_Duo(Source,Dest)
	EndIf

	Return
EndFunction

Function ActorActionBirth_Solo(Actor Source)
{single actor birthing sequence.}

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	self.ImmersiveAnimationBirthing(Source)

	;;self.ImmersiveAboutFace(Source)

	If(Source == self.Player)
		MiscUtil.SetFreeCameraState(TRUE,7.0)
	EndIf

	While(self.ActorGemGetCount(Source) > 0)
		Utility.Wait(3.0)
		self.ImmersiveBlush(Source,1.0,3,3.0)
		self.ImmersiveExpression(Source,FALSE)
		Utility.Wait(3.0)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(3.0)
		self.ImmersiveSoundMoan(Source,TRUE)
		self.ActorGemGiveTo(Source,None,1)
		self.ActorBodyUpdate_BellyScale(Source)
		Utility.Wait(3.0)
		If(self.OptAnimationBirthing == -1)
			self.ImmersiveAnimationBirthing(Source)
		EndIf
	EndWhile

	If(Source == self.Player)
		MiscUtil.SetFreeCameraState(FALSE)
	EndIf

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAboutFace(Source)
	self.ImmersiveAnimationIdle(Source)
	self.ActorReplaceChestpiece(Source)
	self.BehaviourClear(Source,TRUE)

	Return
EndFunction

Function ActorActionBirth_Duo(Actor Source, Actor Dest)
{dual actor birthing sequence. i plan this to be the transfer animation.}

	;; todo

	return
EndFunction

Function ActorActionMilk(Actor Source, Actor Dest)
{perform the full milking sequence.}

	If(self.ActorMilkGetWeight(Source) < 1.0)
		self.Print(Source.GetDisplayName() + " is not ready to be milked.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionMilk_Solo(Source)
	Else
		self.ActorActionMilk_Duo(Source,Dest)
	EndIf

	Return
EndFunction

Function ActorActionMilk_Solo(Actor Source)
{single actor milking sequence.}

	Actor Dest = None
	If(Source == self.Player)
		Dest = self.Player
	EndIf

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	self.ImmersiveAnimationMilking(Source)

	While(self.ActorMilkGetWeight(Source) >= 1.0)
		self.ImmersiveBlush(Source)
		Utility.Wait(2.0)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(2.0)
		self.ActorMilkGiveTo(Source,Dest,1)
		self.ActorBodyUpdate_BreastScale(Source)
		self.ImmersiveExpression(Source,FALSE)
	EndWhile

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.ActorReplaceChestpiece(Source)
	self.BehaviourClear(Source,TRUE)

	Return
EndFunction

Function ActorActionMilk_Duo(Actor Source, Actor Dest)
{dual actor milking sequence.}

	Return
EndFunction

Function ActorActionWank(Actor Source, Actor Dest)
{perform the full wanking sequence.}

	If(self.ActorSemenGetWeight(Source) < 1.0)
		self.Print(Source.GetDisplayName() + " is not ready to be wanked.")
		Return
	EndIf

	If(Source == Dest)
		self.ActorActionWank_Solo(Source)
	Else
		self.ActorActionWank_Duo(Source,Dest)
	EndIf

	self.ActorTrackForSemen(Source,TRUE)
	Return
EndFunction

Function ActorActionWank_Solo(Actor Source)
{single actor wanking sequence.}

	Actor Dest = None
	If(Source == self.Player)
		Dest = self.Player
	EndIf

	self.BehaviourDefault(Source)
	self.ActorRemoveChestpiece(Source)
	self.ImmersiveErection(Source,TRUE)
	self.ImmersiveAnimationWanking(Source)

	While(self.ActorSemenGetWeight(Source) >= 1.0)
		self.ImmersiveBlush(Source)
		Utility.Wait(3.0)
		self.ImmersiveExpression(Source,TRUE)
		self.ImmersiveSoundMoan(Source,FALSE)
		Utility.Wait(3.0)
		self.ActorSemenGiveTo(Source,Dest,1)
		self.ActorBodyUpdate_TesticleScale(Source)
		self.ImmersiveExpression(Source,FALSE)
		Utility.Wait(1.0)
	EndWhile

	self.ImmersiveExpression(Source,FALSE)
	self.ImmersiveAnimationIdle(Source)
	self.ImmersiveErection(Source,FALSE)
	self.ActorReplaceChestpiece(Source)
	self.BehaviourClear(Source,TRUE)

	Return
EndFunction

Function ActorActionWank_Duo(Actor Source, Actor Dest)
{dual actor wanking sequence.}

	Return
EndFunction

Function ActorActionInsert(Actor Source, Actor Dest, Int Size)
{gem insertion sequence.}

	If(self.ActorGemGetCount(Dest) >= self.ActorGemGetCapacity(Dest))
		self.Print(Dest.GetDisplayName() + " cannot fit anymore gems.")
		Return
	EndIf

	If(self.ActorGemRemoveFromInventory(Source,Size) == None)
		self.Print(Source.GetDisplayName() + " has none of those gems to use.")
		Return
	EndIf

	self.BehaviourDefault(Dest)
	self.ActorRemoveChestpiece(Dest)
	self.ImmersiveAnimationInsertion(Dest)
	Utility.Wait(3.0)

	self.ImmersiveExpression(Dest,TRUE)
	self.ImmersiveSoundMoan(Dest,FALSE)
	self.ImmersiveBlush(Dest)
	Utility.Wait(3.0)

	self.ActorGemAdd(Dest,Size)
	self.ActorBodyUpdate_BellyScale(Dest)
	self.ImmersiveSoundMoan(Dest)
	Utility.Wait(2.0)

	self.ImmersiveAnimationIdle(Dest)
	self.ImmersiveExpression(Dest,FALSE)
	self.ActorReplaceChestpiece(Dest)
	self.BehaviourClear(Dest,TRUE)

	Return
EndFunction


;/*****************************************************************************
  __                                    __               __     __   
 |__.--------.--------.-----.----.-----|__.-----.-----._|  |_ _|  |_ 
 |  |        |        |  -__|   _|__ --|  |  _  |     |_    _|_    _|
 |__|__|__|__|__|__|__|_____|__| |_____|__|_____|__|__| |__|   |__|  
                                                                     
*****************************************************************************/;

;; immersive events

Function Immersive_OnGemFull(Actor Who)
{send messages about gem fullness.}

	If(Who == self.Player)
		String[] Msg = new String[6]
		Msg[0] = "It feels like all my gems are ready."
		Msg[1] = "I can tell the gems I carry have hit their max potential."
		Msg[2] = "My belly feels like it is about to burst."
		Msg[3] = "Ugh some of these gems have sharp corners."
		Msg[4] = "If I drop my weapon I'm not sure I could bend down to pick it up again!"
		Msg[5] = "Ding! Oven's done."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnGemProgress(Actor Who, Int[] Progress)
{send messages about gem progression.}

	If(Who == self.Player)
		String[] Msg = new String[3]
		Msg[0] = "You feel another gem has progressed."
		Msg[1] = "You feel a gem has reached the next stage of development."
		Msg[2] = "You can tell a gem got a little bigger than earlier."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnMilkFull(Actor Who)
{send messages about milk being full.}

	If(Who == self.Player)
		String[] Msg = new String[9]
		Msg[0] = "My breasts are sore and ready to burst."
		Msg[1] = "If my breasts get any fuller they might pop!"
		Msg[2] = "If my breasts get any larger they are going to need their own Jarl."
		Msg[4] = "I bet I could get some great deals flashing these milkshakes around."
		Msg[5] = "My back is sore from supporting these things."
		Msg[6] = "These things are so full they are dribbling milk."
		Msg[7] = "My boobs are so full. I wonder if anyone is thirty?" ;; chajapa
		Msg[8] = "I think my jugs are full." ;; chajapa
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnMilkProgress(Actor Who)
{send messages about milk progression.}

	If(Who == self.Player)
		String[] Msg = new String[3]
		Msg[0] = "My breasts feel a little heavier."
		Msg[1] = "My breasts have gotten heavier."
		Msg[2] = "Who needs a cow for milk when I've got these puppies." ;; mm777
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnSemenFull(Actor Who)
{send messages about milk being full.}

	If(Who == self.Player)
		String[] Msg = new String[4]
		Msg[0] = "My balls ache from being so full."
		Msg[1] = "My balls are so full it hurts."
		Msg[2] = "My balls are so full I can probably out-cum a dragon." ;; mm777
		Msg[3] = "Sitting may be a bit difficult." ;; Meerkats Dance
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

Function Immersive_OnSemenProgress(Actor Who)
{send messages about milk progression.}

	If(Who == self.Player)
		String[] Msg = new String[2]
		Msg[0] = "My balls feel a little heavier"
		Msg[1] = "I can tell my balls have refilled some."
		self.PrintRandom(Msg)
	EndIf

	Return
EndFunction

;; immersive actions

Function ImmersiveBlush(Actor Who, Float Opacity=1.0, Int FullTime=2, Float FadeTime=2.0)
{provide integration for Blush When Aroused. this will trigger a short blushing
event if installed http://www.loverslab.com/files/file/1724-blush-when-aroused}

	int e = 0

	If(Who != self.Player)
		e = ModEvent.Create("BWA_ForceBlushOn")
	Else
		e = ModEvent.Create("BWA_ForceBlushOnPlr")
	Endif

	If(e == 0)
		self.PrintDebug("Blush Event Failure")
		Return
	EndIf

	If(Who != self.Player)
		ModEvent.PushForm(e,Who as Form)
	EndIf

	ModEvent.PushFloat(e,Opacity)
	ModEvent.PushInt(e,FullTime)
	ModEvent.PushFloat(e,FadeTime)
	ModEvent.PushBool(e,FALSE)
	ModEvent.Send(e)
	Return
EndFunction

Function ImmersiveExpression(Actor Who, Bool Enable)
{play an expression on the actor face.}

	If(Enable)
		sslBaseExpression exp = SexLab.PickExpression(Who)
		exp.Apply(Who,100,1)
	Else
		Who.ClearExpressionOverride()
		MfgConsoleFunc.ResetPhonemeModifier(Who)
	EndIf
EndFunction

Function ImmersiveSheatheWeapon(Actor Who)
{sheathe the weapon and wait if drawn.}

	If(Who.IsWeaponDrawn())
		Who.SheatheWeapon()
		Utility.Wait(3.0)
	EndIf

	Return
EndFunction

Function ImmersiveSoundMoan(Actor Who, Bool Hard=FALSE)
{play a moaning sound from the actor.}

	sslBaseVoice Voice = SexLab.PickVoice(Who)
	Int SoundID = StorageUtil.GetIntValue(Who,"SGO.Actor.Sound.Moan")
	Sound Moan

	If(Hard)
		Moan = Voice.GetSound(100)
	Else
		Moan = Voice.GetSound(30)
	EndIf

	if SoundID > 0
		Sound.StopInstance(SoundID)
	Endif

	StorageUtil.SetIntValue(Who,"SGO.Actor.Sound.Moan",Moan.Play(who))
EndFunction

Function ImmersiveAboutFace(Actor Who)
{spin the actor around 180deg.}

	Who.SetAngle(Who.GetAngleX(),Who.GetAngleY(),(Who.GetAngleZ() + 180.0))
	Return
EndFunction

Function ImmersiveAnimationBirthing(Actor Who)
{play a birthing animation on the actor.}
	self.ImmersiveSheatheWeapon(Who)

	;;;;;;;;

	;; Ani are the animations we want.
	;; Pre are the animations we have to call before aclling the one we
	;; want. a weird bug introduced into the animations in sexlab 1.6.
	;; animations greater than S1 need to have S1 called before the actual.

	;; cannot compare a string to a none (cast missing or types unrelated)
	;; roflmao.

	String[] Ani = new String[8]
	String[] Pre = new String[8]

	Ani[0] = "AP_BedMissionary_A1_S3"
	Pre[0] = "AP_BedMissionary_A1_S1"

	Ani[1] = "DoggyStyle_A1_S4"
	Pre[1] = "DoggyStyle_A1_S1"

	Ani[2] = "Missionary_A1_S4"
	Pre[2] = "Missionary_A1_S1"

	Ani[3] = "Zyn_Missionary_A1_S1"
	Pre[3] = "----"

	Ani[4] = "ZaZAPCCHorFB"
	Pre[4] = "----"

	Ani[5] = "ZaZAPC201"
	Pre[5] = "----"

	Ani[6] = "ZaZAPC202"
	Pre[6] = "----"

	Ani[7] = "ZaZAPC205"
	Pre[7] = "----"

	;;;;;;;;

	Int Which
	If(self.OptAnimationBirthing <= 0)
		Which = Utility.RandomInt(0,(Ani.Length - 1))
	Else
		Which = self.OptAnimationBirthing - 1
	EndIf

	If(Pre[Which] != "----")
		Debug.SendAnimationEvent(Who,Pre[Which])
	EndIf

	Debug.SendAnimationEvent(Who,Ani[Which])
	Return
EndFunction

Function ImmersiveAnimationIdle(Actor Who)
{play the idle animation on an actor.}

	self.ImmersiveSheatheWeapon(Who)

	Debug.SendAnimationEvent(who,"IdleForceDefaultState")
	;;Who.SetAngle(Who.GetAngleX(),Who.GetAngleY(),(Who.GetAngleZ() + 180.0))
	Return
EndFunction

Function ImmersiveAnimationMilking(Actor Who)
{play the milking animation on an actor.} 

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"ZaZAPCHorFC")
	Return
EndFunction

Function ImmersiveAnimationWanking(Actor Who)
{play the milking animation on an actor.} 

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"Arrok_MaleMasturbation_A1_S2")
	Return
EndFunction

Function ImmersiveAnimationInsertion(Actor Who)
{play the insertion animation on an actor.} 

	self.ImmersiveSheatheWeapon(Who)
	Debug.SendAnimationEvent(Who,"ZaZAPCHorFA")
	Return
EndFunction

Function ImmersiveErection(Actor Who, Bool Enable)
{give the actor an erection or not.}

	Utility.Wait(0.1)

	If(Enable)
		Debug.SendAnimationEvent(Who, "SOSFastErect")
	Else
		Debug.SendAnimationEvent(Who, "SOSFlaccid")
	EndIf

	Return
EndFunction

Function ImmersiveMenuCamera(Bool Enable)
{move the camera when the menu opens.}

	Int Camera = Game.GetCameraState()
	If(Camera != 5 && Camera != 8 && Camera != 9 && Camera != 10)
		self.PrintDebug("not in third person")
		Return
	EndIf

	Float CurX = Utility.GetINIFloat("fOverShoulderPosX:Camera")
	Float CurZ = Utility.GetINIFloat("fOverShoulderPosZ:Camera")
	Float CurS = Utility.GetINIFLoat("fShoulderDollySpeed:Camera")

	If(Enable)
		StorageUtil.SetFloatValue(None,"SGO.Camera.X",CurX)
		StorageUtil.SetFloatValue(None,"SGO.Camera.Z",CurZ)
		StorageUtil.SetFloatValue(None,"SGO.Camera.S",CurS)
		Utility.SetINIFloat("fOverShoulderPosX:Camera",-50)
		Utility.SetINIFloat("fOverShoulderPosZ:Camera",-40)
		Utility.SetINIFloat("fShoulderDollySpeed:Camera",40)
	Else
		Utility.SetINIFloat("fOverShoulderPosX:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.X"))
		Utility.SetINIFloat("fOverShoulderPosZ:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.Z"))
		Utility.SetINIFloat("fShoulderDollySpeed:Camera",StorageUtil.GetFloatValue(None,"SGO.Camera.S"))
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.X")
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.Z")
		StorageUtil.UnsetFloatValue(None,"SGO.Camera.S")
	EndIf

	Game.UpdateThirdPerson()
	Return
EndFunction


;/*****************************************************************************
                                             __ 
 .--------.-----.-----.--.--.   .---.-.-----|__|
 |        |  -__|     |  |  |   |  _  |  _  |  |
 |__|__|__|_____|__|__|_____|   |___._|   __|__|
                                      |__|      

*****************************************************************************/;

;; ui extension utility.

Function MenuWheelSetItem(Int Num, String Label, String Text, Bool Enabled=True)
{assign an item to the uiextensions wheel menu.}

	UIExtensions.SetMenuPropertyIndexString("UIWheelMenu","optionLabelText",Num,Label)
	UIExtensions.SetMenuPropertyIndexString("UIWheelMenu","optionText",Num,Text)
	UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu","optionEnabled",Num,Enabled)

	If(!Enabled)
		UIExtensions.SetMenuPropertyIndexInt("UIWheelMenu","optionTextColor",Num,0x555555)
	EndIf

	Return
EndFunction

;; mod menus.

Function MenuMain(Actor Who=None)
{show the main soulgem oven menu.}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	self.MenuMain_Construct(Who)
	self.MenuMain_Handle(Who)
	Return
EndFunction

Function MenuMain_Construct(Actor Who)
{construct the menu for the main sgo menu.}

	Int ActorBio = self.ActorGetBiologicalFunctions(Who)

	;;;;;;;;

	Bool ItemBirthEnable = FALSE
	String ItemBirthLabel = "Not Pregnant"
	String ItemBirthText = "Induce labour."

	If(self.ActorGemGetWeight(Who) > 0.0)
		ItemBirthEnable = TRUE
		ItemBirthLabel = "Gems (" + (self.ActorGemGetCount(Who)) + ", " + (self.ActorGemGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	Bool ItemMilkEnable = FALSE
	String ItemMilkLabel = "Not Milkable"
	String ItemMilkText = "Milk it dry."

	If(self.ActorMilkGetWeight(Who) > 0.0)
		ItemMilkEnable = TRUE
		ItemMilkLabel = "Milk (" + (self.ActorMilkGetWeight(Who) as Int) + ", " + (self.ActorMilkGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	Bool ItemSemenEnable = FALSE
	String ItemSemenLabel = "Not Wankable"
	String ItemSemenText = "Wank it dry."

	If(self.ActorSemenGetWeight(Who) > 0.0)
		ItemSemenEnable = TRUE
		ItemSemenLabel = "Semen (" + (self.ActorSemenGetWeight(Who) as Int) + ", " + (self.ActorSemenGetPercent(Who) as Int) + "%)"
	EndIf

	;;;;;;;;

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(0,"Insert Gem...","Insert gems from inventory.",TRUE)
	self.MenuWheelSetItem(1,"Actor Options...","Set advanced options.",TRUE)
	self.MenuWheelSetItem(4,ItemBirthLabel,ItemBirthText,ItemBirthEnable)
	self.MenuWheelSetItem(5,ItemMilkLabel,ItemMilkText,ItemMilkEnable)
	self.MenuWheelSetItem(6,ItemSemenLabel,ItemSemenText,ItemSemenEnable)
	Return
EndFunction

Function MenuMain_Handle(Actor Who)
{handle the choice from the sgo menu.}

	self.ImmersiveMenuCamera(TRUE)
	self.dcc_sgo_ImodMenu.Apply(1.0)
	Utility.Wait(0.25)

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result == 0)
		self.MenuSoulgemInsert(Who)
	ElseIf(Result == 1)
		self.MenuActorOptions(Who)
	ElseIf(Result == 4)
		self.ActorActionBirth(Who,Who)
	ElseIf(Result == 5)
		self.ActorActionMilk(Who,Who)
	ElseIf(Result == 6)
		self.ActorActionWank(Who,Who)
	EndIf

	Return
EndFunction

Function MenuSoulgemInsert(Actor Who)
{show the soulgem insertion menu system.}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	;;;;;;;;

	Int Bio = self.ActorGetBiologicalFunctions(Who)

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == 0)
		self.Print(Who.GetDisplayName() + " cannot produce gems.")
		Return
	EndIf

	self.MenuSoulgemInsert_Construct(Who)
	self.MenuSoulgemInsert_Handle(Who)
	Return
EndFunction

Function MenuSoulgemInsert_Construct(Actor Who)
{construct the soulgem insertion menu}

	Int[] Inventory = self.ActorGemGetInventory(self.Player)
	Bool Enable
	String Label
	String Text
	Int x = 0

	UIExtensions.InitMenu("UIWheelMenu")

	While(x < Inventory.Length)

		If(Inventory[x] > 0)
			Enable = TRUE
		Else
			Enable = FALSE
		EndIf

		Label = self.GetGemName(x as Float) + " (" + Inventory[x] + ")"
		Text = "Insert a " + self.GetGemName(x as Float) + " gem."

		self.MenuWheelSetItem(x,Label,Text,Enable)

		x += 1
	EndWhile

	self.MenuWheelSetItem(7,"[Main Menu]","Back to main menu.",TRUE)
	Return
EndFunction

Function MenuSoulgemInsert_Handle(Actor Who)
{handle the soulgem insertion menu.}

	self.ImmersiveMenuCamera(TRUE)
	self.dcc_sgo_ImodMenu.Apply(1.0)
	Utility.Wait(0.25)

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result >= 0 && Result <= 6)
		self.ActorActionInsert(self.Player,Who,Result)
	Else
		self.MenuMain(Who)
	EndIf

	Return
EndFunction

Function MenuActorOptions(Actor Who)
{show the biological feature toggle menu}

	If(Who == None)
		Who = Game.GetCurrentCrosshairRef() as Actor
	EndIf

	If(Who == None)
		Who = self.Player
	EndIf

	self.MenuActorOptions_Construct(Who)
	self.MenuActorOptions_Handle(Who)
	Return
EndFunction

Function MenuActorOptions_Construct(Actor Who)
{construct the actor option menu.}

	Int Bio = self.ActorGetBiologicalFunctions(Who)

	;;;;;;;;

	Bool ItemGemEnable = TRUE
	String ItemGemLabel = "Enable Gems"
	String ItemGemText = "Toggle gem pregnancy on/off."

	If(Math.LogicalAnd(Bio,self.BioProduceGems) == self.BioProduceGems)
		ItemGemLabel = "Disable Gems"
	EndIf

	;;;;;;;;

	Bool ItemMilkEnable = TRUE
	String ItemMilkLabel = "Enable Milk"
	String ItemMilkText = "Toggle milk production on/off."

	If(Math.LogicalAnd(Bio,self.BioProduceMilk) == self.BioProduceMilk)
		ItemMilklabel = "Disable Milk"
	EndIf

	;;;;;;;;

	Bool ItemInseminateEnable = TRUE
	String ItemInseminateLabel = "Enable Inseminate"
	String ItemInseminateText = "Toggle to inseminate others on/off."

	If(Math.LogicalAnd(Bio,self.BioInseminate) == self.BioInseminate)
		ItemInseminateLabel = "Disable Inseminate"
	EndIf

	;;;;;;;;

	UIExtensions.InitMenu("UIWheelMenu")
	self.MenuWheelSetItem(0,ItemGemLabel,ItemGemText,ItemGemEnable)
	self.MenuWheelSetItem(1,ItemMilkLabel,ItemMilkText,ItemMilkEnable)
	self.MenuWheelSetItem(2,ItemInseminateLabel,ItemInseminateText,ItemInseminateEnable)
	self.MenuWheelSetItem(4,"F: x" + self.ActorFertilityGetMod(Who) + "","This actor's fertility modifier.",FALSE)
	self.MenuWheelSetItem(7,"[Main Menu]","Back to main menu.",TRUE)

	Return
EndFunction

Function MenuActorOptions_Handle(Actor Who)
{handle the actor option menu.}

	self.ImmersiveMenuCamera(TRUE)
	self.dcc_sgo_ImodMenu.Apply(1.0)
	Utility.Wait(0.25)

	Int Result = UIExtensions.OpenMenu("UIWheelMenu",Who)
	self.ImmersiveMenuCamera(FALSE)

	If(Result == 0)
		self.ActorToggleBiologicalFunction(Who,self.BioProduceGems)
	ElseIf(Result == 1)
		self.ActorToggleBiologicalFunction(Who,self.BioProduceMilk)
	ElseIf(Result == 2)
		self.ActorToggleBiologicalFunction(Who,self.BioInseminate)
	ElseIf(Result == 7)
		self.MenuMain(Who)
	EndIf

	Return
EndFunction
