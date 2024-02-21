//
//  AddWeldNumberView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddWeldNumberView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var name = ""
    
//    var selectedJobIndex: Int
//    var selectedProcedureIndex: Int
//    var selectedWelderIndex: Int
    
    func addWeldNumber(){
        mainViewModel.addWeldNumber(name: name)
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Weld Number", text: $name)
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
        AddWeldNumberView(mainViewModel: MainViewModel())
    }
}
