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
    @Published var selectedWeldNumber: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers?
    
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

    
    func deleteSelectedProcedure(index: Int){
        selectedJob?.weldingProcedures.remove(at: index)
    }
    
    func deleteSelectedWelder(index: Int){
        selectedWeldingProcedure?.weldersQualified.remove(at: index)
    }
    
    func deleteSelectedWeldNumber(index: Int){
        selectedWelder?.welds.remove(at: index)
    }

    // Methods to add ne items to selected lists
    
    func addJob(name: String, weldingProcedures: [WeldingInspector.Job.WeldingProcedure] = []) {
        weldingInspector.jobs.append(WeldingInspector.Job(name: name, weldingProcedures: weldingProcedures))
    }

    func addProcedure(name: String, type: String = "", usage: String = "", owner: String = "", minRanges: [String: CGFloat] = [:], maxRanges: [String: CGFloat] = [:], weldersQualified: [WeldingInspector.Job.WeldingProcedure.Welder] = [] ) {
        selectedJob?.weldingProcedures.append(WeldingInspector.Job.WeldingProcedure(name: name, type: type, usage: usage, owner: owner, minRanges: minRanges, maxRanges: maxRanges, weldersQualified: weldersQualified))
    }
    
    func addWelder(name: String, welderId: String = "", pressureNumber: String = "", PressureExpiry: String = "", welds: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers] = [] ) {
        selectedWeldingProcedure?.weldersQualified.append(WeldingInspector.Job.WeldingProcedure.Welder(name: name, welderId: welderId, pressureNumber: pressureNumber, pressureExpiry: PressureExpiry, welds: welds))
    }
    
    func addWeldNumber(name: String , parametersCollected:[WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters] = [] ) {
        selectedWelder?.welds.append(WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers(name: name, parametersCollected: parametersCollected))
    }

    
}
