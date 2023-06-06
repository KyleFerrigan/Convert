//
//  DistanceView.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

// TODO: Add switch statements to calc function

import SwiftUI

struct DistanceView: View {
	// MARK: - Variables
	// Metric Imperial Switcher
	@State private var selectIndex : Int = 0
	@State private var selectOptions = ["Imperial to Metric","Metric to Imperial"]
	// Input
	@State private var lengthIn: String = ""
    // Metric Picker
    @State private var metricIndex : Int = 2
    @State private var metricOptions = ["mm","cm","m", "km"]
    // Imperial Picker
    @State private var imperialIndex : Int = 1
    @State private var imperialOptions = ["in","Ft","Yd", "Miles"]
    // Precision Picker
	@State private var precision : Int = 3
	@State private var precisionOptions = [0,1,2,3,4,5,6,7,8,9,10]
	// Result
	@State private var result : String = ""
	
	// MARK: - Calc Function
    func calc(){
        if (selectIndex == 0){
			// Prevent invalid input values
			let imperial : Double = Double(lengthIn) ?? -0.9876504321
            if (imperial != -0.9876504321){
                //Imperial to Metric
                if imperialIndex == 0{ //Inches
                    if metricIndex == 0{ //Millimeters
                        result = dts(dub: (imperial * 25.4))
                    }
                    if metricIndex == 1{ //Centimeters
                        result = dts(dub: (imperial * 2.54))
                    }
                    if metricIndex == 2{ //Meters
                        result = dts(dub: (imperial * 0.0254))
                    }
                    if metricIndex == 3{ //Kilometers
                        result = dts(dub: (imperial * 0.0000254))
                    }
                }
				
                if imperialIndex == 1{ //Feet
                    if metricIndex == 0{ //Millimeters
                        result = dts(dub: (imperial * 304.8))
                    }
                    if metricIndex == 1{ //Centimeters
                        result = dts(dub: (imperial * 30.48))
                    }
                    if metricIndex == 2{ //Meters
                        result = dts(dub: (imperial * 0.3048))
                    }
                    if metricIndex == 3{ //Kilometers
                         result = dts(dub: (imperial * 0.0003048))
                    }
                }
				
                if imperialIndex == 2{ //Yards
                    if metricIndex == 0{ //Millimeters
                         result = dts(dub: (imperial * 914.4))
                    }
                    if metricIndex == 1{ //Centimeters
                        result = dts(dub: (imperial * 91.44))
                    }
                    if metricIndex == 2{ //Meters
                        result = dts(dub: (imperial * 0.9144))
                    }
                    if metricIndex == 3{ //Kilometers
                        result = dts(dub: (imperial * 0.0009144))
                    }
                }
				
                if imperialIndex == 3{ //Miles
                    if metricIndex == 0{ //Millimeters
                         result = dts(dub: (imperial * 1609344))
                    }
                    if metricIndex == 1{ //Centimeters
                        result = dts(dub: (imperial * 160934.4))
                    }
                    if metricIndex == 2{ //Meters
                        result = dts(dub: (imperial * 1609.344))
                    }
                    if metricIndex == 3{ //Kilometers
                        result = dts(dub: (imperial * 1.609344))
                    }
                }
            }
        }
        
        if (selectIndex == 1){
			// Prevent invalid input values
			let metric: Double = Double(lengthIn) ?? -0.9876504321
            if (metric != -0.9876504321){
                //Metric To Imperial
                if metricIndex == 0{ //Millimeters
                    if imperialIndex == 0{ //mm to Inches
                        result = dts(dub: (metric * 0.039370))
                    }
                    if imperialIndex == 1{ //mm to Feet
                        result = dts(dub: ((metric * 0.039370)/12))
                    }
                    if imperialIndex == 2{ //mm to Yards
                        result = dts(dub: (((metric * 0.039370)/12)/3))
                    }
                    if imperialIndex == 3{ //mm to Miles
                        result = dts(dub: ((((metric * 0.039370)/12)/3)*0.00056818))
                    }
                }
				
                if metricIndex == 1{ //Centimeters
                    if imperialIndex == 0{ //cm to Inches
                        result = dts(dub: (metric * 0.39370))
                    }
                    if imperialIndex == 1{ //cm to Feet
                        result = dts(dub: ((metric * 0.39370)/12))
                    }
                    if imperialIndex == 2{ //cm to Yards
                        result = dts(dub: (((metric * 0.39370)/12)/3))
                    }
                    if imperialIndex == 3{ //cm to Miles
                        result = dts(dub: ((((metric * 0.39370)/12)/3)*0.00056818))
                    }
                }
				
                if metricIndex == 2{ //Meters
                    if imperialIndex == 0{ //m to Inches
                        result = dts(dub: (metric * 39.37008))
                    }
                    if imperialIndex == 1{ //m toFeet
                        result = dts(dub: ((metric * 39.37008)/12))
                    }
                    if imperialIndex == 2{ //m to Yards
                        result = dts(dub: (((metric * 39.37008)/12)/3))
                    }
                    if imperialIndex == 3{ //m to Miles
                        result = dts(dub: ((((metric * 39.37008)/12)/3)*0.00056818))
                    }
                }
				
                if metricIndex == 3{ //Kilometers
                    if imperialIndex == 0{ //Km to Inches
                        result = dts(dub: (metric * 39370.08))
                    }
                    if imperialIndex == 1{ // Km to Feet
                        result = dts(dub: ((metric * 39370.08)/12))
                    }
                    if imperialIndex == 2{ //Km to Yards
                        result = dts(dub: (((metric * 39370.08)/12)/3))
                    }
                    if imperialIndex == 3{ //Km to Miles
                        result = dts(dub: ((((metric * 39370.08)/12)/3)*0.00056818))
                    }
                }
            }
        }
    }
    // MARK: - Clear Func
    func clear(){
        lengthIn = ""
        result = ""
        done()
    }
	
    // MARK: - Body
    var body: some View {
		nf.maximumFractionDigits = precision //precision of units
        return NavigationStack{
            Form{
				Section{
					Picker("Direction", selection: $selectIndex){
						ForEach(0..<selectOptions.count, id: \.self){
							Text(self.selectOptions[$0])
						}
					}.pickerStyle(SegmentedPickerStyle())
				}
                Section{
                    if (selectIndex == 0){
                        Picker("Initial Unit", selection: $imperialIndex){
                            ForEach(0..<imperialOptions.count, id: \.self){
                                Text(self.imperialOptions[$0])
                            }
                        }
                    }
                    if (selectIndex == 1){
                        Picker("Initial Unit", selection: $metricIndex){
                            ForEach(0..<metricOptions.count, id: \.self){
                                Text(self.metricOptions[$0])
                            }
                        }
                    }
					TextField("Enter Distance", text: $lengthIn)
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
                    if (selectIndex == 0){
                        Picker("Converted Unit", selection: $metricIndex){
                            ForEach(0..<metricOptions.count, id: \.self){
                                Text(self.metricOptions[$0])
                            }
                        }
                    }
                    if (selectIndex == 1){
                        Picker("Converted Unit", selection: $imperialIndex){
                            ForEach(0..<imperialOptions.count, id: \.self){
                                Text(self.imperialOptions[$0])
                            }
                        }
                    }
					HStack{
						Text("Result: ")
							.fontWeight(.bold)
						Text(self.result)
					}
                }
            }
			// MARK: - NavStack Modifiers
			.keyboardType(.decimalPad)
			.navigationTitle(Text("Distance Converter"))
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
struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceView()
    }
}
