extends Area2D
class_name HurtboxComponent

@export var entity: Entity
@export var collision_shape: CollisionShape2D

var hitbox_component: HitboxComponent


func _ready():
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)


func _process(delta: float) -> void:
	if hitbox_component == null:
		return
	
	if hitbox_component.active:
		collision_shape.disabled = true 
		hitbox_component.hit.emit()
		entity._despawn(entity.death_type.EATEN) 


func on_area_entered(other_area: Area2D):
	if not other_area is HitboxComponent:
		return
	
	if entity == null:
		return
	
	hitbox_component = other_area


func on_area_exited(other_area: Area2D): 
	hitbox_component = null
