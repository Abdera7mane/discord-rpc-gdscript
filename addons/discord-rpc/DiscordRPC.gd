class_name DiscordRPC extends Node

# warning-ignore-all:unused_signal
# warning-ignore-all:return_value_discarded


## Emitted when a connection to a Discord client is established.
## [code]user[/code] is a [code]Dictionary[/code]
## of this [url=https://discord.com/developers/docs/resources/user#user-object]structure[/url]
signal rpc_ready(user: Dictionary)

## Emitted when Discord authorized the current application.
## [code]code[/code] is the OAuth2 authorization code.
signal authorized(code: String)

## Emitted when Discord autenticated the current application.
## [code]application[/code] is a [url=https://discord.com/developers/docs/resources/application#application-object]Discord application[/url] object. 
## [code]expires[/code] is an ISO-8601 string representing the expiration date of OAuth2 token.
signal authenticated(application: Dictionary, expires: String)

## Emitted when a subscribed server's state changes.
## [code]guild[/code] is a partial [url=https://discord.com/developers/docs/resources/guild#guild-object]guild[/url] object.
signal guild_status(guild: Dictionary)

## Emitted when a guild is created/joined on the client.
## [code]id[/code] is the server id.
## [code]name[/code] is the name of the server.
signal guild_create(id: String, name: String)

## Emitted when a channel is created/joined on the client.
## [code]id[/code] is the channel id.
## [code]name[/code] is the name of the channel.
## [code]type[/code] denotes the [url=https://discord.com/developers/docs/resources/channel#channel-object-channel-types]channel type[/url].
signal channel_create(id: String, name: String, type: String)

## Emitted when the client joins a voice channel.
## [code]channel_id[/code] is the channel's id.
## [code]guild_id[/code] is the guild's id of the voice channel.
signal voice_channel_select(channel_id: String, guild_id: String)

## Emitted when a user joins a subscribed voice channel.
## [code]member[/code] is a partial [url=https://discord.com/developers/docs/resources/guild#guild-member-object]guild member[/url] object
## with extra [code]voice_state[/code], [code]volume[/code] and [code]pan[/code] fields.
signal voice_state_create(member: Dictionary)

## Emitted when a user's voice state changes in a subscribed voice channel (mute, volume, etc...).
## [code]member[/code] is a partial [url=https://discord.com/developers/docs/resources/guild#guild-member-object]guild member[/url] object
## with extra [code]voice_state[/code], [code]volume[/code] and [code]pan[/code] fields.
signal voice_state_update(member: Dictionary)

## Emitted when a user leaves a subscribed voice channel.
## [code]member[/code] is a partial [url=https://discord.com/developers/docs/resources/guild#guild-member-object]guild member[/url] object
## with extra [code]voice_state[/code], [code]volume[/code] and [code]pan[/code] fields.
signal voice_state_delete(member: Dictionary)

## Emitted when the client's voice settings update.
## [code]settings[/code] is a [url=https://discord.com/developers/docs/topics/rpc#voicesettingsupdate-example-voice-settings-dispatch-payload]voice settings response[/url]
signal voice_settings_update(settings: Dictionary)

## Emitted when the client's voice connection status changes.
## [code]state[/code] is the [url=https://discord.com/developers/docs/topics/rpc#voiceconnectionstatus-voice-connection-states]voice connection state[/url].
## [code]hostname[/code] is the address of the connected voice server.
## [code]pings[/code] is a list of the last 20 pings in milliseconds.
## [code]average_ping[/code] is the average ping in milliseconds.
## [code]last_ping[/code] is the last ping in milliseconds.
signal voice_connection_status(state: String, hostname: String, pings: Array[float], average_ping: int, last_ping: int)

## Emitted when a user in a subscribed voice channel speaks.
## [code]user_id[/code] is the id of user who started speaking.
signal speaking_start(user_id: String)

## Emitted when a user in a subscribed voice channel stops speaking.
## [code]user_id[/code] is the id of user who stopped speaking.
signal speaking_stop(user_id: String)

## Emitted when a message is created in a subscribed text channel.
## [code]channel_id[/code] is the channel id of the message.
## [code]message[/code] is a [url=https://discord.com/developers/docs/resources/channel#message-object]message[/url] object.
signal message_create(channel_id: String, message: Dictionary)

## Emitted when a message is updated in a subscribed text channel.
## [code]channel_id[/code] is the channel id of the message.
## [code]message[/code] is a [url=https://discord.com/developers/docs/resources/channel#message-object]message[/url] object.
signal message_update(channel_id: String, message: Dictionary)

## Emitted when a message is deleted in a subscribed text channel
## [code]channel_id[/code] is the channel id of the message.
## [code]message[/code] is a partial message object containing only the id.
signal message_delete(channel_id: String, message: Dictionary)

## Emitted when the client receives a notification (mention or new message in eligible channels).
## This event requires the [code]rpc.notifications.read[/code] OAuth2 scope.
## [code]channel_id[/code] is the channel id of where the notifcation originate from.
## [code]message[/code] is a [url=https://discord.com/developers/docs/resources/channel#message-object]message[/url] object.
## [code]icon_url[/code] is a URL to the avatar of the message's author.
## [code]title[/code] is the notification title.
## [code]body[/code] is the notification body (content of the message).
signal notification_create(channel_id: String, message: Dictionary, icon_url: String, title: String, body: String)

## Emitted when the user clicks a Rich Presence join invite in chat to join a game.
## [code]secret[/code] is the [url=https://discord.com/developers/docs/rich-presence/how-to#updating-presence-update-presence-payload-fields]join_secret[/url] for the given invite.
signal activity_join(secret: String)

## Emitted when the user clicks a Rich Presence spectate invite in chat to spectate a game.
## [code]secret[/code] is the [url=https://discord.com/developers/docs/rich-presence/how-to#updating-presence-update-presence-payload-fields]spectate_secret[/url] for the given invite.
signal activity_spectate(secret: String)

## Emitted when the user receives a Rich Presence Ask to Join request.
## [code]user[/code] is a partial [url=https://discord.com/developers/docs/resources/user#user-object]user[/url] object.
signal activity_join_request(user: Dictionary)

## Emitted when Discord RPC connection is closed either manually or after Discord client closes.
signal rpc_closed()

## Emitted when Discord RPC face a connection error.
## possible errors are: 
## [code]ERR_UNCONFIGURED[/code], [code]DiscordRPC.ERR_UNSUPPORTED[/code],
## [code]DiscordRPC.ERR_HANDSHAKE[/code] and [code]DiscordRPC.ERR_CLIENT_NOT_FOUND[/code]
signal rpc_error(error: int)

## Connection states
enum Status {
	DISCONNECTED,
	CONNECTING,
	CONNECTED,
}

## Error codes
enum {
	ERR_UNSUPPORTED = 49,
	ERR_HANDSHAKE,
	ERR_CLIENT_NOT_FOUND
}

const PING_INTERVAL_MS: int = 10_000

## Discord RPC version
const VERSION: int = 1

const DISCORD_API_ENDPOINT: String = "https://discord.com/api/%s"

const Commands: Dictionary = {
	DISPATCH = "DISPATCH",
	AUTHORIZE = "AUTHORIZE",
	AUTHENTICATE = "AUTHENTICATE",
	GET_GUILD = "GET_GUILD",
	GET_GUILDS = "GET_GUILDS",
	GET_CHANNEL = "GET_CHANNEL",
	GET_CHANNELS = "GET_CHANNELS",
	SUBSCRIBE = "SUBSCRIBE",
	UNSUBSCRIBE = "UNSUBSCRIBE",
	SET_USER_VOICE_SETTINGS  = "SET_USER_VOICE_SETTINGS",
	SELECT_VOICE_CHANNEL = "SELECT_VOICE_CHANNEL",
	GET_SELECTED_VOICE_CHANNEL = "GET_SELECTED_VOICE_CHANNEL",
	SELECT_TEXT_CHANNEL = "SELECT_TEXT_CHANNEL",
	GET_VOICE_SETTINGS = "GET_VOICE_SETTINGS",
	SET_VOICE_SETTINGS = "SET_VOICE_SETTINGS",
	SET_CERTIFIED_DEVICES = "SET_CERTIFIED_DEVICES",
	SET_ACTIVITY = "SET_ACTIVITY",
	SEND_ACTIVITY_JOIN_INVITE = "SEND_ACTIVITY_JOIN_INVITE",
	CLOSE_ACTIVITY_REQUEST = "CLOSE_ACTIVITY_REQUEST"
}

const Events: Dictionary = {
	READY = "READY",
	ERROR = "ERROR",
	GUILD_STATUS = "GUILD_STATUS",
	GUILD_CREATE = "GUILD_CREATE",
	CHANNEL_CREATE = "CHANNEL_CREATE",
	VOICE_CHANNEL_SELECT = "VOICE_CHANNEL_SELECT",
	VOICE_STATE_CREATE = "VOICE_STATE_CREATE",
	VOICE_STATE_UPDATE = "VOICE_STATE_UPDATE",
	VOICE_STATE_DELETE = "VOICE_STATE_DELETE",
	VOICE_SETTINGS_UPDATE = "VOICE_SETTINGS_UPDATE",
	VOICE_CONNECTION_STATUS = "VOICE_CONNECTION_STATUS",
	SPEAKING_START = "SPEAKING_START",
	SPEAKING_STOP = "SPEAKING_STOP",
	MESSAGE_CREATE = "MESSAGE_CREATE",
	MESSAGE_UPDATE = "MESSAGE_UPDATE",
	MESSAGE_DELETE = "MESSAGE_DELETE",
	NOTIFICATION_CREATE = "NOTIFICATION_CREATE",
	ACTIVITY_JOIN = "ACTIVITY_JOIN",
	ACTIVITY_SPECTATE = "ACTIVITY_SPECTATE",
	ACTIVITY_JOIN_REQUEST = "ACTIVITY_JOIN_REQUEST"
}

const EventParameters: Dictionary = {
	Events.GUILD_STATUS            : ["guild"],
	Events.GUILD_CREATE            : ["id", "name"],
	Events.CHANNEL_CREATE          : ["id", "name", "type"],
	Events.VOICE_CHANNEL_SELECT    : ["channel_id", "guild_id"],
	Events.VOICE_SETTINGS_UPDATE   : [],
	Events.VOICE_STATE_CREATE      : [],
	Events.VOICE_STATE_UPDATE      : [],
	Events.VOICE_STATE_DELETE      : [],
	Events.VOICE_CONNECTION_STATUS : ["state", "hostname", "pings", "average_ping", "last_ping"],
	Events.MESSAGE_CREATE          : ["channel_id", "message"],
	Events.MESSAGE_UPDATE          : ["channel_id", "message"],
	Events.MESSAGE_DELETE          : ["channel_id", "message"],
	Events.SPEAKING_START          : ["user_id"],
	Events.SPEAKING_STOP           : ["user_id"],
	Events.NOTIFICATION_CREATE     : ["channel_id", "message", "icon_url", "title", "body"],
	Events.ACTIVITY_JOIN           : ["secret"],
	Events.ACTIVITY_SPECTATE       : ["secret"],
	Events.ACTIVITY_JOIN_REQUEST   : ["user"]
}

var _timer: Timer
var _missed_pongs: int

var connection: DiscordRPCConnection

## Current connection status.
var status: Status = Status.DISCONNECTED

## Discord application id.
var application_id: int

## List of authorized OAuth2 scopes.
var scopes: PackedStringArray


## Attempts to connect to a Discord client instance.
## emits [code]rpc_ready[/code] on success, otherwise [code]rpc_error[/code].
func establish_connection(_application_id: int) -> void:
	if is_connected_to_client():
		push_error("DiscordRPC: Already in an active connection")
		return
	
	if not is_supported():
		push_error("DiscordRPC: Unsupported platform")
		rpc_error.emit(ERR_UNSUPPORTED)
		return
	
	if not is_inside_tree():
		push_error("DiscordRPC isn't inside a scene tree")
		rpc_error.emit(ERR_UNCONFIGURED)
		return
	
	application_id = _application_id
	status = Status.CONNECTING

	_create_connection()

	for i in 10:
		for path in connection.get_possible_paths():
			if connection.open(path % i) == OK:
				_handshake()
				return
			connection.close()

	rpc_error.emit(ERR_CLIENT_NOT_FOUND)
	shutdown()

## Whether this instance is connected to a Discord client or not
func is_connected_to_client() -> bool:
	return status == Status.CONNECTED

## Used to authenticate a new client with your application. By default this
## opens a modal that asks the user to authorize access to your application.  
## [code]scopes[/code] a PoolSringArray of [url=https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes]OAuth2 scopes[/url].
func authorize(auth_scopes: Array[String]) -> String:
	if not is_connected_to_client():
		push_error("DiscordRPC: Can not authorize while disconnected")
		return ""
		
	var request := AuthorizePayload.new(application_id, auth_scopes)
	var response := await connection.send(request)

	var code: String = ""
	if not response.is_error():
		code = response.data["code"]
		authorized.emit(code)

	return code

## Used to authenticate an existing client with your application.
func authenticate(access_token: String) -> bool:
	if not is_connected_to_client():
		push_error("DiscordRPC: Can not authenticate while disconnected")
		return false
		
	var request := AuthenticatePayload.new(access_token)
	var response := await connection.send(request)
	
	if not response.is_error():
		scopes = response.data["scopes"]
		authenticated.emit(response.data["application"], response.data["expires"])

	return not response.is_error()

func get_auth_token(
	authorize_code: String, secret: String,
	redirect_uri: String = "http://127.0.0.1"
) -> String:
	var http_request: HTTPRequest = HTTPRequest.new()
	var url: String = DISCORD_API_ENDPOINT % "oauth2/token"
	var headers: PackedStringArray = [
		"Content-Type: application/x-www-form-urlencoded"
	]
	var data: Dictionary = {
		client_id = application_id,
		client_secret = secret,
		grant_type = "authorization_code",
		code = authorize_code,
		redirect_uri = redirect_uri
	}

	var query: Array[String] = []

	for parameter in data.keys():
		query.append("%s=%s" % [parameter, str(data[parameter]).uri_encode()])

	add_child(http_request)
	http_request.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		"&".join(query)
	)
	var response: Array = await http_request.request_completed
	var _result: int = response[0]
	var _code: int = response[1]
	var body: PackedByteArray = response[3]
	
	http_request.queue_free()

	return JSON.parse_string(body.get_string_from_utf8()).get("access_token", "")

## Retrieves a guild information known to the client.
## Returns a [code]Dictionary[/code] containing: [code]id[/code],
## [code]name[/code], [code]icon_url[/code] and [code]members[/code].
## [code]id[/code] The id of the guild.  
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [url=https://discord.com/developers/docs/topics/rpc#getguild]Reference[/url]
func get_guild(id: String, timeout: int = 0) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_GUILD
	request.arguments = {guild_id = id}
	if timeout > 0:
		request["timeout"] = timeout
	var response := await connection.send(request)
	return response.data

## Retrieves a list of guilds from the client. Returns a list of partial guild
## objects ([code]id[/code] and [code]name[/code]).
## [url=https://discord.com/developers/docs/topics/rpc#getguilds]Reference[/url]
func get_guilds() -> Array[Dictionary]:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_GUILDS
	var response := await connection.send(request)
	var guilds: Array[Dictionary] = []
	guilds.assign(response.data["guilds"])
	return guilds

## Retrieves channel information from the client.
## [code]id[/code] The id of the channel.  
## [url=https://discord.com/developers/docs/topics/rpc#getchannel]Reference[/url]
func get_channel(id: String) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_CHANNEL
	request.arguments = {channel_id = id}
	var response := await connection.send(request)
	return response.data

## Retrieves a list of channels of a guild from the client.
## Returns a list of partial channel objects
## ([code]id[/code], [code]name[/code] and [code]type[/code]).
## [code]guild_id[/code] The id of the guild to get the channels from.  
## [url=https://discord.com/developers/docs/topics/rpc#getchannels]Reference[/url]
func get_channels(guild_id: String) -> Array[Dictionary]:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_CHANNELS
	request.arguments = {guild_id = guild_id}
	var response := await connection.send(request)
	var channels: Array[Dictionary] = []
	channels.assign(response.data["channels"])
	return channels

## Subscribes to events in order for certain signals to be emitted.
## Returns [code]true[/code] on success.  
## [code]event[/code] is the event name to subscribe to in UPPER_CASE.  
## [code]arguments[/code] a Dictionary of name|value pair of arguments
## needed by certain events.  
## [url=https://discord.com/developers/docs/topics/rpc#subscribe]Reference[/url]
func subscribe(event: String, arguments: Dictionary = {}) -> bool:
	var response := await connection.send(SubscribePayload.new(event, arguments))
	return not response.is_error()

## Unsubscribes from events.
## [code]event[/code] is the event name that was subscribe to in UPPER_CASE.
## [code]arguments[/code] a Dictionary of name|value pair of arguments of 
## the previously subscribed event.  
## [url=https://discord.com/developers/docs/topics/rpc#unsubscribe]Reference[/url]
func unsubscribe(event: String, arguments: Dictionary = {}) -> bool:
	var response := await connection.send(UnsubscribePayload.new(event, arguments))
	return not response.is_error()

## Changes voice settings of a user in a voice channel.
## [url=https://discord.com/developers/docs/topics/rpc#setuservoicesettings]Reference[/url]
func set_user_voice_settings(settings: Dictionary) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.SET_USER_VOICE_SETTINGS
	request.arguments = settings
	var response := await connection.send(request)
	return response.data

## Joins or leaves a voice channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [code]force[/code] forces the client to join a voice channel.
## [url=https://discord.com/developers/docs/topics/rpc#selectvoicechannel]Reference[/url]
func select_voice_channel(
	id: String, timeout: int = 0, force: bool = false
) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.SELECT_VOICE_CHANNEL
	request.arguments = {
		channel_id = null if id.is_empty() else id,
		force = force
	}
	if timeout > 0:
		request["timeout"] = timeout
	var response := await connection.send(request)
	return response.data

## Joins a voice channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [code]force[/code] forces the client to join a voice channel.
## [url=https://discord.com/developers/docs/topics/rpc#selectvoicechannel]Reference[/url]
func join_voice_channel(
	id: String, timeout: int = 0, force: bool = false
) -> Dictionary:
	return await select_voice_channel(id, timeout, force)

## Leaves a voice channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [code]force[/code] forces the client to join a voice channel.
## [url=https://discord.com/developers/docs/topics/rpc#selectvoicechannel]Reference[/url]
func leave_voice_channel(timeout: int = 0) -> void:
	await select_voice_channel("", timeout)

## Gets the current voice channel the client is in.
## [url=https://discord.com/developers/docs/topics/rpc#getselectedvoicechannel]Reference[/url]
func get_selected_voice_channel() -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_SELECTED_VOICE_CHANNEL
	var response := await connection.send(request)
	return response.data

## Joins or leaves a text channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [url=https://discord.com/developers/docs/topics/rpc#selecttextchannel]Reference[/url]
func select_text_channel(id: String, timeout: int = 0) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.SELECT_TEXT_CHANNEL
	request.arguments = {channel_id = null if id.is_empty() else id}
	if timeout > 0:
		request["timeout"] = timeout
	var response := await connection.send(request)
	return response.data

## Joins a text channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [url=https://discord.com/developers/docs/topics/rpc#selecttextchannel]Reference[/url]
func join_text_channel(id: String, timeout: int = 0) -> Dictionary:
	return await select_text_channel(id, timeout)

## Leaves a text channel.
## [code]id[/code] is the voice channel id (leaves if empty).
## [code]timeout[/code] time to wait before aborting the request on timeout.
## [url=https://discord.com/developers/docs/topics/rpc#selecttextchannel]Reference[/url]
func leaves_text_channel(timeout: int = 0) -> void:
	await select_text_channel("", timeout)

## Retrieves the client's voice settings.
## [url=https://discord.com/developers/docs/topics/rpc#getvoicesettings]Reference[/url]
func get_voice_settings() -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.GET_VOICE_SETTINGS
	var response := await connection.send(request)
	return response.data

## Retrieves the client's voice settings.
## [url=https://discord.com/developers/docs/topics/rpc#getvoicesettings]Reference[/url]
func set_voice_settings(settings: Dictionary) -> Dictionary:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.SET_VOICE_SETTINGS
	request.arguments = settings
	var response := await connection.send(request)
	return response.data

## Used by hardware manufacturers to send information about the current state of
## their certified devices that are connected to Discord.
## [url=https://discord.com/developers/docs/topics/rpc#setcertifieddevices]Reference[/url]
func set_certified_devices(devices: Array[Dictionary]) -> bool:
	var request := DiscordRPCConnection.Payload.new()
	request.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	request.command = Commands.SET_CERTIFIED_DEVICES
	request.arguments = {devices = devices}
	var response := await connection.send(request)
	return not response.is_error()

## Updates the user's Rich Presence status.
## [url=https://discord.com/developers/docs/topics/rpc#setactivity]Reference[/url]
func update_presence(presence: Dictionary) -> bool:
	var response := await connection.send(UpdateRichPresencePayload.new(presence))
	return not response.is_error()

## Clears the user's Rich Presence status.
## [url=https://discord.com/developers/docs/topics/rpc#setactivity]Reference[/url]
func clear_presence() -> bool:
	return await update_presence({})

## Accepts an "Ask to Join" request.
## [code]user_id[/code] is the id of the requesting user.
## [url=https://discord.com/developers/docs/topics/rpc#sendactivityjoininvite]Reference[/url]
func accept_join_request(user_id: String) -> bool:
	var payload := DiscordRPCConnection.Payload.new()
	payload.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	payload.command = Commands.SEND_ACTIVITY_JOIN_INVITE
	payload.arguments = {user_id = user_id}
	var response := await connection.send(payload)
	return not response.is_error()

## Rejects an "Ask to Join" request.
## [code]user_id[/code] is the id of the requesting user.
## [url=https://discord.com/developers/docs/topics/rpc#sendactivityjoininvite]Reference[/url]
func reject_join_request(user_id: String) -> bool:
	var payload := DiscordRPCConnection.Payload.new()
	payload.opcode = DiscordRPCConnection.Payload.OpCodes.FRAME
	payload.command = Commands.CLOSE_ACTIVITY_REQUEST
	payload.arguments = {user_id = user_id}
	var response := await connection.send(payload)
	return not response.is_error()

func ping() -> void:
	var payload := DiscordRPCConnection.Payload.new()
	payload.opcode = DiscordRPCConnection.Payload.OpCodes.PING
	connection.send(payload)
	_missed_pongs += 1

## Closes the current connection to the discord client
func shutdown() -> void:
	if status != Status.DISCONNECTED:
		connection.close()
		application_id = 0
		connection = null
		_missed_pongs = 0
		if is_instance_valid(_timer):
			_timer.queue_free()
		scopes = []
		status = Status.DISCONNECTED
		rpc_closed.emit()

func _create_connection() -> void:
	match OS.get_name():
		"Windows":
			connection = DiscordRPCWindows.new()
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD", "macOS":
			connection = DiscordRPCUnix.new()

	connection.payload_received.connect(_on_data)

	_timer = Timer.new()
	_timer.wait_time = PING_INTERVAL_MS / 1000.0
	_timer.timeout.connect(
		func():
			if _missed_pongs < 3:
				ping()
			else:
				shutdown()
	)

	add_child(_timer)

func _handshake() -> void:
	if is_connected_to_client():
		push_error("DiscordRPC: Already handshaked")
		return
	elif status != Status.CONNECTING:
		push_error("DiscordRPC: Attempt to handshake while disconnected")
		return

	var request := HandshakePayload.new(VERSION, application_id)
	var response := await connection.send(request)

	if response.is_close_request() or response.is_error():
		rpc_error.emit(ERR_HANDSHAKE)
		shutdown()
		return

	status = Status.CONNECTED
	_timer.start()
	rpc_ready.emit(response.data["user"])

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			shutdown()

func _process(_delta: float) -> void:
	if status != Status.DISCONNECTED:
		if connection.is_open():
			connection.poll()
		else:
			shutdown()
	
func _on_data(payload: DiscordRPCConnection.Payload) -> void:
	if payload.is_error():
		return

	match payload.opcode:
		DiscordRPCConnection.Payload.OpCodes.CLOSE:
			shutdown()
		DiscordRPCConnection.Payload.OpCodes.PING:
			var reply := DiscordRPCConnection.Payload.new()
			reply.opcode = DiscordRPCConnection.Payload.OpCodes.PONG
			connection.send(reply)
		DiscordRPCConnection.Payload.OpCodes.PONG:
			_missed_pongs = 0

	if payload.is_event_dispatch() and EventParameters.has(payload.event):
		var arguments: Array = [payload.event.to_lower()]

		var parameters: PackedStringArray = EventParameters[payload.event]
		if parameters.is_empty():
			arguments.append(payload.data)
		else:
			for parameter in parameters:
				arguments.append(payload.data[parameter])

		emit_signal.callv(arguments)

func _to_string() -> String:
	return "[DiscordRPC:%d]" % get_instance_id()

static func is_supported() -> bool:
	var os: String = OS.get_name()
	return os in ["Windows", "Linux", "macOS"] or os.match("*BSD")

class HandshakePayload extends DiscordRPCConnection.Payload:
	var version: int
	var client_id: int
	
	func _init(rpc_version: int, application_id: int) -> void:
		opcode = OpCodes.HANDSHAKE
		version = rpc_version
		client_id = application_id
	
	func to_dict() -> Dictionary:
		return {
			v = version,
			client_id = str(client_id),
		}

class AuthorizePayload extends DiscordRPCConnection.Payload:
	func _init(application_id: int, scopes: PackedStringArray) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.AUTHORIZE
		arguments = {
			client_id = str(application_id),
			scopes = scopes
		}

class AuthenticatePayload extends DiscordRPCConnection.Payload:
	func _init(access_token: String) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.AUTHENTICATE
		arguments = {access_token = access_token}

class SubscribePayload extends DiscordRPCConnection.Payload:
	func _init(subscribe_event: String, arg: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.SUBSCRIBE
		arguments = arg
		event = subscribe_event.to_upper()

class UnsubscribePayload extends DiscordRPCConnection.Payload:
	func _init(usubscribe_event: String, arg: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.UNSUBSCRIBE
		arguments = arg
		event = usubscribe_event.to_upper()

class UpdateRichPresencePayload extends DiscordRPCConnection.Payload:
	func _init(presence: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.SET_ACTIVITY
		arguments = {
			pid = OS.get_process_id(),
			# warning-ignore:incompatible_ternary
			activity = null if presence.is_empty() else presence
		}
