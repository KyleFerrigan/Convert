//
//  ContentView.swift
//  Convert++
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

//Universal access to this function accross views
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            OhmsViewRedux()
            .tabItem {
                VStack {
                    Image(systemName: "function")
                    Text("Ohms Law")
                    }
                }
                .tag(0)

            DistanceView()
            .tabItem {
                VStack {
                    Image(systemName: "skew")
                    Text("Distance")
                    }
                }
                .tag(1)
                
            TempView()
            .tabItem{
                VStack{
                    Image(systemName: "thermometer")
                    Text("Temp")
                }
            }
            .tag(2)
            
            SpeedView()
            .tabItem{
                VStack{
                    Image(systemName: "speedometer")
                    Text("Speed")
                }
            }
            .tag(3)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
