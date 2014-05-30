//
//  ViewController.m
//  Assessment3
//
//  Created by Vik Denic on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "DivvyStation.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property NSArray *stationsArray;
@property NSMutableArray *retrievedStationsArray;
@property (weak, nonatomic) IBOutlet UITableView *divvyTableView;
@property NSDictionary *selectedDivvyDictionary;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.stationsArray = [[NSArray alloc]init];
    self.retrievedStationsArray = [[NSMutableArray alloc]init];

    NSURL *url = [NSURL URLWithString:@"http://www.divvybikes.com/stations/json/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,
                                                                                                            NSData *data,
                                                                                                            NSError *connectionError) {

        NSDictionary *divvyDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        self.stationsArray = [divvyDictionary objectForKey:@"stationBeanList"];

        for(NSDictionary *stationDictionary in self.stationsArray)
        {
            DivvyStation *divvyStation = [[DivvyStation alloc]init];

            divvyStation.name = [stationDictionary objectForKey:@"stAddress1"];
            divvyStation.bikesAvailable = [[stationDictionary objectForKey:@"availableBikes"] integerValue];
            divvyStation.docksOpen = [[stationDictionary objectForKey:@"availableDocks"] integerValue];

            [self.retrievedStationsArray addObject:divvyStation];
        }
        [self.divvyTableView reloadData];
    }];
}

#pragma mark - Delegates

// TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.retrievedStationsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DivvyStation *divvyStation = [self.retrievedStationsArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationCellID"];
    cell.textLabel.text = divvyStation.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d bikes | %d open docks", divvyStation.bikesAvailable, divvyStation.docksOpen];

    return cell;
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = self.divvyTableView.indexPathForSelectedRow;
    DetailViewController *detailVC = [segue destinationViewController];
    NSDictionary *dictionary = [self.stationsArray objectAtIndex:selectedIndexPath.row];
    detailVC.detailedDivvyDictionary = dictionary;
}

@end
