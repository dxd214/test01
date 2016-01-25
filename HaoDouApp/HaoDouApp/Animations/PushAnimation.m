//
//  PushAnimation.m
//  NavAnoimation_Demo
//
//  Created by luo on 14-9-26.
//  Copyright (c) 2014年 luo. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation

//2. UIViewControllerAnimatedTransitioning代理

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    
    
    
    [UIView animateWithDuration:0.3*[self transitionDuration:transitionContext]  animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(0.6, 0.6);
        toViewController.view.alpha = 0.3;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3*[self transitionDuration:transitionContext]  animations:^{
            
            fromViewController.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
            toViewController.view.alpha = 0.6;

        } completion:^(BOOL finished){
            
            [UIView animateWithDuration:0.4*[self transitionDuration:transitionContext] animations:^{
                
                fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                toViewController.view.alpha = 1.0;
            } completion:^(BOOL finished){
                
                fromViewController.view.transform = CGAffineTransformIdentity;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
            
        }];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 3.0f;
}



@end
