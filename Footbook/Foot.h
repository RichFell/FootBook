//
//  Foot.h
//  Footbook
//
//  Created by Richard Fellure on 6/4/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User;

@interface Foot : NSManagedObject

@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * hairiness;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Foot (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
