//
//  AddProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddProcedureView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    // var selectedJob: WeldingInspector.Job
    @State private var procedureName = ""
    
    var onAddProcedure: ((String) -> Void) // Completion closure to return collected data
    
    
    
    func addProcedure(){
        // mainViewModel.selectedJob = selectedJob
//        mainViewModel.addProcedure(name: procedureName)
        
        onAddProcedure(procedureName) // Call the completion closure with the collected data
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Procedure Name", text: $procedureName)
                .onSubmit {
                    addProcedure()
                }
            HStack{
                Button("Add Item") {
                    addProcedure()
                }
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Add New Procedure Item")
    }
}


struct AddProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data
        
        return AddProcedureView(mainViewModel: mockMainViewModel, onAddProcedure: { procedureName in
            // Handle the collected data within the closure
            print("Collected Procedure Name: \(procedureName)")
            // Add any additional actions based on the collected data here
        })
    }
}

