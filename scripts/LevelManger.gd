extends Node


signal switchon
signal restart
var curlevel = 0
var waitingnext = false
var platformdir = false


func _play_off():
	$off.play()

func switch_level(level,flag = true):
	#if("web" not in OS.get_name().to_lower()):
		#$off.play()
	if("web" not in OS.get_name().to_lower() or flag):
		$platformtimer.start()
		get_tree().change_scene_to_file("res://levels/" + str(level) + ".tscn")


func get_platform_pos():
	if(platformdir):
		return 1 - $platformtimer.time_left/$platformtimer.wait_time
	else:
		return $platformtimer.time_left/$platformtimer.wait_time
		

func darken():
	$ColorRect.show()
	$off.play()

func reload_level():
	if($restart.time_left <= 0):
		darken()
		$restart.start()

func next_level():
	curlevel += 1
	switch_level(curlevel)

func _switch_off():
	$CanvasLayer/ColorRect.material.set_shader_parameter("intense",5.0)
	LightManger.turn_off()

func _switch_on():
	waitingnext = true
	$CanvasLayer/ColorRect.material.set_shader_parameter("intense",3.0)
	$on.play()
	LightManger.turn_on()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		if(waitingnext):
			next_level()
			waitingnext = false

#func _physics_process(delta: float) -> void:
	#$Camera2D.global_position.x = randf_range(-10,10) / 20
	#$Camera2D.global_position.y = randf_range(-10,10) / 20


func _ready() -> void:
	#reload_level()
	switchon.connect(_switch_on)
	restart.connect(reload_level)
	$CanvasLayer/ColorRect.material.set_shader_parameter("web",true)


func _on_restart_timeout() -> void:
	$ColorRect.hide()
	switch_level(curlevel,"web" not in OS.get_name().to_lower())


func _on_platformtimer_timeout() -> void:
	$platformcooldown.start()


func _on_platformcooldown_timeout() -> void:
	platformdir = not platformdir
	$platformtimer.start()
