//
//  InterfaceController.m
//  WatchKitHackathon2014 WatchKit Extension
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *text;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *myImage;
- (IBAction)open;


@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
    }
    return self;
}
-(void)autoUpdateStart
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                   {
                       NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.masaBando.shared"];
                       NSString* prevLoc = @"";
                       while(true)
                       {
                           if([sharedDefaults objectForKey:@"locations"]!=prevLoc)
                           {
                               prevLoc = [sharedDefaults objectForKey:@"locations"];
                               dispatch_async(dispatch_get_main_queue(), ^
                                              {
                                                  [self.text setText:[sharedDefaults objectForKey:@"locations"]];
                                                  if([sharedDefaults objectForKey:@"pic"]!=nil)
                                                  {
                                                     
                                                      [self.myImage setImage: [UIImage imageWithData:[sharedDefaults objectForKey:@"pic"]]];
                                                  }
                                              });
                           }
                       }
                   });
}
- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    [self autoUpdateStart];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (IBAction)open {
     [self.text setText:@"nice"];
}
@end



