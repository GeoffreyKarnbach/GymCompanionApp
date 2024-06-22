//
//  Gym_Companion_AppApp.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData
import CoreData

@main
struct Gym_Companion_AppApp: App {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(ContainerGenerator.create(shouldCreateDefaults: &isFirstTimeLaunch))

    }

}
