#import <Foundation/Foundation.h>


@interface NSString (Extensions) 


- (NSNumber*)stringToNSNumber;
- (BOOL)isEmpty;
- (BOOL)stringContainsSubString:(NSString *)subString;
- (NSString *)stringByReplacingStringsFromDictionary:(NSDictionary *)dict;

- (NSString *)filterStringWithCharacterSet:(NSCharacterSet *)separator;
- (NSString *)filterSpecialString;
- (BOOL)isBlank;
- (NSArray *)splitOnChar:(NSString *)ch;
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)stringByStrippingWhitespace;
+ (BOOL) stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;
+ (BOOL) stringIsEmpty:(NSString *) aString;
- (NSString *)removeNumbersFromString:(NSString *)string;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)isPureNumberCharacters;
- (BOOL)isAllNumber;
- (BOOL)isPureInt;
- (BOOL)containsOnlyLetters;
- (NSString*)add:(NSString*)string;
- (NSDictionary*)firstAndLastName;
- (BOOL)isEqualToOneOf:(NSArray*)strings;
- (BOOL)hasPrefixes:(NSArray*)prefixes;
- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes;
- (NSString*)stringByRemovingPrefix:(NSString*)prefix;
- (NSArray *)arrayByCharacterSet:(NSCharacterSet *)separator;
+ (NSString *)filterAlphabet:(NSString *)str;
+ (NSString *)filterFigure:(NSString *)str;
+ (NSString *)stringWithReformat:(NSString *)formatStr;
-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string;
+ (NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *) jsonStringWithArray:(NSArray *)array;

+ (NSString *) jsonStringWithString:(NSString *)string;

+ (NSString *) jsonStringWithObject:(id)object;

- (NSArray *) arrayWithJsonString:(NSString *)jsonString;

+ (BOOL)validateEmail:(NSString *)email;
- (NSArray *)words;
-(BOOL)isChinese:(NSString *)str;

@end
