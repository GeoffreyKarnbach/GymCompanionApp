//
//  GlobalAnalyseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData

struct GlobalAnalyseView: View {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    @Environment(\.modelContext) private var context

    var body: some View {
        VStack {
            Button("DELETE ALL CONTENT") {
                isFirstTimeLaunch = true
            }
            let descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: nil)
            
            let tpExec = try! context.fetch(
                descriptor
            )
            
            ForEach(tpExec.sorted(by: { $0.tID < $1.tID }), id: \.self) { tpExecVal in
                Text(tpExecVal.tID)
            }
        }

    }
}

#Preview {
    GlobalAnalyseView()
}
