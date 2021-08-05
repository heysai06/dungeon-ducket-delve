extends Node2D

var greet_content = Narrative.CSVToArray("res://Narrative/Greet.txt")
var content_to_display = []

func _ready():
	display_text_box(greet_content)

func display_text_box(content):
	content_to_display = Narrative.GetContent(content)
	
	$Content.text = content_to_display[Narrative.CONTENT]
	$YesOption.text = content_to_display[Narrative.YES_ANSWER]
	$NoOption.text = content_to_display[Narrative.NO_ANSWER]

func _on_YesOption_pressed():
	$YesOption.visible = false
	$NoOption.visible = false
	$Content.text = content_to_display[Narrative.YES_RESPONSE]
	
func _on_NoOption_pressed():
	$YesOption.visible = false
	$NoOption.visible = false
	$Content.text = content_to_display[Narrative.NO_RESPONSE]

