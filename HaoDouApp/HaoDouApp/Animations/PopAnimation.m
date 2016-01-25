//
//  PopAnimation.m
//  NavAnoimation_Demo
//
//  Created by luo on 14-9-26.
//  Copyright (c) 2014年 luo. All rights reserved.
//

#import "PopAnimation.h"

@implementation PopAnimation


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        toViewController.view.alpha = 1.0f;
        fromViewController.view.alpha = 0.0f;
    
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 3.0f;
}


@end
