//
//  OhmsView.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 7/8/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct OhmsView: View {
    // MARK: - Variables
	// Inputs
    @State private var usrIn : String = ""
    @State private var usr2In : String = ""
    // First Picker
    @State private var usrIndex : Int = 0
    @State private var usrOptions = ["Amps","Volts","Ohms", "Watts"]
    // Second Picker
    @State private var usr2Index : Int = 1
    @State private var usr2Options = ["Amps","Volts","Ohms", "Watts"]
	// Precision Picker
	@State private var precision : Int = 3
	@State private var precisionOptions = [0,1,2,3,4,5,6,7,8,9,10]
    // Results
    @State private var ampsOut : String = ""
    @State private var voltsOut : String = ""
    @State private var ohmsOut : String = ""
    @State private var wattsOut : String = ""
    
	// MARK: - Calc Function
    func calc(){
		//if either input is blank do not compute
		if ((usrIn == "") || (usr2In == "")){ return }
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
			
			switch self.usr2Index{
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
			
			switch self.usr2Index{
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
			
			switch self.usr2Index {
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
    }
    
    // MARK: - Clear Function
    func clear(){
        usrIn = ""
        usr2In = ""
        ampsOut = ""
        voltsOut = ""
        ohmsOut = ""
        wattsOut = ""
        done()
    }
    
	// MARK: - Body
	var body: some View {
		nf.maximumFractionDigits = precision //precision of units
		return NavigationStack{
			Form{
				Section{
					Picker("First Unit", selection: $usrIndex){
						ForEach(0..<usrOptions.count, id: \.self) {
							Text(self.usrOptions[$0])
						}
					}
					
					TextField("Enter " + String(usrOptions[usrIndex]) + " value", text: $usrIn)
					
					
					Picker("Second Unit", selection: $usr2Index){
						ForEach(0..<usr2Options.count, id: \.self) {
							Text(self.usr2Options[$0])
						}
					}
					TextField("Enter " + String(usr2Options[usr2Index]) + " value", text: $usr2In)
					
					Picker("Precision" , selection: $precision){
						ForEach(0..<precisionOptions.count, id: \.self) {
							Text(String(precisionOptions[$0]) + " DP")
						}
					}
					
					Button(
						action:{
							calc()
						},
						label:{
							Text("Calculate")
								.fontWeight(.bold)
						}
					)
				}
				
				Section{
					Text("Results")
						.font(.title3)
						.fontWeight(.heavy)
					
					HStack{
						Text("Amps: ")
							.fontWeight(.bold)
						Text(ampsOut)
					}
					
					HStack{
						Text("Volts:  ")
							.fontWeight(.bold)
						Text(voltsOut)
					}
					
					HStack{
						Text("Ohms: ")
							.fontWeight(.bold)
						Text(ohmsOut)
					}
					
					HStack{
						Text("Watts: ")
							.fontWeight(.bold)
						Text(wattsOut)
					}
				}
			}
			// MARK: - NavStack Modifiers
			.keyboardType(.decimalPad)
			.navigationTitle(Text("Ohms Law Calculator"))
			.navigationBarTitleDisplayMode(.inline)
			.toolbar{
				ToolbarItemGroup(placement: .navigationBarLeading){
					Button(action: {self.clear()}) {Text("Clear")}
				}
				ToolbarItemGroup(placement: .navigationBarTrailing){
				#if targetEnvironment(macCatalyst)
					//Hide
				#else
					Button(action: {done()}) {Text("Done")}
				#endif
				}
			}
		}
	}
}

// MARK: - Preview
struct OhmsView_Previews: PreviewProvider {
    static var previews: some View {
        OhmsView()
    }
}
