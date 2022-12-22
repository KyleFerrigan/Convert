//
//  TempView.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct TempView: View {
    // MARK: - Variables
	// Input
    @State var tempIn: String = ""
	// Input Temp Picker
    @State var inputTIndex : Int = 0
    @State var inputTOptions = ["F","C", "K"]
	// Precision Picker
	@State var precision : Int = 2
	@State var precisionOptions = [0,1,2,3,4,5,6,7,8,9,10]
	// Output Temp Picker
    @State var outputTIndex : Int = 1
    @State var outputTOptions = ["F","C", "K"]
	// Result
	@State var result: String = ""
    
	// MARK: - Calc Function
    func calc(){
		// Prevent invalid input values
		let temp : Double = Double(tempIn) ?? -459.68
        if (temp == -459.68){ return }
		
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
    }
	
    // MARK: - Clear Function
    func clear(){
        tempIn = ""
        result = ""
        done()
    }
	
    // MARK: - Body
    var body: some View {
		nf.maximumFractionDigits = precision //precision of units
         return NavigationStack{
            Form{
				Section{
					Picker("Initial Unit", selection: $inputTIndex){
						ForEach(0..<inputTOptions.count, id: \.self) {
							Text(self.inputTOptions[$0])
						}
					}
					
					TextField("Enter Temperature", text: $tempIn)
					
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
                    Picker("Converted Unit", selection: $outputTIndex){
                        ForEach(0..<outputTOptions.count, id: \.self) {
                        Text(self.outputTOptions[$0])
                        }
                    }
					
                    HStack {
                        Text("Result: ")
							.fontWeight(.bold)
                        Text(String(result))
                        
                    }
                }
            }
			 // MARK: - NavStack Modifiers
			.keyboardType(.decimalPad)
			.navigationTitle(Text("Temperature Converter"))
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
struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
