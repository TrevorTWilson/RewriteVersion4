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
    
    func addWeldNumber(){
        mainViewModel.addWeldNumber(selectedWelderIndex: selectedWelderIndex, selectedProcedureIndex: selectedProcedureIndex, selectedJobIndex: selectedJobIndex, name: weldId)
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Weld Number", text: $weldId)
                .onSubmit {
                    addWeldNumber()
                }
            HStack{
                Button("Add Weld Number") {
                    addWeldNumber()
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


struct AddWeldNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AddWeldNumberView(mainViewModel: MainViewModel(), selectedJobIndex: 0, selectedProcedureIndex: 0, selectedWelderIndex: 0)
    }
}
