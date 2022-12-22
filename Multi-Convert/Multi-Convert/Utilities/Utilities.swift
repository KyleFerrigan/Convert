//
//  Utilities.swift
//  Multi-Convert
//
//  Created by Kyle Ferrigan on 2022-12-21.
//

import SwiftUI
// TODO: Move converters here
//Dismiss Keyboard
extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

// Close Keyboard
func done(){
	UIApplication.shared.endEditing()
}

//Number Formatting
let nf = NumberFormatter()

// Double to String
func dts(dub : Double) -> String {
	let str : String = nf.string(from: (dub as NSNumber))!
	return str
}

// String to Double
func std(str : String) -> Double {
	let dub : Double = Double(str) ?? 0
	return dub
}
