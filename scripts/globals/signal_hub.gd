extends Node

signal player_died
signal collected
signal scored_point


func emit_scored_point(score) -> void:
	scored_point.emit(score)

func emit_apple_collected() -> void:
	collected.emit()

# write a func to emit the signal 
func emit_player_died(player) -> void:
	player_died.emit(player)
