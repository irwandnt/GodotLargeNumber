# GodotLargeNumber
Large number for clicker game 

example

var a="2.5k"
var b="-2700"
result = addtition(a,b)  

#or

result = subtraction(a,b) 


#or


result = multiplication(a,b) 

#displaying result

readNum(result)  #with symbol , "k","mil" ,"bil" ,etc and default 2 decimal digits

readNum(result,true,1)  #with symbol and custom decimal digit *max 3 digits

readNum(result,false) # raw number without symbol 
