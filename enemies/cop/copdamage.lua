local CopDamage = module:hook_class("CopDamage")

module:hook(CopDamage, "damage_melee", function(self, attack_data)
	if self._dead or self._invulnerable then
		return
	end

	local result
	local head = self._head_body_name
		and attack_data.col_ray.body
		and attack_data.col_ray.body:name() == self._ids_head_body_name
	local damage = attack_data.damage
	if head then
		if self._char_tweak.headshot_dmg_mul then
			damage = damage * self._char_tweak.headshot_dmg_mul
		else
			damage = self._health * 10
		end
	end

	local damage_effect = attack_data.damage_effect
	damage = math.clamp(damage, self._HEALTH_INIT_PRECENT, self._HEALTH_INIT)
	local damage_percent = math.ceil(damage / self._HEALTH_INIT_PRECENT)
	damage = damage_percent * self._HEALTH_INIT_PRECENT

	if damage >= self._health then
		attack_data.damage = self._health
		result = {
			type = "death",
			variant = attack_data.variant,
		}
		self:die(attack_data.variant)
	else
		attack_data.damage = damage
		damage_effect = math.clamp(damage_effect, self._HEALTH_INIT_PRECENT, self._HEALTH_INIT)
		local damage_effect_percent = math.ceil(damage_effect / self._HEALTH_INIT_PRECENT)
		local result_type = CopDamage.get_damage_type(self._char_tweak.damage.hurt_severity, damage_effect_percent)
		result = {
			type = result_type,
			variant = attack_data.variant,
		}
		self._health = self._health - damage
		self._health_ratio = self._health / self._HEALTH_INIT
	end

	attack_data.result = result
	attack_data.pos = attack_data.col_ray.position

	if result.type == "death" then
		local data = {
			name = self._unit:base()._tweak_table,
			head_shot = head,
			weapon_unit = attack_data.weapon_unit,
			variant = attack_data.variant,
		}

		managers.statistics:killed_by_anyone(data)
		if attack_data.attacker_unit == managers.player:player_unit() then
			self:_comment_death(attack_data.attacker_unit, self._unit:base()._tweak_table)
			self:_show_death_hint(self._unit:base()._tweak_table)
			managers.statistics:killed(data)
		end
	end

	self:_send_melee_attack_result(
		attack_data,
		damage_percent,
		math.clamp(attack_data.col_ray.position.z - self._unit:movement():m_pos().z, 0, 300)
	)
	self:_on_damage_received(attack_data)

	return result
end)
