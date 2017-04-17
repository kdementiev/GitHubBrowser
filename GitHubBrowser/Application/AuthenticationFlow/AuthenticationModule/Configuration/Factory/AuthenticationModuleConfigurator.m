//
//  AuthenticationModuleConfigurator.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//


#import "AuthenticationModuleConfigurator.h"


#import "AuthenticationInteractor.h"
#import "AuthenticationPresenter.h"
#import "AuthenticationRouter.h"

#import "GitHubCredentialsValidator.h"

@implementation AuthenticationModuleContainer
@end


@implementation AuthenticationModuleConfigurator

+ (AuthenticationModuleContainer *)configureteModuleWithView:(id<AuthenticationViewProtocol>)view delegate:(id<AuthenticationModuleDelegate>)delegate {

    //
    AuthenticationInteractor *interactor = [AuthenticationInteractor new];
    AuthenticationRouter *router = [AuthenticationRouter new];
    AuthenticationPresenter *presenter = [AuthenticationPresenter new];

    presenter.output = delegate;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;

    view.output = presenter;
    interactor.output = presenter;
    interactor.credentialsValidator = [GitHubCredentialsValidator new];
    
    [router prepareWithViewController:view];

    // Prepare module container.
    AuthenticationModuleContainer *moduleContainer = [AuthenticationModuleContainer new];

    moduleContainer.moduleViewController = (UIViewController<AuthenticationViewProtocol> *)view;
    moduleContainer.moduleInterface = presenter;

    return moduleContainer;
}

@end
