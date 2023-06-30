class_name User
extends Node2D

var peerId = null;
#var peerAddr = "0.0.0.0";
var ip_addr = "0.0.0.0";
var gateway = "0.0.0.0";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func addressToPosition(addr: String = ip_addr) -> Vector2:
	var addrParts = addr.split(".");
	print("addrParts", addrParts)
	var minimapSize = Vector2(300,300);
	var x = floor(int(addrParts[0]) / 255.0 * minimapSize.x);
	var y = floor(int(addrParts[1]) / 255.0 * minimapSize.y);
	var angle = floor(int(addrParts[2]) / 255.0 * 360.0);
	var radius = floor(int(addrParts[3]) / 255.0 * 10.0);
	var nx = x + (radius * cos(angle));
	var ny = y + (radius * sin(angle));
	print(nx, " ", ny);
	return Vector2(nx, ny);
