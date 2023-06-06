//
//  TempView.swift
//  Convert
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
						action:{ self.result = calcTemp(tempIn: self.tempIn, inputTIndex: self.inputTIndex, outputTIndex: self.outputTIndex) },
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
			.keyboardType(.numbersAndPunctuation) //Shows negative sign
			.navigationTitle(Text("Temperature Converter"))
			.navigationBarTitleDisplayMode(.inline)
			.toolbar{
				ToolbarItemGroup(placement: .navigationBarLeading){
					Button(action: {self.clear()}) {Text("Clear")}
				}
				ToolbarItemGroup(placement: .navigationBarTrailing){
				#if targetEnvironment(macCatalyst)
					//Hide Button
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
