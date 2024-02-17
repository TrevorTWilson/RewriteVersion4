//
//  AddWeldNumberView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct AddWeldNumberView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var weldId = ""
    
    var selectedJobIndex: Int
    var selectedProcedureIndex: Int
    var selectedWelderIndex: Int
    
    var body: some View {
        Form {
            TextField("New Weld Number", text: $weldId)
            HStack{
                Button("Add Weld Number") {
                    mainViewModel.addWeldNumber(selectedWelderIndex: selectedWelderIndex, selectedProcedureIndex: selectedProcedureIndex, selectedJobIndex: selectedJobIndex, name: weldId)
                    dismiss()
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
