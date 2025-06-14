//
//  ChipLayout.swift
//  KurlyExam_iOS
//
//  Created by 허성연 on 6/10/25.
//
import SwiftUI

struct ChipLayout: Layout {
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var sumX: CGFloat = 0
        var sumY: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            
            if sumX + viewSize.width > width {
                sumX = 0
                sumY += lineHeight + verticalSpacing
                lineHeight = 0
            }
            
            sumX += viewSize.width + horizontalSpacing
            lineHeight = max(lineHeight, viewSize.height)
        }
        
        sumY += lineHeight
        
        return CGSize(width: width, height: sumY)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified)
            
            if sumX + viewSize.width > bounds.maxX {
                sumX = bounds.minX
                sumY += lineHeight + verticalSpacing
                lineHeight = 0
            }
            
            view.place(at: CGPoint(x: sumX, y: sumY), anchor: .topLeading, proposal: ProposedViewSize(width: viewSize.width, height: viewSize.height))
            sumX += viewSize.width + horizontalSpacing
            lineHeight = max(lineHeight, viewSize.height)
        }
    }
}
