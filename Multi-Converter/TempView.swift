//
//  TempView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct TempView: View {
    
    @State var tempIn: Double?
    
    @State var result: String = ""
    
    @State var inputTIndex : Int = 0
    @State var inputTOptions = ["F","C", "K"]
        
    @State var outputTIndex : Int = 1
    @State var outputTOptions = ["F","C", "K"]
    
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
        if (tempIn == nil){
            return
        }
        let temp : Double = Double(tempIn ?? 0)
    
        //Fahrenheit
        if inputTIndex == 0{
            //F to F
            if outputTIndex == 0{
                result = dts(dub: temp)
            }
            //F to C
            else if outputTIndex == 1{
                result = dts(dub: ((temp - 32 ) * (5/9)))
                 
            }
            //F to K
            else if outputTIndex == 2{
                   result = dts(dub: (((temp - 32 )*(5/9)) + 273.15))
            }
        }
        //Celsius
        else if inputTIndex == 1{
            //C to F
            if outputTIndex == 0{
                 result = dts(dub: ((temp * 9/5) + 32))
            }
            //C to C
            else if outputTIndex == 1{
                 result = dts(dub: (temp))
            }
            //C to K
            else if outputTIndex == 2{
                result = dts(dub: (temp + 273.15))
                
            }
        }
        //Kelvin
        else if inputTIndex == 2{
            //K to F
            if outputTIndex == 0{
                 result = dts(dub: (((temp - 273.15) * 9/5) + 32))
            }
            //K to C
            else if outputTIndex == 1{
                 result = dts(dub: (temp - 273.15))
            }
            //K to K
            else if outputTIndex == 2{
                 result = dts(dub: temp)
            }
        }
    }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        tempIn = nil
        result = ""
        
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        nf.maximumFractionDigits = 5 //max decimal points, maybe make this a setting?
        
        let inProxy = Binding<String>(
            get: {
                if self.tempIn == nil{
                    return ""
                }
                else{
                    return dts(dub: tempIn ?? 0)
                }
            },
            set: {
                let txtBxValue = $0
                if ((txtBxValue == "")){
                    tempIn = nil
                    result = ""
                }
                else{
                    self.tempIn = std(str: txtBxValue)
                    self.calc()
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
                Picker("", selection: inputTIndexProxy){
                    ForEach(0..<inputTOptions.count) {
                        Text(self.inputTOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                TextField("Enter Temperature", text: inProxy)
                
                
                Section{
                    Picker("", selection: outputTIndexProxy){
                        ForEach(0..<outputTOptions.count) {
                        Text(self.outputTOptions[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("Result: ")
                        Text(String(result))
                        
                    }
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
