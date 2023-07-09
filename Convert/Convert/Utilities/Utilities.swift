//
//  Utilities.swift
//  Convert
//
//  Created by Kyle Ferrigan on 2022-12-21.
//
import Foundation
import SwiftUI

// MARK: Dismiss Keyboard
extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

// MARK: Close Keyboard
func done(){
	UIApplication.shared.endEditing()
}

// MARK: Number Formatting
let nf = NumberFormatter()

// MARK: Double to String
func dts(dub : Double) -> String {
	let str : String = nf.string(from: (dub as NSNumber))!
	return str
}

// MARK: String to Double
func std(str : String) -> Double {
	let dub : Double = Double(str) ?? 0
	return dub
}
