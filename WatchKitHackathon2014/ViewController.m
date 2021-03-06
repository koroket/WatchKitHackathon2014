//
//  ViewController.m
//  WatchKitHackathon2014
//
//  Created by sloot on 11/23/14.
//  Copyright (c) 2014 sloot. All rights reserved.
//

#import "ViewController.h"
#import "AppCommunication.h"
@interface ViewController (){

    NSArray *_pickerData;
    
    
    
}
@property (nonatomic,strong) CLLocationManager* locationManager;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) NSString* currentLatitude;
@property (nonatomic,strong) NSString* currentLongitude;
@property (strong, nonatomic) IBOutlet UITextField *searchTerm2;
@property (nonatomic,strong) NSString* searchTerm;
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
    

        NSString *fixedURL = [NSString stringWithFormat:@"http://young-sierra-7245.herokuapp.com/watch/yelp/%@/%@/%@",self.currentLatitude,self.currentLongitude,self.searchTerm];
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
                                    if(fetchedData.count>0)
                                    {
                                        NSMutableDictionary *temp = fetchedData[0];
                                        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.masaBando.shared"];
                                        if(temp[@"image_url"]!=nil)
                                        {
                                            
                                            NSString* newString = temp[@"image_url"];
                                            
                                            NSString* new2String = [newString stringByReplacingOccurrencesOfString:@"/ms.jpg" withString:@"/o.jpg"];
                 
                                            //UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:new2String]]];
                                            
                                            [sharedDefaults setObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:new2String]] forKey:@"pic"];
                                            
                                            
                            
                                        }
                                        [sharedDefaults setObject:temp[@"name"] forKey:@"locations"];
                                        [sharedDefaults synchronize];
                                        
                                    }
                                    else
                                    {
                                        
                                    }

                                    
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
    _pickerData = @[@"Restaurants", @"Quick Eats", @"Bars", @"NightLife", @"Coffee & Breakfast"];
    self.searchTerm = @"Restaurants";

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
    
    [sharedDefaults setObject:@"Searching..." forKey:@"locations"];
    [sharedDefaults synchronize];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"updated");
    CLLocation *newLocation = [locations lastObject];
    
    self.currentLatitude = [NSString stringWithFormat:(@"%f"), newLocation.coordinate.latitude];
    
    self.currentLongitude = [NSString stringWithFormat:(@"%f"), newLocation.coordinate.longitude];
    [self getYelp];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    return _pickerData[row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    
    self.searchTerm =  _pickerData[row];

    
    NSLog(@"The current selection is %@",_pickerData[row]);
}

// Change the attributes of the text in the UIPicker
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:_pickerData[row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    return attString;
    
}

- (IBAction)save:(id)sender {
    self.searchTerm = self.searchTerm2.text;
    [self getYelp];
}
@end
