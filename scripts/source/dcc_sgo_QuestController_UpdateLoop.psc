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
	SGO.ActorFertilityUpdateData(SGO.Player)

	self.OnUpdate_GemData()
	self.OnUpdate_MilkData()
	self.OnUpdate_SemenData()
	self.RegisterForSingleUpdate(SGO.OptUpdateInterval)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function OnUpdate_GemData()
{run through the list to process gem data for actors on the list.}

	;; cleanup things the engine fucked us over.
	StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",None,TRUE)

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Gem")
	Actor Who

	;;SGO.PrintDebug("Gem List " + Count)

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Gem",x) as Actor

		If(Who)
			;;SGO.PrintDebug("Update Gem Data " + Who.GetDisplayName())
			SGO.ActorGemUpdateData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_MilkData()
{run through the list to process the milk data for actors on the list.}

	;; cleanup things the engine fucked us over.
	StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",None,TRUE)

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Milk")
	Actor Who

	;; SGO.PrintDebug("Milk List " + Count)

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Milk",x) as Actor

		If(Who)
			;; SGO.PrintDebug("Update Milk Data " + Who.GetDisplayName())
			SGO.ActorMilkUpdateData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_SemenData()
{run through the list to process the semen data for actors on the list.}

	;; cleanup things the engine fucked us over.
	StorageUtil.FormListRemove(None,"SGO.ActorList.Semen",None,TRUE)

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Semen")
	Actor Who

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Semen",x) as Actor

		If(Who)
			SGO.ActorSemenUpdateData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction