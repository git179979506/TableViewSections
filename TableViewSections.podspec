
Pod::Spec.new do |s|
  s.name             = 'TableViewSections'
  s.version          = '0.1.0'
  s.summary          = 'TableView Sections 更优雅和高效的实现复杂列表。'

  s.description      = <<-DESC
  采用分层解耦的思想，可以很好的解决上面提到的问题
  1. 降低代码复杂度，增加代码的可维护性
  2. 提高代码聚合度，增加代码的可复用性
  3. 通过组合的方式，增加代码的可扩展性，提高多人协作的编码体验和效率
  
  强化 Section，给他创建一个实体，承载更多的逻辑。抽象出 SectionType 类型负责管理自己的数据处理、视图状态、用户交互、业务逻辑等。DataSource 那一层只需要负责Section的组装和页面框架相关的逻辑。
  
  从：`TableView -> DataSource -> Cells`
  变为：`TableView -> DataSource -> Sections -> Cells`
                       DESC

  s.homepage         = 'https://github.com/git179979506/TableViewSections'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoshouwen' => 'zsw19911017@163.com' }
  s.source           = { :git => 'https://github.com/git179979506/TableViewSections.git', :tag => s.version.to_s }
  s.social_media_url = 'https://juejin.cn/user/4265760847569166'
  s.swift_versions = ['4.2', '5.0']

  s.ios.deployment_target = '10.0'

  s.source_files = 'TableViewSections/Classes/**/*'
end
