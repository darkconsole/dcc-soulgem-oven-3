Scriptname dcc_sgo_QuestController_UpdateLoop extends Quest
{This script will do nothing but perform the update loop for recalculating the
tracked actors. It has been separated from the main QuestController API to
hopefully make integration from ther mods a bit cleaner. this also implements
the single update process to prevent thread stacking, as well as delays to
throttle how fast it can try and chug the lists.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dcc_sgo_QuestController Property SGO Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Event OnUpdate()
	self.OnUpdate_GemData()
	self.OnUpdate_MilkData()
	self.RegisterForSingleUpdate(SGO.OptUpdateInterval)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function OnUpdate_GemData()
{run through the list to process gem data for actors on the list.}

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Gem")
	Actor Who

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Gem",x) as Actor

		If(Who)
			SGO.ActorUpdateGemData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_MilkData()
{run through the list to process the milk data for actors on the list.}

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Milk")
	Actor Who

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Milk",x) as Actor

		If(Who)
			SGO.ActorUpdateMilkData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction
