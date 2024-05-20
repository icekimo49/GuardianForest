extends Resource

class_name InvItem

@export var name : String = ""
@export var texture : Texture2D
@export var stack : bool
@export var type : bool

#stack true = stack, false = non-stack
#type true = material, false = tools
