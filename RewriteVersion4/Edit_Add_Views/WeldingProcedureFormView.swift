//
//  WeldingProcedureFormView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-22.
//

import SwiftUI

struct WeldingProcedureFormView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    
    @State private var name = ""
    @State private var type = ""
    @State private var usage = ""
    @State private var owner = ""
    
    @State private var amps: CGFloat = 0
    @State private var volts: CGFloat = 0
    @State private var arcSpeed: CGFloat = 0
    @State private var heatInput: CGFloat = 0
    
    let procedureTypes = ["SMAW", "FCAW", "GMAW", "GTAW"]
    @State private var selectedProcedureType = 0
    
    let procedureUse = ["Girth Welds", "Girth/Repair"]
    @State private var selectedProcedureUse = 0
    
    let procedureOwner = ["Client", "Contractor"]
    @State private var selectedProcedureOwner = 0
    
    // Define the keys in the desired order
    let orderedKeys = ["Amps", "Volts", "Distance", "Time", "ArcSpeed", "HeatInput"]

    var body: some View {
        Form {
            Section(header: Text("Procedure Details")) {
                TextField("Procedure Name", text: $name)
                
                Picker("Procedure Type", selection: $selectedProcedureType) {
                    ForEach(procedureTypes.indices, id: \.self) { index in 
                        Text(procedureTypes[index])
                    }
                }
                
                Picker("Procedure Use", selection: $selectedProcedureUse) {
                    ForEach(procedureUse.indices, id: \.self) { index in
                        Text(procedureUse[index])
                    }
                }
                Picker("Procedure Owner", selection: $selectedProcedureOwner) {
                    ForEach(procedureOwner.indices, id: \.self) { index in
                        Text(procedureOwner[index])
                    }
                }
            }
            
            Section(header: Text("Parameter Ranges")) {
//                SliderRow(value: $amps, title: "Amps")
//                SliderRow(value: $volts, title: "Volts")
//                SliderRow(value: $arcSpeed, title: "Arc Speed")
//                SliderRow(value: $heatInput, title: "Heat Input")
                
                ForEach(orderedKeys, id: \.self) { key in
                    
                }
                
            }

            Button(action: {
                // Add logic to save the collected data for WeldingProcedure
                let minRanges = ["Amps": amps, "Volts": volts, "ArcSpeed": arcSpeed, "HeatInput": heatInput]
                let maxRanges = [String: CGFloat]() // Initialize maxRanges as needed
                
                // let weldingProcedure = WeldingProcedure(name: name, type: procedureTypes[selectedProcedureType], usage: usage, owner: owner, minRanges: minRanges, maxRanges: maxRanges, weldersQualified: [])
                
                // Add logic to save or use the weldingProcedure instance
            }) {
                Text("Save Procedure")
            }
        }
        .navigationTitle("Add Welding Procedure")
    }
}


struct SliderRow: View {
    @Binding var value: CGFloat
    let title: String
    
    var body: some View {
        VStack {
            Text("\(title): \(value)")
            Slider(value: $value, in: 0...100, step: 1)
                .accentColor(.blue)
        }
        .padding()
    }
}


struct WeldingProcedureFormView_Previews: PreviewProvider {
    static var previews: some View {
        WeldingProcedureFormView(mainViewModel: MainViewModel())
    }
}

