//
//  DistanceView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct DistanceView: View {
    @State var imperialIn : Double?
    @State var metricIn : Double?
    
    @State var result : String = ""
   
    @State var metricIndex : Int = 0
    @State var metricOptions = ["mm","cm","m", "km"]
    
    @State var imperialIndex : Int = 0
    @State var imperialOptions = ["in","Ft","Yd", "Miles"]
    
    @State var selectIndex : Int = 0
    @State var selectOptions = ["Imperial to Metric","Metric to Imperial"]
    
    let nf = NumberFormatter()
    
    func dts(dub : Double) -> String{
        let str : String = nf.string(from: (dub as NSNumber))!
        return str
    }
    
    func std(str : String) -> Double{
        let dub : Double = Double(str) ?? 0
        return dub
    }
    
    func calc(){
        if (selectIndex == 0){
            let imperial : Double = Double(imperialIn ?? 0)
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
            metricIn = std(str: result)
        }
        
        
        if (selectIndex == 1){
            let metric: Double = Double(metricIn ?? 0)
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
            imperialIn = std(str: result)
        }
        
    }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        imperialIn = nil
        metricIn = nil
        result = ""
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        nf.maximumFractionDigits = 3 //max decimal points, maybe make this a setting?
        
        let metersProxy = Binding<String>(
            get: {
                if (self.metricIn == nil){
                    return ""
                }
                else{
                    return dts(dub: (self.metricIn ?? 0))
                }
            },
            set: {
                let value = $0
                if (value == ""){
                    metricIn = nil
                    result = ""
                }
                else{
                    self.metricIn = std(str: value)
                    self.calc()
                }
                
            }
        )
        
        let imperialProxy = Binding<String>(
            get: {
                if self.imperialIn == nil{
                    return ""
                }
                else {
                    return dts(dub: (self.imperialIn ?? 0))
                }
            },
            set: {
                let value = $0
                if (value == ""){
                    imperialIn = nil
                    result = ""
                }
                else{
                    self.imperialIn = std(str: value)
                    self.calc()
                }
            }
        )
        
        
        //So it can calculate on state change of the pickers
        let imperialPProxy = Binding<Int>(
            get: { return self.imperialIndex },
            set: {
                self.imperialIndex = $0
                self.calc()
            }
        )
        let metricPProxy = Binding<Int>(
            get: {
                return self.metricIndex
            },
            set: {
                self.metricIndex = $0
                self.calc()
            }
        )
        let selectProxy = Binding<Int>(
            get:{
                return self.selectIndex
            },
            set:{
                self.selectIndex = $0
                self.calc()
            }
        )
        
        return NavigationView{
            Form{
                
                    Picker("Direction", selection: selectProxy){
                        ForEach(0..<selectOptions.count){
                            Text(self.selectOptions[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                
                Section{
                    if (selectIndex == 0){
                        Picker("Imperial", selection: imperialPProxy){
                            ForEach(0..<imperialOptions.count){
                                Text(self.imperialOptions[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        TextField("Enter Imperial Distance", text: imperialProxy)
                    }
                    if (selectIndex == 1){
                        Picker("Metric", selection: metricPProxy){
                            ForEach(0..<metricOptions.count){
                                Text(self.metricOptions[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        TextField("Enter Metric Distance", text: metersProxy)
                    }
                }
                Section{
                    if (selectIndex == 0){
                        Picker("Metric", selection: metricPProxy){
                            ForEach(0..<metricOptions.count){
                                Text(self.metricOptions[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    if (selectIndex == 1){
                        Picker("Imperial", selection: imperialPProxy){
                            ForEach(0..<imperialOptions.count){
                                Text(self.imperialOptions[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack{
                        Text("Result: ")
                        Text(self.result)
                    }
                }
            }
            
        .listStyle(GroupedListStyle())
        .navigationBarTitle((Text("Distance Converter")), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {self.clear()}) {Text("Clear")}, trailing: Button(action: {self.done()}) {Text("Done")})
        .keyboardType(.decimalPad)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceView()
    }
}
