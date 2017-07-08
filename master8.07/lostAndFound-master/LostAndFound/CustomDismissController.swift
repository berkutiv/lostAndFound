//
//  CustomInteractionController.swift
//  LostAndFound
//
//  Created by Орлов Максим on 26.06.17.
//  Copyright © 2017 Иван. All rights reserved.
//

import Foundation
import UIKit

class CustomDismissAnimationController : NSObject, UIViewControllerAnimatedTransitioning
{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),  animations: {
                        fromViewController.view.alpha = 1.0
                        toViewController.view.frame = finalFrameForVC
                    }, completion: {
                        finished in
                        transitionContext.completeTransition(true)
                        fromViewController.view.alpha = 1.0
                        
                    })
    
        
        
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
//            fromViewController.view.alpha = 1.0
//            toViewController.view.frame = finalFrameForVC
//        }, completion: {
//            finished in
//            transitionContext.completeTransition(true)
//            fromViewController.view.alpha = 1.0
//            
//        })
    }
}
