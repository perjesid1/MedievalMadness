extends GutTest


class TestEnemyCombat:
	extends GutTest
	
	
	var enemy: Enemy
	
	
	func before_all() -> void:
		enemy = Enemy.new()
		add_child(enemy)
	
	
	func after_all() -> void:
		if enemy != null:
			enemy.queue_free()
	
	
	func test_enemy_take_damage() -> void:
		enemy.health = 100
		enemy.take_damage(20)
		assert_eq(enemy.health, 80, "Health should be reduced by damage amount")
	
	
	func test_enemy_handles_collosion() -> void:
		enemy.health = 100
		enemy.handle_collision(enemy.TERMINAL_VELOCITY / 2.0)
		assert_eq(enemy.health, 50, "Health should be reduced proportionally to the impact velocity's ration to the terminal velocity.")
	
	
	func test_enemy_heal() -> void:
		enemy.health = 80
		enemy.heal(30)
		assert_eq(enemy.health, enemy.MAX_HP, "Health should not exceed the maximum amount.")
	
	
	func test_enemy_negative_heal_prevented() -> void:
		enemy.health = 80
		enemy.heal(-30)
		assert_eq(enemy.health, 80, "Negative healing should not affect health.")
	
	
	func test_enemy_dies_at_zero_health_but_not_removed() -> void:
		watch_signals(enemy)
		var enemy_name: String = enemy.name
		enemy.health = 100
		enemy.take_damage(100)
		var not_freed: Variant = assert_not_freed(enemy, enemy_name)
		if not_freed != null and not_freed != false:
			assert_true(enemy.is_dead(), "Enemy should be dead at zero health.")
			assert_signal_emitted(enemy, "died", "Died signal should be emitted.")
	
	
	func test_enemy_dies_at_zero_health_and_removed() -> void:
		watch_signals(enemy)
		var enemy_name: String = enemy.name
		enemy.health = 100
		enemy.remove_upon_death = true
		enemy.handle_collision(enemy.TERMINAL_VELOCITY)
		assert_signal_emitted(enemy, "died", "Died signal should be emitted.")
		await(wait_seconds(1, "Waiting for " + enemy_name + " to be freed..."))
		assert_freed(enemy, enemy_name)
		
