//
//  MainViewModel.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-13.
//

import Foundation
import Combine

class MainViewModel: ObservableObject, Equatable {
    static func == (lhs: MainViewModel, rhs: MainViewModel) -> Bool {
        // Implement custom logic to compare two MainViewModel instances for equality
        return lhs.weldingInspector == rhs.weldingInspector &&
               lhs.selectedJob == rhs.selectedJob &&
               lhs.selectedWeldingProcedure == rhs.selectedWeldingProcedure &&
               lhs.selectedWelder == rhs.selectedWelder &&
               lhs.selectedWeldNumber == rhs.selectedWeldNumber &&
               lhs.selectedWeldNumberParameters == rhs.selectedWeldNumberParameters
    }
    
    // Setup for Objects to be available through scope of app
    @Published var weldingInspector: WeldingInspector {
        didSet {
            // Perform actions when weldingInspector is updated
            // For example, you can save the updated weldingInspector to storage
            // saveWeldingInspector()
            print("weldingInspector Updated")
            
            // You can add more logic or actions here based on the updated weldingInspector
        }
    }

    @Published var selectedJob: WeldingInspector.Job? {
        didSet {
            // Perform actions when selectedJob is set or changed
            if let job = selectedJob {
                // Example action: Print the name of the selected job
                print("Selected Job: \(job.name)")
            } else {
                print("No job selected")
            }
            
            // You can add more logic or actions here based on the new selectedJob value
        }
    }

    @Published var selectedWeldingProcedure: WeldingInspector.Job.WeldingProcedure?{
        didSet {
            // Perform actions when selectedJob is set or changed
            if let procedure = selectedWeldingProcedure {
                // Example action: Print the name of the selected job
                print("Selected procedure: \(procedure.name)")
            } else {
                print("No procedure selected")
            }
            
            // You can add more logic or actions here based on the new selectedJob value
        }
    }
    @Published var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?{
        didSet {
            // Perform actions when selectedJob is set or changed
            if let welder = selectedWelder {
                // Example action: Print the name of the selected job
                print("Selected welder: \(welder.name)")
            } else {
                print("No welder selected")
            }
            
            // You can add more logic or actions here based on the new selectedJob value
        }
    }
    @Published var selectedWeldNumber: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers?{
        didSet {
            // Perform actions when selectedJob is set or changed
            if let number = selectedWeldNumber {
                // Example action: Print the name of the selected job
                print("Selected weld number: \(number.name)")
            } else {
                print("No weld number selected")
            }
            
            // You can add more logic or actions here based on the new selectedJob value
        }
    }
    @Published var selectedWeldNumberParameters: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?{
        didSet {
            // Perform actions when selectedJob is set or changed
            if let parameters = selectedWeldNumberParameters {
                // Example action: Print the name of the selected job
                print("Selected parameters: \(parameters.passName)")
            } else {
                print("No job selected")
            }
            
            // You can add more logic or actions here based on the new selectedJob value
        }
    }
    
    //Init of WeldingInspector on project launch
    init() {
        weldingInspector = StorageFunctions.retrieveInspector()
    }
    
    
    // Methods to set selectedItems
    func setSelectedJob(job: WeldingInspector.Job) {
        selectedJob = job
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
    
    // Methods to add new items to selected lists
    
    func addJob(name: String, weldingProcedures: [WeldingInspector.Job.WeldingProcedure] = []) {
        weldingInspector.jobs.append(WeldingInspector.Job(name: name, weldingProcedures: weldingProcedures))
    }
    
    func addProcedure(name: String, type: String = "", usage: String = "", owner: String = "", minRanges: [String: CGFloat] = [:], maxRanges: [String: CGFloat] = [:], weldersQualified: [WeldingInspector.Job.WeldingProcedure.Welder] = []) {
        guard let jobIndex = weldingInspector.jobs.firstIndex(where: { $0.id == selectedJob?.id }),
            var updatedJob = selectedJob
        else {
            return
        }

        let newProcedure = WeldingInspector.Job.WeldingProcedure(name: name, type: type, usage: usage, owner: owner, minRanges: minRanges, maxRanges: maxRanges, weldersQualified: weldersQualified)

        updatedJob.weldingProcedures.append(newProcedure)

        weldingInspector.jobs[jobIndex] = updatedJob
        
        
        //print(jobIndex)

    }


    func addWelder(name: String, welderId: String = "", pressureNumber: String = "", pressureExpiry: String = "", welds: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers] = []) {
        guard var updatedProcedure = selectedWeldingProcedure else {
            return
        }

        let newWelder = WeldingInspector.Job.WeldingProcedure.Welder(name: name, welderId: welderId, pressureNumber: pressureNumber, pressureExpiry: pressureExpiry, welds: welds)

        updatedProcedure.weldersQualified.append(newWelder)

        if let jobIndex = weldingInspector.jobs.firstIndex(where: { $0.id == selectedJob?.id }), let procedureIndex = updatedProcedure.weldersQualified.firstIndex(where: { $0.id == newWelder.id }) {
            weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
            
            //print("\(jobIndex)  \(procedureIndex)")
        }
    }


    func addWeldNumber(name: String, parametersCollected: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters] = []) {
        guard var updatedWelder = selectedWelder else {
            return
        }

        let newWeldNumber = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers(name: name, parametersCollected: parametersCollected)

        updatedWelder.welds.append(newWeldNumber)

        if let jobIndex = weldingInspector.jobs.firstIndex(where: { $0.id == selectedJob?.id }), let procedureIndex = selectedJob?.weldingProcedures.firstIndex(where: { $0.id == selectedWeldingProcedure?.id }), let welderIndex = selectedWeldingProcedure?.weldersQualified.firstIndex(where: { $0.id == selectedWelder?.id }) {
            
            weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex] = updatedWelder
        }
    }


    func addParameters(passName: String, collectedValues: [String: CGFloat] = [:]) {
        guard var updatedWeldNumber = selectedWeldNumber else {
            return
        }

        let newParameters = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters(passName: passName, collectedValues: collectedValues)

        updatedWeldNumber.parametersCollected.append(newParameters)

        if let jobIndex = weldingInspector.jobs.firstIndex(where: { $0.id == selectedJob?.id }), let procedureIndex = selectedJob?.weldingProcedures.firstIndex(where: { $0.id == selectedWeldingProcedure?.id }), let welderIndex = selectedWeldingProcedure?.weldersQualified.firstIndex(where: { $0.id == selectedWelder?.id }), let weldNumberIndex = selectedWelder?.welds.firstIndex(where: { $0.id == selectedWeldNumber?.id }) {
            
            //selectedWelder?.welds[weldNumberIndex] = updatedWeldNumber
            weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds[weldNumberIndex] = updatedWeldNumber
        }
    }




}




