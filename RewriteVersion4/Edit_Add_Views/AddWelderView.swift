//
//  AddWelderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddWelderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var welderName = ""
    @Binding var isPresented: Bool
    
//    var selectedJobIndex: Int
//    var selectedProcedureIndex: Int
    
    func addWelder(){
        mainViewModel.addWelder(name: welderName)
        isPresented = false
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
                    isPresented = false
                }
            }
        }
        .navigationTitle("Add New Welder")
    }
}


struct AddWelderView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true // Define isPresented as @State variable
        AddWelderView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}
