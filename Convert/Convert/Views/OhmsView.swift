//
//  OhmsView.swift
//  Convert
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
    
    // MARK: - Clear Function
    func clearOhmsLaw(){
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
							var temp : [String]
							if ((usrIn == "") || (usr2In == "")){
								temp = ["","","",""]
							} else {
								temp = calcOhms(usrIn: self.usrIn, usr2In: self.usr2In, usrIndex: self.usrIndex, usr2Index: self.usr2Index)
							}
							ampsOut = temp[0]
							voltsOut = temp[1]
							ohmsOut = temp[2]
							wattsOut = temp[3]
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
					Button(action: {self.clearOhmsLaw()}) {Text("Clear")}
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
struct OhmsView_Previews: PreviewProvider {
    static var previews: some View {
        OhmsView()
    }
}
