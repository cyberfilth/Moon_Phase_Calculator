extends Node

func _ready():
	var time = OS.get_date()
	var day = time["weekday"]
	var month = time["month"]
	var year = time["year"]
	var result = moon_phase(month, day, year)
	print(result)

func moon_phase(month, day, year):
	var ages = [18, 0, 11, 22, 3, 14, 25, 6, 17, 28, 9, 20, 1, 12, 23, 4, 15, 26, 7]
	var offsets = [-1, 1, 0, 1, 2, 3, 4, 5, 7, 7, 9, 9]
	var description = ["new (totally dark)",\
	"waxing crescent (increasing to full)",\
	"in its first quarter (increasing to full)",\
	"waxing gibbous (increasing to full)",\
	"full (full light)",\
	"waning gibbous (decreasing from full)",\
	"in its last quarter (decreasing from full)",\
	"waning crescent (decreasing from full)"]
	var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	if day == 31:
		day = 1
	var days_into_phase = ((ages[(year + 1) % 19] + ((day + offsets[month-1]) % 30) + (year < 1900)) % 30)
	var index = int((days_into_phase + 2) * 16/59.0)
	if index > 7:
		index = 7
	var status = description[index]
	
	# light should be 100% 15 days into phase
	var light = int(2 * days_into_phase * 100/29)
	if light > 100:
		light = abs(light - 200);
	var date = str(day)+" "+str(months[month-1])+" "+str(year)
	
	return "Moon phase on "+date+" is "+status+", light = "+str(light)+"%"