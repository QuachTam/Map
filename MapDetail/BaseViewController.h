//
//  BaseViewController.h
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/18/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <REMenu/REMenu.h>

@interface BaseViewController : UIViewController
- (void)setLeftButtonNavicationBar;
- (void)setRightButtonNavicationBar;
- (void)setViewNavicationBar;
- (void)actionTouchMenu:(NSString *)text;
@end
