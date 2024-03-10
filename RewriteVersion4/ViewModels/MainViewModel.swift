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
        // Comparison models for Equatable lhs=Left Hand Side, rhs=Right Hand Side
        return lhs.weldingInspector == rhs.weldingInspector &&
        lhs.selectedJob == rhs.selectedJob &&
        lhs.selectedWeldingProcedure == rhs.selectedWeldingProcedure &&
        lhs.selectedWelder == rhs.selectedWelder &&
        lhs.selectedWeldNumber == rhs.selectedWeldNumber &&
        lhs.selectedWeldPass == rhs.selectedWeldPass
    }
    
    // Setup for Objects to be available through scope of app
    @Published var weldingInspector: WeldingInspector {
        didSet {
            // Perform actions when weldingInspector is updated, for deBugging
            print("weldingInspector Updated")
        }
    }
    
    @Published var selectedJob: WeldingInspector.Job? {
        didSet {
            // Perform actions when selectedJob is set or changed for deBugging
            if let job = selectedJob {
                // Set the jobIndex value to use with methods in Model
                // Print to console for deBugging
                if let index = weldingInspector.jobs.firstIndex(where: { $0.id == selectedJob?.id }){
                    jobIndex = index
                    print("Selected job: \(job.name). Has an index of: \(jobIndex)")
                } else {
                    print("Selected Job: \(job.name).  Index Failed")
                }
            } else {
                print("No job selected")
            }
        }
    }
    
    @Published var selectedWeldingProcedure: WeldingInspector.Job.WeldingProcedure?{
        didSet {
            // Perform actions when selectedJob is set or changed for deBugging
            if let procedure = selectedWeldingProcedure {
                // Print to console for deBugging
                if let index = weldingInspector.jobs[jobIndex].weldingProcedures.firstIndex(where: {$0.id == selectedWeldingProcedure?.id}){
                    procedureIndex = index
                    print("Selected Procedure in JobIndex: \(jobIndex), has been set to index: \(procedureIndex)")
                } else {
                    print("Selected procedure: \(procedure.name)  INDEX FAILED")
                }
            } else {
                print("No procedure selected")
            }
        }
    }
    
    @Published var selectedProcedurePass: WeldingInspector.Job.WeldingProcedure.WeldPass?{
        didSet {
            // Perform actions when selectedJob is set or changed for deBugging
            if let weldPass = selectedProcedurePass {
                // Print to console for deBugging
                if let index = weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldPass.firstIndex(where: {$0.id == selectedProcedurePass?.id}){
                    weldPassIndex = index
                    print("Selected WeldPass in JobIndex: \(jobIndex), and Procedureindex: \(procedureIndex), has been set to: \(weldPassIndex)")
                } else {
                    print("Selected WeldPass: \(weldPass.passName)  INDEX FAILED")
                }
            } else {
                print("No procedure selected")
            }
        }
    }
    
    @Published var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?{
        didSet {
            // Perform actions when selectedJob is set or changed for deBugging
            if let welder = selectedWelder {
                // Print to console for deBugging
                if let index = weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified.firstIndex(where: {$0.id == selectedWelder?.id}){
                    welderIndex = index
                    print("Selected Welder in JobIndex: \(jobIndex) and Procedure Index: \(procedureIndex). has been set to index: \(welderIndex)")
                } else {
                    print("Selected welder: \(welder.name) INDEX FAILED")
                }
            } else {
                print("No welder selected")
            }
        }
    }
    @Published var selectedWeldNumber: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers?{
        didSet {
            // Perform actions when selectedJob is set or changed for deBuging
            if let number = selectedWeldNumber {
                // Print to console for deBugging
                if let index = weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds.firstIndex(where: {$0.id == selectedWeldNumber?.id}){
                    weldNumberIndex = index
                    print("Selected Weld Number in JobIndex: \(jobIndex) with Procedure Index: \(procedureIndex), and Welder Index \(welderIndex) has been set to index: \(weldNumberIndex)")
                } else{
                    print("Selected weld number: \(number.name) INDEX FAILED")
                }
            } else {
                print("No weld number selected")
            }
        }
    }
    
    @Published var selectedWeldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?{
        didSet {
            // Perform actions when selectedJob is set or changed for deBugging
            if let parameters = selectedWeldPass {
                // Print to console for deBugging
                if let index = weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds[weldNumberIndex].parametersCollected.firstIndex(where: {$0.id == selectedWeldPass?.id}){
                    passIndex = index
                    print("Selected passName in JobIndex: \(jobIndex) with procedureIndex: \(procedureIndex), welderIndex: \(welderIndex), weldNumberIndex: \(weldNumberIndex) has been set to index: \(passIndex)")
                } else {
                    print("Selected WeldPass \(parameters.passName)  INDEX FAILED")
                }
            } else {
                print("No weld pass selected")
            }
        }
    }
    
    private var jobIndex: Int = 0
    private var procedureIndex: Int = 0
    private var weldPassIndex: Int = 0
    private var welderIndex: Int = 0
    private var weldNumberIndex: Int = 0
    private var passIndex: Int = 0
    
    
    //Init of WeldingInspector on project launch
    init() {
        weldingInspector = StorageFunctions.retrieveInspector()
    }
    
    
    // Methods to set selectedItems
    func setSelectedJob(job: WeldingInspector.Job) {
        selectedJob = job
    }
    
    func setSelectedProcedure(procedure: WeldingInspector.Job.WeldingProcedure) {
        selectedWeldingProcedure = procedure
    }
    
    func setSelectedProcedurePass(weldPass: WeldingInspector.Job.WeldingProcedure.WeldPass) {
        selectedProcedurePass = weldPass
    }
    
    func setSelectedWelder(welder: WeldingInspector.Job.WeldingProcedure.Welder){
        selectedWelder = welder
    }
    
    func setSelectedWeldNumber(weldId: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers){
        selectedWeldNumber = weldId
    }
    
    func setSelectedWeldPass(weldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters){
        selectedWeldPass = weldPass
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
        weldingInspector.jobs[jobIndex].weldingProcedures.remove(at: index)
    }
    
    func deleteSelectedProcedurePass(index: Int) {
        guard var updatedProcedure = selectedWeldingProcedure else {
            print("FAILED, \(String(describing: selectedWeldingProcedure))")
            return
        }
        updatedProcedure.weldPass.remove(at: index)
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
        setSelectedProcedure(procedure: updatedProcedure)
    }
    
    func deleteSelectedWelder(index: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified.remove(at: index)
    }
    
    func deleteSelectedWeldNumber(index: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds.remove(at: index)
    }
    
    func deleteSelectedWeldPass(index: Int){
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds[weldNumberIndex].parametersCollected.remove(at: index)
    }
    
    // Methods to add new items to selected lists
    
    func addJob(name: String, weldingProcedures: [WeldingInspector.Job.WeldingProcedure] = []) {
        let newJob = WeldingInspector.Job(name: name, weldingProcedures: weldingProcedures)
        weldingInspector.jobs.append(newJob)
    }
    
    func addProcedure(name: String,
                      type: String? = nil,
                      usage: String? = nil,
                      owner: String? = nil,
                      weldPass: [WeldingInspector.Job.WeldingProcedure.WeldPass] = [],
                      weldersQualified: [WeldingInspector.Job.WeldingProcedure.Welder] = []) {
      
        guard var updatedJob = selectedJob else {
            return
        }
        
        let newProcedure = WeldingInspector.Job.WeldingProcedure(name: name,
                                                                 type: type ?? "",
                                                                 usage: usage ?? "",
                                                                 owner: owner ?? "",
                                                                 weldPass: weldPass,
                                                                 weldersQualified: weldersQualified)
        
        updatedJob.weldingProcedures.append(newProcedure)
        
        weldingInspector.jobs[jobIndex] = updatedJob
        
        setSelectedJob(job: updatedJob)
    }

    
    func addProcedurePass(name: String, minRanges: [String:Double] = [:], maxRanges: [String:Double] = [:]) {
        print("Recieved from addProcedurePass")
        guard var updatedProcedure = selectedWeldingProcedure else {
            print("FAILED, \(String(describing: selectedWeldingProcedure))")
            return
        }
        print("updated procedure = selected Job: \(weldingInspector.jobs[jobIndex].name) at index: \(jobIndex) and selected procedure \(weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].name) at index: \(procedureIndex)")
        let newPass = WeldingInspector.Job.WeldingProcedure.WeldPass(passName: name, minRanges: minRanges, maxRanges: maxRanges)
        
        updatedProcedure.weldPass.append(newPass)
        
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
        print("added \(newPass.passName) to \(weldingInspector.jobs[jobIndex].name) @index: \(jobIndex) in \(weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].name) @index: \(procedureIndex)")
        
        setSelectedProcedure(procedure: updatedProcedure)
    }
    
    func addProcedurePaasRange(key: String, minRange: Double, maxRange: Double) {
        guard var updatedProcedure = selectedWeldingProcedure else {
            print("FAILED, \(String(describing: selectedWeldingProcedure))")
            return
        }
        let newMinRange = minRange
        let newMaxRange = maxRange
        
        updatedProcedure.weldPass[weldPassIndex].minRanges[key] = newMinRange
        updatedProcedure.weldPass[weldPassIndex].maxRanges[key] = newMaxRange
        
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
        
        print("Added minRange value: \(newMinRange) and maxRange value: \(newMaxRange) to key: \(key) inside welding procedure pass: \(weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldPass[weldPassIndex].passName)")
        
        setSelectedProcedure(procedure: updatedProcedure)
    }
    
    func addWelder(name: String, welderId: String, pressureNumber: String, pressureExpiry: String, welds: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers] = []) {
        guard var updatedProcedure = selectedWeldingProcedure else {
            return
        }
        
        let newWelder = WeldingInspector.Job.WeldingProcedure.Welder(name: name, welderId: welderId, pressureNumber: pressureNumber, pressureExpiry: pressureExpiry, welds: welds)
        
        updatedProcedure.weldersQualified.append(newWelder)
        
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
        setSelectedProcedure(procedure: updatedProcedure)
    }
    
    func updateWelder(name: String, welderId: String, pressureNumber: String, pressureExpiry: String, welds: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers] = []) {
        guard let updatedProcedure = selectedWeldingProcedure else {
            return
        }
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].name = name
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welderId = welderId
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].pressureNumber = pressureNumber
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].pressureExpiry = pressureExpiry
        
        setSelectedProcedure(procedure: updatedProcedure)
    }
    
    func addWeldNumber(name: String, parametersCollected: [WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters] = []) {
        guard var updatedWelder = selectedWelder else {
            return
        }
        
        let newWeldNumber = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers(name: name, parametersCollected: parametersCollected)
        
        updatedWelder.welds.append(newWeldNumber)
        
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex] = updatedWelder
        setSelectedWelder(welder: updatedWelder)
    }
    
    func addParameters(passName: String, collectedValues: [String: Double] = [:]) {
        guard var updatedWeldNumber = selectedWeldNumber else {
            return
        }
        
        let newParameters = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters(passName: passName, collectedValues: collectedValues)
        
        updatedWeldNumber.parametersCollected.append(newParameters)

            weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex].weldersQualified[welderIndex].welds[weldNumberIndex] = updatedWeldNumber
        setSelectedWeldNumber(weldId: updatedWeldNumber)
    }
    
    //  Methods to edit items on selected lists
    
    func editProcedure(newName:String, newType: String, newUse: String, newOwner: String){
        guard var updatedProcedure = selectedWeldingProcedure else {
            return
        }
        updatedProcedure.name = newName
        updatedProcedure.type = newType
        updatedProcedure.usage = newUse
        updatedProcedure.owner = newOwner
        
        weldingInspector.jobs[jobIndex].weldingProcedures[procedureIndex] = updatedProcedure
        
        setSelectedProcedure(procedure: updatedProcedure)
    }
}

