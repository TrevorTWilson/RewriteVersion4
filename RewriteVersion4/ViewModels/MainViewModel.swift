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
    
    var jobIndex: Int = 0
    var procedureIndex: Int = 0
    var weldPassIndex: Int = 0
    var welderIndex: Int = 0
    var weldNumberIndex: Int = 0
    var passIndex: Int = 0
    
    //Init of WeldingInspector on project launch
    init() {
        weldingInspector = StorageFunctions.retrieveInspector()
    }
}

