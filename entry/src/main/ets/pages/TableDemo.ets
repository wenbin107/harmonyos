import { Table, SourceData } from '../components/table/Table'
import { SourceTitle } from '../components/table/TableHeader';

@Entry
@Component
struct TableDemo {
  @State sourceTitle: SourceTitle[] = [
    {
      title: "ID",
      key: 'id',
      width: 200,
      align: 'center',
    },
    {
      title: "姓名",
      key: 'name',
      width: 200,
    },
    {
      title: "年龄",
      key: 'age',
      width: 200,
    }
  ]
  @State sourceColumn: SourceData[] = [
    new SourceData({
      id: 1,
      name: 'xiaoming',
      age: 12,
    }),
    new SourceData({
      id: 2,
      name: 'xiaohong',
      age: 12
    })
  ];

  getJson(record: any): string {
    return "1111";
  }

  @Builder
  renderColumn($$: {
    record: SourceData,
    text: string,
    index: number
  }) {
    // 修改第二列的样式
    Column() {
      if ($$.index == 1) {
        Text($$.record.name).fontColor('red')
          .onClick(e => {
            console.log(JSON.stringify($$.record))
          })
      } else {
        Text($$.text)
          .onClick(e => {
            console.log(JSON.stringify($$.record))
          })
      }

    }

  }

  build() {
    Column() {
      Button("点击新增")
        .onClick(() => {
          this.sourceColumn.push(new SourceData({
            id: 4,
            name: '111',
            age: 12
          }))
        })
      Button("点击修改")
        .onClick(() => {
          this.sourceColumn[0].name = "修改完成"
        })
      Table({
        sourceTitle: $sourceTitle,
        sourceColumn: $sourceColumn,
        renderColumn: this.renderColumn
      })
    }
  }
}