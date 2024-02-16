//
//  AddProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct AddProcedureView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var procedureName = ""
    
    var selectedJobIndex: Int
    
    var body: some View {
        Form {
            TextField("New Procedure Name", text: $procedureName)
            HStack{
                Button("Add Item") {
                    mainViewModel.addProcedure(selectedJobIndex: selectedJobIndex, name: procedureName)
                    dismiss()
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
