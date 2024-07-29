class_name Message extends Node

## The Message class is used to represent a message in the conversation system.
## 
## This class includes properties for the role and content of a message, along with
## methods to set and retrieve these properties.
##
# @tutorial:            https://the/tutorial1/url.com
# @tutorial(Tutorial2): https://the/tutorial2/url.com
# @experimental

## The role of the sender in the conversation (e.g., "user" or "system").
## This variable holds the role of the message sender.
var role: String = "user"

## The text content of the message.
## This variable contains the actual message text.
var content: String = "say 'template text'"

## Sets the role of the message sender.
##
## This function updates the `role` variable with a new role.
func set_role(new_role: String) -> void:
	role = new_role
	
## Sets the content of the message.
##
## This function updates the `content` variable with new content.
func set_content(new_content: String) -> void:
	content = new_content
	
## Retrieves the role of the message sender.
##
## This function returns the current value of the `role` variable.
func get_role() -> String:
	return role
	
## Retrieves the content of the message.
##
## This function returns the current value of the `content` variable.
func get_content() -> String:
	return content

## Retrieves the role and the content of the message.
##
## This function returns the current value of the `role` and `content` as a Dictionary variable.
func get_as_dict() -> Dictionary:
	return {"role":role,"content":content}

## Sets the content of the message.
##
## This function updates the current value of the `role` and `content` as a Dictionary variable.
func set_as_dict(dictionary:Dictionary) -> void:
	if !dictionary.has("role") or !dictionary.has("content"):
		push_error("Dictionary for \"set_as_dict\" do not containt the needed keys!")
		return
	set_role(dictionary["role"])
	set_content(dictionary["content"])
