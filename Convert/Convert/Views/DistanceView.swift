//
//  DistanceView.swift
//  Convert
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

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
	
    // MARK: - Clear Func
    func clearLength(){
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
							self.result = calcLength(selectIndex: self.selectIndex, lengthIn: self.lengthIn, imperialIndex: self.imperialIndex, metricIndex: self.metricIndex)
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
					Button(action: {self.clearLength()}) {Text("Clear")}
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
struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceView()
    }
}
