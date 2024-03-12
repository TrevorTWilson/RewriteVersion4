//
//  testPicker.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-12.
//

import SwiftUI

struct WeldPass: Codable, Identifiable, Hashable {
    var id = UUID()
    var passName: String = ""
    var minRanges: [String: Double] = [:]
    var maxRanges: [String: Double] = [:]

    init(passName: String, minRanges: [String: Double], maxRanges: [String: Double]) {
        self.passName = passName
        self.minRanges = minRanges
        self.maxRanges = maxRanges
    }
}

struct ContentView: View {
    @State private var selectedPass: WeldPass // Change to non-optional binding
    let passList: [WeldPass] = [
        WeldPass(passName: "Pass 1", minRanges: ["Amps": 90, "Volts": 7, "ArcSpeed": 50, "HeatInput": 0.3], maxRanges: ["Amps": 350, "Volts": 35, "ArcSpeed": 1000, "HeatInput": 3.0]),
        WeldPass(passName: "Pass 2", minRanges: ["Amps": 100, "Volts": 8, "ArcSpeed": 60, "HeatInput": 0.4], maxRanges: ["Amps": 400, "Volts": 40, "ArcSpeed": 1200, "HeatInput": 4.0])
    ]

    init() {
        _selectedPass = State(initialValue: passList.first!) // Set initial selectedPass value
    }

    var body: some View {
        VStack {
            Picker("Select Pass", selection: $selectedPass) {
                ForEach(passList) { pass in
                    Text(pass.passName).tag(pass)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            Text("Selected Pass: \(selectedPass.passName)")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


