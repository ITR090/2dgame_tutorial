extends Node

var score : int = 0


func increase_socre() -> void:
	score+=1
	SignalHub.emit_scored_point(score)
