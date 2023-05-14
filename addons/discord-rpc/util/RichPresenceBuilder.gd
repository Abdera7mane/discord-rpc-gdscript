class_name RichPresenceBuilder

var activity: Dictionary = {
	timestamps = {},
	assets = {},
	party = {}
}

## Sets the activity description.
func with_details(details: String) -> RichPresenceBuilder:
	activity["details"] = details
	return self

## Sets the user's current party status.
func with_state(state: String) -> RichPresenceBuilder:
	activity["state"] = state
	return self

## Sets the Unix time in milliseconds of when the activity started.
func start_timestamp(timestamp: int) -> RichPresenceBuilder:
	activity["timestamps"]["start"] = timestamp
	return self

## Sets the Unix time in milliseconds of when the activity ended.
func end_timestamp(timestamp: int) -> RichPresenceBuilder:
	activity["timestamps"]["end"] = timestamp
	return self

## Sets the large image, can either be an application asset key or a URL.
func with_large_image(image: String) -> RichPresenceBuilder:
	activity["assets"]["large_image"] = image
	return self

## Sets the large image text.
func with_large_text(text: String) -> RichPresenceBuilder:
	activity["assets"]["large_text"] = text
	return self

## Sets the small image, can either be an application asset key or a URL.
func with_small_image(image: String) -> RichPresenceBuilder:
	activity["assets"]["small_image"] = image
	return self

## Sets the large image text.
func with_small_text(text: String) -> RichPresenceBuilder:
	activity["assets"]["small_text"] = text
	return self

## Sets information for the current party of the player.
## [code]id[/code] is the ID of the party.
## [code]size[/code] is the current party size.
## [code]max_size[/code] is the maxium size of the party.
func with_party(
	id: String, size: int = 0, max_size: int = 0
) -> RichPresenceBuilder:
	activity["party"]["id"] = id
	if max_size > 0:
		activity["party"]["size"] = [size, max_size]
	return self

## Provides secrets for Rich Presence joining and spectating.
func with_secrets(
	join: String = "", spectate: String = "", match: String = ""
) -> RichPresenceBuilder:
	var secrets: Dictionary
	if activity.has("secrets"):
		secrets = activity["secrets"]
	else:
		activity["secrets"] = secrets

	if not join.is_empty():
		secrets["join"] = join
	if not spectate.is_empty():
		secrets["spectate"] = spectate
	if not match.is_empty():
		secrets["match"] = match

	return self

## Adds a custom button (max 2).
func add_button(label: String, url: String) -> RichPresenceBuilder:
	var buttons: Array[Dictionary]
	if activity.has("buttons"):
		buttons.assign(activity["button"])
	else:
		activity["buttons"] = buttons

	if buttons.size() < 2:
		buttons.append({label = label, url = url})
	else:
		push_error("Rich Presence button are limited to 2")

	return self

## Whether or not the activity is an instanced game session.
func is_instance(value: bool) -> RichPresenceBuilder:
	activity["instance"] = value
	return self

## Returns the activity object.
func build() -> Dictionary:
	return activity.duplicate(true)

