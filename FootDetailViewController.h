//
//  FootDetailViewController.h
//  Footbook
//
//  Created by Richard Fellure on 6/5/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootDetailViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property NSFetchedResultsController *footFetchedResultController;
@property NSManagedObjectContext *footManagedObjectContext;

@end
