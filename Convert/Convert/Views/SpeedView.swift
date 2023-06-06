//  SpeedView.swift
//  Convert
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
						action:{ result = calcSpeed(speedIn: self.speedIn, inputIndex: self.inputIndex, outputIndex: self.outputIndex) },
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
struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView()
    }
}
