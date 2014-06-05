//
//  DetailViewController.m
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberOfFeetLabel;
@property (weak, nonatomic) IBOutlet UILabel *footSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


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

    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];

}




@end
