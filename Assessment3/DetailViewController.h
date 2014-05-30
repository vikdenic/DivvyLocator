//
//  DetailViewController.h
//  Assessment3
//
//  Created by Vik Denic on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DivvyStation.h"
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController

@property NSDictionary *detailedDivvyDictionary;
@property MKPointAnnotation *bikeStationAnnotation;

@end
