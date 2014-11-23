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
@property (nonatomic,strong) CLLocationManager* locationManager;
@property (nonatomic,strong) NSString* currentLatitude;
@property (nonatomic,strong) NSString* currentLongitude;
@end

@implementation ViewController
- (IBAction)change:(id)sender {
   
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.masaBando.shared"];

    [sharedDefaults setObject:@"meow" forKey:@"locations"];
    [sharedDefaults synchronize];
    [self getYelp];
    
}
-(void)getYelp
{
    

        NSString *fixedURL = [NSString stringWithFormat:@"http://young-sierra-7245.herokuapp.com/watch/yelp/%@/%@/food",self.currentLatitude,self.currentLongitude];
        NSURL *url = [NSURL URLWithString:fixedURL];
        // Request
        NSMutableURLRequest *request =
        [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        // Request type
        [request setHTTPMethod:@"GET"];
        // Session
        NSURLSession *urlSession = [NSURLSession sharedSession];
        // Data Task Block
        NSURLSessionDataTask *dataTask =
        [urlSession dataTaskWithRequest:request
                      completionHandler:^(NSData *data,
                                          NSURLResponse *response,
                                          NSError *error)
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             NSInteger responseStatusCode = [httpResponse statusCode];
             
             if (responseStatusCode == 200 && data)
             {
                 dispatch_async(dispatch_get_main_queue(), ^(void)
                                {
                                    NSArray*fetchedData = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:0
                                                                                            error:nil];
                                    NSLog(@"got more cards");
                                    
                                    NSLog(@"%@",fetchedData);
                                }); // Main Queue dispatch block
                 
                 // do something with this data
                 // if you want to update UI, do it on main queue
             }
             else
             {
                 NSLog(@"error");
                 // error handlingN
             }
         }]; // Data Task Block
        [dataTask resume];
    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [AppCommunication sharedManager].viewController = self;
    [self startStandardUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma GPS

- (void)startStandardUpdates
{
    
    // Create the location manager if this object does not
    // already have one.
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    
    self.locationManager.distanceFilter = .01; // meters
    
    [self.locationManager startUpdatingLocation];
    
}


- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location!:(");
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.masaBando.shared"];
    
    [sharedDefaults setObject:@"GPS not available" forKey:@"locations"];
    [sharedDefaults synchronize];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"updated");
    CLLocation *newLocation = [locations lastObject];
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.masaBando.shared"];
    
    [sharedDefaults setObject:@"location Updated" forKey:@"locations"];
    [sharedDefaults synchronize];
    
    self.currentLatitude = [NSString stringWithFormat:(@"%f"), newLocation.coordinate.latitude];
    
    self.currentLongitude = [NSString stringWithFormat:(@"%f"), newLocation.coordinate.longitude];
    [self getYelp];
}
@end
