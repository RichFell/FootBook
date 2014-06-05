//
//  DetailViewController.m
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "DetailViewController.h"
#import "FootPhotoCollectionCell.h"
#import "FootDetailViewController.h"

@interface DetailViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberOfFeetLabel;
@property (weak, nonatomic) IBOutlet UILabel *footSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.numberOfFeetLabel.text = [NSString stringWithFormat:@"Number of feet %@", self.detailItem.numberOfFeet];
    self.footSizeLabel.text = [NSString stringWithFormat:@"Footsize %@", self.detailItem.footSize];

    if ([self.detailItem.favorite isEqual:@(1)])
    {
        self.favoriteLabel.text = @"One of your friends";
    }
    else
    {
        self.favoriteLabel.text = @"Why can you see this detail?";
    }

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Foot"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"picture" ascending:YES]];
    self.detailFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContextDetail sectionNameKeyPath:nil cacheName:nil];

    self.detailFetchedResultsController.delegate = self;
    [self.detailFetchedResultsController performFetch:nil];
    [self.collectionView reloadData];
}

- (IBAction)onButtonPressedAccessPhotoLibrary:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    [picker dismissViewControllerAnimated:YES completion:nil];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    NSData *data = UIImagePNGRepresentation(image);

    Foot *foot = [NSEntityDescription insertNewObjectForEntityForName:@"Foot" inManagedObjectContext:self.managedObjectContextDetail];

    foot.picture = data;
    [self.detailItem addFeetObject:foot];
    [self.collectionView reloadData];
    [self.managedObjectContextDetail save:nil];

    NSLog(@"%@", image);

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.detailFetchedResultsController.sections[section]numberOfObjects];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FootPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellID" forIndexPath:indexPath];
    Foot *foot = [self.detailFetchedResultsController objectAtIndexPath:indexPath];

    cell.footImageView.image = [UIImage imageWithData:foot.picture];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FootDetailViewController *footVC = segue.destinationViewController;
    footVC.footFetchedResultController = self.detailFetchedResultsController;
    footVC.footManagedObjectContext = self.managedObjectContextDetail;

    Foot *foot = [self.detailFetchedResultsController objectAtIndexPath:self.collectionView.indexPathsForSelectedItems[0]];



}


@end
