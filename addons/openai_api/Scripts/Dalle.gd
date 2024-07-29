extends Node
class_name Dalle
var http_request: HTTPRequest
var http_request_image_download: HTTPRequest

@onready var parent = get_parent()


func _ready():
	#the http request to generate the image
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	
	#the http request do download the image
	http_request_image_download = HTTPRequest.new()
	add_child(http_request_image_download)
	http_request_image_download.request_completed.connect(self._image_downloaded)
	
func prompt_dalle(prompt:String, resolution:String = "1024x1024", model: String = "dall-e-2", url:String="https://api.openai.com/v1/images/generations"):
	var openai_api_key = parent.get_api()
	if !openai_api_key:
		return
	var headers = [
		"Content-Type: application/json",
		"Authorization: Bearer " + openai_api_key
	]
	var body = {
		"model": model,
		"prompt": prompt,
		"n": 1,
		"size": resolution
	}
	
	var json = JSON.new()
	var body_json = json.stringify(body)
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body_json)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Error with the request.")
		return
	
	var json = JSON.new()
	var error = json.parse(body.get_string_from_utf8())
	if error != OK:
		push_error("Error parsing response.")
		return
	
	var response = json.get_data()
	if "data" in response and response["data"].size() > 0:
		var image_url = response["data"][0]["url"]
		http_request_image_download.request(image_url)


func _image_downloaded(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Failed to download the image.")
		return
	
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")
		return
	
	var texture = ImageTexture.create_from_image(image)
	parent.emit_signal("dalle_response_completed", texture)
