//
//  SwinjectStoryboard+Setup.swift
//  DI
//
//  Created by kusumi on 2021/04/19.
//

import Foundation
import Swinject
import SwinjectStoryboard
import UseCase
import Domain
import UI
import Infra

extension SwinjectStoryboard {
    class InfraAssembly: Assembly {
        func assemble(container: Container) {
            container.register(BeerDataSource.self) { _ in
                return BeerApiService()
            }.inObjectScope(.container)
        }
    }
    class DomainAssembly: Assembly {
        func assemble(container: Container) {
            container.register(BeerRepository.self) { resolver in
                let dataSource = resolver.resolve(BeerDataSource.self)!
                return BeerRepository(dataSource: dataSource)
            }.inObjectScope(.container)
        }
    }
    class UseCaseAssembly: Assembly {
        func assemble(container: Container) {
            container.register(BeerUseCase.self) { resolver in
                let repository = resolver.resolve(BeerRepository.self)!
                return BeerUseCase(repository: repository)
            }
        }
    }
    class ViewModelAssembly: Assembly {
        func assemble(container: Container) {
            container.register(BeerListViewModel.self) { resolver in
                let useCase = resolver.resolve(BeerUseCase.self)!
                return BeerListViewModel(useCase: useCase)
            }
            container.register(BeerDetailViewModel.self) { resolver in
                let useCase = resolver.resolve(BeerUseCase.self)!
                return BeerDetailViewModel(useCase: useCase)
            }
        }
    }
    class ViewControllerAssembly: Assembly {
        func assemble(container: Container) {
            container.storyboardInitCompleted(BeerListViewController.self) { resolver, vc in
                vc.viewModel = resolver.resolve(BeerListViewModel.self)!
            }
            container.storyboardInitCompleted(BeerDetailViewController.self) { resolver, vc in
                vc.viewModel = resolver.resolve(BeerDetailViewModel.self)
            }
        }
    }
    
    @objc class func setup() {
        let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
        assembler.apply(assemblies: [
            InfraAssembly(),
            DomainAssembly(),
            UseCaseAssembly(),
            ViewModelAssembly(),
            ViewControllerAssembly()
        ])
    }
}
