//
//  SearchModuleConfigurator.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//


#import "SearchModuleConfigurator.h"


#import "SearchInteractor.h"
#import "SearchPresenter.h"
#import "SearchRouter.h"


@implementation SearchModuleContainer
@end


@implementation SearchModuleConfigurator

+ (SearchModuleContainer *)configureteModuleWithView:(id<SearchViewProtocol>)view delegate:(id<SearchModuleDelegate>)delegate {

    //
    SearchInteractor *interactor = [SearchInteractor new];
    SearchRouter *router = [SearchRouter new];
    SearchPresenter *presenter = [SearchPresenter new];

    presenter.output = delegate;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;

    view.output = presenter;
    interactor.output = presenter;

    // Prepare module container.
    SearchModuleContainer *moduleContainer = [SearchModuleContainer new];

    moduleContainer.moduleViewController = (UIViewController<SearchViewProtocol> *)view;
    moduleContainer.moduleInterface = presenter;

    return moduleContainer;
}

@end
