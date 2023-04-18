extends Control

signal setting_update(status: String)

@export var status_label: Label

@onready var screenshot_button = %ScreenshotButton
@onready var fullscreen_button = %FullscreenButton

func _ready() -> void:
	screenshot_button.pressed.connect(on_screenshot_button_pressed)
	fullscreen_button.toggled.connect(on_fullscreen_button_pressed)
	setting_update.connect(on_self_setting_update)


func on_screenshot_button_pressed() -> void:
	setting_update.emit(Ultilities.create_screenshot())


func on_fullscreen_button_pressed(button_pressed: bool) -> void:
	setting_update.emit(Ultilities.set_fullscreen(button_pressed))


func on_self_setting_update(status: String) -> void:
	status_label.text = status
