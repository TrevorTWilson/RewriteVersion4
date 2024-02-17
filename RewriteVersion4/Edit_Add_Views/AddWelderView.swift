//
//  AddWelderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct AddWelderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var welderName = ""
    
    var selectedJobIndex: Int
    var selectedProcedureIndex: Int
    
    func addWelder(){
        mainViewModel.addWelder(selectedProcedureIndex: selectedProcedureIndex, selectedJobIndex: selectedJobIndex, name: welderName)
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Welder Name", text: $welderName)
                .onSubmit {
                    addWelder()
                }
            HStack{
                Button("Add Welder") {
                    addWelder()
                }
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Add New Welder")
    }
}
