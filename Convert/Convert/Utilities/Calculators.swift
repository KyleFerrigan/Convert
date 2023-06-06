//
//  Calculators.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 2022-12-22.
//

import Foundation

// MARK: - Calculate Ohms Law
func calcOhms(usrIn : String, usr2In : String, usrIndex : Int, usr2Index : Int) -> [String]{
	var result: [String]
	var ampsOut : String = ""
	var voltsOut : String = ""
	var ohmsOut : String = ""
	var wattsOut : String = ""
	
	//if either input is blank do not compute
	if ((usrIn == "") || (usr2In == "")){ return [""]}
	let usrDbl = (Double(usrIn) ?? 0)
	let usr2Dbl = (Double(usr2In) ?? 0)
	
	//Logic
	switch usrIndex {
	case 0://AMPS as input
		let amps = usrDbl
		ampsOut = dts(dub: amps)
		
		switch usr2Index{
		case 1: //Calculate Ohms & Watts
			let volts = usr2Dbl
			voltsOut = dts(dub: volts)
			ohmsOut = dts(dub: (volts / amps))
			wattsOut = dts(dub: (volts * amps))
		case 2: //Calculate Volts & Watts
			let ohms = usr2Dbl
			ohmsOut = dts(dub: ohms)
			voltsOut = dts(dub: (amps * ohms))
			wattsOut = dts(dub: (pow(amps,2) * ohms))
		case 3: //Calculate Volts & Ohms
			let watts = usr2Dbl
			wattsOut = dts(dub : watts)
			voltsOut = dts(dub: (watts / amps))
			ohmsOut = dts(dub: (watts / pow(amps,2)))
		default:
			print("Error in switch usrIndex[0]")
		}
		
	case 1: //VOLTAGE as input
		let volts = usrDbl
		voltsOut = dts(dub: volts)
		
		switch usr2Index{
		case 0: //Calculate Ohms & Watts
			let amps = usr2Dbl
			ampsOut = dts(dub: amps)
			ohmsOut = dts(dub: (volts / amps))
			wattsOut = dts(dub: (volts * amps))
		case 2: //Calculate Amps & Watts
			let ohms = usr2Dbl
			ohmsOut = dts(dub: (ohms))
			ampsOut = dts(dub: (volts/ohms))
			wattsOut = dts(dub: (pow(volts,2) / ohms))
		case 3: //Calculate Amps & Ohms
			let watts = usr2Dbl
			wattsOut = dts(dub: watts)
			ampsOut = dts(dub: (watts / volts))
			ohmsOut = dts(dub: (pow(volts,2) / watts))
		default:
			print("Error in switch usrIndex[1]")
		}
		
	case 2: //RESISTANCE as input
		let ohms = usrDbl
		ohmsOut = dts(dub: ohms)
		
		switch usr2Index{
		case 0: //Calculate Volts & Watts
			let amps = usr2Dbl
			ampsOut = dts(dub: amps)
			voltsOut = dts(dub: (amps * ohms))
			wattsOut = dts(dub: (pow(amps,2) * ohms))
		case 1: //Calculate Amps & Watts
			let volts = usr2Dbl
			voltsOut = dts(dub: volts)
			ampsOut = dts(dub: (volts/ohms))
			wattsOut = dts(dub: (pow(volts,2) / ohms))
		case 3: //Calculate Amps & Volts
			let watts = usr2Dbl
			wattsOut = dts(dub: watts)
			ampsOut = dts(dub: pow((watts / ohms), 0.5))
			voltsOut = dts(dub: pow((watts * ohms), 0.5))
		default:
			print("Error in switch usrIndex[2]")
		}
		
	case 3: //POWER
		let watts = usrDbl
		wattsOut = dts(dub: watts)
		
		switch usr2Index {
		case 0: //Calculate Volts & Ohms
			let amps = usr2Dbl
			ampsOut = dts(dub: amps)
			voltsOut = dts(dub: (watts / amps))
			ohmsOut = dts(dub:(watts / pow(amps,2)))
		case 1: //Calculate Amps & Ohms
			let volts = usr2Dbl
			voltsOut = dts(dub: volts)
			ampsOut = dts(dub: (watts / volts))
			ohmsOut = dts(dub: (pow(volts,2) / watts))
		case 2: //Calculate Amps & Volts
			let ohms = usr2Dbl
			ohmsOut = dts(dub: ohms)
			ampsOut = dts(dub: (pow((watts / ohms), 0.5)))
			voltsOut = dts(dub: (pow((watts * ohms), 0.5)))
		default:
			print("Error in switch usrIndex[3]")
		}
	default:
		print("Error in usrIndexSwitch")
	}
	result = [ampsOut, voltsOut, ohmsOut, wattsOut]
	return result
}

// MARK: Calculate Length
func calcLength(selectIndex : Int, lengthIn: String, imperialIndex: Int,  metricIndex : Int) -> String {
	var result : String = ""
	switch selectIndex{
	case 0: // Imperial to Metric
		// Prevent invalid input values
		let imperial : Double = Double(lengthIn) ?? -0.9876504321
		if (imperial != -0.9876504321){
			switch imperialIndex{
			case 0: // Inches
				switch metricIndex{
				case 0: // Millimeters
					result = dts(dub: (imperial * 25.4))
				case 1: // Centimeters
					result = dts(dub: (imperial * 2.54))
				case 2: // Meters
					result = dts(dub: (imperial * 0.0254))
				case 3: // Kilometers
					result = dts(dub: (imperial * 0.0000254))
				default:
					print("Error in Switch imperialIndex[0]")
				}
			case 1: // Feet
				switch metricIndex{
				case 0: // Millimeters
					result = dts(dub: (imperial * 304.8))
				case 1: // Centimeters
					result = dts(dub: (imperial * 30.48))
				case 2: // Meters
					result = dts(dub: (imperial * 0.3048))
				case 3: // Kilometers
					result = dts(dub: (imperial * 0.0003048))
				default:
					print("Error in Switch imperialIndex[1]")
				}
			case 2: // Yards
				switch metricIndex{
				case 0: // Millimeters
					result = dts(dub: (imperial * 914.4))
				case 1: // Centimeters
					result = dts(dub: (imperial * 91.44))
				case 2: // Meters
					result = dts(dub: (imperial * 0.9144))
				case 3: // Kilometers
					result = dts(dub: (imperial * 0.0009144))
				default:
					print("Error in Switch imperialIndex[2]")
				}
			case 3: // Miles
				switch metricIndex{
				case 0: // Millimeters
					result = dts(dub: (imperial * 1609344))
				case 1: // Centimeters
					result = dts(dub: (imperial * 160934.4))
				case 2: // Meters
					result = dts(dub: (imperial * 1609.344))
				case 3: // Kilometers
					result = dts(dub: (imperial * 1.609344))
				default:
					print("Error in Switch imperialIndex[3]")
				}
			default:
				print("Error in Switch imperialIndex")
			}
		}
	case 1: // Metric to Imperial
		// Prevent invalid input values
		let metric: Double = Double(lengthIn) ?? -0.9876504321
		if (metric != -0.9876504321){
			switch metricIndex{
			case 0: // Millimeters
				switch imperialIndex{
				case 0: // mm to Inches
					result = dts(dub: (metric * 0.039370))
				case 1: // mm to Feet
					result = dts(dub: ((metric * 0.039370)/12))
				case 2: // mm to Yards
					result = dts(dub: (((metric * 0.039370)/12)/3))
				case 3: // mm to Miles
					result = dts(dub: ((((metric * 0.039370)/12)/3)*0.00056818))
				default:
					print("Error in Switch metricIndex[0]")
				}
			case 1: // Centimeters
				switch imperialIndex{
				case 0: // cm to Inches
					result = dts(dub: (metric * 0.39370))
				case 1: // cm to Feet
					result = dts(dub: ((metric * 0.39370)/12))
				case 2: // cm to Yards
					result = dts(dub: (((metric * 0.39370)/12)/3))
				case 3: // cm to Miles
					result = dts(dub: ((((metric * 0.39370)/12)/3)*0.00056818))
				default:
					print("Error in Switch metricIndex[1]")
				}
			case 2: // Meters
				switch imperialIndex{
				case 0: // m to Inches
					result = dts(dub: (metric * 39.37008))
				case 1: // m to Feet
					result = dts(dub: ((metric * 39.37008)/12))
				case 2: // m to Yards
					result = dts(dub: (((metric * 39.37008)/12)/3))
				case 3: // m to Miles
					result = dts(dub: ((((metric * 39.37008)/12)/3)*0.00056818))
				default:
					print("Error in Switch metricIndex[2]")
				}
			case 3: // Kilometers
				switch imperialIndex{
				case 0: // Km to Inches
					result = dts(dub: (metric * 39370.08))
				case 1: // Km to Feet
					result = dts(dub: ((metric * 39370.08)/12))
				case 2: // Km to Yards
					result = dts(dub: (((metric * 39370.08)/12)/3))
				case 3: // Km to Miles
					result = dts(dub: ((((metric * 39370.08)/12)/3)*0.00056818))
				default:
					print("Error in Switch metricIndex[3]")
				}
			default:
				print("Error in Switch metricIndex")
			}
		}
	default:
		print("Error in SwitchSelectIndex")
	}
	return result
}

// MARK: - Calculate Temp
func calcTemp(tempIn: String, inputTIndex : Int, outputTIndex : Int) -> String{
	var result : String = ""
	// Prevent invalid input values
	let temp : Double = Double(tempIn) ?? -459.68
	if (temp == -459.68){ return ""}
	
	switch inputTIndex{
	case 0: // Fahrenheit
		switch outputTIndex{
		case 0: // F to F
			result = dts(dub: temp)
		case 1: // F to C
			result = dts(dub: ((temp - 32 ) * (5/9)))
		case 2: //F to K
			result = dts(dub: (((temp - 32 )*(5/9)) + 273.15))
		default:
			print("Error in outputTIndex[0] switch")
		}
	case 1: //Celsius
		switch outputTIndex{
		case 0: //C to F
			result = dts(dub: ((temp * 9/5) + 32))
		case 1: //C to C
			result = dts(dub: (temp))
		case 2: //C to K
			result = dts(dub: (temp + 273.15))
		default:
			print("Error in outputTIndex[1] switch")
		}
	case 2: //Kelvin
		switch outputTIndex{
		case 0: //K to F
			result = dts(dub: (((temp - 273.15) * 9/5) + 32))
		case 1://K to C
			result = dts(dub: (temp - 273.15))
		case 2: //K to K
			result = dts(dub: temp)
		default:
			print("Error in outputTIndex[2] switch")
		}
	default:
		print("Error in inputTIndex Switch")
	}
	return result
}

// MARK: Calculate Speed
func calcSpeed(speedIn : String, inputIndex : Int, outputIndex : Int) -> String{
	var result : String = ""
	// Prevent invalid input values
	let speed = Double(speedIn) ?? -0.998877665544332211
	if (speed == -0.998877665544332211){ return ""}
	
	// Logic
	switch inputIndex {
	case 0: // mph
		switch outputIndex {
		case 0: // mph to mph
			result = dts(dub: speed)
		case 1: // mph to km/h
			result = dts(dub: (speed * 1.609344))
		case 2: // mph to m/s
			result = dts(dub: (speed * 0.44704))
		case 3: // mph to knots
			result = dts(dub: (speed * 0.8689758))
		default:
			print("Error in inputIndex case 2")
		}
	case 1: // km/h
		switch outputIndex {
		case 0: // km/h to mph
			result = dts(dub: (speed * 0.6213712))
		case 1: // km/h to km/h
			result = dts(dub: speed)
		case 2: // km/h to m/s
			result = dts(dub: (speed * 0.2777778))
		case 3: // km/h to knots
			result = dts(dub: (speed * 0.5399565))
		default:
			print("Error in inputIndex case 2")
		}
	case 2: // m/s
		switch outputIndex {
		case 0: // m/s to mph
			result = dts(dub: (speed * 2.236936))
		case 1: // m/s to km/h
			result = dts(dub: (speed * 3.6))
		case 2: // m/s to m/s
			result = dts(dub: (speed))
		case 3:// m/s to knots
			result = dts(dub: (speed * 1.943844))
		default:
			print("Error in inputIndex case 2")
		}
	case 3: // knots
		switch outputIndex {
		case 0: // knots to mph
			result = dts(dub: (speed * 1.15078))
		case 1: // knots to km/h
			result = dts(dub: (speed * 1.852001))
		case 2: // knots to m/s
			result = dts(dub: (speed * 0.5144447))
		case 3: // knots to knots
			result = dts(dub: (speed))
		default:
			print("Error in inputIndex case 2")
		}
	default:
		print("Error in inputIndex")
	}
	return result
}
