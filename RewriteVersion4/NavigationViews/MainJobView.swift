//
//  MainMenu.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-03.
//

import SwiftUI

struct MainJobView: View {
    
    @EnvironmentObject var profile:Profile
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
    @State private var selectedItemForDeletion: WeldingInspector.Job?
    @State private var showProfileView = false
    @State private var addNewJob = false
    
    
    func output<T>(_ data: T) {
        print(data)
    }
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Select a Job")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addNewJob = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                Spacer()
                // Iterate through list of jobs in instance of WeldingInspector for navigation list of each
                List {
                    ForEach(Array(mainViewModel.weldingInspector.jobs.enumerated()), id: \.element.id) { index, job in
                        NavigationLink(destination: ProcedureView(mainViewModel: mainViewModel, selectedJob: job)) {
                            Text(job.name)
                        }
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            selectedItemForDeletion = mainViewModel.weldingInspector.jobs[index]
                        }
                    }
                }
            }
            .navigationTitle("Main Menu")
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
            .alert(item: $selectedItemForDeletion) { job in
                Alert(
                    title: Text("Delete Job"),
                    message: Text("Are you sure you want to delete \(job.name)? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let index = mainViewModel.weldingInspector.jobs.firstIndex(where: { $0.id == job.id }) {
                            mainViewModel.deleteSelectedJob(index: index)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .sheet(isPresented: $showProfileView) {
                //ProfileView(weldingInspector: weldingInspector)
            }
            .sheet(isPresented: $addNewJob, content: {
                // Add new job item view
                AddJobView(mainViewModel: mainViewModel)
            })
        }
    }
}




#Preview {
    MainJobView()
        .environmentObject(Profile())
}

