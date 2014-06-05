//
//  DetailViewController.h
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Foot.h"

@interface DetailViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) User *detailItem;
@property NSManagedObjectContext *managedObjectContextDetail;
@property NSFetchedResultsController *detailFetchedResultsController;

@end
