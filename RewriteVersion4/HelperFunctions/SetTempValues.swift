//
//  SetTempValues.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-06.
//

import Foundation

// Helper function to set tempMin and tempMax
func setTempValuesForKey(for key: String, pass: WeldingInspector.Job.WeldingProcedure.WeldPass?) -> (String, String, Double, Double) {
    var tempMin: Double = 0.0
    var tempMax: Double = 0.0

    var selectedKey: String = ""
    var selectedDescriptor: String = ""
    var selectedMinRange: Double = 0.0
    var selectedMaxRange: Double = 0.0

    if let minRange = pass?.minRanges[key], let maxRange = pass?.maxRanges[key] {
        tempMin = minRange
        tempMax = maxRange
        selectedDescriptor = "Edit Range Values"
    } else {
        (tempMin, tempMax) = getTemporaryValuesForKey(key)
        selectedDescriptor = "Add new Range Values"
    }

    selectedKey = key
    selectedMinRange = tempMin
    selectedMaxRange = tempMax

    return (selectedKey, selectedDescriptor, selectedMinRange, selectedMaxRange)
}

