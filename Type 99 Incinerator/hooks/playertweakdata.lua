Hooks:PostHook(PlayerTweakData, "init", "Type99IncModInit", function(self)
if self.stances.system then
	self.stances.system.standard.shoulders.translation = Vector3(-1.747, 10.399, -3.338)
	self.stances.system.standard.shoulders.rotation = Rotation(-0.107, 0.0860002, -0.628)

	self.stances.system.crouched.shoulders.translation = Vector3(-3.747, 9.399, -6.338)
	self.stances.system.crouched.shoulders.rotation = Rotation(-0.107, 0.0860001, -9.628)

	self.stances.system.steelsight.shoulders.translation = Vector3(-10.722, 6.399, -1.977)
	self.stances.system.steelsight.shoulders.rotation = Rotation(-0.107, 0.0860002, -0.628)
end
end)