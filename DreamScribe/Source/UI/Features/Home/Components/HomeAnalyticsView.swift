//
//  HomeAnalyticsView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import Charts
import SwiftUI

struct HomeAnalyticsView: View {
    
    // MARK: - PUBLIC PROPERTIES
    
    var dreams: [DreamModel] = []
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            buildGraph()
            if let mostRepeatedTag = getMostRepeatedTag() {
                Text("Most frequent tag:")
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                Text(mostRepeatedTag)
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                    .foregroundColor(.dreamPurple)
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildGraph() -> some View {
        Chart {
            ForEach(DreamType.allCases, id: \.self) { type in
                BarMark(x: .value("Type", type.rawValue),
                        y: .value("Total", getCountFor(type: type)))
            }
        }
        .frame(height: 250)
    }
    
    private func getCountFor(type: DreamType) -> Int {
        let typeArray = dreams.map { $0.type }
        let countedSet = NSCountedSet(array: typeArray)
        let count = countedSet.count(for: type)
        return count
    }
    
    private func getMostRepeatedTag() -> String? {
        let tags = dreams.flatMap { $0.tags }
        var counts = [String: Int]()
        tags.forEach { counts[$0] = (counts[$0] ?? 00) + 1 }
        
        if let (value, _) = counts.max(by: { $0.1 < $1.1 }) {
            return value
        }
        return nil
    }
}

#Preview {
    HomeAnalyticsView()
}
