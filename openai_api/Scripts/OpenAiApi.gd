@icon("res://addons/openai_api/Icons/openico.png")
extends Node

var chatgpt_inst = preload("res://addons/openai_api/Scenes/ChatGpt.tscn")
var dalle_inst = preload("res://addons/openai_api/Scenes/Dalle.tscn")

var dalle :Node = null
var chatgpt :Node = null

var openai_api_key = ""

signal gpt_response_completed(message:Message, response:Dictionary)
signal dalle_response_completed(texture:ImageTexture)

##Makes an api call to open ai chatgpt, and returns a class `Message` that contains `{"role":role,"content":content}`
func prompt_gpt(ListOfMessages:Array[Message], model: String = "gpt-o-mini", url:String="https://api.openai.com/v1/chat/completions"):
	if !chatgpt:
		push_error("ChatGpt hasnt instantiated yet!")
		return
	chatgpt.prompt_gpt(ListOfMessages,model,url)

##Makes an api call to open ai dalle, and returns the generated Texture
func prompt_dalle(prompt:String, resolution:String = "1024x1024", model: String = "dall-e-2", url:String="https://api.openai.com/v1/images/generations"):
	if !dalle:
		push_error("Dalle hasnt instantiated yet!")
		return
	dalle.prompt_dalle(prompt,resolution,model,url)

func get_api() -> String:
	if openai_api_key.is_empty() or openai_api_key == "":
		push_error("Insert your OpenAi api key!")
	return openai_api_key
	
func set_api(api:String) -> void:
	openai_api_key = api

func _ready():
	if chatgpt and dalle:
		return
		
	call_deferred("add_child",chatgpt_inst.instantiate())
	call_deferred("add_child",dalle_inst.instantiate())
	
func _process(delta):
	if dalle and chatgpt:
		set_process(false)
	if get_children() == []:
		return
		
	chatgpt = get_children()[0]
	dalle = get_children()[1]
