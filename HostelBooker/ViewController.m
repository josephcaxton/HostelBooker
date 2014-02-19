//
//  ViewController.m
//  HostelBooker
//
//  Created by Joseph caxton-idowu on 19/02/2014.
//  Copyright (c) 2014 Interview. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
#import "HotelDetails.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize HUD,URL,jsonData,strData,LocationObjects,mytableView,PlaceImageView,PlaceImage;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startActivity];
    [self GetDataFromHostelBookers];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:0.9]];
    self.navigationItem.title = @"Locations";
    
    //mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.x, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
   //self.dataSource = self;
    //mytableView.delegate = self;
 //[self.view addSubview:mytableView];
	
}

-(void)viewWillAppear:(BOOL)animated{
    
   
}

-(void) startActivity{
    
    if(!HUD){
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
    }
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    
}

-(void) StopActivity{
    
    [HUD hide:TRUE];
}


-(void) GetDataFromHostelBookers{
    
    // URL can be move to a better location for the whole app but no time
    URL =@"http://www.gingermcninja.com/hw_test/propertylocationsearch.json";
    
    NSURL *url = [NSURL URLWithString:URL];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Cannot connect to their server, ask at why at the interview" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            //NSLog(@"there has been an error");
        } else {
            
            
            jsonData = data;
        
            //NSLog(@"Spew out data %@", jsonData);
        
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            strData = [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
            
             //NSLog(@"Spew out data %@", strData );
            
            NSDictionary *dicLocations = [jsonParser objectWithString:strData  error: nil];
            NSDictionary *items = [[dicLocations objectForKey:@"result"]objectForKey:@"Properties"];
            
            //NSLog(@"Spew out data %@", items);
            
            LocationObjects = [[NSMutableArray alloc] init];
            
            
            for (NSDictionary *Properties in items)
            {
                
                
                HotelObject *h = [[HotelObject  alloc] init];
                
                
                h.Name =[Properties objectForKey:@"name"];
                
                //NSLog(@"%@", h.Name);
                h.Address1 = [Properties objectForKey: @"Address1"];
                h.Address2 = [Properties objectForKey: @"Address2"];
                h.Type = [Properties objectForKey: @"type"];
                h.StarRating = [Properties objectForKey: @"starRating"];
                h.AverageRating = [Properties  objectForKey: @"avgRating"];
                
                h.ShortDescription = [Properties objectForKey: @"shortDescription"];
                h.Imagewidth = [[[[Properties objectForKey:@"images"] objectAtIndex:0] objectForKey:@"width"] floatValue];
                h.ImageHeight = [[[[Properties objectForKey: @"images"]objectAtIndex:0] objectForKey:@"height"] floatValue];
                
                //NSLog(@"%f", h.ImageHeight);
                
                h.url = [[[Properties objectForKey: @"images"]objectAtIndex:0] objectForKey:@"url"];
                
                
                h.latitude = [Properties objectForKey: @"latitude"];
                h.longitude = [Properties objectForKey: @"longitude"];
                
                
                
                
                [LocationObjects  addObject:h];
                
                
            }
            
            
            if(![NSThread isMainThread])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //[self LoadMap];
                    [self StopActivity];
                    [self.tableView reloadData];
                    
                });
            }
            
            
            
            
        }
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%i", LocationObjects.count);
    return [LocationObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    HotelObject *hotel = [LocationObjects objectAtIndex:indexPath.row];
    
    NSString *FullImageURL = hotel.url;
    PlaceImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:FullImageURL]]];
   
    cell.imageView.image =PlaceImage;

    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",hotel.Name];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    cell.textLabel.textColor = [UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:1];
    
    return cell;
    
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     HotelObject *hotel = [LocationObjects objectAtIndex:indexPath.row];
    NSLog(@"%@", hotel.ShortDescription);
    
      HotelDetails *d = [[HotelDetails alloc] initWithNibName:nil bundle:nil];
        d.obj = hotel;
    [self.navigationController pushViewController:d animated:YES];
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
