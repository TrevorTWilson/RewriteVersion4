//
//  WeldingInspectorModel.swift
//  Create_Json_Seed_File
//
//  Created by trevor wilson on 2024-02-02.
//

import Foundation


struct WeldingInspector: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String = ""
    var jobs: [Job]
    
    init(name: String, jobs: [Job]) {
        self.name = name
        self.jobs = jobs
    }
    
    struct Job: Codable, Identifiable, Hashable {
        var id = UUID()
        var name: String = ""
        var weldingProcedures: [WeldingProcedure]
        
        init(name: String, weldingProcedures: [WeldingProcedure]) {
            self.name = name
            self.weldingProcedures = weldingProcedures
        }
        
        struct WeldingProcedure: Codable, Identifiable, Hashable {
            var id = UUID()
            var name: String = ""
            var type: String = ""                        // SMAW, GMAW, FCAW
            var usage: String = ""                       // Girth, Repair, Girth/Repair, CSA, ABSA
            var owner: String = ""                       // Client, Contractor
            var weldPass: [WeldPass]
            var weldersQualified: [Welder]
            
            init(name: String, type: String, usage: String, owner: String, weldPass: [WeldPass], weldersQualified: [Welder]) {
                self.name = name
                self.type = type
                self.usage = usage
                self.owner = owner
                self.weldPass = weldPass
                self.weldersQualified = weldersQualified
            }
            
            struct WeldPass: Codable, Identifiable, Hashable {
                var id = UUID()
                var passName: String = ""
                var minRanges: [String: Double] = [:]      // Dictionary: min->Amps, Volts, ArcSpeed, HeatInput
                var maxRanges: [String: Double] = [:]      // Dictionary: max->
                
                init(passName: String, minRanges: [String : Double], maxRanges: [String : Double]) {
                    self.passName = passName
                    self.minRanges = minRanges
                    self.maxRanges = maxRanges
                }
                
            }
            
            struct Welder: Codable, Identifiable, Hashable {
                var id = UUID()
                var name:   String = ""
                var welderId: String = ""
                var pressureNumber: String = ""
                var pressureExpiry: String = ""
                var welds: [WeldNumbers]
                
                init(name: String, welderId: String, pressureNumber: String, pressureExpiry: String, welds: [WeldNumbers]) {
                    self.name = name
                    self.welderId = welderId
                    self.pressureNumber = pressureNumber
                    self.pressureExpiry = pressureExpiry
                    self.welds = welds
                }
                
                struct WeldNumbers: Codable, Identifiable, Hashable {
                    var id = UUID()
                    var name: String = ""
                    var parametersCollected: [Parameters]
                    
                    init(name: String, parametersCollected: [Parameters]) {
                        self.name = name
                        self.parametersCollected = parametersCollected
                    }
                    
                    struct Parameters: Codable, Identifiable, Hashable {
                        var id = UUID()
                        var passName: String = ""
                        var collectedValues: [String: Double] = [:]    //Dictionary of amps, volts, arcSpeed, heatInput
                        
                        init(passName: String, collectedValues: [String: Double]) {
                            self.passName = passName
                            self.collectedValues = collectedValues
                        }
                    }
                }
            }
        }
    }
 
    mutating func addJob(newJob: String) {
            let newJobName = WeldingInspector.Job(name: newJob, weldingProcedures: [])
            jobs.append(newJobName)
        }
}
