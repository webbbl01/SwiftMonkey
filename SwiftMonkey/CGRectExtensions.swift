//
//  CGRectExtensions.swift
//  SwiftMonkey
//
//  Created by Wojciech Czerski on 22.10.17.
//  Copyright © 2017 Zalando SE. All rights reserved.
//

import UIKit

enum CGRectAxis {
    case horizontal
    case vertical
}

extension CGRect {
    func divided(toExclude excluded: [CGRect], minSize: CGFloat) -> [CGRect] {
        if intersects(excluded) {
            let configs: [(dimmension: CGFloat, axis: CGRectAxis, longerDimmension: Bool)] = [
                (width, .vertical, width > height),
                (height, .horizontal, height > width)
            ]
            
            let divideResults: [(axis: CGRectAxis, first: CGRect, second: CGRect, score: Int)]
            divideResults = configs.flatMap { config in
                guard config.dimmension / 2 >= minSize else {
                    return nil
                }
                let (first, second) = halved(axis: config.axis)
                let hasClearHalf = !first.intersects(excluded) || !second.intersects(excluded)
                let score = (hasClearHalf ? 10 : 0) + (config.longerDimmension ? 1 : 0)
                return (config.axis, first, second, score)
            }
            
            var result = [CGRect]()
            divideResults.sorted { $0.score > $1.score }.first.flatMap { divideResult in
                [divideResult.first, divideResult.second].forEach { rect in
                    if rect.intersects(excluded) {
                        result.append(contentsOf: rect.divided(toExclude: excluded, minSize: minSize))
                    } else {
                        result.append(rect)
                    }
                }
            }
            return result
        } else {
            return [self]
        }
    }

    func halved(axis: CGRectAxis) -> (first: CGRect, second: CGRect) {
        let edge: CGRectEdge
        let dimmension: CGFloat
        
        switch axis {
        case .vertical:
            edge = .minXEdge
            dimmension = width
        case .horizontal:
            edge = .minYEdge
            dimmension = height
        }
        
        let (slice, reminder) = divided(atDistance: dimmension / 2, from: edge)
        return (slice, reminder)
    }
    
    func intersects(_ rectangles: [CGRect]) -> Bool {
        return rectangles.contains(where: self.intersects(_:)) 
    }
    
    var area: CGFloat {
        return width * height
    }
}
