import { Table,SourceData} from '../components/table/Table'
import { SourceTitle } from '../components/table/TableHeader';
@Entry
@Component
struct TableDemo {
  @State sourceTitle:SourceTitle[] = [
    {
      title:"ID",
      key:'id',
      width:200,
      align:'center',
      render:this.render
    },
    {
      title:"ID",
      key:'id',
      width:200,
      align:'center',
      render:this.render
    },
    {
      title:"姓名",
      key:'name',
      width:200,
      render:this.render
    },
    {
      title:"年龄",
      key:'age',
      width:200,
    }
  ]

  @State sourceColumn:SourceData[] = [
    new SourceData({
      id:1,
      name:'xiaoming',
      age:12,
    }),
    new SourceData({
      id:2,
      name:'xiaohong',
      age:12
    })
  ];

  @Builder
  render(record:SourceData,text:string,index:number){
     Text(text).fontColor('red')
  }
  // @State columns:ColumnType[] = []
  build() {
    Column(){
      Button("点击新增")
        .onClick(() => {
           this.sourceColumn.push(new SourceData({
             id:4,
             name:'111',
             age:12
           }))
        })
      Button("点击修改")
        .onClick(() => {
          this.sourceColumn[0].name = "修改完成"
          this.sourceColumn.splice(0,1,this.sourceColumn[0])
        })
      Table({
        sourceTitle:$sourceTitle,
        sourceColumn:$sourceColumn
      })
    }
  }
}