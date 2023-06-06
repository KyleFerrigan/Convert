//  SpeedView.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 5/23/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.

import SwiftUI

struct SpeedView: View {
    // MARK: - Variables
	// Input
	@State var speedIn : String = ""
	// Input Picker
	@State var inputIndex : Int = 0
	@State var inputOptions = ["mph","km/h", "m/s", "knots"]
	// Precision Picker
	@State var precision : Int = 2
	@State var precisionOptions = [0,1,2,3,4,5,6,7,8,9,10]
	// Output Picker
	@State var outputIndex : Int = 1
	@State var outputOptions = ["mph","km/h", "m/s", "knots"]
	// Result
	@State var result : String = ""
    
	// MARK: Calc Function
    func calc(){
		// Prevent invalid input values
		let speed = Double(speedIn) ?? -0.998877665544332211
        if (speed == -0.998877665544332211){ return }
        
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
    }
	
    // MARK: - Clear Func
    func clear(){
        speedIn = ""
        result = ""
        done()
    }
	
    // MARK: - Body
    var body: some View {
		nf.maximumFractionDigits = precision //precision of units
        return NavigationStack{
			Form{
				Section{
					Picker("Initial Unit", selection: $inputIndex){
						ForEach(0..<inputOptions.count, id: \.self) {
							Text(self.inputOptions[$0])
						}
					}
					
					TextField("Enter Speed", text: $speedIn)
					
					Picker("Precision" , selection: $precision){
						ForEach(0..<precisionOptions.count, id: \.self) {
							Text(String(precisionOptions[$0]) + " DP")
						}
					}
					
					Button(
						action:{ calc() },
						label:{
							Text("Calculate")
								.fontWeight(.bold)
						}
					)
				}
				Section{
					Picker("Converted Unit", selection: $outputIndex){
						ForEach(0..<outputOptions.count, id: \.self) {
							Text(self.outputOptions[$0])
						}
					}
					
					HStack{
						Text("Result: ")
							.fontWeight(.bold)
						Text(String(result))
						
					}
				}
			}
			// MARK: - NavStack Modifiers
			.keyboardType(.decimalPad)
			.navigationTitle(Text("Speed Converter"))
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
struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView()
    }
}
