//
//  Load_Data.swift
//  Create_Json_Seed_File
//
//  Created by trevor wilson on 2024-02-02.
//
import Foundation

func loadSample()-> WeldingInspector{
    let welderParams: [String: CGFloat] = ["Amps": 200, "Volts": 28, "ArcSpeed": 50, "HeatInput": 80]
    let weldNumbersParams = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters(passName: "Root", collectedValues: welderParams)
    
    let weldNumber1 = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers(name: "TI-0001", parametersCollected: [weldNumbersParams])
    
    let weldNumber2 = WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers(name: "TI-0002", parametersCollected: [weldNumbersParams])
    
    let welder1 = WeldingInspector.Job.WeldingProcedure.Welder(name: "John Doe", welderId: "10", pressureNumber: "P456", pressureExpiry: "2025-12-31", welds: [weldNumber1])
    
    let welder2 = WeldingInspector.Job.WeldingProcedure.Welder(name: "John Doe", welderId: "99", pressureNumber: "P456", pressureExpiry: "2025-12-31", welds: [weldNumber2])
    
    let pass1 = WeldingInspector.Job.WeldingProcedure.WeldPass(passName: "Root", minRanges: ["Amps": 200, "Volts": 28, "ArcSpeed": 50, "HeatInput": 80], maxRanges: [:])
    
    let pass2 = WeldingInspector.Job.WeldingProcedure.WeldPass(passName: "HotPass", minRanges: ["Amps": 300, "Volts": 26, "ArcSpeed": 150, "HeatInput": 66], maxRanges: [:])
    
    let weldingProcedure1 = WeldingInspector.Job.WeldingProcedure(name: "Procedure1", type: "SMAW", usage: "Girth", owner: "Client", weldPass: [pass1] ,weldersQualified: [welder1,welder2])
    
    let weldingProcedure2 = WeldingInspector.Job.WeldingProcedure(name: "Procedure2", type: "SMAW", usage: "Girth", owner: "Client", weldPass: [pass1, pass2], weldersQualified: [welder1])
    
    let job1 = WeldingInspector.Job(name: "Welder Job 1", weldingProcedures: [weldingProcedure1]) // Create an array of weldingProcedures
    
    let job2 = WeldingInspector.Job(name: "Welder Job 2", weldingProcedures: [weldingProcedure1, weldingProcedure2]) // Create an array of weldingProcedures
    
    let weldingInspector = WeldingInspector(name: "Inspector1", jobs: [job1,job2]) // Create an array of jobs
    
    return weldingInspector
}
