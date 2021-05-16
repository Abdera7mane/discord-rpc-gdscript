extends Node

var ipc: DiscordRPC = DiscordRPC.new()

# https://discord.com/developers/applications/
# application_id: Found in 'Genneral information & OAuth2'
# secret: Found in 'OAuth2'
var application_id: int = 123456789012345678
var secret: String = "mjAJ1Bfzy3ooi2qoJ6eHH1qLfHkTYEqh"
var access_token: String

func _ready() -> void:
	ipc.connect("rpc_ready", self, "_on_ready")
	ipc.connect("authorized", self, "_on_authorized")
	ipc.connect("authenticated", self, "_on_authenticated")
	
	add_child(ipc)
	
	ipc.establish_connection(application_id)

func _on_ready(user) -> void:
	print("Ready!")
	prints("client username:", user["username"])
	
	if (access_token.empty()):
		# Authorize your application for the first time or when 'access_token' expires
		var scopes: PoolStringArray = ["rpc", "rpc.notifications.read"]
		ipc.authorize(scopes, secret)
		
	else:
		ipc.authenticate(access_token)

func _on_authorized(access_token: String) -> void:
	# You must save the 'access_token' to authenticate directly next time
	ipc.authenticate(access_token)

func _on_authenticated(expires) -> void:
	print(expires)
	print("Authenticated !")
	# Now you can call RPC commands that require specific scopes
