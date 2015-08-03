Scriptname dcc_sgo_QuestController_UpdateLoop extends Quest
{This script will do nothing but perform the update loop for recalculating the
tracked actors. It has been separated from the main QuestController API to
hopefully make integration from ther mods a bit cleaner.}

dcc_sgo_QuestController Property SGO Auto

Event OnUpdate()

	self.RegisterForSingleUpdate(SGO.OptUpdateInterval)
EndEvent
