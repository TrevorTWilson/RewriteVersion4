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
    
    //var selectedJobIndex: Int
    
    func addProcedure(){
        mainViewModel.addProcedure(name: procedureName)
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
        AddProcedureView(mainViewModel: MainViewModel())
    }
}
