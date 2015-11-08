Scriptname dcc_sgo_QuestController_UpdateLoop extends Quest
{This script will do nothing but perform the update loop for recalculating the
tracked actors. It has been separated from the main QuestController API to
hopefully make integration from ther mods a bit cleaner. this also implements
the single update process to prevent thread stacking, as well as delays to
throttle how fast it can try and chug the lists.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Global SGO.Actorlist.Gem
;; Global SGO.ActorList.Milk
;; GLobal SGo.ActorList.Semen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dcc_sgo_QuestController Property SGO Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Event OnUpdate()
	If(!SGO.Enabled)
		Return
	EndIf

	;; maintenance.
	self.OnUpdate_CleanLostData()
	self.OnUpdate_CleanPersistHack()

	;; data processing.
	SGO.ActorFertilityUpdateData(SGO.Player)
	self.OnUpdate_GemData()
	self.OnUpdate_MilkData()
	self.OnUpdate_SemenData()

	self.RegisterForSingleUpdate(SGO.OptUpdateInterval)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function OnUpdate_CleanLostData()
{pull any lost references out of the lists.}

	;; cleanup things the engine fucked us over.
	StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",None,TRUE)
	StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",None,TRUE)
	StorageUtil.FormListRemove(None,"SGO.ActorList.Semen",None,TRUE)

	Return
EndFunction

Function OnUpdate_GemData()
{run through the list to process gem data for actors on the list.}

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Gem")
	Actor Who

	;;SGO.PrintDebug("Gem List " + Count)

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Gem",x) as Actor

		If(Who && Who.Is3DLoaded())
			;;SGO.PrintDebug("Update Gem Data " + Who.GetDisplayName())
			SGO.ActorGemUpdateData(Who)
			SGO.ActorApplyBellyEncumber(Who)
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

	;; SGO.PrintDebug("Milk List " + Count)

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Milk",x) as Actor

		If(Who && Who.Is3DLoaded())
			;; SGO.PrintDebug("Update Milk Data " + Who.GetDisplayName())
			SGO.ActorMilkUpdateData(Who)
			SGO.ActorApplyBreastInfluence(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_SemenData()
{run through the list to process the semen data for actors on the list.}

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Semen")
	Actor Who

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Semen",x) as Actor

		If(Who && Who.Is3DLoaded())
			SGO.ActorSemenUpdateData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		x += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_CleanPersistHack()
{run through the list of persistance hacks to remove any that need to be
removed.}

	Int Count = StorageUtil.FormListCount(None,"SGO.ActorList.Persist")
	Form Who

	Int Gem
	Int Milk
	Int Semen

	Int x = 0
	While(x < Count)
		Who = StorageUtil.FormListGet(None,"SGO.ActorList.Persist",x)

		;; check if this actor exists in the other lists. if not, remove it.
		Gem = StorageUtil.FormListFind(None,"SGO.ActorList.Gem",Who)
		Milk = StorageUtil.FormListFind(None,"SGO.ActorList.Milk",Who)
		Semen = StorageUtil.FormListFind(None,"SGO.ActorList.Semen",Who)

		If(Gem == -1 && Milk == -1 && Semen == -1)
			SGO.PersistHackClear(Who as Actor)
		EndIf

		Utility.Wait(SGO.OptUpdateDelay)
		x += 1
	EndWhile

	Return
EndFunction