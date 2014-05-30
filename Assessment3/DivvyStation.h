//
//  DivvyStation.h
//  Assessment3
//
//  Created by Vik Denic on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DivvyStation : NSObject

@property NSString *name;
@property int bikesAvailable;
@property int docksOpen;

@property MKMapItem *mapItem;

@end
