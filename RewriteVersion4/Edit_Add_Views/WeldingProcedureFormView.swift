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
    @State private var addNewPass = false // add weldPass
    
    @State private var isRangeSliderSheetPresented = false
    @State private var selectedKey: String = "" // Store the selected key
    @State private var selectedDescriptor: String = "" // Store descriptor
    @State private var selectedMinRange: Double = 0.0 // Store the minimum range
    @State private var selectedMaxRange: Double = 0.0 // Store the maximum range
    
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
                addNewPass.toggle()
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
                                                    // Get temp values
                                                    let (tempMin, tempMax) = getTemporaryValuesForKey(key)
                                                    selectedKey = key
                                                    selectedDescriptor = "Add new Range Values"
                                                    selectedMinRange = tempMin
                                                    selectedMaxRange = tempMax
                                                    isRangeSliderSheetPresented = true
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
                                                    let tempMin = pass.minRanges[key]
                                                    let tempMax = pass.maxRanges[key]
                                                    selectedKey = key
                                                    selectedDescriptor = "Edit Range Values"
                                                    selectedMinRange = tempMin!
                                                    selectedMaxRange = tempMax!
                                                    isRangeSliderSheetPresented = true
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
            HStack{
                Button(action: {
                    // Add logic to save the collected data for WeldingProcedure
                    dismiss()
                }) {
                    Text("Save Procedure")
                }
                Spacer()
                Button(action: {
                    // Add logic to save the collected data for WeldingProcedure
                    dismiss()
                }) {
                    Text("Cancel")
                }
            }
            
        }
//        .onAppear{
//            if selectedWeldingProcedure != nil {
//                mainViewModel.setSelectedProcedure(procedure: selectedWeldingProcedure!)
//            } else {
//                print("onAppear failed")
//            }
//        }
        .navigationTitle("Add Welding Procedure")
        
        .sheet(isPresented: $isRangeSliderSheetPresented) {
            RangeSlider(
                isPresented: $isPresented,
                attributeTitle: selectedKey,
                descriptor: selectedDescriptor,
                minValue: selectedMinRange,
                maxValue: selectedMaxRange,
                onValueSelected: { minValue, maxValue in
                    print(minValue, maxValue)
                }
            )
        }
        .sheet(isPresented: $addNewPass, content: {
            // Add new job item view
            AddProcedurePass(mainViewModel: mainViewModel, isPresented: $addNewPass)
        })

    }
}



struct WeldingProcedureFormView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data
        //mockMainViewModel.setSelectedJob(job: mockMainViewModel.weldingInspector.jobs[1]) 
        //mockMainViewModel.selectedWeldingProcedure = mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[1]
        @State var isPresented: Bool = true // Define isPresented as @State variable
        
        return WeldingProcedureFormView(mainViewModel: MainViewModel(), isPresented: $isPresented, selectedWeldingProcedure: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[1])
    }
}

