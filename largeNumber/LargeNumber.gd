class LargeNumber:
	# author : irwan dianto
	# fb: https://www.facebook.com/irwandianto
	# license : GNU GPL
	func _init():
		pass
	func bootstrapNum():
		return {
		"nums":[\
		{"val":0,"label":""},\
		{"val":0,"label":""},\
		{"val":0,"label":""},\
		{"val":0,"label":"k"},\
		{"val":0,"label":"k"},\
		{"val":0,"label":"k"},\
		{"val":0,"label":"mil"},\
		{"val":0,"label":"mil"},\
		{"val":0,"label":"mil"},\
		{"val":0,"label":"bil"},\
		{"val":0,"label":"bil"},\
		{"val":0,"label":"bil"},\
		{"val":0,"label":"tri"},\
		{"val":0,"label":"tri"},\
		{"val":0,"label":"tri"},\
		{"val":0,"label":"quad"},\
		{"val":0,"label":"quad"},\
		{"val":0,"label":"quad"},\
		{"val":0,"label":"quin"},\
		{"val":0,"label":"quin"},\
		{"val":0,"label":"quin"},\
		{"val":0,"label":"sext"},\
		{"val":0,"label":"sext"},\
		{"val":0,"label":"sext"},\
		{"val":0,"label":"sept"},\
		{"val":0,"label":"sept"},\
		{"val":0,"label":"sept"},\
		{"val":0,"label":"oct"},\
		{"val":0,"label":"oct"},\
		{"val":0,"label":"oct"},\
		{"val":0,"label":"non"},\
		{"val":0,"label":"non"},\
		{"val":0,"label":"non"},\
		{"val":0,"label":"dec"},\
		{"val":0,"label":"dec"},\
		{"val":0,"label":"dec"},\
		],
		"negative":false
		}
	func parseNum(val):
		var blk=bootstrapNum()
		var m=str(val)
		var isMinus=false
		if(typeof(val)==21):
			return val
		elif(typeof(val)==4):
			var tmpNum=""
			var tmpSymbol=""
			var decimalCount=0
			var isDecimal=false
			
			#for i in range(val.size()-1,-1,-1):
			#---- insert character 0 - 9 to temporaryNum , check if it has decimal, check if it minus, check the symbol
			for f in range(0,val.length()):
				if(val[f] in ["0","1","2","3","4","5","6","7","8","9"]):
					tmpNum+=val[f]
					if(isDecimal):
						decimalCount+=1
				elif(val[f]=="."):
					isDecimal=true
				elif(val[f]=="-"):
					isMinus=true
				else:
					tmpSymbol+=val[f]
			#--end checked --
			if(tmpSymbol==""):
				m=str(tmpNum)  #without symbol
			else:
				var labelPos=-1
				for f in range(0,blk["nums"].size()):
					#print(blk[f]["label"]," == ",tmpSymbol)
					if(blk["nums"][f]["label"]==tmpSymbol):
						labelPos=f
						break
				if(labelPos==-1):
					m=str(tmpNum)
				else:
					
					var zeros=""
					for i in range(0,labelPos-decimalCount):
						zeros+="0"
					m=tmpNum+zeros
					#print(m)
		var idx=0
		for i in range(m.length()-1,-1,-1):
			blk["nums"][idx]["val"]=int(m[i])
			if(i==0 && isMinus):
				#lk[idx]["val"]=int(m[i])*-1
				blk["negative"]=true
			idx+=1
		#print(blk)
		return blk
	func compare(val,val2):
		var result="equal"
		for i in range(val["nums"].size()-1,-1,-1):
			if(val["nums"][i]["val"] > val2["nums"][i]["val"]):
				result="1"
				break
			elif(val["nums"][i]["val"] < val2["nums"][i]["val"]):
				result="2"
				break
		return result
	func addition(val, val2=null):
		var blk=parseNum(val)
		if(val2==null):
			#print(blk)
			return blk
		else:
			var blk2=parseNum(val2)
			var blk3=bootstrapNum()
			#var resultNegative=false
			if((blk["negative"] && !blk2["negative"])||(!blk["negative"] && blk2["negative"])):
				var comp=compare(blk,blk2)
				if(comp=="equal"):
					return blk3
				elif(comp=="1"):
					blk3=normSubtract(blk,blk2)
					if(blk["negative"]):
						blk3["negative"]=true
					return blk3
				elif(comp=="2"):
					blk3=normSubtract(blk2,blk)
					if(blk2["negative"]):
						blk3["negative"]=true
					return blk3
			else:
				var saved=0
				blk3=normAddition(blk,blk2)
				if(blk["negative"] && blk2["negative"]):
					blk3["negative"]=true
				
				return blk3
	func normAddition(blk1,blk2):
		var saved=0
		var blk3=bootstrapNum()
		for b in range(0, blk3["nums"].size()):
			var add=int(blk1["nums"][b]["val"])+int(blk2["nums"][b]["val"])+saved
			if(add <10):
				saved=0
				blk3["nums"][b]["val"]=add
			else:
				var addstr=str(add)
				blk3["nums"][b]["val"]=int(addstr[1])
				saved=int(addstr[0])
		return blk3
	func subtraction(val, val2):
		var blk=parseNum(val)
		if(val2==null):
			#print(blk)
			return blk
		else:
			var blk2=parseNum(val2)
			var blk3=bootstrapNum()
			#var resultNegative=false
			if(!blk["negative"] && blk2["negative"]):
				blk3=normAddition(blk,blk2)
				return blk3
			if(blk["negative"] && !blk2["negative"]):
				#print("yesss")
				blk3=normAddition(blk,blk2)
				blk3["negative"]=true
				return blk3
			else:
				var isNegative=blk["negative"] && blk2["negative"]
				var borrow=0
				var comp=compare(blk,blk2)
				if(comp=="equal"):
					return blk3
				elif(comp=="1"):
					blk3=normSubtract(blk,blk2)
					if(isNegative):
						blk3["negative"]=true
					return blk3
				elif(comp=="2"):
					blk3=normSubtract(blk2,blk)
					if(!isNegative):
						blk3["negative"]=true
					return blk3
				
	func normSubtract(blk1,blk2):
		var borrow=0
		var blk3=bootstrapNum()
		for i in range(0, blk1["nums"].size()):
			if(blk1["nums"][i]["val"]-borrow < blk2["nums"][i]["val"]):
				blk3["nums"][i]["val"]=((blk1["nums"][i]["val"]-borrow)+10)-blk2["nums"][i]["val"]
				borrow=1
			else:
				blk3["nums"][i]["val"]=(blk1["nums"][i]["val"]-borrow)-blk2["nums"][i]["val"]
				borrow=0
		return blk3
		
	func multiplication(val1,val2):
		var blk1=parseNum(val1)
		var blk2=parseNum(val2)
		var blk3=bootstrapNum()
		var blkLength1=0 ;var blkLength2=0
		for i in range(blk1["nums"].size()-1,-1,-1):
			if(blk1["nums"][i]["val"] !=0 ||  i==0 ):
				blkLength1=i
				break
		for i in range(blk2["nums"].size()-1,-1,-1):
			if(blk2["nums"][i]["val"] !=0 ||  i==0 ):
				blkLength2=i
				break
		var saved=0
		var tab=0
		for i2 in range(0,blkLength2+1):
			var tmpBlk=bootstrapNum()
			for i in range(0,blkLength1+2):  #add more 1 blok for handle saved value
				var mult=(blk2["nums"][i2]["val"] * blk1["nums"][i]["val"])+saved
				if(mult < 10 ):
					tmpBlk["nums"][i+tab]["val"]=mult
					#print(mult)
					saved=0
				else:
					var rest=mult%10
					tmpBlk["nums"][i+tab]["val"]=rest
					saved=(mult - rest)/10
			#print(readNum(tmpBlk))
			tab+=1
			if(i2==0):
				#print(readNum(tmpBlk))
				blk3=tmpBlk
			else:
				#print(readNum(tmpBlk))
				blk3=normAddition(blk3,tmpBlk)
				#print(readNum(blk3,false))
		if((blk1["negative"] && !blk2["negative"]) || (!blk1["negative"] && blk2["negative"])):
			blk3["negative"]=true
		return blk3
	func readNum(arrnum,withSymbol=true,maxDecimal=2):
		var num=""
		var num2=""
		var symbol=""
		var startNum=false
		var decimalCount=0
		var startDecimal=true
		var tmpDecimal=""
		var txtNegative=""
		if(arrnum["negative"]):
			txtNegative="-"
		for i in range(arrnum["nums"].size()-1,-1,-1):
			if((!startNum && arrnum["nums"][i]["val"] !=0) || (!startNum && i==0) ):
				startNum=true
				symbol=arrnum["nums"][i]["label"]
			
			if(startNum):
				if(withSymbol && symbol!=arrnum["nums"][i]["label"]): #check if entering decimal number
					if(decimalCount >= maxDecimal):
						break
					#if(startDecimal):
					#	num+="."
					#	startDecimal=false
					tmpDecimal+=str(arrnum["nums"][i]["val"])
					decimalCount+=1
				else:
					num+=str(arrnum["nums"][i]["val"])
		if(withSymbol):
			if(tmpDecimal!=""):
				#tmpDecimal="."+tmpDecimal
				var decFloat=float(str("0.")+tmpDecimal)*1
				tmpDecimal=str(decFloat)
				tmpDecimal[0]=""
				print(tmpDecimal)
			return txtNegative+num+tmpDecimal+symbol
		else:
			return txtNegative+num