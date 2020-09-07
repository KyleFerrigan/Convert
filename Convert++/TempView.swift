//
//  TempView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct TempView: View {
    
    @State var tempIn: Float = 0.0
    @State var tempTemp: Float = -0.0001
    
    @State var result: Float = 0.0
    
    @State var inputTIndex : Int = 0
    @State var inputTOptions = ["F","C", "K"]
        
    @State var outputTIndex : Int = 1
    @State var outputTOptions = ["F","C", "K"]
    
    
    
    
    func calc(){
        //Fahrenheit
        if inputTIndex == 0{
            //F to F
            if outputTIndex == 0{
                 result = tempIn
            }
            //F to C
            else if outputTIndex == 1{
                result = (tempIn - 32 ) * (5/9)
                 
            }
            //F to K
            else if outputTIndex == 2{
                   result = ((tempIn - 32 )*(5/9)) + 273.15
            }
        }
        //Celsius
        else if inputTIndex == 1{
            //C to F
            if outputTIndex == 0{
                 result = (tempIn * 9/5) + 32
            }
            //C to C
            else if outputTIndex == 1{
                 result = tempIn
            }
            //C to K
            else if outputTIndex == 2{
                result = tempIn + 273.15
                
            }
        }
        //Kelvin
        else if inputTIndex == 2{
            //K to F
            if outputTIndex == 0{
                 result = ((tempIn - 273.15) * 9/5) + 32
            }
            //K to C
            else if outputTIndex == 1{
                 result = tempIn - 273.15
            }
            //K to K
            else if outputTIndex == 2{
                 result = tempIn
            }
        }
    }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        tempTemp = -0.0001
        tempIn = 0.0
        result = 0.0
        
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        let inProxy = Binding<String>(
            get: { if self.tempTemp == -0.0001{return ""}
            else{return String(Float(self.tempTemp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.tempIn = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.tempIn){
                            self.tempTemp = value.floatValue
                            self.calc()
                        }
                    }
                }
            }
        )
        let inputTIndexProxy = Binding<Int>(
            get: {return self.inputTIndex},
            set: {
                self.inputTIndex = $0
                self.calc()
            }
        )
        let outputTIndexProxy = Binding<Int>(
            get: {return self.outputTIndex},
            set: {
                self.outputTIndex = $0
                self.calc()
            }
        )
         return NavigationView{
            Form{
                Section{
                    HStack {
                        TextField("Enter Temperature", text: inProxy)
                        Picker("", selection: inputTIndexProxy){
                            ForEach(0..<inputTOptions.count) {
                                Text(self.inputTOptions[$0])
                            }
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    HStack {
                        Text("Result: ")
                        Text(String(result))
                        Picker("", selection: outputTIndexProxy){
                            ForEach(0..<outputTOptions.count) {
                            Text(self.outputTOptions[$0])
                            }
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
            }
        .keyboardType(.decimalPad)
        .navigationBarTitle((Text("Temperature Converter")), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {self.clear()}) {Text("Clear")}, trailing: Button(action: {self.done()}) {Text("Done")})
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
