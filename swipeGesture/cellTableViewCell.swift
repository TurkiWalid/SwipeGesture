//
//  cellTableViewCell.swift
//  swipeGesture
//
//  Created by walid on 27/9/2021.
//  Copyright © 2021 walid. All rights reserved.
//

import UIKit
enum AnimationTiming: CGFloat {
    case Long = 0.5
    case Short = 0.1
}
class cellTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    var isOpeningScroll = false
    var shouldHelpScrolling = false
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var openedIndicationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
    }
    
    func animateScrollViewToOffset(to point: CGPoint, timing: AnimationTiming = .Long, completion: @escaping ()-> Void = {}){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.scrollView.contentOffset = point
        }, completion: { _ in
            completion()
        })
    }
}

extension cellTableViewCell: UIScrollViewDelegate{
    

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if shouldHelpScrolling {
            self.animateScrollViewToOffset(to: CGPoint(x: isOpeningScroll ? 100 : 0, y: 0))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= 100.0 {
            openedIndicationLabel.text = "Opened"
        }else if scrollView.contentOffset.x <= 0.0 {
            openedIndicationLabel.text = "Closed"
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if abs(velocity.x) > 0.4{
            shouldHelpScrolling = false
        }else {
            if targetContentOffset.pointee.x >= 100.0 || targetContentOffset.pointee.x <= 0.0 {
                shouldHelpScrolling = false
            } else {
                shouldHelpScrolling = true
            }
            if velocity.x <= 0 {
                isOpeningScroll = false
            } else if velocity.x > 0  && !isOpeningScroll{
                isOpeningScroll = true
            }
        }
    }
}
