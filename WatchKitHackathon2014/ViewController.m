//
//  ViewController.m
//  WatchKitHackathon2014
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import "ViewController.h"
#import "AppCommunication.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [AppCommunication sharedManager].viewController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
