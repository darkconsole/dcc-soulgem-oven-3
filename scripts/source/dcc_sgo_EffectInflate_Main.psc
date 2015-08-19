Scriptname dcc_sgo_EffectInflate_Main extends ActiveMagicEffect

dcc_sgo_QuestController Property SGO Auto

Float Property Value Auto Hidden
Bool Property Up Auto Hidden
Bool Property Female Auto Hidden
Actor Property Who Auto Hidden

Event OnEffectStart(Actor Target, Actor From)
	self.Who = Target
	self.Value = 1.0
	self.Up = TRUE
	self.Female = (Target.GetActorBase().GetSex() == 1)
	self.OnUpdate()
	Return
EndEvent

Event OnUpdate()

	If(self.Up)
		self.Value += 0.01
		If(self.Value >= 2.0)
			self.Value = 2.0
			self.Up = FALSE
			Utility.Wait(2.0)
		EndIf
	Else
		self.Value -= 0.005
		If(self.Value <= 1.0)
			self.Value = 1.0
		EndIf
	EndIf

	;;SGO.PrintDebug(self.Who.GetDisplayName() + " inflate " + self.Value)
	NiOverride.AddNodeTransformScale((self.Who as ObjectReference),FALSE,self.Female,"NPC Belly","SGO.Inflate",self.Value)
	NiOverride.UpdateNodeTransform((self.Who as ObjectReference),FALSE,self.Female,"NPC Belly")

	If(self.Value > 1.0)
		Utility.Wait(0.01)
		self.OnUpdate()
	Else
		NiOverride.RemoveNodeTransformScale(self.Who,FALSE,self.Female,"NPC Belly","SGO.Inflate")
		self.Who.RemoveSpell(SGO.dcc_sgo_SpellInflate)
	EndIf

	Return
EndEvent
