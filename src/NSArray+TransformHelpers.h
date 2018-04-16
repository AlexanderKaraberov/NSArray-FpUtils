//
//  NSArray+TransformHelpers.h
//
//  Created by Alexander  Karaberov on 16.04.18.
//  Copyright © 2018 All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id _Nonnull (^MapBlock)(_Nonnull id object);
typedef id _Nonnull (^ReduceBlock)(_Nonnull id initialResult, _Nonnull id nextPartialResult);
typedef BOOL (^Predicate)(_Nonnull id object);

@interface NSArray (TransformHelpers)

/** Maps a given block over the receiver array and returns an array containing the results of this mapping
 @param mapBlock A block which will be applied to each element of the array
 @return New transformed array */
- (nonnull NSArray *)map:(nonnull MapBlock)mapBlock;

/** Returns an array containing elements of the receiver in reversed order */
- (nonnull NSArray *)reverse;

/** Applied to a predicate and an array, returns array of those elements that satisfy the predicate
 @param predicate: function from object to boolean type.
 @return New filtered array */
- (nonnull NSArray *)filter:(nonnull Predicate)predicate;

/** Flattens the nesting in an arbitrary array of values
 @return Flattened array
 @code [[1], [[[3]]], 4, [4], [3,[2]]] -> [1,3,4,4,3,2] */
- (nonnull NSArray *)flatten;

/** Returns all the elements of the receiver array exactly once */
- (nonnull NSArray *)uniq;

/** Removes null vulues from array */
- (nonnull NSArray *)compactMap;

/** Produce a single value from the elements of an entire NSArray using reducer block as an accumulating function and seed as intital value */
- (nonnull id)reduceFromSeed:(nonnull id)seed withReduceBlock:(nonnull ReduceBlock)reducer;

/** Same as reduceFromSeed but takes first element of the array as a seed value hence array has to non-empty */
- (nonnull id)reduceWithBlock:(nonnull ReduceBlock)reducer;

@end
