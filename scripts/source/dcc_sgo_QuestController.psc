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
;; ASCII Text http://patorjk.com/software/taag/#p=display&f=Cricket

;; >
;; THERE ARE ONLY 6 SOULGEM
;; MODELS.

;; StorageUtil Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FormList SGO.ActorList.Gems - list all actors currently growing gems.
;; FormList SGO.ActorList.Milk - list all actors currently producing milk.

;/*****************************************************************************
                                    __   __             
 .-----.----.-----.-----.-----.----|  |_|__.-----.-----.
 |  _  |   _|  _  |  _  |  -__|   _|   _|  |  -__|__ --|
 |   __|__| |_____|   __|_____|__| |____|__|_____|_____|
 |__|             |__|                                  

*****************************************************************************/;

;; scripts n stuff.
dcc_sgo_QuestController_UpdateLoop Property UpdateLoop Auto

;; mod options (most changable via mcm)
Bool  Property OK = FALSE Auto Hidden
Float Property OptUpdateInterval = 5.0 Auto Hidden

;/*****************************************************************************
                     __                      __              __ 
 .--------.-----.--|  |   .----.-----.-----|  |_.----.-----|  |
 |        |  _  |  _  |   |  __|  _  |     |   _|   _|  _  |  |
 |__|__|__|_____|_____|   |____|_____|__|__|____|__| |_____|__|

*****************************************************************************/;

Event OnInit()
	self.OK = FALSE
	self.ResetMod_Prepare()
	self.ResetMod_Values()
	self.ResetMod_Events()
EndEvent

Function ResetMod()
{perform a quest (and ergo mod) reboot.}

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

	self.OK = TRUE
	Return
EndFunction

Function ResetMod_Values()
{force reset settings to default values.}

	self.OptUpdateInterval = 5.0
	Return
EndFunction

Function ResetMod_Events()
{cleanup and reinit of any event handling things.}

	UpdateLoop.UnregisterForUpdate()

	If(!self.OK)
		;; we allowed this method to do a cleanup, but if the mod is not
		;; satisified we will not re-engage events.
		Return
	EndIf

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

Bool Function IsInstalledNiOverride()
{make sure nioverride is installed and active.}

	If(SKSE.GetPluginVersion("nioverride.dll") == -1)
		Debug.MessageBox("NiOverride is not installed. Install it by installing RaceMenu or by installing it standalone from the Nexus.")
		Return FALSE
	EndIf

	Return TRUE
EndFunction

Bool Function IsInstalledUIExtensions()
{make sure UIExtensions is installed and active.}

	If(Game.GetModByName("UIExtensions.esp") == 255)
		Debug.MessageBox("UIExtensions is not installed. Install it from the Nexus.")
		Return FALSE
	EndIf

	Return TRUE
EndFunction

;/*****************************************************************************
  __                   __    __                             __ 
 |  |_.----.---.-.----|  |--|__.-----.-----.   .---.-.-----|__|
 |   _|   _|  _  |  __|    <|  |     |  _  |   |  _  |  _  |  |
 |____|__| |___._|____|__|__|__|__|__|___  |   |___._|   __|__|
                                     |_____|         |__|      

*****************************************************************************/;

Function TrackActorForGems(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors who are growing gems}

	If(Enabled)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Gems",Who,False)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Gems",Who,True)
	EndIf

	Return
EndFunction

Function TrackActorForMilk(Actor Who, Bool Enabled)
{place or remove an actor from the list tracking actors generating milk.}

	If(Enabled)
		StorageUtil.FormListAdd(None,"SGO.ActorList.Milk",Who,False)
	Else
		StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",Who,True)
	EndIf		

	Return
EndFunction
