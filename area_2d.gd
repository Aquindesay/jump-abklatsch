extends StaticBody2D

func _ready():
	create_collision()

func create_collision():
	var collision = CollisionShape2D.new()
	var shape = WorldBoundaryShape2D.new()
	shape.size = 
	collision.shape = shape
	collision.position = $ColorRect.position + $ColorRect.size * 0.5
	
	add_child(collision)
	
