//
//  OhmsView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 7/8/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct OhmsView: View {
    
    //1st TextField input
    @State var usrIn : Double?
    
    //2nd TextField input
    @State var usr2In : Double?
    
    //1st Picker Variables
    @State var usrIndex : Int = 0
    @State var usrOptions = ["Amps","Volts","Ohms", "Watts"]
    
    //2nd Picker Variables
    @State var usr2Index : Int = 1
    @State var usr2Options = ["Amps","Volts","Ohms", "Watts"]
    
    //Output Variables
    @State var ampsOut : String = ""
    @State var voltsOut : String = ""
    @State var ohmsOut : String = ""
    @State var wattsOut : String = ""
    
    let nf = NumberFormatter()
	
	func dts(dub : Double) -> String{//Double to string TODO replace all existing functions with this
		let str : String = nf.string(from: (dub as NSNumber))!
		return str
	}
	
	func std(str : String) -> Double{//String to double TODO replace all other functions with this
		let dub : Double = Double(str)!
        return dub
	}
    
    func calc(){
		
		//if either input is blank do not compute
		if ((usrIn == nil) || (usr2In == nil)){
            return
    	}
		
		
        //AMPS as input
        if (self.usrIndex == 0){
            let amps = Double(usrIn!)
            ampsOut = dts(dub: amps)
			
            //Calculate Ohms & Watts
            if (self.usr2Index == 1){
                let volts = Double(usr2In!) //Convert from Double? to Double
                voltsOut = dts(dub: volts)
                ohmsOut = dts(dub: (volts / amps))
                wattsOut = dts(dub: (volts * amps))
            }
			
            //Calculate Volts & Watts
            else if (self.usr2Index == 2){
                let ohms = Double(usr2In!)
                ohmsOut = dts(dub: ohms)
                voltsOut = dts(dub: (amps * ohms))
                wattsOut = dts(dub: (pow(amps,2) * ohms))
            }
			
            //Calculate Volts & Ohms
            else if (self.usr2Index == 3){
                let watts = Double(usr2In!)
                wattsOut = dts(dub : watts)
                voltsOut = dts(dub: (watts / amps))
                ohmsOut = dts(dub: (watts / pow(amps,2)))
            }
        }

        //VOLTAGE as input
        else if (self.usrIndex == 1){
            let volts = Double(usrIn!)
            voltsOut = dts(dub: volts)
			
            //Calculate Ohms & Watts
            if (self.usr2Index == 0){
                let amps = Double(usr2In!)
                ampsOut = dts(dub: amps)
                ohmsOut = dts(dub: (volts / amps))
                wattsOut = dts(dub: (volts * amps))
            }
			
            //Calculate Amps & Watts
            else if (self.usr2Index == 2){
                let ohms = Double(usr2In!)
                ohmsOut = dts(dub: (ohms))
                ampsOut = dts(dub: (volts/ohms))
                wattsOut = dts(dub: (pow(volts,2) / ohms))
            }
			
            //Calculate Amps & Ohms
            else if (self.usr2Index == 3){
                let watts = Double(usr2In!)
                wattsOut = dts(dub: watts)
                ampsOut = dts(dub: (watts / volts))
                ohmsOut = dts(dub: (pow(volts,2) / watts))
            }
        }
        /*//stopped here
        //RESISTANCE as input
        else if (self.usrIndex == 2 ){
			let ohms = usrIn
			ohmsOut = ohms
			
            //Calculate Volts & Watts
            if (self.usr2Index == 0){
                let amps = usr2In
				ampsOut = amps
                voltsOut = amps * ohms
                wattsOut = pow(amps,2) * ohms
            }
			
            //Calculate Amps & Watts
            else if (self.usr2Index == 1){
                let volts = usr2In
                voltsOut = volts
                ampsOut = volts/ohms
                wattsOut = pow(volts,2) / ohms
            }
			
            //Calculate Amps & Volts
            else if (self.usr2Index == 3){
                let watts = usr2In
                wattsOut = watts
                ampsout = pow((watts / ohms), 0.5)
                voltsout = pow((watts * ohms), 0.5)
            }
        }
        
        //POWER
        else if (self.usrIndex == 3){
			let watts = usrIn
			wattsOut = watts
			
            //Calculate Volts & Ohms
            if (self.usr2Index == 0){
                let amps = usr2In
                ampsOut = amps
                voltsOut = watts / amps
                ohmsOut = watts / pow(amps,2)
            }
			
            //Calculate Amps & Ohms
            else if (self.usr2Index == 1){
                let volts = usr2In
                voltsOut = volts
                ampsOut = watts / volts
                ohmsOut = pow(volts,2) / watts
            }
			
            //Calculate Amps & Volts
            else if (self.usr2Index == 2){
                let ohms = usr2In
                ohmsOut = ohms
                ampsOut = pow((watts / ohms), 0.5)
                voltsOut = pow((watts * ohms), 0.5)
            }
        }*/
    }
    
    func done(){
        UIApplication.shared.endEditing()
    }
    
    func clear(){
        usrIn = nil
        usr2In = nil
        
        ampsOut = ""
        voltsOut = ""
        ohmsOut = ""
        wattsOut = ""
        
        UIApplication.shared.endEditing()
    }
    
    var body: some View {
        
        nf.maximumFractionDigits = 10 //max decimal points, maybe make this a setting?
        
        //First user input
        let usrProxy = Binding<String>(
            get: {
                if (usrIn == nil){
                    return ""
                }
                else{
                    return dts(dub: (usrIn!))
                }
            },
            set: {
                let txtBxValue = $0 //if text box empty reset text fields
                if txtBxValue == ""{
                    usrIn = nil;
                    ampsOut = ""
                    voltsOut = ""
                    ohmsOut = ""
                    wattsOut = ""
                    return
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.usrIn = std(str : txtBxValue)
                        self.calc()
                    }
                }
            }
        )
        
        //Second user input
        let usr2Proxy = Binding<String>(
            get: {
                if (usr2In == nil){
                    return ""
                }
                else{
                    return dts(dub: (usr2In!))
                }
            },
            set: {
                let txtBxValue = $0
                if txtBxValue == ""{ //if text box empty reset text fields
                    usr2In = nil;
                    ampsOut = ""
                    voltsOut = ""
                    ohmsOut = ""
                    wattsOut = ""
                    return
                }
                else{
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.usr2In = std(str : txtBxValue)
                        self.calc()
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
        //TODO make it so the textfield takes up 75% or so so its more easily clickable
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
                            Text(ampsOut)
                        }
                        
                        HStack{
                            Text("Volts:  ")
                            Text(voltsOut)
                        }
                        
                        HStack{
                            Text("Ohms: ")
                            Text(ohmsOut)
                        }
                        
                        HStack{
                            Text("Watts: ")
                            Text(wattsOut)
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


struct OhmsView_Previews: PreviewProvider {
    static var previews: some View {
        OhmsView()
    }
}
