//
//  BaseViewController.m
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/18/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "BaseViewController.h"
#import <PureLayout/PureLayout.h>


@interface BaseViewController (){
    SWRevealViewController *revealController;
    UIImageView *imageStatusMenu;
    UILabel *labelTitle;
}
@property (nonatomic, strong) REMenu *menu;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
}

- (void)setLeftButtonNavicationBar {
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (void)setRightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)statusExpand:(BOOL)isExpand {
    if (isExpand) {
        [imageStatusMenu setImage:[UIImage imageNamed:@"UITableExpand"]];
    }else{
        [imageStatusMenu setImage:[UIImage imageNamed:@"UITableContract"]];
    }
}

- (void)setViewNavicationBar {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    labelTitle = [[UILabel alloc] initForAutoLayout];
    labelTitle.text = @"Normal";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelTitle];
    [labelTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [labelTitle autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [labelTitle autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    imageStatusMenu = [[UIImageView alloc] initForAutoLayout];
    [self statusExpand:YES];
    [view addSubview:imageStatusMenu];
    
    [imageStatusMenu autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:labelTitle withOffset:5];
    [imageStatusMenu autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleMenu)];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
    
    self.navigationItem.titleView = view;
    
    REMenuItem *normalItem = [[REMenuItem alloc] initWithTitle:@"Normal"
                                                    subtitle:nil
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [self actionChangeTitle:item];
                                                      }];
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Satellite"
                                                    subtitle:nil
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [self actionChangeTitle:item];
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Terrain"
                                                       subtitle:nil
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             [self actionChangeTitle:item];
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem1 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem2 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem3 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem4 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem5= [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem6 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem7 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              [self actionChangeTitle:item];
                                                          }];
    REMenuItem *activityItem8 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                         subtitle:nil
                                                            image:[UIImage imageNamed:@"Icon_Activity"]
                                                 highlightedImage:nil
                                                           action:^(REMenuItem *item) {
                                                               [self actionChangeTitle:item];
                                                           }];
    REMenuItem *activityItem9 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                         subtitle:nil
                                                            image:[UIImage imageNamed:@"Icon_Activity"]
                                                 highlightedImage:nil
                                                           action:^(REMenuItem *item) {
                                                               [self actionChangeTitle:item];
                                                           }];
    REMenuItem *activityItem10 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                         subtitle:nil
                                                            image:[UIImage imageNamed:@"Icon_Activity"]
                                                 highlightedImage:nil
                                                           action:^(REMenuItem *item) {
                                                               [self actionChangeTitle:item];
                                                           }];
    REMenuItem *activityItem11 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                         subtitle:nil
                                                            image:[UIImage imageNamed:@"Icon_Activity"]
                                                 highlightedImage:nil
                                                           action:^(REMenuItem *item) {
                                                               [self actionChangeTitle:item];
                                                           }];
    REMenuItem *activityItem12 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                          subtitle:nil
                                                             image:[UIImage imageNamed:@"Icon_Activity"]
                                                  highlightedImage:nil
                                                            action:^(REMenuItem *item) {
                                                                [self actionChangeTitle:item];
                                                            }];
    REMenuItem *activityItem13 = [[REMenuItem alloc] initWithTitle:@"Hybrid"
                                                          subtitle:nil
                                                             image:[UIImage imageNamed:@"Icon_Activity"]
                                                  highlightedImage:nil
                                                            action:^(REMenuItem *item) {
                                                                [self actionChangeTitle:item];
                                                            }];
    REMenuItem *activityItem14 = [[REMenuItem alloc] initWithTitle:@"End"
                                                          subtitle:nil
                                                             image:[UIImage imageNamed:@"Icon_Activity"]
                                                  highlightedImage:nil
                                                            action:^(REMenuItem *item) {
                                                                [self actionChangeTitle:item];
                                                            }];
    
    
    
    self.menu = [[REMenu alloc] initWithItems:@[normalItem, homeItem, exploreItem, activityItem, activityItem1, activityItem2, activityItem3, activityItem4, activityItem5, activityItem6, activityItem7, activityItem8, activityItem9, activityItem10, activityItem11, activityItem12, activityItem13, activityItem14]];
}

- (void)actionChangeTitle:(REMenuItem *)item{
    labelTitle.text = item.title;
    [self actionTouchMenu:item.title];
}

- (void)toggleMenu
{
    if (self.menu.isOpen){
        [self statusExpand:YES];
        return [self.menu close];
    }else{
        [self statusExpand:NO];
        [self.menu showFromNavigationController:self.navigationController];
    }
}

- (void)actionTouchMenu:(NSString *)text{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
