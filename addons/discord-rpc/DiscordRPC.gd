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
## [code]state[/code] is the [url=https://discord.com/developers/docs/topics/rpc#voiceconnectionstatus-voice-connection-states]voice connection state[url].
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
	CAPTURE_SHORTCUT = "CAPTURE_SHORTCUT",
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


# Attempts to connect to a Discord client instance.
# emits `rpc_ready` on success, otherwise `rpc_error`.
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

# Whether this instance is connected to a Discord client or not
func is_connected_to_client() -> bool:
	return status == Status.CONNECTED

# Used to authenticate a new client with your application. By default this opens
# a modal that asks the user to authorize access to your application.  
# `scopes` a PoolSringArray of OAuth2 scopes:
# https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes  
# `secret` OAuth2 client's sceret code.
func authorize(_scopes: Array[String], secret: String) -> bool:
	if not is_connected_to_client():
		push_error("DiscordRPC: Can not authorize while disconnected")
		return false
		
	var request: Payload = AuthorizePayload.new(application_id, _scopes)
	var response: Payload = await connection.send(request)

	if not response.is_error():
		var code: String = response.data["code"]
		var token: String = await get_auth_token(code, secret)
		if not token.is_empty():
			authorized.emit(token)
			return await authenticate(token)

	return not response.is_error()

# Used to authenticate an existing client with your application.
func authenticate(access_token: String) -> bool:
	if not is_connected_to_client():
		push_error("DiscordRPC: Can not authenticate while disconnected")
		return false
		
	var request: Payload = AuthenticatePayload.new(access_token)
	var response: Payload = await connection.send(request)
	
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

# Subscribes to events in order for certain signals to be emitted.
# Returns [code]true[/code] on success.  
# [code]event[/code] is the event name to subscribe to in UPPER_CASE.  
# [code]arguments[/code] a Dictionary of name|value pair of arguments needed by certain events.  
# reference: https://discord.com/developers/docs/topics/rpc#subscribe
func subscribe(event: String, arguments: Dictionary = {}) -> bool:
	var response := await connection.send(SubscribePayload.new(event, arguments))
	return not response.is_error()

# Unsubscribes from events.
# `event` is the event name that was subscribe to in UPPER_CASE.
# `arguments` a Dictionary of name|value pair of arguments of the previously subscribed event.  
# reference: https://discord.com/developers/docs/topics/rpc#unsubscribe
func unsubscribe(event: String, arguments: Dictionary = {}) -> bool:
	var response := await connection.send(UnsubscribePayload.new(event, arguments))
	return not response.is_error()

func update_presence(presence: Dictionary) -> bool:
	var response := await connection.send(UpdateRichPresencePayload.new(presence))
	return not response.is_error()

func clear_presence() -> bool:
	return await update_presence({})

func ping() -> void:
	var payload: Payload = Payload.new()
	payload.opcode = Payload.OpCodes.PING
	connection.send(payload)
	_missed_pongs += 1

# Closes the current connection to the discord client
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

	var request: Payload = HandshakePayload.new(VERSION, application_id)
	var response: Payload = await connection.send(request)

	if response.is_close_request() or response.is_error():
		print("Bye bye")
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
	
func _on_data(payload: Payload) -> void:
	if payload.is_error():
		return

	match payload.opcode:
		Payload.OpCodes.CLOSE:
			shutdown()
		Payload.OpCodes.PING:
			var reply: Payload = Payload.new()
			reply.opcode = Payload.OpCodes.PONG
			connection.send(reply)
		Payload.OpCodes.PONG:
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


const Payload := DiscordRPCConnection.Payload

class HandshakePayload extends Payload:
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

class AuthorizePayload extends Payload:
	func _init(application_id: int, scopes: PackedStringArray) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.AUTHORIZE
		arguments = {
			client_id = str(application_id),
			scopes = scopes
		}

class AuthenticatePayload extends Payload:
	func _init(access_token: String) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.AUTHENTICATE
		arguments = {access_token = access_token}

class SubscribePayload extends Payload:
	func _init(subscribe_event: String, arg: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.SUBSCRIBE
		arguments = arg
		event = subscribe_event.to_upper()

class UnsubscribePayload extends Payload:
	func _init(usubscribe_event: String, arg: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.UNSUBSCRIBE
		arguments = arg
		event = usubscribe_event.to_upper()

class UpdateRichPresencePayload extends Payload:
	func _init(presence: Dictionary) -> void:
		super()
		opcode = OpCodes.FRAME
		command = DiscordRPC.Commands.SET_ACTIVITY
		arguments = {
			pid = OS.get_process_id(),
			# warning-ignore:incompatible_ternary
			activity = null if presence.is_empty() else presence
		}
