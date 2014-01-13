//
//  Section.h
//  Documents
//
//  Created by Jesse Grosjean on 5/18/09.
//


@class RootSection;
@class Tree;
@class Tag;
@class TreeViewTheme;

@interface Section : NSObject {
	Tree *__weak tree;
	NSString *uniqueID;
	NSInteger level;
	NSString *content;
	NSUInteger type;
	NSArray *tags;
	NSString *selfString;
	Section *__weak parent;
	Section *__weak previousSibling;
	Section *__weak nextSibling;
	Section *__weak firstChild;
	Section *__weak lastChild;
	NSUInteger countOfChildren;
}

+ (Class)sectionClass;
+ (void)setSectionClass:(Class)aClass;
+ (Section *)sectionWithString:(NSString *)aString;
+ (NSArray *)commonAncestorsForSections:(NSEnumerator *)sections;

#pragma mark Attributes

@property(weak, readonly) Tree *tree;
@property(readonly) NSString *uniqueID;
@property (nonatomic, assign) NSUInteger type;
@property(weak, readonly) NSString *typeAsString;
@property(readonly) BOOL isBlank;
@property(nonatomic, assign) NSInteger level;
- (void)setLevel:(NSInteger)newLevel includeChildren:(BOOL)includeChildren;
@property(weak, readonly) NSString *levelAsString;
@property(readonly) NSInteger index;
@property(weak, readonly) NSString *indexAsString;
@property(nonatomic, strong) NSString *content;

- (void)replaceContentInRange:(NSRange)aRange withString:(NSString *)aString;

#pragma mark SelfString 

@property(readonly) NSUInteger selfStringLength;
@property(strong) NSString *selfString;
- (void)noteSelfStringChanged;

#pragma mark Tags

@property(weak, readonly) NSArray *tags;
- (Tag *)tagWithName:(NSString *)name;
- (Tag *)tagWithName:(NSString *)name createIfNeccessary:(BOOL)createIfNeccessary;
- (Tag *)tagWithOnlyName:(NSString *)name;
- (void)addTag:(Tag *)tag;
- (void)removeTag:(Tag *)tag;

#pragma mark Tree

@property(readonly) BOOL isRoot;
@property(weak, readonly) RootSection *root;
@property(weak, readonly) Section *treeOrderPrevious;
@property(weak, readonly) Section *treeOrderNext;
@property(weak, readonly) Section *treeOrderNextSkippingInterior;
@property(weak, readonly) NSIndexPath *treeIndexPath;

#pragma mark Ancestors

- (BOOL)isAncestor:(Section *)section;
@property(weak, readonly) NSEnumerator *ancestors;
@property(weak, readonly) NSEnumerator *ancestorsWithSelf;
@property(weak, readonly) Section *rootLevelAncestor;

#pragma mark Headers

@property(readonly) NSUInteger headerType;
@property(weak, readonly) Section *topLevelHeader;
@property(weak, readonly) Section *containingHeader;
@property(weak, readonly) Section *headerOrSelf;

#pragma mark Decendents

- (BOOL)isDecendent:(Section *)section;
@property(weak, readonly) NSEnumerator *descendants;
@property(weak, readonly) NSEnumerator *descendantsWithSelf;
@property(weak, readonly) NSString *descendantsAsString;
@property(weak, readonly) Section *leftmostDescendantOrSelf;
@property(weak, readonly) Section *rightmostDescendantOrSelf;

#pragma mark Children

@property(weak, readonly) Section *parent;
@property(weak, readonly) Section *previousSibling;
@property(weak, readonly) Section *nextSibling;
@property(weak, readonly) Section *firstChild;
@property(weak, readonly) Section *lastChild;
@property(readonly) NSUInteger countOfChildren;
@property(weak, readonly) NSEnumerator *enumeratorOfChildren;

- (id)initWithString:(NSString *)aString;

- (Section *)memberOfChildren:(Section *)aChild;
- (void)addChildrenObject:(Section *)aChild;
- (void)insertChildrenObject:(Section *)insertedChild before:(Section *)beforeChild;
- (void)insertChildrenObject:(Section *)insertedChild after:(Section *)afterChild;
- (void)removeChildrenObject:(Section *)aChild;
- (void)removeFromParent;

#pragma mark Read / Write Strings

+ (RootSection *)rootSectionFromString:(NSString *)string;
+ (NSMutableArray *)sectionsFromString:(NSString *)string;
+ (NSMutableString *)sectionsToString:(NSEnumerator *)sections includeTags:(BOOL)includeTags;
	
+ (NSString *)validateSectionString:(NSString *)aString;
- (void)writeSelfToString:(NSMutableString *)aString includeTags:(BOOL)includeTags;

#if !TARGET_OS_IPHONE
//- (NSString *)writeSelfToDOMElement:(DOMElement *)element theme:(TreeViewTheme *)theme;
#endif

@end