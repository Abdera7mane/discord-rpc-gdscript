extends Node

# https://discord.com/developers/docs/topics/gateway-events#activity-object-activity-structure
# ^ (not all fields are allowed by Discord)

const APPLICATION_ID: int = 123456789012345678 

var discord := DiscordRPC.new()

func _ready() -> void:
	add_child(discord)

	discord.rpc_ready.connect(
		func(user: Dictionary):
			discord.update_presence({
				details = "In lobby",
				state = "AFK",
				timestamps = {
					start = int(Time.get_unix_time_from_system())
				},
				assets = {
					large_image = "game_icon",
				}
			})
	)

	discord.establish_connection(APPLICATION_ID)

