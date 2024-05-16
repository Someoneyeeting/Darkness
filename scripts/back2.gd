extends Sprite2D




func _ready() -> void:
	LightManger.background = self
	LevelManger._play_off()
