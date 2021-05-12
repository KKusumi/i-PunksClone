source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0' # or platform :osx, '10.10' if your target is OS X.

# 以下のframeworkを使いますみたいな宣言
# 必要
use_frameworks!

target 'i-PunksClone' do
  # 全体で使いたいライブラリをここで書く

  # Rx
  pod 'RxSwift', '6.1.0'
  pod 'RxCocoa', '6.1.0'

  # 個別のTargetで使いたいライブラリをここに書く
  target 'DI' do
    # Swinject
    pod 'Swinject', '~> 2.7.1'
    pod 'SwinjectStoryboard', :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :commit => '0ca45c83a8aa398c153d8a036c95abb4343cfa0c'

  end

  target 'Infra' do
    # Alamofire
    pod 'Alamofire', '~> 5.2'

  end

  target 'Domain' do
  end

  target 'UseCase' do
  end

  target 'UI' do
    # Swinject
    pod 'Swinject', '~> 2.7.1'
    pod 'SwinjectStoryboard', :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :commit => '0ca45c83a8aa398c153d8a036c95abb4343cfa0c'
  end
end
