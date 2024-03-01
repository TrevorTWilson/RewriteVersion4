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
    var selectedWeldingProcedure: WeldingInspector.Job.WeldingProcedure?
    @Binding var isPresented: Bool
    
    @State  var procedureName = ""
    @State  var procedureType = ""
    @State  var procedureUsage = ""
    @State  var procedureOwner = ""
    @State  var procedureWeldPass: [WeldingInspector.Job.WeldingProcedure.WeldPass] = []
    
    let procedureTypesList = ["","SMAW", "FCAW", "GMAW", "GTAW"]
    @State private var selectedProcedureType = 0
    
    let procedureUseList = ["","Girth", "Girth/Repair"]
    @State private var selectedProcedureUse = 0
    
    let procedureOwnerList = ["","Client", "Contractor"]
    @State private var selectedProcedureOwner = 0
    
    // Define the keys in the desired order
    let orderedKeys = ["Amps", "Volts", "ArcSpeed", "HeatInput"]
    
    init(mainViewModel: MainViewModel, isPresented: Binding<Bool>, selectedWeldingProcedure: WeldingInspector.Job.WeldingProcedure? = nil) {
        self.mainViewModel = mainViewModel
        self._isPresented = isPresented
        self.selectedWeldingProcedure = selectedWeldingProcedure
        
        _procedureName = State(initialValue: selectedWeldingProcedure?.name ?? "")
        
        // Initialize procedure type with stored value or default to the first element
        if let selectedType = selectedWeldingProcedure?.type,
           let typeIndex = procedureTypesList.firstIndex(of: selectedType) {
            _selectedProcedureType = State(initialValue: typeIndex)
        } else {
            _selectedProcedureType = State(initialValue: 0)
        }
        
        // Initialize procedure usage with stored value or default to the first element
        if let selectedUsage = selectedWeldingProcedure?.usage,
           let usageIndex = procedureUseList.firstIndex(of: selectedUsage) {
            _selectedProcedureUse = State(initialValue: usageIndex)
        } else {
            _selectedProcedureUse = State(initialValue: 0)
        }
        
        // Initialize procedure owner with stored value or default to the first element
        if let selectedOwner = selectedWeldingProcedure?.owner,
           let ownerIndex = procedureOwnerList.firstIndex(of: selectedOwner) {
            _selectedProcedureOwner = State(initialValue: ownerIndex)
        } else {
            _selectedProcedureOwner = State(initialValue: 0)
        }
        
        _procedureWeldPass = State(initialValue: selectedWeldingProcedure?.weldPass ?? [])
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Procedure Details")) {
                TextField("Procedure Name", text: $procedureName)
                
                Picker("Procedure Type", selection: $selectedProcedureType) {
                    ForEach(procedureTypesList.indices, id: \.self) { index in
                        Text(procedureTypesList[index])
                    }
                }
                
                Picker("Procedure Use", selection: $selectedProcedureUse) {
                    ForEach(procedureUseList.indices, id: \.self) { index in
                        Text(procedureUseList[index])
                    }
                }
                Picker("Procedure Owner", selection: $selectedProcedureOwner) {
                    ForEach(procedureOwnerList.indices, id: \.self) { index in
                        Text(procedureOwnerList[index])
                    }
                }
            }
            
            Section(header: CustomSectionHeader(sectionLabel: "Weld Passes", action: {
                // Add action for the button here
            })) {
                if let passList = selectedWeldingProcedure?.weldPass, !passList.isEmpty {
                    ForEach(Array(passList.enumerated()), id: \.element.id) { index, pass in
                        HStack {
                            Text(pass.passName)
                            
                            HStack(spacing: 5) {
                                // Update the button actions to handle each key individually
                                ForEach(orderedKeys, id: \.self) { key in
                                    GeometryReader { geometry in
                                        if pass.minRanges[key] == nil || pass.maxRanges[key] == nil {
                                            Text("Add \(key)")
                                                .padding()
                                                .font(.system(size: 12))
                                                .frame(width: 60, height: 60)
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(5)
                                                .onTapGesture {
                                                    addActionFor(pass: pass, key: key)
                                                }
                                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                        } else {
                                            Text("Edit \(key)")
                                                .padding()
                                                .font(.system(size: 12))
                                                .frame(width: 60, height: 60)
                                                .background(Color.green)
                                                .foregroundColor(.white)
                                                .cornerRadius(5)
                                                .onTapGesture {
                                                    editActionFor(pass: pass, key: key)
                                                }
                                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                        }
                                    }
                                    .frame(width: 60, height: 60)
                                }
                            }
                        }
                    }
                    
                } else {
                    Text("No welding passes available")
                    Text("Add welding passes to the selected procedure")
                }
            }
            
            Button(action: {
                // Add logic to save the collected data for WeldingProcedure
                
            }) {
                Text("Save Procedure")
            }
        }
        .navigationTitle("Add Welding Procedure")
    }
}

func addActionFor(pass: WeldingInspector.Job.WeldingProcedure.WeldPass, key: String) {
    // Handle action for 'Add Range' button based on the pass and key
    print("Add action for \(pass.passName) - \(key)")
}

func editActionFor(pass: WeldingInspector.Job.WeldingProcedure.WeldPass, key: String) {
    // Handle action for 'Edit Range' button based on the pass and key
    print("Edit action for \(pass.passName) - \(key)")
}


struct CustomSectionHeader: View {
    var sectionLabel: String
    var action: () -> Void
    
    var body: some View {
        VStack{
            HStack {
                Text(sectionLabel)
                    .font(.headline)
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            Text("Range Values")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            HStack {
                Text("Pass")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("Amps")
                    .frame(maxWidth: .infinity)
                Text("Volts")
                    .frame(maxWidth: .infinity)
                VStack {
                    Text("Arc")
                    Text("Speed")
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Heat")
                    Text("Input")
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding(.vertical, 5)
            
        }
        .padding(.horizontal)
    }
}


struct WeldingProcedureFormView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data
        
        @State var isPresented: Bool = true // Define isPresented as @State variable
        
        return WeldingProcedureFormView(mainViewModel: MainViewModel(), isPresented: $isPresented, selectedWeldingProcedure: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[1])
    }
}

