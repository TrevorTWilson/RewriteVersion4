//
//  AddParametersView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddParametersView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var passName = ""
    
    func addParameters(){
        mainViewModel.addParameters(passName: passName)
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Pass Name", text: $passName)
                .onSubmit {
                    addParameters()
                }
            HStack{
                Button("Add Weld Number") {
                    addParameters()
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

#Preview {
    AddParametersView(mainViewModel: MainViewModel())
}
