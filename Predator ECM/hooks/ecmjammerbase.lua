Hooks:PostHook(ECMJammerBase, "init", "init_predator", function (self)
	self._g_glow_feedback_red:set_visibility(true)
end)

Hooks:PostHook(ECMJammerBase, "_set_battery_low", "_set_battery_low_predator", function (self)
	self._g_glow_jammer_red:set_visibility(false)
end)

Hooks:PostHook(ECMJammerBase, "_set_battery_empty", "_set_battery_empty_predator", function (self)
	self._g_glow_jammer_red:set_visibility(true)
end)

Hooks:PostHook(ECMJammerBase, "_set_feedback_active", "_set_feedback_active_predator", function (self, state)
	self._g_glow_feedback_green:set_visibility(state)
	self._g_glow_feedback_red:set_visibility(not state)
	
	log("feedback", tostring(state))

	if not state or self._feedback_expire_t or not self._owner_id then
		return
	end

	local duration_mul = 1
	if self._owner_id == 1 then
		duration_mul = duration_mul * managers.player:upgrade_value("ecm_jammer", "feedback_duration_boost", 1)
		duration_mul = duration_mul * managers.player:upgrade_value("ecm_jammer", "feedback_duration_boost_2", 1)
	else
		duration_mul = duration_mul * (self:owner():base():upgrade_value("ecm_jammer", "feedback_duration_boost") or 1)
		duration_mul = duration_mul * (self:owner():base():upgrade_value("ecm_jammer", "feedback_duration_boost_2") or 1)
	end

	self._feedback_duration = math.lerp(tweak_data.upgrades.ecm_feedback_min_duration or 15, tweak_data.upgrades.ecm_feedback_max_duration or 20, math.random()) * duration_mul
	self._feedback_expire_t = t + self._feedback_duration
end)

Hooks:PostHook(ECMJammerBase, "update", "update_predator", function (self, unit, t)
	if self._battery_low and not self._battery_empty then
		if not self._low_battery_blink_t or self._low_battery_blink_t < t then
			self._g_glow_jammer_green:set_visibility(not self._g_glow_jammer_green:visibility())
			self._low_battery_blink_t = t + 0.15
		end
	end

	if self._feedback_active and self._feedback_expire_t and self._feedback_expire_t - t < self._feedback_duration * 0.1 then
		if not self._low_feedback_blink_t or self._low_feedback_blink_t < t then
			self._g_glow_feedback_green:set_visibility(not self._g_glow_feedback_green:visibility())
			self._low_feedback_blink_t = t + 0.15
		end
	end
end)

local clbk_feedback = ECMJammerBase.clbk_feedback
function ECMJammerBase:clbk_feedback(...)
	local green = self._g_glow_feedback_green:visibility()
	local red = self._g_glow_feedback_red:visibility()

	clbk_feedback(self, ...)

	self._g_glow_feedback_green:set_visibility(green and self._feedback_active)
	self._g_glow_feedback_red:set_visibility(red or not self._feedback_active)
end
