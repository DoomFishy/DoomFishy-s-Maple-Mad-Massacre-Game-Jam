extends Node

var player = null
var player_pos = null
var crit = false

var opencutscene_vacuum = true
var opencutscene_bobby = true
var camera = null

var player_health = 100

var in_tutorial = false

var roomba_num = 0

var timer = 0.0

var on_boss_world = 0
var has_beat_vacuum = false
var has_beat_squirrel = false
var has_beat_bobby = false

var is_vacuum_dead = false
var current_boss = null
var is_half_hp = false
var has_cloned = false

var has_exchange_vacuum = false
var has_exchange_bobby = false
var has_exchange_squirrel = false
