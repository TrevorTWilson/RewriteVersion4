//
//  TemporaryValueBuilder.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-01.
//

import Foundation


// Sets temporary values for minRange and maxRange in WeldingInspector.Jobs.WeldingProcedure[index].passName.minRange(maxRange)

func getTemporaryValuesForKey(_ key: String) -> (CGFloat, CGFloat) {
    switch key {
    case "Amps":
        return (CGFloat(90), CGFloat(350))
    case "Volts":
        return (CGFloat(7), CGFloat(35))
    case "ArcSpeed":
        return (CGFloat(100), CGFloat(1000))
    case "HeatInput":
        return (CGFloat(0.8), CGFloat(3.0))
    default:
        return (CGFloat(0), CGFloat(0)) // Default values if key does not match
    }
}
