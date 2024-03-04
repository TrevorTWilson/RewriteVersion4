//
//  ProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-13.
//

import SwiftUI
import Combine

struct ProcedureView: View {
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    
    var selectedJob: WeldingInspector.Job?
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    
    @State private var selectedItemForDeletion: WeldingInspector.Job.WeldingProcedure?
    @State private var showProfileView = false
    @State private var addNewProcedure = false
    @State private var showProcedureFormView = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Current Job: ")
                    Text(mainViewModel.selectedJob?.name ?? "Title")
                }
                HStack{
                    Text("Select a Procedure")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addNewProcedure = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                Spacer()
                // Iterate through list of procedures in instance of WeldingInspector for navigation list of each
                List {
                    
                    if let weldingProcedures = selectedJob?.weldingProcedures, !weldingProcedures.isEmpty {
                        ForEach(Array(weldingProcedures.enumerated()), id: \.element.id) { index, procedure in
                            NavigationLink(destination: WelderView(mainViewModel: mainViewModel, selectedWeldingProcedure: procedure)) {
                                Text(procedure.name)
                            }
                            .contextMenu {
                                Button(action: {
                                    // Edit action
                                    // Implement editing functionality here
                                    mainViewModel.setSelectedProcedure(procedure: procedure)
                                    showProcedureFormView = true
                                    
                                }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(action: {
                                    // Delete action
                                    selectedItemForDeletion = mainViewModel.selectedJob?.weldingProcedures[index]
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                selectedItemForDeletion = mainViewModel.selectedJob?.weldingProcedures[index]
                            }
                        }
                        
                    } else {
                        Text("No welding procedures available")
                        Text("Add welding procedures to the selected Job")
                    }
                }

            }
            .onAppear{
                if selectedJob != nil {
                    mainViewModel.setSelectedJob(job: selectedJob!)
                }
            }
            
            .alert(item: $selectedItemForDeletion) { procedure in
                Alert(
                    title: Text("Delete Procedure"),
                    message: Text("Are you sure you want to delete \(procedure.name)? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let index = mainViewModel.selectedJob?.weldingProcedures.firstIndex(where: { $0.id == procedure.id }) {
                            print("Alert Index: \(index)")
                            mainViewModel.deleteSelectedProcedure(index: index)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showProfileView = true
                        
                    }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showProfileView) {
                //ProfileView(weldingInspector: weldingInspector)
                
            }
            .sheet(isPresented: $addNewProcedure, content: {
                AddProcedureView(mainViewModel: mainViewModel, isPresented: $addNewProcedure)
            })
            .sheet(isPresented: $showProcedureFormView) {
                if let selectedProcedure = mainViewModel.selectedWeldingProcedure {
                    WeldingProcedureFormView(mainViewModel: mainViewModel, isPresented: $showProcedureFormView, selectedWeldingProcedure: selectedProcedure)
                }
            }
        }
    }
}


struct ProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data
        
        return ProcedureView(mainViewModel: mockMainViewModel, selectedJob: mockMainViewModel.weldingInspector.jobs[1])
            .environmentObject(Profile())
    }
}

