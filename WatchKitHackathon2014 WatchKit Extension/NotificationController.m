//
//  NotificationController.m
//  WatchKitHackathon2014 WatchKit Extension
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ init", self);
        
    }
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PushNotificationPayload" ofType:@"json"];
//    
//    NSError * error;
//    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
//    
//    
//
////    NSDictionary* mydict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath]
////                                                           options:0
////                                                             error:nil];
//    NSString* filePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],@"data.json"];
//    
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    [dictionary setValue:@"sup" forKey:@"friends"];
//    [dictionary setValue:@"gucci" forKey:@"myName"];
//    
//    //Error Handling
//    NSError *error = nil;
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
//    [data writeToFile:filePath atomically:YES];
//    NSLog(@"k");
    

    
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

/*
- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification inteface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
*/

/*
- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification inteface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
*/
-(void) firstAction:(id)sender
{
    NSLog(@"sup");
}
@end



