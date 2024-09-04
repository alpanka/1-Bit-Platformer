General Topics
[] Adapt got hit shader
[] Add UI
	[] Create theme for the main UI node
	[] Player health
	[] Player kill count
	[X] Add a GameWorld scene
		- Systems
		- UI
		- Level
[] Add player state machine
	[] Adjust animations for each state


[] Player death scene


AnimatedSprite2D
	[] Add more animations

ShooterController
	[] Add a cooldown timer

ProjectileBase
	[] Make it queue_free upon collision

	[] Add variety
	[] Add magazine count mechanic
	[] Add knockback

WanderingController
	[] Apply timer
	[] Adjust collision layers/masks


Extra topics to consider, research
	[] Try to optimize character stat init function.
		Better way to make it work for both enemy and player?
			get_script_property_list()
