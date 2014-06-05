//
//  User.h
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Foot;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * footSize;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * numberOfFeet;
@property (nonatomic, retain) NSSet *feet;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFeetObject:(Foot *)value;
- (void)removeFeetObject:(Foot *)value;
- (void)addFeet:(NSSet *)values;
- (void)removeFeet:(NSSet *)values;

@end
