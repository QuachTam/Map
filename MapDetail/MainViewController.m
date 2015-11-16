//
//  ViewController.m
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/9/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "MainViewController.h"
#import "MDLeftViewController.h"
#import "MDCenterViewController.h"
#import "MDRightViewController.h"

@interface MainViewController ()<SWRevealViewControllerDelegate>

@end

@implementation MainViewController
@synthesize viewController = _viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpSWRevealViewController];
}

- (void)setUpSWRevealViewController{
    MDCenterViewController *centerViewController = [[MDCenterViewController alloc] init]; // center viewcontroller
    MDLeftViewController *leftViewController = [[MDLeftViewController alloc] init]; // left viewcontroller
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController]; // left
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    
    MDRightViewController *rightViewController = [[MDRightViewController alloc] init];
    revealController.rightViewController = rightViewController;
    
    
    revealController.bounceBackOnOverdraw=NO;
    revealController.stableDragOnOverdraw=YES;
    
    self.viewController = revealController;
    
    [self addChildViewController:self.viewController];
    self.viewController.view.frame = self.view.bounds;
    [self.view addSubview:self.viewController.view];
}

#pragma mark - SWRevealViewDelegate

- (id <UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ( operation != SWRevealControllerOperationReplaceRightController )
        return nil;
    
    if ( [toVC isKindOfClass:[MDRightViewController class]] )
    {
//        if ( [(MDRightViewController*)toVC wantsCustomAnimation] )
//        {
//            id<UIViewControllerAnimatedTransitioning> animationController = [[CustomAnimationController alloc] init];
//            return animationController;
//        }
    }
    
    return nil;
}


#define LogDelegates 0

#if LogDelegates
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

#endif


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
