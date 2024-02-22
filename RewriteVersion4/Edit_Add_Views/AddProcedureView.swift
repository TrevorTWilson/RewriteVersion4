//
//  AddProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddProcedureView: View {
    //@Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    // var selectedJob: WeldingInspector.Job
    @Binding var isPresented: Bool
    @State private var procedureName = ""

    
    
    
    func addProcedure(){
        // mainViewModel.selectedJob = selectedJob
        mainViewModel.addProcedure(name: procedureName)
        isPresented = false
//        dismiss()
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
                    isPresented = false
//                    dismiss()
                }
            }
        }
        .navigationTitle("Add New Procedure Item")
    }
}


struct AddProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data
        @State var isPresented: Bool = true // Define isPresented as @State variable

        return AddProcedureView(mainViewModel: mockMainViewModel, isPresented: $isPresented)
    }
}


