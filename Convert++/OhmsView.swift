//
//  OhmsView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct OhmsView: View {
    
    @State var ampsin : Float = 0.0
    @State var ampstemp : Float = 0.0
    @State var voltsin : Float = 0.0
    @State var voltstemp : Float = 0.0
    @State var ohmsin : Float = 0.0
    @State var ohmstemp : Float = 0.0
    @State var wattsin : Float = 0.0
    @State var wattstemp : Float = 0.0
    
    
    func calc(){
            //AMPS
            if (self.ampsin == 0.0){
                if(self.wattsin == 0.0){
                    self.ampstemp = self.voltsin/self.ohmsin
                }
                if(self.voltsin == 0.0){
                    self.ampstemp = (self.wattsin/self.ohmsin).squareRoot()
                }
                if(self.ohmsin == 0.0){
                    self.ampstemp = self.wattsin/self.voltsin
                }
            }
        
            //RESISTANCE
            if (self.ohmsin == 0.0){
                //Amps & Volts
                if(self.wattsin == 0.0){
                    self.ohmstemp = self.voltsin/self.ampsin
                }
                //Watts & Amps
                if(self.voltsin == 0.0){
                    self.ohmstemp = self.wattsin/(pow(self.ampsin, 2))
                }
                //Watts & Volts
                if(self.ampsin == 0.0){
                    self.ohmstemp = (pow(self.voltsin, 2.0))/self.wattsin
                }
            }
        
            //VOLTAGE
            if (self.voltsin == 0.0){
                if(self.wattsin == 0.0){
                    self.voltstemp = self.ampsin*self.ohmsin
                }
                if(self.ampsin == 0.0){
                    self.voltstemp = (self.wattsin*self.ohmsin).squareRoot()
                }
                if(self.ohmsin == 0.0){
                    self.voltstemp = self.wattsin/self.ampsin
                }
            }
        
            //POWER
            if (self.wattsin == 0.0){
                if(self.ampsin == 0.0){
                    self.wattstemp = pow(self.voltsin,2)/self.ohmsin
                }
                else if(self.voltsin == 0.0){
                    self.wattstemp = pow(self.ampsin, 2)/self.ohmsin
                }
                else if(self.ohmsin == 0.0){
                    self.wattstemp = self.voltsin*self.ampsin
                }
            }
        UIApplication.shared.endEditing()
    }
    func clear(){
        ampstemp = 0
        ampsin = 0
        voltstemp = 0
        voltsin = 0
        ohmstemp = 0
        ohmsin = 0
        wattstemp = 0
        wattsin = 0
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 5
        
        //Set varibale after checking if new variable is different
        let ampsProxy = Binding<String>(
            get: { if self.ampstemp == 0{return ""}
            else{return String(Float(self.ampstemp))} },
            set: {
                if let value = numberFormatter.number(from: $0) {//converts string to Float value
                        self.ampsin = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if value.floatValue == self.ampsin{
                                self.ampstemp = value.floatValue
                            
                        }
                    }
                }
            }
        )
        
        let voltsProxy = Binding<String>(
            get: { if self.voltstemp == 0{return ""}
            else{return String(Float(self.voltstemp))} },
            set: {
                if let value = numberFormatter.number(from: $0) {
                    self.voltsin = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if value.floatValue == self.voltsin{
                            self.voltstemp = value.floatValue
                        }
                    }
                }
            }
        )
        
        let ohmsProxy = Binding<String>(
            get: { if self.ohmstemp == 0{return ""}
                else{return String(Float(self.ohmstemp))} },
            set: {
                if let value = numberFormatter.number(from: $0) {
                    self.ohmsin = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.ohmsin){
                            self.ohmstemp = value.floatValue
                        }
                    }
                }
            }
        )
        
        let wattsProxy = Binding<String>(
            get: { if self.wattstemp == 0{return ""}
            else{return String(Float(self.wattstemp))} },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.wattsin = value.floatValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if (value.floatValue == self.wattsin){
                            self.wattstemp = value.floatValue
                        }
                    }
                }
            }
        )
        
        return VStack {
            NavigationView{
                Form{
                    HStack{
                        Text("Amps: ")
                        TextField("Enter Amps", text: ampsProxy)
                        
                    }
                    
                    HStack{
                        Text("Volts:  ")
                        TextField("Enter Volts", text: voltsProxy)
                    }
                    HStack{
                        Text("Ohms: ")
                        TextField("Enter Ohms", text: ohmsProxy)
                    }
                    HStack{
                        Text("Watts: ")
                        TextField("Enter Watts", text: wattsProxy)
                    }
            
                }
                .navigationBarTitle((Text("Ohm's Law Calculator")), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {self.clear()}) {Text("Clear")}, trailing: Button(action: {self.calc()}) {Text("Calculate")})
                .keyboardType(.decimalPad)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


struct OhmsView_Previews: PreviewProvider {
    static var previews: some View {
        OhmsView()
    }
}
