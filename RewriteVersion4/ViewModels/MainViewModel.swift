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
    func deleteSelectedJob(index: Int){
        weldingInspector.jobs.remove(at: index)
    }

    
    func deleteSelectedProcedure(index: Int, jobIndex: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures.remove(at: index)
    }
    
    func deleteSelectedWelder(index: Int, jobIndex: Int, procedureIndex: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified.remove(at: index)
    }
    
    func deleteSelectedWeldNumber(index: Int, jobIndex: Int, procedureIndex: Int, welderIndex: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds.remove(at: index)
    }

    
    

    
    

}
