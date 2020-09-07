//
//  OhmsViewRedux.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 7/8/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct OhmsViewRedux: View {
    
    //1st TextField input
    @State var usrIn : Float = 0.0
    @State var usrTemp : Float = 0.0
    
    //2nd TextField input
    @State var usr2In : Float = 0.0
    @State var usr2Temp : Float = 0.0
    
    //1st Picker Variables
    @State var usrIndex : Int = 0
    @State var usrOptions = ["Amps","Volts","Ohms", "Watts"]
    
    //2nd Picker Variables
    @State var usr2Index : Int = 1
    @State var usr2Options = ["Amps","Volts","Ohms", "Watts"]
    
    //Output Variables
    @State var ampsout : Float = 0.0
    @State var voltsout : Float = 0.0
    @State var ohmsout : Float = 0.0
    @State var wattsout : Float = 0.0
    
    
    func calc(){
        //TODO replace -1 with formulas
        
        //AMPS as input
        if (self.usrIndex == 0){
            //Calculate Ohms & Watts
            if (self.usr2Index == 1){
                ampsout = usrIn
                voltsout = usr2In
                
                ohmsout = voltsout / ampsout
                wattsout = voltsout * ampsout
            }
            //Calculate Volts & Watts
            else if (self.usr2Index == 2){
                ampsout = usrIn
                ohmsout = usr2In
                
                voltsout = ampsout * ohmsout
                wattsout = (pow(ampsout,2) * ohmsout)
            }
            //Calculate Volts & Ohms
            else if (self.usr2Index == 3){
                ampsout = usrIn
                wattsout = usr2In
                
                voltsout = (wattsout / ampsout)
                ohmsout = (wattsout / pow(ampsout,2))
            }
        }
        //VOLTAGE as input
        else if (self.usrIndex == 1){
            //Calculate Ohms & Watts
            if (self.usr2Index == 0){
                voltsout = usrIn
                ampsout = usr2In
                
                ohmsout = (voltsout / ampsout)
                wattsout = (voltsout * ampsout)
            }
            //Calculate Amps & Watts
            else if (self.usr2Index == 2){
                voltsout = usrIn
                ohmsout = usr2In
                
                ampsout = (voltsout/ohmsout)
                wattsout = (pow(voltsout,2) / ohmsout)
            }
            //Calculate Amps & Ohms
            else if (self.usr2Index == 3){
                voltsout = usrIn
                wattsout = usr2In
                
                ampsout = (wattsout / voltsout)
                ohmsout = (pow(voltsout,2) / wattsout)
            }
        }
        //RESISTANCE as input
        else if (self.usrIndex == 2 ){
            //Calculate Volts & Watts
            if (self.usr2Index == 0){
                ohmsout = usrIn
                ampsout = usr2In
                
                voltsout = ampsout * ohmsout
                wattsout = pow(ampsout,2) * ohmsout
            }
            //Calculate Amps & Watts
            else if (self.usr2Index == 1){
                ohmsout = usrIn
                voltsout = usr2In
                
                ampsout = voltsout/ohmsout
                wattsout = pow(voltsout,2) / ohmsout
            }
            //Calculate Amps & Volts
            else if (self.usr2Index == 3){
                ohmsout = usrIn
                wattsout = usr2In
                
                ampsout = pow((wattsout / ohmsout), 0.5)
                voltsout = pow((wattsout * ohmsout), 0.5)
            }
        }
        //POWER
        else if (self.usrIndex == 3){
            //Calculate Volts & Ohms
            if (self.usr2Index == 0){
                wattsout = usrIn
                ampsout = usr2In
                
                voltsout = wattsout / ampsout
                ohmsout = wattsout / pow(ampsout,2)
            }
            //Calculate Amps & Ohms
            else if (self.usr2Index == 1){
                wattsout = usrIn
                voltsout = usr2In
                
                ampsout = wattsout / voltsout
                ohmsout = pow(voltsout,2) / wattsout
            }
            //Calculate Amps & Volts
            else if (self.usr2Index == 2){
                wattsout = usrIn
                ohmsout = usr2In
                
                ampsout = pow((wattsout / ohmsout), 0.5)
                voltsout = pow((wattsout * ohmsout), 0.5)
            }
        }
    }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        usrIn = 0
        usr2In = 0
        usrTemp = 0
        usr2Temp = 0
        
        ampsout = 0
        voltsout = 0
        ohmsout = 0
        wattsout = 0
        UIApplication.shared.endEditing()
    }
    
    
    
    var body: some View {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 5
        
        //First user input
        let usrProxy = Binding<String>(
            get: { if self.usrTemp == 0{return ""}
            else{return String(Float(self.usrTemp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.usrIn = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.usrIn){
                            self.usrTemp = value.floatValue
                            self.calc()
                        }
                    }
                }
            }
        )
        
        //Second user input
        let usr2Proxy = Binding<String>(
            get: { if self.usr2Temp == 0{return ""}
            else{return String(Float(self.usr2Temp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.usr2In = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.usr2In){
                            self.usr2Temp = value.floatValue
                            self.calc()
                        }
                    }
                }
            }
        )
        let usrIndexProxy = Binding<Int>(
            get: {return self.usrIndex},
            set: {
                self.usrIndex = $0
                self.calc()
            }
        )
        let usr2IndexProxy = Binding<Int>(
            get: {return self.usr2Index},
            set: {
                self.usr2Index = $0
                self.calc()
            }
        )
        return VStack {
            NavigationView{
                Form{
                    Section{
                        HStack{
                            TextField("Enter first value", text: usrProxy)
                            Picker("", selection: usrIndexProxy){
                                ForEach(0..<usrOptions.count) {
                                    Text(self.usrOptions[$0])
                                }
                            }
                        }
                        HStack{
                            TextField("Enter second value", text: usr2Proxy)
                            Picker("", selection: usr2IndexProxy){
                                ForEach(0..<usr2Options.count) {
                                    Text(self.usr2Options[$0])
                                }
                            }
                        }
                    }
                    Section{
                        HStack{
                            Text("Amps: ")
                            Text(String(ampsout))
                        }
                        
                        HStack{
                            Text("Volts:  ")
                            Text(String(voltsout))
                        }
                        HStack{
                            Text("Ohms: ")
                            Text(String(ohmsout))
                        }
                        HStack{
                            Text("Watts: ")
                            Text(String(wattsout))
                        }
                    }
                }
                .navigationBarTitle((Text("Ohm's Law Calculator")), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {self.clear()}) {Text("Clear")}, trailing: Button(action: {self.done()}) {Text("Done")})
                .keyboardType(.decimalPad)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


struct OhmsViewRedux_Previews: PreviewProvider {
    static var previews: some View {
        OhmsViewRedux()
    }
}
