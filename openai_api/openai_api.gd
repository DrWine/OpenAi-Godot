@tool
extends EditorPlugin

var openai_script :Script = preload("res://addons/openai_api/Scripts/OpenAiApi.gd")
var openai_icon :Texture = preload("res://addons/openai_api/Icons/openico.png")

func _enter_tree():
	add_custom_type("OpenAi","Node",openai_script,openai_icon)
	pass

func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
