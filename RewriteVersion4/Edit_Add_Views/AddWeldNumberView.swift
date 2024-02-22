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
    @Binding var isPresented: Bool
    
//    var selectedJobIndex: Int
//    var selectedProcedureIndex: Int
//    var selectedWelderIndex: Int
    
    func addWeldNumber(){
        mainViewModel.addWeldNumber(name: name)
        isPresented = false
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
                    isPresented = false
                }
            }
        }
        .navigationTitle("Add New Welder")
    }
}


struct AddWeldNumberView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true // Define isPresented as @State variable
        AddWeldNumberView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}
