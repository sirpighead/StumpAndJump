extends ParallaxLayer

export(float) var CLOUD_SPEED = -20


func _process(delta: float) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta
