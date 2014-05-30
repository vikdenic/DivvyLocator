//
//  DetailViewController.m
//  Assessment3
//
//  Created by Vik Denic on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *detailedMapView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.bikeStationAnnotation = [[MKPointAnnotation alloc] init];

    self.title = [self.detailedDivvyDictionary objectForKey:@"stAddress1"];

    NSString *latitude = [self.detailedDivvyDictionary objectForKey:@"latitude"];
    NSString *longitude = [self.detailedDivvyDictionary objectForKey:@"longitude"];
    double latConvertedToDouble = [latitude doubleValue];
    double longConvertedToDouble = [longitude doubleValue];

    self.bikeStationAnnotation.coordinate = CLLocationCoordinate2DMake(latConvertedToDouble, longConvertedToDouble);
    self.bikeStationAnnotation.title = [self.detailedDivvyDictionary objectForKey:@"location"];
    self.bikeStationAnnotation.subtitle = [self.detailedDivvyDictionary objectForKey:@"statusValue"];
    [self.detailedMapView addAnnotation:self.bikeStationAnnotation];

    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latConvertedToDouble, longConvertedToDouble);
    MKCoordinateSpan span = MKCoordinateSpanMake(.5, .5);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    [self.detailedMapView setRegion:region];
}

@end
