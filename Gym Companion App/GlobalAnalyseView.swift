//
//  GlobalAnalyseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI

struct GlobalAnalyseView: View {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true

    var body: some View {
        Button("DELETE ALL CONTENT") {
            isFirstTimeLaunch = true
        }
    }
}

#Preview {
    GlobalAnalyseView()
}
