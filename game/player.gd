extends Node2D

var deck = []

var cards = []

func space(zone:Rect2,point:Vector2)->bool:
	var a:Rect2 = get_viewport_rect()
	var b:Rect2
	b.position = a.position*(Vector2(1,1)-zone.position)+a.end*zone.position
	b.end = a.position*(Vector2(1,1)-zone.end)+a.end*zone.end
	return b.has_point(point)
