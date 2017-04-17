//
//  MediaContentServiceProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bolts/Bolts.h>


@protocol MediaContentServiceProtocol <NSObject>

- (nonnull BFTask<UIImage *> *)fetchImageMediaFromLink:(nonnull NSString*)link;

@end
