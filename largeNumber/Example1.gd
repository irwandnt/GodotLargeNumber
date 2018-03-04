extends Control

	# author : irwan dianto
	# fb: https://www.facebook.com/irwandianto
	# license : GNU GPL
onready var opt=get_node("opt")
var bignum
func _ready():
	#var LNscript=preload("res://LargeNumber.gd")
	bignum=preload("res://LargeNumber.gd").LargeNumber.new()
	opt.add_item("+",0)
	opt.add_item("-",1)
	opt.add_item("x",2)
	opt.select(0)
	get_node("Button").connect("button_down",self,"countIt")
func countIt():
	var result
	#if(opt.get_item_ID())
	#print(opt.get_selected_ID())
	if(opt.get_selected_ID()==0):
		result=bignum.addition(get_node("input1").get_text(),get_node("input2").get_text())
	elif(opt.get_selected_ID()==1):
		result=bignum.subtraction(get_node("input1").get_text(),get_node("input2").get_text())
	elif(opt.get_selected_ID()==2):
		result=bignum.multiplication(get_node("input1").get_text(),get_node("input2").get_text())
	if(get_node("formated").is_pressed()):
		get_node("result").set_text(bignum.readNum(result))
	else:
		get_node("result").set_text(bignum.readNum(result,false))