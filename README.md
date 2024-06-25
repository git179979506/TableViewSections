# TableViewSections

采用分层解耦的思想，强化 Section，给他创建一个实体，承载更多的逻辑。抽象出 SectionType 类型负责管理自己的数据处理、视图状态、用户交互、业务逻辑等。
1. 降低代码复杂度，增加代码的可维护性 
2. 提高代码聚合度，增加代码的可复用性 
3. 通过组合的方式，增加代码的可扩展性，提高多人协作的编码体验和效率

从：`TableView -> DataSource -> Cells` 

变为：`TableView -> DataSource -> Sections -> Cells`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<img src="Document/TableViewSections.gif" alt="" width="50%"/>

## Requirements
- iOS 10.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

TableViewSections is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TableViewSections'
```

## Usage
[TableView Sections 更优雅和高效的实现复杂列表](https://juejin.cn/post/7383990445049020455)

## Author

zhaoshouwen, zsw19911017@163.com

## License

TableViewSections is available under the MIT license. See the LICENSE file for more info.
