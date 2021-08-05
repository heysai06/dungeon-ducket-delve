extends Node

const CONDITION = 0
const IMPORTANCE = 1
const CONTENT = 2
const YES_ANSWER = 3
const YES_RESPONSE = 4
const YES_OUTCOME = 5
const NO_ANSWER = 6
const NO_RESPONSE = 7
const NO_OUTCOME = 8

var story_variables = [""]

# Called when the node enters the scene tree for the first time.
func _ready():
	#var printable_content = CSVToArray("res://test.txt")
	
	pass

func GetContent(content):
	var valid_content = []
	
	# Find Valid Events
	for i in content.size():
		for j in story_variables.size():
			if(story_variables[j] == content[i][CONDITION]):
				valid_content.append(content[i])
	
	# If there is no valid content, return false
	if(valid_content.size() == 0):
		return false
	
	var selected_content = SelectRandomContent(valid_content)
	
	# If selected content is meant for output return the content
	if(typeof(selected_content[CONTENT]) == TYPE_STRING):
		for i in content.size():
			if(content[i][CONTENT] == selected_content[CONTENT]):
				content[i][CONDITION] = "locked"
		
		return selected_content
	
	# else, it's a content list, therefor get valid content
	return GetContent(selected_content[CONTENT])
		

func SelectRandomContent(valid_content):
	var totalWeight = 0
	
	for i in valid_content.size():
		totalWeight += int(valid_content[i][IMPORTANCE])
		
	randomize()
	var threshhold = randf() * totalWeight
	
	var total = 0
	
	for i in valid_content.size():
		total += int(valid_content[i][IMPORTANCE])
		
		if total >= threshhold:
			return valid_content[i]
	
func CSVToArray(file_path):
	var story_content = []
	var header = true
	
	var file = File.new()
	file.open(file_path, File.READ)
	file.seek(0)
	
	while !file.eof_reached():
		if header == true:
			file.get_csv_line()
			header = false
			continue
		else:
			story_content.append(file.get_csv_line())
	
	file.close()
	return story_content
