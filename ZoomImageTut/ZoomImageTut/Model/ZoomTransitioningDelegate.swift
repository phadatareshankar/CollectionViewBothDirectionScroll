//
//  ZoomTransitioningDelegate.swift
//  ZoomImageTut
//
//  Created by Meenakshi Phadatare on 10/19/17.
//  Copyright © 2017 Shankar Phadatare. All rights reserved.
//

import Foundation
import UIKit


@objc
protocol ZoomingProtocol {
    
    func zoomingImageView(for transition:ZoomTransitioningDelegate) -> UIImageView?
    //func zoomingBackgroundView(for transition:ZoomTransitioningDelegate) -> UIView
    
}

enum TransitionState {
    case initial
    case final
}


class ZoomTransitioningDelegate:NSObject {
    
    var transitionDuration = 0.5
    
    var operation: UINavigationControllerOperation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7);
    
    typealias ZoomingViews = (otherView:UIView, imageView:UIView)
    
    func configureViews(for state:TransitionState, containerView:UIView, backgroundViewController:UIViewController, viewsInBackground:ZoomingViews,viewsInForeground:ZoomingViews,snapshotView:ZoomingViews) {
        
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1;
            snapshotView.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
        case .final:
            backgroundViewController.view.transform = CGAffineTransform.init(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotView.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
        }
    }
    
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var forgroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            forgroundViewController = fromViewController
        }
        
        
        let mayBeBackgroundImageView = (backgroundViewController as? ZoomingProtocol)?.zoomingImageView(for: self)
        let mayBeForegroundImageView = (forgroundViewController as? ZoomingProtocol)?.zoomingImageView(for: self)
        
        assert(mayBeBackgroundImageView != nil,"Not found")
        assert(mayBeForegroundImageView != nil,"Not found")
        
        
        let backgroundImageView  = mayBeBackgroundImageView
        let forgroundImageView = mayBeForegroundImageView
        
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView?.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        
        
        backgroundImageView?.isHidden = true
        forgroundImageView?.isHidden = true
        
        let foregroundViewBackgroundColor = forgroundViewController?.view.backgroundColor
        forgroundViewController?.view.backgroundColor = UIColor.clear
        
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview((backgroundViewController?.view)!)
        containerView.addSubview((forgroundViewController?.view)!)
        
        containerView.addSubview(imageViewSnapshot)

        var preTransitionState = TransitionState.initial
        
        var postTransitionState =  TransitionState.final
        
        
        if operation == .pop {
            
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController!, viewsInBackground: (backgroundImageView!,backgroundImageView!), viewsInForeground: (forgroundImageView!,forgroundImageView!), snapshotView: (imageViewSnapshot,imageViewSnapshot))
        
        forgroundViewController?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController!, viewsInBackground: (backgroundImageView!,backgroundImageView!), viewsInForeground: (forgroundImageView!,forgroundImageView!), snapshotView: (imageViewSnapshot,imageViewSnapshot))
        }) { (finished) in
            backgroundViewController?.view.transform = CGAffineTransform.identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView?.isHidden = false
            forgroundImageView?.isHidden = false
            
            forgroundViewController?.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
}


extension ZoomTransitioningDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is ZoomingProtocol && toVC is ZoomingProtocol {
            self.operation = operation
            
            return self
            
        }else {
            return nil
        }
        
        
    }
    
}
