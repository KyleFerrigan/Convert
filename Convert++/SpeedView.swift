//
//  SpeedView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/23/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct SpeedView: View {
    
    
     @State var speedIn : Double?
    
     @State var result : String = ""
    
     @State var inputIndex : Int = 0
     @State var inputOptions = ["mph","km/h", "m/s", "knots"]
     
     @State var outputIndex : Int = 1
     @State var outputOptions = ["mph","km/h", "m/s", "knots"]
    
    let nf = NumberFormatter()
    
    //double to string
    func dts(dub : Double) -> String{
        let str : String = nf.string(from: (dub as NSNumber))!
        return str
    }
    
    //string to double
    func std(str : String) -> Double{
        let dub : Double = Double(str) ?? 0
        return dub
    }
    
    
    func calc(){
        if (speedIn == nil){
            return
        }
        
        let speed = Double(speedIn ?? 0)
        
        if inputIndex == 0{
            if outputIndex == 0{ // mph to mph
                result = dts(dub: speed)
            }
            else if outputIndex == 1{ // mph to km/h
                result = dts(dub: (speed * 1.609344))
            }
            else if outputIndex == 2{// mph to m/s
                result = dts(dub: (speed * 0.44704))
            }
            else if outputIndex == 3{ //mph to knots
                result = dts(dub: (speed * 0.8689758))
            }
            
        }
        else if inputIndex == 1{
            
            if outputIndex == 0{ // km/h to mph
                result = dts(dub: (speed * 0.6213712))
            }
            else if outputIndex == 1{ // km/h to km/h
                 result = dts(dub: speed)
            }
            else if outputIndex == 2{ //km/h to m/s
                result = dts(dub: (speed * 0.2777778))
            }
            else if outputIndex == 3{ //km/h to knots
                result = dts(dub: (speed * 0.5399565))
            }
        }
        else if inputIndex == 2{
            
            if outputIndex == 0{// m/s to mph
                result = dts(dub: (speed * 2.236936))
            }
            if outputIndex == 1{ // m/s to km/h
                result = dts(dub: (speed * 3.6))
            }
            if outputIndex == 2{ // m/s to m/s
                 result = dts(dub: (speed))
            }
            if outputIndex == 3{  // m/s to knots
                result = dts(dub: (speed * 1.943844))
            }
        }
        else if inputIndex == 3{ //knots
            
            if outputIndex == 0{ //knots to mph
                result = dts(dub: (speed * 1.15078))
            }
            else if outputIndex == 1{ //knots to km/h
                result = dts(dub: (speed * 1.852001))
            }
            else if outputIndex == 2{ // knots to m/s
                result = dts(dub: (speed * 0.5144447))
            }
            else if outputIndex == 3{ //knots to knots
                 result = dts(dub: (speed))
            }
        }
    }
    //close keyboard
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        speedIn = nil
        result = ""
        
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        nf.maximumFractionDigits = 3 //max decimal points, maybe make this a setting?
        
        let metersProxy = Binding<String>(
            get: {
                if speedIn == nil{
                    return ""
                }
                else{
                return dts(dub: speedIn ?? 0)
                }
            },
            set: {
                let txtBxValue = $0
                
                if txtBxValue == ""{
                    speedIn = nil
                    result = ""
                }
                else{
                    speedIn = std(str: txtBxValue)
                    self.calc()
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
                    
                        HStack{
                            TextField("Enter Speed", text: metersProxy)
                            Picker("", selection: inputIndexProxy){
                                ForEach(0..<inputOptions.count) {
                                    Text(self.inputOptions[$0])
                                }
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                    
                    Section{
                        HStack{
                            Text("Result: ")
                            Text(String(result))
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
