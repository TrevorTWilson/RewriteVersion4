//
//  AddProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddProcedureView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @Binding var isPresented: Bool
    @State private var procedureName: String
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure? // Optional parameter for selected procedure
    
    init(mainViewModel: MainViewModel, isPresented: Binding<Bool>, selectedProcedure: WeldingInspector.Job.WeldingProcedure? = nil) {
        self.mainViewModel = mainViewModel
        self._isPresented = isPresented
        self.selectedProcedure = selectedProcedure
        _procedureName = State(initialValue: selectedProcedure?.name ?? "") // Initialize with existing procedure name if editing
    }
    
    func addProcedure() {
        
        mainViewModel.addProcedure(name: procedureName)
        
        isPresented = false
    }
    
    var body: some View {
        Form {
            TextField("Procedure Name", text: $procedureName)
                .onSubmit {
                    addProcedure()
                }
            HStack {
                Button("Save") {
                    addProcedure()
                }
                Spacer()
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
        .navigationTitle(selectedProcedure != nil ? "Edit Procedure" : "Add New Procedure") // Adjust title based on editing or adding
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


