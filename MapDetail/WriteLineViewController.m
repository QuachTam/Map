//
//  WriteLineViewController.m
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/18/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "WriteLineViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MBLocationManager/MBLocationManager.h>

#define kCircleRadius 3
#define ToRadian(x) ((x) * M_PI/180)
#define ToDegrees(x) ((x) * 180/M_PI)

@interface WriteLineViewController ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocationCoordinate2D oldCoordinate2D;
    
}
@property (nonatomic, strong) NSArray *arrayData;
@end

@implementation WriteLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    geocoder = [[CLGeocoder alloc] init];
}

-(void)locationManagerFailed:(NSNotification*)notification
{
    NSLog(@"Location manager failed");
}

-(void)changeLocation:(NSNotification*)notification
{
    CLLocation *location = [[MBLocationManager sharedManager] currentLocation];
    self.longTi.text = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
    self.latTi.text = [NSString stringWithFormat:@"%.8f", location.coordinate.latitude];
}

- (NSArray *)arrayData {
    if (!_arrayData) {
        _arrayData =  @[@"0.7", @"0.4", @"0.9", @"1.0", @"0.2", @"0.85", @"0.11", @"0.75", @"0.53", @"0.44", @"0.88", @"0.77", @"0.99", @"0.55"];
    }
    return _arrayData;
}


+ (CLLocationCoordinate2D)midpointBetweenCoordinate:(CLLocationCoordinate2D)c1 andCoordinate:(CLLocationCoordinate2D)c2
{
    c1.latitude = ToRadian(c1.latitude);
    c2.latitude = ToRadian(c2.latitude);
    CLLocationDegrees dLon = ToRadian(c2.longitude - c1.longitude);
    CLLocationDegrees bx = cos(c2.latitude) * cos(dLon);
    CLLocationDegrees by = cos(c2.latitude) * sin(dLon);
    CLLocationDegrees latitude = atan2(sin(c1.latitude) + sin(c2.latitude), sqrt((cos(c1.latitude) + bx) * (cos(c1.latitude) + bx) + by*by));
    CLLocationDegrees longitude = ToRadian(c1.longitude) + atan2(by, cos(c1.latitude) + bx);
    
    CLLocationCoordinate2D midpointCoordinate;
    midpointCoordinate.longitude = ToDegrees(longitude);
    midpointCoordinate.latitude = ToDegrees(latitude);
    
    return midpointCoordinate;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    CLLocationCoordinate2D coordinate = [[self class] midpointBetweenCoordinate:newLocation.coordinate andCoordinate:oldLocation.coordinate];
    if (currentLocation != nil) {
        self.longTi.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latTi.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    self.midLocation.text = [NSString stringWithFormat:@"%.8f - %.8f", coordinate.longitude, coordinate.latitude];
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionGetLocation:(id)sender {
    [locationManager stopUpdatingLocation];
    [locationManager startUpdatingLocation];
}
@end
