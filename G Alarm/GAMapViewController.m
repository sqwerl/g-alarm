//
//  GAMapViewController.m
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import "GAMapViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation GAMapViewController
@synthesize coordinateLabel;
@synthesize mapView;

CLLocationManager *_locationManager;
NSArray *_regionArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self initializeMap];
    [self initializeLocationManager];
    //NSArray *geofences = [self buildGeofenceData];
    //[self initializeRegionMonitoring:geofences];
    //[self initializeLocationUpdates];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

// Add this Method
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.002, 0.002);
    [self.mapView setRegion:mapRegion animated: YES];
}

- (void)viewDidUnload
{
    [self setCoordinateLabel:nil];
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)initializeMap {
//    CLLocationCoordinate2D initialCoordinate;
//    initialCoordinate.latitude = 41.88072;
//    initialCoordinate.longitude = -87.67429;
    
    MKCoordinateRegion mapRegion;

    mapRegion.center.latitude = mapView.userLocation.coordinate.latitude;
    mapRegion.center.longitude = mapView.userLocation.coordinate.longitude;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    [mapView setRegion:mapRegion animated: YES];
//
//    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 100, 100) animated:YES];
//    self.mapView.centerCoordinate = initialCoordinate;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (void)initializeLocationManager {
    // Check to ensure location services are enabled
    if(![CLLocationManager locationServicesEnabled]) {
        [self showAlertWithMessage:@"You need to enable location services to use this app."];
        return;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}


- (void) initializeRegionMonitoring:(NSArray*)geofences {
    
    if (_locationManager == nil) {
        [NSException raise:@"Location Manager Not Initialized" format:@"You must initialize location manager first."];
    }
    
    if(![CLLocationManager regionMonitoringAvailable]) {
        [self showAlertWithMessage:@"This app requires region monitoring features which are unavailable on this device."];
        return;
    }
    
    for(CLRegion *geofence in geofences) {
        [_locationManager startMonitoringForRegion:geofence];
    }
    
}

- (NSArray*) buildGeofenceData {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"regions" ofType:@"plist"];
    _regionArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *geofences = [NSMutableArray array];
    for(NSDictionary *regionDict in _regionArray) {
        CLRegion *region = [self mapDictionaryToRegion:regionDict];
        [geofences addObject:region];
    }
    
    return [NSArray arrayWithArray:geofences];
}

- (CLRegion*)mapDictionaryToRegion:(NSDictionary*)dictionary {
    NSString *title = [dictionary valueForKey:@"title"];
    
    CLLocationDegrees latitude = [[dictionary valueForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude =[[dictionary valueForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    CLLocationDistance regionRadius = [[dictionary valueForKey:@"radius"] doubleValue];
    
    return [[CLRegion alloc] initCircularRegionWithCenter:centerCoordinate
                                                   radius:regionRadius
                                               identifier:title];
}

- (void)initializeLocationUpdates {
    [_locationManager startUpdatingLocation];
}

#pragma mark - Location Manager - Region Task Methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered Region - %@", region.identifier);
    [self showRegionAlert:@"Entering Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Exited Region - %@", region.identifier);
    [self showRegionAlert:@"Exiting Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Started monitoring %@ region", region.identifier);
}

#pragma mark - Location Manager - Standard Task Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.coordinateLabel.text = [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.latitude, newLocation.coordinate.longitude];
}
#pragma mark - Alert Methods

- (void) showRegionAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:regionIdentifier
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)showAlertWithMessage:(NSString*)alertText {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Services Error"
                                                        message:alertText
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end