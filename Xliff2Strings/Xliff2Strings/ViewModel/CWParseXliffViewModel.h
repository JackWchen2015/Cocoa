//
//  CWParseXliffViewModel.h
//  Xliff2Strings
//
//  Created by Jack Chen on 2020/5/30.
//  Copyright © 2020 iwown. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^parseCompleteBlock)(NSAttributedString* resutlt);


@interface CWParseXliffViewModel : NSObject

@property(nonatomic,copy)parseCompleteBlock  completeBlcock;

-(void)parseXliffWithPath:(NSString*)path;



@end

NS_ASSUME_NONNULL_END
