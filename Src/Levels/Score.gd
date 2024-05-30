extends Label
# code by GDQuest

var score = 0

func _on_player_dodge():
	score += 1
	text = "Score: %s" % score


func _player_survive():
	score += 1
	text = "Score: %s" % score
