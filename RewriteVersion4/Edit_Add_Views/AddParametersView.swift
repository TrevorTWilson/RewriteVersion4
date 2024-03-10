//
//  AddParametersView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddParametersView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @State private var passName: String
    @Binding var isPresented: Bool
    
    var selectedWeldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    
    @State private var sectionTitle: String = "Add"
    
    
    public init(mainViewModel: MainViewModel, isPresented: Binding<Bool>, selectedWeldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters? = nil) {
        self.mainViewModel = mainViewModel
        self._passName = State(initialValue: selectedWeldPass?.passName ?? "")
        self._isPresented = isPresented
        self.selectedWeldPass = selectedWeldPass
    }
    
    func addParameters(){
        if selectedWeldPass != nil {
            // Edit existing weldNumber
            mainViewModel.updateParameters(passName: passName)
        } else {
            // Add new weldNumber
            mainViewModel.addParameters(passName: passName)
        }
        isPresented = false
    }
    
    var body: some View {
        Form {
            Section(header: Text("\(sectionTitle) Weld Pass")){
                Text("\(sectionTitle) Pass Name")
                TextField("\(sectionTitle) Pass Name", text: $passName)
                    .onSubmit {
                        addParameters()
                    }
            }
           
            HStack{
                Button("\(sectionTitle) Pass Name") {
                    addParameters()
                }
                Spacer()
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
        .navigationTitle("Add New Pass")
        .onAppear {
            if let selectedWeldPass = selectedWeldPass {
                // Populate form fields with selected welder's data for editing
                passName = selectedWeldPass.passName
                sectionTitle = "Edit"
            }
        }
    }
}

struct AddParametersView_Preview: PreviewProvider {
    @State static var isPresented: Bool = true

    static var previews: some View {
        AddParametersView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}

