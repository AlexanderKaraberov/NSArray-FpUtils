//
//  NSArray+TransformHelpers.m
//
//  Created by Alexander  Karaberov on 16.04.18.
//  Copyright © 2018 All rights reserved.
//

#import "NSArray+TransformHelpers.h"

@implementation NSArray (TransformHelpers)

- (nonnull NSArray *)map:(nonnull MapBlock)mapBlock {
    NSParameterAssert(mapBlock);
    __auto_type const output = [NSMutableArray array];
    [[self compactMap] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [output addObject:mapBlock(obj)];
    }];
    return [output copy];
}


- (nonnull NSArray *)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}


- (nonnull NSArray *)filter:(nonnull Predicate)predicate {
    NSParameterAssert(predicate);
    __auto_type const output = [NSMutableArray array];
    [[self compactMap] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (predicate(obj)) [output addObject:obj];
    }];
    return [output copy];
}


- (nonnull NSArray *)flatten {
    __auto_type const flattened = [NSMutableArray array];
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]] && [object respondsToSelector:@selector(flatten)])
            [flattened addObjectsFromArray:[((NSArray *)object) flatten]];
        else
            [flattened addObject:object];
    }
    return [flattened copy];
}


- (nonnull id)reduceFromSeed:(nonnull id)seed withReduceBlock:(nonnull ReduceBlock)reducer {
    NSParameterAssert(seed && reducer);
    id result = seed;
    for (id object in self) {
        result = reducer(result, object);
    }
    return result;
}


- (nonnull id)reduceWithBlock:(nonnull ReduceBlock)reducer {
    NSParameterAssert(reducer && self.count && self.firstObject);
    return [self reduceFromSeed:self.firstObject withReduceBlock:^id _Nonnull(id  _Nonnull initialResult, id  _Nonnull nextPartialResult) {
        return reducer(initialResult, nextPartialResult);
    }];
}


- (nonnull NSArray *)uniq {
    return [[[NSOrderedSet orderedSetWithArray:self] array] compactMap];
}


- (nonnull NSArray *)compactMap {
    NSMutableArray * const selfArray = [self mutableCopy];
    [selfArray removeObjectIdenticalTo:[NSNull null]];
    return [selfArray copy];
}


@end
