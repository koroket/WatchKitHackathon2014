//
//  AppCommunication.h
//  WatchKitHackathon2014
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
@interface AppCommunication : NSObject

+ (instancetype)sharedManager;
@property (nonatomic,weak) ViewController* viewController;
@end
