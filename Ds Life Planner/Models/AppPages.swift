//
//  AppPages.swift
//  Ds Life Planner
//
//  Created by BoiseITGuru on 4/11/23.
//

import Foundation

enum AppPages: String, CaseIterable, Hashable, Codable {
    case today = "Today"
    case memoryDump = "Memory Dump"
    case goals = "Goals"
    case calendar = "Calendar"
}
