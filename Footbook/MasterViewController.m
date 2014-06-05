#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SelectionViewController.h"
#import "Foot.h"
#import "User.h"
#import "Comment.h"
@interface MasterViewController()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *favoritesArray;

@end

@implementation MasterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite == 1"];
    request.predicate = predicate;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{

        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite == 1"];
        request.predicate = predicate;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
       self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];

        self.fetchedResultsController.delegate = self;
        [self.fetchedResultsController performFetch:nil];
        [self.tableView reloadData];

}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section]numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of feet %@", user.numberOfFeet];

    return cell;
}

-(IBAction)unwindFromSelectionVC:(UIStoryboardSegue *)sender
{
    SelectionViewController *sourceVC = sender.sourceViewController;
    self.fetchedResultsController = sourceVC.fetchRequestControllerUser;
    self.managedObjectContext = sourceVC.managedObjectContextUser;
    [self.managedObjectContext save:nil];
    [self.tableView reloadData];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"showUsers"])
    {
        SelectionViewController *nextViewController = segue.destinationViewController;
        nextViewController.fetchRequestControllerUser = self.fetchedResultsController;
        nextViewController.managedObjectContextUser = self.managedObjectContext;
    }
    else if ([segue.identifier isEqual:@"showDetail"])
    {
        User *user = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.detailItem = user;
        detailVC.title = user.name;
    }
}



@end

