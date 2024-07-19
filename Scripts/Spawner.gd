extends Node3D

var enemyScene = preload("res://Scenes/enemy.tscn")

@export var timeInterval = 2

@onready var timer = $Timer

func _ready():
	timer.set_wait_time(timeInterval)

#function runs every time timer times out (through signals)
func _on_timer_timeout():
	#Instantiate enemy
	var enemy = enemyScene.instantiate()
	#set their position to be wherever the spawner is
	
	add_child(enemy)
