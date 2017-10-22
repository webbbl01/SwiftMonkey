//
//  WeightedRectCollection.swift
//  SwiftMonkey
//
//  Created by Wojciech Czerski on 22.10.17.
//

import UIKit

struct WeightedRectCollection {
    typealias Item = (rect: CGRect, weightRange: CountableClosedRange<Int>)
    
    let maxWeight: Int
    let items: [Item]
    
    init(rects: [CGRect] = []) {
        let sortedRects = rects.sorted { $0.area > $1.area }
        var start = 0
        var end = 0
        items = sortedRects.map { rect in
            end = start + Int(rect.area)
            let result = (rect: rect, weightRange: start...end)
            start = end + 1
            return result
        }
        maxWeight = end
    }
    
    func rect(forWeight weight: Int) -> CGRect? {
        return items.first { $0.weightRange ~= weight }?.rect
    }
}
