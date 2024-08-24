##
## Item's area where it does ouch
##
class_name HitboxController
extends BoxControllerBase

var owner_type: String

func _ready() -> void:
	controller_area_init()
	_check_owner_type()

	
	self.emit_signal("area_entered")


func _check_owner_type():
	if owner_node is PlatformerCharacterBase:
		owner_type = "PlatformerCharacter"
