//
//  WeldNumberView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct WelderNumberView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
    var selectedJobIndex: Int
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    var selectedProcedureIndex: Int
    var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    var selectedWelderIndex: Int
    
    
    @State private var showProfileView = false
    @State private var addNewWeldNumber = false
    
    //        var body: some View {
    //            VStack{
    //                // Rendering the view based on selected procedure
    //                Text("Selected Procedure: \(selectedWelder?.name  ?? "None")")
    //            }
    //            .onAppear(perform: {
    //                mainViewModel.selectedWelder = selectedWelder
    //                if let selectedWelderName = mainViewModel.selectedWelder?.name {
    //                    print("Selected welder name is \(selectedWelderName)")
    //                } else {
    //                    print("No welder selected")
    //                }
    //
    //            })
    //        }
    
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
                    Text("Current Welder: ")
                    Text(selectedWelder?.name ?? "Title")
                }
                HStack{
                    Text("Select a Weld Number")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addNewWeldNumber = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                Spacer()
                // Iterate through list of procedures in instance of WeldingInspector for navigation list of each
                List {
                    if let weldNumbers = selectedWelder?.welds, !weldNumbers.isEmpty {
                        ForEach(Array(weldNumbers.enumerated()), id: \.element.id) { index, weldID in
                            NavigationLink(destination: WeldParameterView(mainViewModel: mainViewModel, selectedJob: selectedJob, selectedJobIndex: selectedJobIndex, selectedProcedure: selectedProcedure, selectedProcedureIndex: selectedProcedureIndex, selectedWelder: selectedWelder, selectedWelderIndex: index )) {
                                Text(weldID.name)
                            }
                        }
                        .onDelete { indexSet in
                            mainViewModel.deleteSelectedWeldNumber(index: indexSet, jobIndex: selectedJobIndex, procedureIndex: selectedProcedureIndex, welderIndex: selectedWelderIndex)
                        }
                    } else {
                        Text("No Numbers available")
                        Text("Add weld number to list of collected parameters")
                    }
                }



                
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
            .sheet(isPresented: $addNewWeldNumber, content: {
                // Add new job item view
                EmptyView()
            })
        }
    }
}
