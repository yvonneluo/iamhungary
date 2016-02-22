//
//  SavedBusiness+CoreDataProperties.h
//  
//
//  Created by Yvonne Luo on 2/21/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SavedBusiness.h"

NS_ASSUME_NONNULL_BEGIN

@interface SavedBusiness (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *neighborhoods;
@property (nullable, nonatomic, retain) NSString *ratingImageUrl;
@property (nullable, nonatomic, retain) NSString *reviewCounts;
@property (nullable, nonatomic, retain) NSString *categories;

@end

NS_ASSUME_NONNULL_END
