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
        _______ __              _______ __    __         __                 
       |       |  |--.-----.   |       |  |--|__.----.--|  |                
       |.|   | |     |  -__|   |.|   | |     |  |   _|  _  |                
       `-|.  |-|__|__|_____|   `-|.  |-|__|__|__|__| |_____|                
         |:  |                   |:  |                                      
         |::.|                   |::.|                                      
         `---'                   `---'                                      
*****************************************************************************/;

;; >
;; THERE ARE ONLY 6 SOULGEM
;; MODELS.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Global) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FormList SGO.ActorList.Gem - list all actors currently growing gems.
;; FormList SGO.ActorList.Milk - list all actors currently producing milk.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys (Actor) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Float    SGO.Actor.Time.Gem - the last time this actor's gem data updated.
;; Float    SGO.Actor.Time.Milk - the last time this actor's milk data updated.
;; Float[]  SGO.Actor.Data.Gem - the gem data for this actor.
;; Float    SGO.Actor.Data.Milk - the milk data for this actor.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Method List ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; these are the methods which have been designed to be used by mods that wish
;; to integrate with soulgem oven.

;; SGO.ActorGetTimeSinceUpdate(Actor, String)
;; SGO.ActorSetTimeUpdated(Actor, String[, Float])
;; SGO.ActorTrackForMilk(Actor, Bool)
;; SGO.ActorTrackForGems(Actor, Bool)
;; SGO.ActorUpdateMilkData(Actor, Bool)
;; SGO.ActorUpdateGemData(Actor, Bool)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NiOverride Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; SGO.Scale on NPC Belly
;; SGO.Scale on NPC L Breast
;; SGO.Scale on NPC R Breast

;/*****************************************************************************
                                    __   __             
 .-----.----.-----.-----.-----.----|  |_|__.-----.-----.
 |  _  |   _|  _  |  _  |  -__|   _|   _|  |  -__|__ --|
 |   __|__| |_____|   __|_____|__| |____|__|_____|_____|
 |__|             |__|                                  

*****************************************************************************/;

Bool  Property OK = FALSE Auto Hidden
{this will be set to true if everything this mod needs to run has been found
and accessible during startup or reset.}

;; scripts n stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Actor Property Player Auto
{maintain a pointer to player. set via ck.}

dcc_sgo_QuestController_UpdateLoop Property UpdateLoop Auto
{the script that will handle the update queue. set via ck.}

SexLabFramework Property SexLab Auto Hidden
{the sexlab framework scripting. it will be set by the dependency checker.}

;; mod forms ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Perk Property dcc_sgo_PerkCanProduceGems Auto
{an actor with this perk will be able to produce gems if they normally could
not because of their sex.}

Perk Property dcc_sgo_PerkCanProduceMilk Auto
{an actor with this perk will be able to produce milk if they normally could
not because of their sex.}

Perk Property dcc_sgo_PerkCanImpregnate Auto
{an actor with this perk will be able to impregnate another actors if they
normally could not because of their sex.}

;; gameplay options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Float Property OptGemMatureTime = 144.0 Auto Hidden
{how many hours for a gem to mature. default 144 = 6 days.}

Int Property OptGemMaxCapacity = 6 Auto Hidden
{how many gems can be carried at one time.}

Float Property OptMilkProduceTime = 8.0 Auto Hidden
{how many hours for milk to produce. default 8 = 3 per day.}

Int Property OptMilkMaxCapacity = 3 Auto Hidden
{how many bottles of milk can be carried at one time.}

Float Property OptScaleBellyMax = 3.0 Auto Hidden
{the maximum size of the belly when full up.}

Float Property OptScaleBreastMax = 2.0 Auto Hidden
{the maximum size of the breasts when filled up.}

Float Property OptPregChanceHumanoid = 75.0 Auto Hidden
{preg chance on encounters with people.}

Float Property OptPregChanceBeast = 10.0 Auto Hidden
{preg chance on encounters with beasts.}

;; mod options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bool  Property OptDebug = TRUE Auto Hidden
{print debugging information out to the console}

Float Property OptUpdateInterval = 5.0 Auto Hidden
{how long to wait before beginning the calculation queue again.}

Float Property OptUpdateDelay = 0.125 Auto Hidden
{how long to delay the update loop each iteration.}

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
	self.Stop()
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

	self.OK = TRUE
	Return
EndFunction

Function ResetMod_Values()
{force reset settings to default values.}

	self.OptGemMatureTime = 144.0
	self.OptGemMaxCapacity = 6
	self.OptMilkProduceTime = 8.0
	self.OptMilkMaxCapacity = 3
	self.OptScaleBellyMax = 3.0
	self.OptScaleBreastMax = 2.0

	self.OptDebug = TRUE
	self.OptUpdateInterval = 5.0
	self.OptUpdateDelay = 0.125
	Return
EndFunction

Function ResetMod_Events()
{cleanup and reinit of any event handling things.}

	UnregisterForModEvent("OrgasmStart")
	UpdateLoop.UnregisterForUpdate()

	If(!self.OK)
		;; we allowed this method to do a cleanup, but if the mod is not
		;; satisified we will not re-engage events.
		Return
	EndIf

	RegisterForModEvent("OrgasmStart","OnEncounterEnding")
	UpdateLoop.RegisterForSingleUpdate(self.OptUpdateInterval)
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

;/*****************************************************************************
                          __         
 .-----.--.--.-----.-----|  |_.-----.
 |  -__|  |  |  -__|     |   _|__ --|
 |_____|\___/|_____|__|__|____|_____|
                                                             
*****************************************************************************/;

Event OnInit()
	self.OK = FALSE
	self.ResetMod_Prepare()
	self.ResetMod_Values()
	self.ResetMod_Events()
EndEvent

Event OnEncounterEnding(String EventName, String Args, Float Argc, Form From)
	Actor[] ActorList = SexLab.HookActors(Args)
	sslBaseAnimation Animation = SexLab.HookAnimation(Args)

	;; ...


	Return
EndEvent

Function EventSendGemProgress(Actor Who, Int[] Progress)
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

Function EventSendMilkProgress(Actor Who, Int Progress)
{emit an event stating the current amount of milk being carried.}

	Int e = ModEvent.Create("SGO.OnMilkProgress")

	If(e)
		ModEvent.PushForm(e,Who)
		ModEvent.PushInt(e,Progress)
		ModEvent.Send(e)
	EndIf

	Return
EndFunction

;/*****************************************************************************
             __                     __       __         
 .---.-.----|  |_.-----.----.   .--|  .---.-|  |_.---.-.
 |  _  |  __|   _|  _  |   _|   |  _  |  _  |   _|  _  |
 |___._|____|____|_____|__|     |_____|___._|____|___._|
                                                        
*****************************************************************************/;

Float Function ActorGetTimeSinceUpdate(Actor Who, String What)
{return how many game hours have passed since this actors specified data has
been updated. the string value is the storageutil name for the data you want.}

	Float Current = Utility.GetCurrentGameTime()
	Float Last = StorageUtil.GetFloatValue(Who,What,Current)

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

;/*****************************************************************************
  __                   __    __                             __ 
 |  |_.----.---.-.----|  |--|__.-----.-----.   .---.-.-----|__|
 |   _|   _|  _  |  __|    <|  |     |  _  |   |  _  |  _  |  |
 |____|__| |___._|____|__|__|__|__|__|___  |   |___._|   __|__|
                                     |_____|         |__|      

*****************************************************************************/;

Function ActorTrackForGems(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors who are growing gems}

	If(Enabled)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Gem",Who,False)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",Who,True)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Time.Gem")
		StorageUtil.FloatListClear(Who,"SGO.Actor.Data.Gem")
	EndIf

	Return
EndFunction

Function ActorTrackForMilk(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating milk.}

	If(Enabled)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Milk",Who,False)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",Who,True)
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Time.Milk")
		StorageUtil.UnsetFloatValue(Who,"SGO.Actor.Data.Milk")
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

Function ActorUpdateBody(Actor Who)
{push the updated visual data into NiOverride. cheers to Groovtama for helping
witht he NiO stuffs.}

	self.ActorUpdateBody_BellyScale(Who)
	self.ActorUpdateBody_BreastScale(Who)
	Return
EndFunction

Function ActorUpdateBody_BellyScale(Actor Who)
{handle the physical representation of the belly.}

	Float Belly = 1.0
	Bool Female = (Who.GetActorBase().GetSex() == 1)

	;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;

	Int x = 0
	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem")
	Float Weight = 0.0

	While(x < Count)
		Weight += StorageUtil.FloatListGet(Who,"SGO.Actor.Data.Gem",x)
		x += 1
	EndWhile

	;; with a max of six gems, max of 300% more visual
	;; depending on how the visual results look we may want to curve this value.
	;; to scale less at higher volumes.
	;; 0 gems (( 0 / 36) * 3.0) + 1 == 1.0
	;; 6 gems ((36 / 36) * 3.0) + 1 == 4.0

	Belly = ((Weight / (6 * self.OptGemMaxCapacity)) * self.OptScaleBellyMax) + 1

	;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;

	If(Belly == 1.0)
		NiOverride.RemoveNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC Belly","SGO.Scale")
	Else
		NiOverride.AddNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC Belly","SGO.Scale",Belly)
	EndIf

	NiOverride.UpdateNodeTransform((Who as ObjectReference),FALSE,Female,"NPC Belly")
	Return
EndFunction

Function ActorUpdateBody_BreastScale(Actor Who)
{handle the physical representation of the breasts.}
	
	Float Breast = 1.0
	Bool Female = (Who.GetActorBase().GetSex() == 1)

	;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;

	;; with a max of 3 bottles, max of 200% more visual
	;; 0 milk ((0 / 3) * 2.0) + 1 == 1.0
	;; 3 milk ((3 / 3) * 2.0) + 1 == 3.0

	Breast = ((StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Milk") / self.OptMilkMaxCapacity) * self.OptScaleBreastMax) + 1

	;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;

	If(Breast == 1.0)
		NiOverride.RemoveNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC L Breast","SGO.Scale")
		NiOverride.RemoveNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC R Breast","SGO.Scale")
	Else
		NiOverride.AddNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC L Breast","SGO.Scale",Breast)
		NiOverride.AddNodeTransformScale((Who as ObjectReference),FALSE,Female,"NPC R Breast","SGO.Scale",Breast)
	EndIf

	NiOverride.UpdateNodeTransform((Who as ObjectReference),FALSE,Female,"NPC L Breast")
	NiOverride.UpdateNodeTransform((Who as ObjectReference),FALSE,Female,"NPC R Breast")
	Return
EndFunction

;/*****************************************************************************
                                       __ 
 .-----.-----.--------.   .---.-.-----|__|
 |  _  |  -__|        |   |  _  |  _  |  |
 |___  |_____|__|__|__|   |___._|   __|__|
 |_____|                        |__|      
                                          
*****************************************************************************/;

Function ActorUpdateGemData(Actor Who, Bool Force=FALSE)
{cause this actor to have its gem data recalculated. it will generate an array
that is a snapshot of the current gem states, and that snapshot will be emitted
in a mod event if a gem reached the next stage. this is probably the heaviest
function in this mod, as data is flying in and out of papyrusutil constantly.}

	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Gem")
	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	Int[] Progress = new Int[7]
	Bool Progressed = FALSE
	Int Count = StorageUtil.FloatListCount(Who,"SGO.Actor.Data.Gem")

	Float Gem
	Float Before
	Int x = 0
	While(x < Count)
		Gem = StorageUtil.FloatListGet(Who,"SGO.Actor.Data.Gem",x)
		Before = Gem

		Gem += (Time / self.OptGemMatureTime)

		If(Gem <= 6)
			Progress[Gem as Int] = Progress[Gem as Int] + 1
		Else
			Progress[6] = Progress[6] + 1
		EndIf

		If(Before as Int != Gem as Int)
			;; if the gem reached the next stage then mark it down
			;; so we can emit an event listing the progression.
			Progressed = TRUE
		EndIf
		
		StorageUtil.FloatListSet(Who,"SGO.Actor.Data.Gem",x,Gem)
		x += 1
	EndWhile
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Gem")

	;;;;;;;;
	;;;;;;;;

	If(Progressed)
		self.EventSendGemProgress(Who,Progress)
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

Function ActorUpdateMilkData(Actor Who, Bool Force=FALSE)
{cause this actor to have its milk data recalculated. if we have gained another
full bottle then emit a mod event saying how many bottles are ready to go.}

	Float Time = self.ActorGetTimeSinceUpdate(Who,"SGO.Actor.Time.Milk")

	If(Time < 1.0 && !Force)
		;; no need to recalculate this actor more than once a game hour.
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	Float Milk = StorageUtil.GetFloatValue(Who,"SGO.Actor.Data.Milk",0.0)
	Float Before = Milk

	Milk += (Time / self.OptMilkProduceTime)
	If(Milk > self.OptMilkMaxCapacity)
		Milk = self.OptMilkMaxCapacity
	EndIf

	StorageUtil.SetFloatValue(Who,"SGO.Actor.Data.Milk",Milk)
	self.ActorSetTimeUpdated(Who,"SGO.Actor.Time.Milk")

	;;;;;;;;
	;;;;;;;;

	If(Before as Int != Milk as Int)
		self.EventSendMilkProgress(Who,(Milk as Int))
	EndIf

	Return
EndFunction
