//
//  ContentView.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 5/13/20.
//  Copyright © 2020 Kyle Ferrigan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	// MARK: - Variables
    @State private var selection = 0
	
	// MARK: - Body
    var body: some View {
        TabView(selection: $selection){
            OhmsView()
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

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

