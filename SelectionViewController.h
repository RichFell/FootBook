//
//  SelectionViewController.h
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionViewController : UIViewController<NSFetchedResultsControllerDelegate>
@property NSManagedObjectContext *managedObjectContextUser;
@property (strong, nonatomic) NSFetchedResultsController *fetchRequestControllerUser;

@end
