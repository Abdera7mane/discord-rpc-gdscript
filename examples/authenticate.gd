extends Node

# https://discord.com/developers/applications/

const APPLICATION_ID: int = 123456789012345678
const SCOPES: PackedStringArray = ["rpc"]
const SECRET: String = ""

var access_token: String
var discord: DiscordRPC = DiscordRPC.new()

func _ready() -> void:
	add_child(discord)

	discord.rpc_ready.connect(
		func(_user: Dictionary):
			var code: String = await discord.authorize(SCOPES)

			# In production, never store or use the secret in the client side.
			# You should have a method of retreiving the `access_token`
			# from the OAuth2 code.
			access_token = await discord.get_auth_token(code, SECRET)
			
			if await discord.authenticate(access_token):
				print("Authenticated to Discord client")
			else:
				push_error("Failed to authenticate to Discord client")
	)

	discord.authenticated.connect(
		func(application: Dictionary, expires: String):
			var guilds: Array[Dictionary] = await discord.get_guilds()
			print("User is in %d guilds" % guilds.size())
	)

	discord.rpc_closed.connect(
		func():
			print("Discord RPC connection closed")
	)

	discord.rpc_error.connect(
		func(error: int):
			print("Discord RPC error: ", error)
	)

	discord.establish_connection(APPLICATION_ID)
