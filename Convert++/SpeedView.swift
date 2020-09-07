//
//  SpeedView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/23/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct SpeedView: View {
    
    
     @State var inputIn : Float = 0.0
     @State var inputTemp : Float = 0.0
    
     @State var outputTemp : Float = 0.0
     @State var outputIn : Float = 0.0
    
     @State var inputIndex : Int = 0
     @State var inputOptions = ["mph","km/h", "m/s", "knots"]
     
     @State var outputIndex : Int = 1
     @State var outputOptions = ["mph","km/h", "m/s", "knots"]
    
    
    func calc(){
        if inputIndex == 0{
            if outputIndex == 0{ // mph to mph
                outputTemp = inputIn
            }
            else if outputIndex == 1{ // mph to km/h
                outputTemp = inputIn * 1.609344
            }
            else if outputIndex == 2{// mph to m/s
                outputTemp = inputIn * 0.44704
            }
            else if outputIndex == 3{ //mph to knots
                outputTemp = inputIn * 0.8689758
            }
            
        }
        else if inputIndex == 1{
            
            if outputIndex == 0{ // km/h to mph
                outputTemp = inputIn * 0.6213712
            }
            else if outputIndex == 1{ // km/h to km/h
                 outputTemp = inputIn
            }
            else if outputIndex == 2{ //km/h to m/s
                outputTemp = inputIn * 0.2777778
            }
            else if outputIndex == 3{ //km/h to knots
                outputTemp = inputIn * 0.5399565
            }
        }
        else if inputIndex == 2{
            
            if outputIndex == 0{// m/s to mph
                outputTemp = inputIn * 2.236936
            }
            if outputIndex == 1{ // m/s to km/h
                outputTemp = inputIn * 3.6
            }
            if outputIndex == 2{ // m/s to m/s
                 outputTemp = inputIn
            }
            if outputIndex == 3{  // m/s to knots
                outputTemp = inputIn * 1.943844
            }
        }
        else if inputIndex == 3{ //knots
            
            if outputIndex == 0{ //knots to mph
                outputTemp = inputIn * 1.15078
            }
            else if outputIndex == 1{ //knots to km/h
                outputTemp = inputIn * 1.852001
            }
            else if outputIndex == 2{ // knots to m/s
                outputTemp = inputIn * 0.5144447
            }
            else if outputIndex == 3{ //knots to knots
                 outputTemp = inputIn
            }
        }
    }
    //close keyboard
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        outputTemp = 0.0
        outputIn = 0.0
        inputIn = 0.0
        inputTemp = 0.0
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        let metersProxy = Binding<String>(
            get: { if self.inputTemp == 0{return ""}
            else{return String(Float(self.inputTemp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.inputIn = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.inputIn){
                            self.inputTemp = value.floatValue
                            self.calc()
                        }
                    }
                }
            }
        )
        
        //So it updates automatically when changing units
        let inputIndexProxy = Binding<Int>(
            get: {return self.inputIndex},
            set: {
                self.inputIndex = $0
                self.calc()
            }
        )
        
        let outputIndexProxy = Binding<Int>(
            get: {return self.outputIndex},
            set:{
                self.outputIndex = $0
                self.calc()
            }
        )
        UITableView.appearance().separatorStyle = .singleLine
        
        return NavigationView{
                Form{
                    Section{
                        HStack{
                            TextField("Enter Speed", text: metersProxy)
                            Picker("", selection: inputIndexProxy){
                                ForEach(0..<inputOptions.count) {
                                    Text(self.inputOptions[$0])
                                }
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        
                        HStack{
                            Text("Result: ")
                            Text(String(outputTemp))
                            Picker("", selection: outputIndexProxy){
                                ForEach(0..<outputOptions.count) {
                                    Text(self.outputOptions[$0])
                                }
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                    }
                }
            .navigationBarTitle((Text("Speed Converter")), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {self.clear()}) {Text("Clear")}, trailing: Button(action: {self.done()}) {Text("Done")})
            .keyboardType(.decimalPad)
            
                }
                .navigationViewStyle(StackNavigationViewStyle())
            
        
    }
}

struct SpeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView()
    }
}
