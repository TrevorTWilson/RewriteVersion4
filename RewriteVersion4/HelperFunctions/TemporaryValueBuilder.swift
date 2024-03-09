//
//  TemporaryValueBuilder.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-01.
//

import Foundation


// Sets temporary values for minRange and maxRange in WeldingInspector.Jobs.WeldingProcedure[index].passName.minRange(maxRange)

func getTemporaryValuesForKey(_ key: String) -> (Double, Double, Double) {
    switch key {
    case "Amps":
        return (Double(90), Double(350), Double(1.0))
    case "Volts":
        return (Double(7), Double(35), Double(0.1))
    case "ArcSpeed":
        return (Double(100), Double(1000), Double(1.0))
    case "HeatInput":
        return (Double(0.8), Double(3.0), Double(0.01))
    default:
        return (Double(0), Double(0), Double(1.0)) // Default values if key does not match
    }
}


