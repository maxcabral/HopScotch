//
//  HSDictionaryWrapper.h
//
//  Created by Maxwell Cabral on 8/2/13.
//

#import <Foundation/Foundation.h>

@protocol HSDictionaryWrapperClass <NSObject>
- (void)shallowCopy:(id<HSDictionaryWrapperClass>)target;
@end

@interface HSDictionaryWrapper : NSObject <HSDictionaryWrapperClass, NSCopying>
@property (getter = getInternalDictionary, readonly)                NSMutableDictionary *internalDictionary;
@property (nonatomic, getter = inStorage, setter = setInStorage:)   BOOL          inStorage;
- (id)initWithDictonary:(NSDictionary*)data;
- (NSDictionary*)getInternalDictionary;
@end

@protocol HSCRUDCapableWrapper <NSObject>
@required
- (id)saveRecord;
- (id)deleteRecord;
@end
