//
//  ShadowMetadata.h
//  SyncTest
//
//  Created by Jesse Grosjean on 8/7/10.
//

#import <CoreData/CoreData.h>
#import "PathController.h"

@class ShadowMetadataTextBlob;
@class PathController;
@class PathOperation;
@class ShadowMetadata;


@interface ShadowMetadata : NSManagedObject {
	PathState pathState;
	BOOL lastSyncIsDirectory;
	NSError *pathError;
	NSString *normalizedPath;
}

+ (ShadowMetadata *)shadowMetadataWithNormalizedName:(NSString *)aNormalizedName managedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

@property(nonatomic, readonly) BOOL isRoot;
@property(weak, nonatomic, readonly) NSString *normalizedName;
@property(weak, nonatomic, readonly) NSString *normalizedPath; // transient
@property(weak, nonatomic, readonly) PathController *pathController; // transient
@property(nonatomic, strong) NSError *pathError; // transient

#pragma mark -
#pragma mark Children

@property(weak, nonatomic, readonly) ShadowMetadata* parent;
@property(nonatomic, strong) NSSet* children;
@property(weak, nonatomic, readonly) NSSet* allDescendantsWithSelf;

#pragma mark -
#pragma mark Last Sync Metadata

@property(nonatomic, assign) PathState pathState;
@property(nonatomic, strong) NSString *lastSyncName;
@property(nonatomic, strong) NSDate *lastSyncDate;
@property(nonatomic, strong) NSString *lastSyncHash;
@property(nonatomic, assign) BOOL lastSyncIsDirectory;
@property(nonatomic, strong) NSDate *clientMTime;
@property(nonatomic, strong) ShadowMetadataTextBlob *lastSyncText;

@end

@interface NSManagedObject (Children)
- (void)addChildrenObject:(ShadowMetadata *)aChild;
- (void)removeChildrenObject:(ShadowMetadata *)aChild;
@end