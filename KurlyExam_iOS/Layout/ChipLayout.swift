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
        return CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY
       
        for index in subviews.indices {
            let view = subviews[index]
            let viewSize = view.sizeThatFits(.unspecified)
            guard let proposalWidth = proposal.width else { continue }
            
            if (sumX + viewSize.width > proposalWidth) {
                sumX = bounds.minX
                sumY += viewSize.height
                sumY += verticalSpacing
            }
            
            let point = CGPoint(x: sumX, y: sumY)
            view.place(at: point, anchor: .topLeading, proposal: proposal)
            sumX += viewSize.width
            sumX += horizontalSpacing
        }
    }
    
}
