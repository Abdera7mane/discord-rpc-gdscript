extends Node

# warnings-disable

var discord_rpc: DiscordRPC = DiscordRPC.new()

# https://discord.com/developers/applications/
# application_id: Found in 'Genneral' information' & OAuth2'
# secret: Found in 'OAuth2'
var application_id: int = 123456789012345678
var secret: String
var access_token: String

func _ready() -> void:
	discord_rpc.rpc_ready.connect(_on_ready)
	discord_rpc.authorized.connect(_on_authorized)
	discord_rpc.authenticated.connect(_on_authenticated)
	discord_rpc.rpc_error.connect(_on_error)
	discord_rpc.notification_create.connect(_on_notification)

	add_child(discord_rpc)
	
	discord_rpc.establish_connection(application_id)

func _on_ready(user: Dictionary) -> void:
	print("Discord RPC Ready")
	print("Client username: ", user["username"])
	
	if access_token.is_empty():
		# Authorize your application for the first time or when 'access_token' expires
		var scopes: PackedStringArray = ["rpc", "rpc.notifications.read"]
		discord_rpc.authorize(scopes, secret)
		
	else:
		discord_rpc.authenticate(access_token)

func _on_authorized(access_token: String) -> void:
	# You must save the 'access_token' to authenticate directly next time
	pass

func _on_authenticated(_application: Dictionary, expires: String) -> void:
	print("access_token expiry: ", expires)
	print("Authenticated !")
	# Now you can call RPC commands that require specific scopes
	
	discord_rpc.subscribe("NOTIFICATION_CREATE")

func _on_error(error: int) -> void:
	print("RPC Connection ERROR: ", error)

func _on_notification(channel_id: String, message: Dictionary, icon_url, title: String, body: String) -> void:
	# Do stuff
	pass
