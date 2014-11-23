//
//  AppDelegate.m
//  WatchKitHackathon2014
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "AppCommunication.h"
//CGImageRef UIGetScreenImage();
CGImageRef UIGetScreenImage(void);


@interface AppDelegate ()

@end

@implementation AppDelegate

//+ (UIImage *)imageWithScreenContents
//{
//    CGImageRef cgScreen = UIGetScreenImage();
//    if (cgScreen) {
//        UIImage *result = [UIImage imageWithCGImage:cgScreen];
//        CGImageRelease(cgScreen);
//        return result;
//    }
//    return nil;
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"backg");
//    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
//    if (NULL != UIGraphicsBeginImageContextWithOptions)
//        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
//    else
//        UIGraphicsBeginImageContext(imageSize);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Iterate over every window from back to front
//    for (UIWindow *window in [[UIApplication sharedApplication] windows])
//    {
//        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
//        {
//            // -renderInContext: renders in the coordinate space of the layer,
//            // so we must first apply the layer's geometry to the graphics context
//            CGContextSaveGState(context);
//            // Center the context around the window's anchor point
//            CGContextTranslateCTM(context, [window center].x, [window center].y);
//            // Apply the window's transform about the anchor point
//            CGContextConcatCTM(context, [window transform]);
//            // Offset by the portion of the bounds left of and above the anchor point
//            CGContextTranslateCTM(context,
//                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
//                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
//            
//            // Render the layer hierarchy to the current context
//            [[window layer] renderInContext:context];
//            
//            // Restore the context
//            CGContextRestoreGState(context);
//        }
//    }
//    
//    // Retrieve the screenshot image
//    UIImage *imageForEmail = UIGraphicsGetImageFromCurrentImageContext();
//    if([AppCommunication sharedManager].viewController!=nil)
//    {
//        [AppCommunication sharedManager].viewController.myImage.image = imageForEmail;
//    }
//    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
//    
//    UIGraphicsBeginImageContext(screenWindow.frame.size);
//    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
//UIGetScreenImage();
//    UIImage* background = [UIImage imageWithCGImage:cgBackground];
//    //UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
//           [AppCommunication sharedManager].viewController.myImage.image = background;
    //CGImageRef screen = UIGetScreenImage();
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "m.WatchKitHackathon2014" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WatchKitHackathon2014" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WatchKitHackathon2014.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
