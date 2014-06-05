//
//  SelectionViewController.m
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "SelectionViewController.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Foot.h"
#import "User.h"
#import "Comment.h"


@interface SelectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchUsers];

//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
//
//    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
//    self.fetchRequestControllerUser = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContextUser sectionNameKeyPath:nil cacheName:nil];
//    self.fetchRequestControllerUser.delegate = self;
//    [self.fetchRequestControllerUser performFetch:nil];
//
//    if (self.fetchRequestControllerUser.fetchedObjects.count == 0)
//    {
//        [self getUserInfo];
//    }
}

-(void)getUserInfo
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/4/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        for (NSString *name in array)
        {
            int numberOffeet = arc4random() % 75;
            int footSize = arc4random() % 20;
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContextUser];
            NSNumber *No = @(0);
            [user setValue:name forKey:@"name"];
            [user setValue:No forKeyPath:@"favorite"];
            [user setValue:@(numberOffeet) forKeyPath:@"numberOfFeet"];
            [user setValue:@(footSize).description forKeyPath:@"footSize"];
        }
        [self.managedObjectContextUser save:nil];
        [self.fetchRequestControllerUser performFetch:nil];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.fetchRequestControllerUser.sections[section]numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    User *user = [self.fetchRequestControllerUser objectAtIndexPath:indexPath];

    cell.textLabel.text = user.name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [self.fetchRequestControllerUser objectAtIndexPath:indexPath];
    NSNumber *Yes = @(1);
    user.favorite = Yes;
    [self.managedObjectContextUser save:nil];

}

-(void)getFlickrImages
{
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=046c464fe0cf12a8ad37b3807e389fdf&text=&format=json&nojsoncallback=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
}

-(void) fetchUsers
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];

    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchRequestControllerUser = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContextUser sectionNameKeyPath:nil cacheName:nil];
    self.fetchRequestControllerUser.delegate = self;
    [self.fetchRequestControllerUser performFetch:nil];

    if (self.fetchRequestControllerUser.fetchedObjects.count == 0)
    {
        [self getUserInfo];
    }

}



@end
