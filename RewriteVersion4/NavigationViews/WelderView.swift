//
//  WelderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct WelderView: View {
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
    var selectedJobIndex: Int
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    var selectedProcedureIndex: Int
    
    @State private var selectedItemForDeletion: WeldingInspector.Job.WeldingProcedure.Welder?
    @State private var showProfileView = false
    @State private var addNewWelder = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Current Job: ")
                    Text(selectedJob?.name ?? "Title")
                }
                HStack{
                    Text("Current Procedure: ")
                    Text(selectedProcedure?.name ?? "Title")
                }
                HStack{
                    Text("Select a Welder")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addNewWelder = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                Spacer()
                // Iterate through list of procedures in instance of WeldingInspector for navigation list of each
                List {
                    if let welders = selectedProcedure?.weldersQualified, !welders.isEmpty {
                        ForEach(Array(welders.enumerated()), id: \.element.id) { index, welder in
                            NavigationLink(destination: WelderNumberView(mainViewModel: mainViewModel, selectedJob: selectedJob, selectedJobIndex: selectedJobIndex, selectedProcedure: selectedProcedure, selectedProcedureIndex: selectedProcedureIndex, selectedWelder: welder, selectedWelderIndex: index )) {
                                Text(welder.name)
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                selectedItemForDeletion = mainViewModel.weldingInspector.jobs[selectedJobIndex].weldingProcedures[selectedProcedureIndex].weldersQualified[index]
                            }
                        }
                    } else {
                        Text("No welders available")
                        Text("Add qualified welder to current procedure")
                    }
                }
            }
            .onAppear{
                mainViewModel.selectedWeldingProcedure = selectedProcedure
            }
            
            .alert(item: $selectedItemForDeletion) { welder in
                Alert(
                    title: Text("Delete Welder"),
                    message: Text("Are you sure you want to delete \(welder.name)? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let index = mainViewModel.weldingInspector.jobs[selectedJobIndex].weldingProcedures[selectedProcedureIndex].weldersQualified.firstIndex(where: { $0.id == welder.id }) {
                            mainViewModel.deleteSelectedWelder(index: index, jobIndex: selectedJobIndex, procedureIndex: selectedProcedureIndex)
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
            .sheet(isPresented: $addNewWelder, content: {
                // Add new job item view
                AddWelderView(mainViewModel: mainViewModel, selectedJobIndex: selectedJobIndex, selectedProcedureIndex: selectedProcedureIndex)
            })
        }
    }
    
}

struct WelderView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data

        return WelderView(mainViewModel: mockMainViewModel, selectedJob: mockMainViewModel.weldingInspector.jobs[1], selectedJobIndex: 1, selectedProcedure: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[0], selectedProcedureIndex: 0)
            .environmentObject(Profile())
    }
}
