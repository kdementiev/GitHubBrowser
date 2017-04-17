//
//  ProfileModuleConfigurator.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//


#import "ProfileModuleConfigurator.h"


#import "ProfileInteractor.h"
#import "ProfilePresenter.h"
#import "ProfileRouter.h"

#import "TokenStorageService.h"
#import "MediaContentService.h"

@implementation ProfileModuleContainer
@end


@implementation ProfileModuleConfigurator

+ (ProfileModuleContainer *)configureteModuleWithView:(id<ProfileViewProtocol>)view delegate:(id<ProfileModuleDelegate>)delegate {

    //
    ProfileInteractor *interactor = [ProfileInteractor new];
    ProfileRouter *router = [ProfileRouter new];
    ProfilePresenter *presenter = [ProfilePresenter new];

    presenter.output = delegate;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;

    view.output = presenter;
    interactor.output = presenter;
    
    // Prepare with services.
    interactor.tokenStorage = [TokenStorageService new];
    interactor.mediaProvider = [MediaContentService new];
    
    //
    [router prepareWithViewController:view];

    // Prepare module container.
    ProfileModuleContainer *moduleContainer = [ProfileModuleContainer new];

    moduleContainer.moduleViewController = (UIViewController<ProfileViewProtocol> *)view;
    moduleContainer.moduleInterface = presenter;

    return moduleContainer;
}

@end
