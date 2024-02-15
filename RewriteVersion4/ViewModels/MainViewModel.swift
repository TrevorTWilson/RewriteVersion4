//
//  MainViewModel.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-13.
//

import Foundation

class MainViewModel: ObservableObject{
    
    // Setup for Objects to be available through scope of app
    @Published var weldingInspector: WeldingInspector
    @Published var selectedJob: WeldingInspector.Job?
    @Published var selectedWeldingProcedure: WeldingInspector.Job.WeldingProcedure?
    @Published var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    @Published var selectedWeldNumber: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers]?
    
    //Init of WeldingInspector on project launch
    init() {
        weldingInspector = StorageFunctions.retrieveInspector()
    }

    // Methods to store and retrieve weldingInspector data from local JSON file (default 'Seed' data available if no file present
    func loadWeldingInspector() {
        weldingInspector = StorageFunctions.retrieveInspector()
    }
    func saveWeldingInspector() {
        StorageFunctions.storeInspector(weldingInspector: weldingInspector)
    }
    
    // Methods to delete selected items
    func deleteSelectedJob(index: IndexSet){
        weldingInspector.jobs.remove(atOffsets: index)
    }
    
    func deleteSelectedProcedure(index: IndexSet, jobIndex: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures.remove(atOffsets: index)
    }
    
    func deleteSelectedWelder(index: IndexSet, jobIndex: Int, procedureIndex: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified.remove(atOffsets: index)
    }
    
    // Methods to set selected Items
    func setSelectedJob(_ job: WeldingInspector.Job) {
        selectedJob = job
        if let selectedJobName = selectedJob?.name {
            print("Selected Job name is \(selectedJobName)")
        } else {
            print("No job selected")
        }
    }

    
    

}
