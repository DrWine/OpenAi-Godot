# OpenAI Godot Plugin

This plugin integrates OpenAI's GPT and DALL-E APIs into Godot, allowing easy access to these powerful AI tools within your Godot projects.

## Features

- ChatGPT integration for text generation
- DALL-E integration for image generation
- Asynchronous API calls using Godot's HTTPRequest
- Easy-to-use Message class for handling conversation context

## Installation

1. Clone this repository or download the plugin files.
2. Copy the `addons/openai_api` folder into your Godot project's `addons` directory.
3. Enable the plugin in your project settings.

## Usage
### Add the OpenAi node
![image](https://github.com/user-attachments/assets/a881abdb-b0b7-4034-8859-b7e5fa05cfdc)

### Setting up the API Key

Before using the plugin, make sure to set your OpenAI API key:

```gdscript
var openai = get_node("OpenAI")
openai.set_api("your-api-key-here")
```
### Using ChatGPT

To send a prompt to ChatGPT:

```gdscript
var messages = [Message.new()]
messages[0].set_content("Hello, how are you?")
openai.prompt_gpt(messages)
```

Listen for the response:

```gdscript
func _ready():
	open_ai.connect("gpt_response_completed", gpt_response_completed)

func _on_gpt_response(message: Message, response: Dictionary):
	print(message.get_content())
```

Full code:
```gdscript
extends Node2D

@onready var open_ai = $OpenAi

# Called when the node enters the scene tree for the first time.
func _ready():
	##Conecting the output from chatgpt
	open_ai.connect("gpt_response_completed", gpt_response_completed)
	
	##Creating meessages template
	var messages:Array[Message] = [Message.new()]
	messages[0].set_content("say hi!")
	
	##setting the api key
	open_ai.set_api("<API HERE>")
	
	##Prompt chatgpt
	open_ai.prompt_gpt(messages)
	
func gpt_response_completed(message:Message, response:Dictionary):
	printt(message.get_as_dict())
```

### Using DALL-E

To generate an image with DALL-E:

```gdscript
openai.prompt_dalle("A beautiful sunset over mountains")
```

Listen for the response:

```gdscript
func _ready():
	open_ai.connect("dalle_response_completed", dalle_response_completed)

func _on_dalle_response(texture: ImageTexture):
	$Sprite2D.texture = texture
```

## Classes

### OpenAI

The main node that handles API requests and responses.

### Message

A utility class for handling conversation messages.

### ChatGpt

Handles ChatGPT API requests.

### Dalle

Handles DALL-E API requests.
