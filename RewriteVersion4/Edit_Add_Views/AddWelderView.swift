//
//  AddWelderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddWelderView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var welderName: String
    @State private var welderId: String
    @State private var pressureNumber: String
    @State private var pressureExpiry: String
    @Binding var isPresented: Bool
    var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    
    public init(mainViewModel: MainViewModel, isPresented: Binding<Bool>, selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder? = nil) {
        self.mainViewModel = mainViewModel
        self._isPresented = isPresented
        self._welderName = State(initialValue: selectedWelder?.name ?? "")
        self._welderId = State(initialValue: selectedWelder?.welderId ?? "")
        self._pressureNumber = State(initialValue: selectedWelder?.pressureNumber ?? "")
        self._pressureExpiry = State(initialValue: selectedWelder?.pressureExpiry ?? "")
        self.selectedWelder = selectedWelder
    }

    func addWelder() {
        if selectedWelder != nil {
            // Edit existing welder
            mainViewModel.updateWelder(name: welderName, welderId: welderId, pressureNumber: pressureNumber, pressureExpiry: pressureExpiry)
        } else {
            // Add new welder
            mainViewModel.addWelder(name: welderName, welderId: welderId, pressureNumber: pressureNumber, pressureExpiry: pressureExpiry)
        }
        isPresented = false
    }

    var body: some View {
        Form {
            Section(header: Text("Add New Welder")) {
                Text("Welders Name")
                TextField("New Welder Name", text: $welderName)
            }

            Section(header: Text("Welder ID")) {
                Text("Welder ID")
                TextField("E.G.: 61", text: $welderId)
            }

            Section(header: Text("Pressure Number")) {
                Text("Pressure Number")
                TextField("Pressure Number", text: $pressureNumber)
            }

            Section(header: Text("Pressure Expiry")) {
                Text("Pressure Expiry")
                TextField("Pressure Expiry", text: $pressureExpiry)
            }

            HStack {
                Button(selectedWelder != nil ? "Edit Welder" : "Add Welder") {
                    addWelder()
                }
                Spacer()
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
        .onAppear {
            if let selectedWelder = selectedWelder {
                // Populate form fields with selected welder's data for editing
                welderName = selectedWelder.name
                welderId = selectedWelder.welderId
                pressureNumber = selectedWelder.pressureNumber
                pressureExpiry = selectedWelder.pressureExpiry
            }
        }
    }
}




struct AddWelderView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true // Define isPresented as @State variable
        AddWelderView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}
