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
    @Binding var isPresented: Bool
    
    func addParameters(){
        mainViewModel.addParameters(passName: passName)
        isPresented = false
    }
    
    var body: some View {
        Form {
            TextField("New Pass Name", text: $passName)
                .onSubmit {
                    addParameters()
                }
            HStack{
                Button("Add New Pass Name") {
                    addParameters()
                }
                Spacer()
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
        .navigationTitle("Add New Pass")
    }
}

struct AddParametersView_Preview: PreviewProvider {
    @State static var isPresented: Bool = true

    static var previews: some View {
        AddParametersView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}

