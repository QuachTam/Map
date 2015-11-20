//
//  MDCenterViewController.m
//  MapDetail
//
//  Created by Quach Ngoc Tam on 11/9/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "MDCenterViewController.h"
#import "SWRevealViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "LRouteController.h"
#import <PureLayout/PureLayout.h>

@interface MDCenterViewController ()<GMSMapViewDelegate>{
    NSMutableArray *_coordinates;
    NSMutableArray *_markers;
    LRouteController *_routeController;
    GMSPolyline *_polyline;
    GMSMarker *_markerStart;
    GMSMarker *_markerFinish;
}
@property (nonatomic, strong) GMSMapView *mapView;
@end

@implementation MDCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftButtonNavicationBar];
    // Do any additional setup after loading the view from its nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:0
                                                                 zoom:15];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.delegate = self;
    self.view = self.mapView;
    
    _coordinates = [NSMutableArray new];
    _markers = [NSMutableArray new];
    
    _routeController = [LRouteController new];
    
    _markerStart = [GMSMarker new];
    _markerStart.title = @"Start";
    
    _markerFinish = [GMSMarker new];
    _markerFinish.title = @"Finish";
    
    [self setViewNavicationBar];
    
    UIButton *buttonClearAll = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonClearAll.frame = CGRectMake(0, 0, 80, 40);
    [buttonClearAll setTitle:@"Clear All" forState:UIControlStateNormal];
    [buttonClearAll setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonClearAll addTarget:self action:@selector(actionClearAllPin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonClearAll = [[UIBarButtonItem alloc] initWithCustomView:buttonClearAll];
    
    UIButton *buttonRemoveLastPin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRemoveLastPin.frame = CGRectMake(0, 0, 80, 40);
    [buttonRemoveLastPin setTitle:@"Delete" forState:UIControlStateNormal];
    [buttonRemoveLastPin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonRemoveLastPin addTarget:self action:@selector(actionClearAllPin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonRemoveLastPin = [[UIBarButtonItem alloc] initWithCustomView:buttonRemoveLastPin];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barButtonClearAll, barButtonRemoveLastPin, nil];
}

- (void)actionClearAllPin {
    
}

- (void)actionDeletePin {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        NSLog(@"Location, %@,", location);
        CLLocationCoordinate2D target =
        CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [self.mapView animateToLocation:target];
    }
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    [_markers addObject:marker];
    
    _polyline.map = nil;
    _markerStart.map = nil;
    _markerFinish.map = nil;
    
    [_coordinates addObject:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude]];
    
    if ([_coordinates count] > 1)
    {
        [_routeController getPolylineWithLocations:_coordinates travelMode:TravelModeDriving andCompletitionBlock:^(GMSPolyline *polyline, NSError *error, MapInfoModel *mapInfo) {
            if (error)
            {
                NSLog(@"%@", error);
            }
            else if (!polyline)
            {
                NSLog(@"No route");
                [_coordinates removeAllObjects];
                [_markers removeAllObjects];
            }
            else
            {
                if (_markers.count>1) {
                    GMSMarker *markerStart = [_markers firstObject];
                    markerStart.title = mapInfo.start_address;
                    GMSMarker *markerEnd = [_markers lastObject];
                    markerEnd.title = mapInfo.end_address;
                }
                
                _markerStart.position = [[_coordinates objectAtIndex:0] coordinate];
                _markerStart.map = _mapView;
                
                _markerFinish.position = [[_coordinates lastObject] coordinate];
                _markerFinish.map = _mapView;
                
                _polyline = polyline;
                _polyline.strokeWidth = 3;
                _polyline.strokeColor = [UIColor blueColor];
                _polyline.map = _mapView;
                
            }
        }];
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    CGPoint point = [self.mapView.projection pointForCoordinate:marker.position];
    point.x = point.x + 100;
    GMSCameraUpdate *camera =
    [GMSCameraUpdate setTarget:[self.mapView.projection coordinateForPoint:point]];
    [self.mapView animateWithCameraUpdate:camera];
    
    //Show info window on map
    [self.mapView setSelectedMarker:marker];
    return YES;
}

- (void)actionTouchMenu:(NSString *)text {
    if ([text isEqualToString:@"Satellite"]) {
        self.mapView.mapType = kGMSTypeSatellite;
    }else if([text isEqualToString:@"Terrain"]){
        self.mapView.mapType = kGMSTypeTerrain;
    }else if([text isEqualToString:@"Hybrid"]){
        self.mapView.mapType = kGMSTypeHybrid;
    }else{
        self.mapView.mapType = kGMSTypeNormal;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.mapView removeObserver:self forKeyPath:@"myLocation"];
}

@end
