tool
extends TileSet


func _is_tile_bound(drawn_id, neighbor_id):
	print(str(drawn_id) + "," + str(neighbor_id))
	return neighbor_id != -1 and not (drawn_id == 3 and neighbor_id == 1) and not (drawn_id == 3 and neighbor_id == 15) and not (drawn_id == 1 and neighbor_id == 2) and not (drawn_id == 1 and neighbor_id == 7)
