//
//  UpcomingGuidesTableViewController.m
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import "UpcomingGuidesTableViewController.h"
#import "GuideWebservice.h"
#import "Guide.h"
#import "GuideTableViewCell.h"

@interface UpcomingGuidesTableViewController ()
{
    NSArray *guides;
    NSMutableArray *groupedGuides;
}

@end

@implementation UpcomingGuidesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getUpcomingGuides)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Handle first time loading guides when view controller appears
    [self getUpcomingGuides];
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0.0f, -60.0f) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Webservice calls

- (void)getUpcomingGuides
{
    // Retrieve upcoming guides and sort by start date before displaying in table view
    [[GuideWebservice sharedInstance] getUpcomingGuidesWithCompletion:^(WebOperation *operation, NSArray *upcomingGuides) {
        if (upcomingGuides) {
            // Successful fetch
            guides = upcomingGuides;
            
            [self sortGuidesByStartDate];
            [self groupGuidesByStartDate];
            
            [self.tableView reloadData];
        } else {
            // Error occured
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops :-(" message:@"Could not load upcoming guides. Please try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
            [alertController addAction:dismissAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Sort guides

- (void)sortGuidesByStartDate
{
    guides = [guides sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        
        NSDate *first = [dateFormatter dateFromString:[(Guide*)a startDate]];
        NSDate *second = [dateFormatter dateFromString:[(Guide*)b startDate]];
        return [first compare:second];
    }];
}

#pragma mark - Group guides

- (void)groupGuidesByStartDate
{
    Guide *lastGuide = nil;
    NSMutableArray *currentGroup = [[NSMutableArray alloc] init];
    
    groupedGuides = [[NSMutableArray alloc] init];
    
    for (Guide *guide in guides) {
        if (![guide.startDate isEqualToString:lastGuide.startDate] && lastGuide != nil) {
            [groupedGuides addObject:currentGroup];
            currentGroup = [[NSMutableArray alloc] init];
        }
        
        [currentGroup addObject:guide];
        lastGuide = guide;
    }
    
    // Add the last group once loop is over
    [groupedGuides addObject:currentGroup];
    currentGroup = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [groupedGuides count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[groupedGuides objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([[groupedGuides objectAtIndex:section] count] > 0) {
        return [[[groupedGuides objectAtIndex:section] objectAtIndex:0] startDate];
    } else {
        return @"Start Date Not Found";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuideTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Guide *guide = [[groupedGuides objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.guideNameLabel.text = guide.name;
    
    if (guide.startDate != nil && guide.endDate != nil) {
        cell.guideTimeframeLabel.text = [NSString stringWithFormat:@"Ends - %@", guide.endDate];
    } else {
        cell.guideTimeframeLabel.text = @"No event time available";
    }
    
    if (guide.venue.city != nil && guide.venue.state != nil) {
        cell.guideLocationLabel.text = [NSString stringWithFormat:@"%@, %@", guide.venue.city, guide.venue.state];
    } else {
        cell.guideLocationLabel.text = @"No event location available";
    }
    
    return cell;
}

@end
