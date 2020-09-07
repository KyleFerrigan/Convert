//
//  DistanceView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct DistanceView: View {
    @State var imperialIn : Float = 0.0
    @State var imperialTemp : Float = 0.0
    @State var metricIn : Float = 0.0
    @State var metricTemp : Float = 0.0
   
    @State var metricIndex : Int = 0
    @State var metricOptions = ["mm","cm","m", "km"]
    
    @State var imperialIndex : Int = 0
    @State var imperialOptions = ["in","Ft","Yd", "Miles"]
    
    func calcM(){
        //Metric To Imperial
        if imperialIn == 0{
            if metricIndex == 0{ //Millimeters
                if imperialIndex == 0{ //mm to Inches
                    imperialTemp = metricIn * 0.039370
                }
                if imperialIndex == 1{ //mm to Feet
                    imperialTemp = (metricIn * 0.039370)/12
                }
                if imperialIndex == 2{ //mm to Yards
                    imperialTemp = ((metricIn * 0.039370)/12)/3
                }
                if imperialIndex == 3{ //mm to Miles
                    imperialTemp = (((metricIn * 0.039370)/12)/3)*0.00056818
                }
            }
            if metricIndex == 1{ //Centimeters
                if imperialIndex == 0{ //cm to Inches
                    imperialTemp = metricIn * 0.39370
                }
                if imperialIndex == 1{ //cm to Feet
                    imperialTemp = (metricIn * 0.39370)/12
                }
                if imperialIndex == 2{ //cm to Yards
                    imperialTemp = ((metricIn * 0.39370)/12)/3
                }
                if imperialIndex == 3{ //cm to Miles
                    imperialTemp = (((metricIn * 0.39370)/12)/3)*0.00056818
                }
            }
            if metricIndex == 2{ //Meters
                if imperialIndex == 0{ //m to Inches
                    imperialTemp = metricIn * 39.37008
                }
                if imperialIndex == 1{ //m toFeet
                    imperialTemp = (metricIn * 39.37008)/12
                }
                if imperialIndex == 2{ //m to Yards
                    imperialTemp = ((metricIn * 39.37008)/12)/3
                }
                if imperialIndex == 3{ //m to Miles
                    imperialTemp = (((metricIn * 39.37008)/12)/3)*0.00056818
                }
            }
            if metricIndex == 3{ //Kilometers
                if imperialIndex == 0{ //Km to Inches
                    imperialTemp = metricIn * 39370.08
                }
                if imperialIndex == 1{ // Km to Feet
                    imperialTemp = (metricIn * 39370.08)/12
                }
                if imperialIndex == 2{ //Km to Yards
                    imperialTemp = ((metricIn * 39370.08)/12)/3
                }
                if imperialIndex == 3{ //Km to Miles
                    imperialTemp = (((metricIn * 39370.08)/12)/3)*0.00056818
                }
            }
        }
    }
    
    func calcI(){
        //Imperial to Metric
        if metricIn == 0 {
            if imperialIndex == 0{ //Inches
                if metricIndex == 0{ //Millimeters
                    metricTemp = imperialIn * 25.4
                }
                if metricIndex == 1{ //Centimeters
                    metricTemp = imperialIn * 2.54
                }
                if metricIndex == 2{ //Meters
                    metricTemp = imperialIn * 0.0254
                }
                if metricIndex == 3{ //Kilometers
                    metricTemp = imperialIn * 0.0000254
                }
            }
            if imperialIndex == 1{ //Feet
                if metricIndex == 0{ //Millimeters
                    metricTemp = imperialIn * 304.8
                }
                if metricIndex == 1{ //Centimeters
                    metricTemp = imperialIn * 30.48
                }
                if metricIndex == 2{ //Meters
                    metricTemp = imperialIn * 0.3048
                }
                if metricIndex == 3{ //Kilometers
                     metricTemp = imperialIn * 0.0003048
                }
            }
            if imperialIndex == 2{ //Yards
                if metricIndex == 0{ //Millimeters
                     metricTemp = imperialIn * 914.4
                }
                if metricIndex == 1{ //Centimeters
                    metricTemp = imperialIn * 91.44
                }
                if metricIndex == 2{ //Meters
                    metricTemp = imperialIn * 0.9144
                }
                if metricIndex == 3{ //Kilometers
                    metricTemp = imperialIn * 0.0009144
                }
            }
            if imperialIndex == 3{ //Miles
                if metricIndex == 0{ //Millimeters
                     metricTemp = imperialIn * 1609344
                }
                if metricIndex == 1{ //Centimeters
                    metricTemp = imperialIn * 160934.4
                }
                if metricIndex == 2{ //Meters
                    metricTemp = imperialIn * 1609.344
                }
                if metricIndex == 3{ //Kilometers
                    metricTemp = imperialIn * 1.609344
                }
            }
        }
     }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        imperialIn = 0
        imperialTemp = 0
        metricIn = 0
        metricTemp = 0
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        let metersProxy = Binding<String>(
            get: { if self.metricTemp == 0{return ""}
            else{return String(Float(self.metricTemp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.metricIn = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.metricIn){
                            self.metricTemp = value.floatValue
                            self.calcM()//i think this is correct
                        }
                    }
                }
            }
        )
        //Proxy to convert int  entered into a binding string so user does not need to commit with return on the keyboard
        let imperialProxy = Binding<String>(
            get: {
                if self.imperialTemp == 0{
                    return ""
                }
                else {
                    return String(Float(self.imperialTemp))
                }
            },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.imperialIn = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.imperialIn){
                            self.imperialTemp = value.floatValue
                            self.calcI()//same here i think this is correct
                        }
                    }
                }
            }
        )
        
        
        //So it can calculate on state change of the pickers
        let imperialPProxy = Binding<Int>(
            get: { return self.imperialIndex },
            set: {
                self.imperialIndex = $0
                self.calcM()//this is fucked
                self.calcI()//i dont know the order
            }
        )
        let metricPProxy = Binding<Int>(
            get: { return self.metricIndex },
            set: {
                self.metricIndex = $0
                self.calcI() //same here
                self.calcM() //wtf
            }
        )
        
        return NavigationView{
            Form{
                Picker("Metric", selection: metricPProxy){
                    ForEach(0..<metricOptions.count){
                        Text(self.metricOptions[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Enter Metric Distance", text: metersProxy)
                
                
                Picker("Imperial", selection: imperialPProxy){
                    ForEach(0..<imperialOptions.count){
                        Text(self.imperialOptions[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Enter Imperial Distance", text: imperialProxy)
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
