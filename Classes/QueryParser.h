//
//  QueryParser.h
//  Documents
//
//  Created by Jesse Grosjean on 5/29/09.
//

@class PKParser, PKTokenizer, PKToken, PKCollectionParser, PKPattern, PKAssembly;

@interface QueryParser : NSObject {
	PKTokenizer *tokenizer;
	NSArray *logicKeywords;
	NSArray *relationKeywords;
	NSArray *attributeKeywords;
	PKToken *nonReservedWordFence;
	PKCollectionParser *expressionParser;
	PKCollectionParser *termParser;
	PKCollectionParser *orTermParser;
	PKCollectionParser *notFactorParser;
	PKCollectionParser *andNotFactorParser;
	PKCollectionParser *primaryExpressionParser;
	PKCollectionParser *predicateParser;
	PKCollectionParser *completePredicateParser;
	PKCollectionParser *attributeValuePredicateParser;
	PKCollectionParser *attributePredicateParser;
	PKCollectionParser *relationValuePredicateParser;
	PKCollectionParser *valuePredicateParser;
	PKPattern *attributeParser;
	PKCollectionParser *relationParser;
	PKCollectionParser *valueParser;
	PKParser *quotedStringParser;
	PKCollectionParser *unquotedStringParser;
	PKPattern *reservedWordParser;
	PKPattern *nonReservedWordParser;
}

+ (id)sharedInstance;

- (NSPredicate *)parse:(NSString *)s highlight:(id *)attributedString;

- (PKAssembly *)assemblyFromString:(NSString *)s;

@property (nonatomic, strong) PKTokenizer *tokenizer;
@property (nonatomic, strong) PKCollectionParser *expressionParser;
@property (nonatomic, strong) PKCollectionParser *termParser;
@property (nonatomic, strong) PKCollectionParser *orTermParser;
@property (nonatomic, strong) PKCollectionParser *notFactorParser;
@property (nonatomic, strong) PKCollectionParser *andNotFactorParser;
@property (nonatomic, strong) PKCollectionParser *primaryExpressionParser;
@property (nonatomic, strong) PKCollectionParser *predicateParser;
@property (nonatomic, strong) PKCollectionParser *completePredicateParser;
@property (nonatomic, strong) PKCollectionParser *attributeValuePredicateParser;
@property (nonatomic, strong) PKCollectionParser *attributePredicateParser;
@property (nonatomic, strong) PKCollectionParser *relationValuePredicateParser;
@property (nonatomic, strong) PKCollectionParser *valuePredicateParser;
@property (nonatomic, strong) PKPattern *attributeParser;
@property (nonatomic, strong) PKCollectionParser *relationParser;
@property (nonatomic, strong) PKCollectionParser *valueParser;
@property (nonatomic, strong) PKParser *quotedStringParser;
@property (nonatomic, strong) PKCollectionParser *unquotedStringParser;
@property (nonatomic, strong) PKPattern *reservedWordParser;
@property (nonatomic, strong) PKPattern *nonReservedWordParser;

@end