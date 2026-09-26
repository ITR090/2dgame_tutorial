extends Node2D

@onready var score_lable: CanvasLayer = $score_lable

func _ready() -> void:
	if ScoreManger.score:
		score_lable.get_child(0).get_child(0).text = "SCORE: %s" % ScoreManger.score
	SignalHub.scored_point.connect(_on_scored_point)

func _on_scored_point(score) -> void:
	score_lable.get_child(0).get_child(0).text = "SCORE: %s" % score
