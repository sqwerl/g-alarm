//
//  GAMapViewController.h
//  G Alarm
//
//  Created by Larry Cao on 5/8/13.
//  Copyright (c) 2013 Larry Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GAMapViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *coordinateLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation* initialLocation;

@end