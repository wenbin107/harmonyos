import { Table,SourceData} from '../components/table/Table'
import { SourceTitle } from '../components/table/TableHeader';
@Entry
@Component
struct TableDemo {
  @Provide sourceTitle:SourceTitle[] = [
    {
      title:"ID",
      key:'id',
      width:200,
      align:'center',
    },
    {
      title:"ID",
      key:'id',
      width:200,
    },
    {
      title:"姓名",
      key:'name',
      width:200,
    },
    {
      title:"年龄",
      key:'age',
      width:200,
    }
  ]

  @Provide sourceColumn:SourceData[] = [
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
  renderColumn($$:{record:SourceData,text:string,index:number}){
    // 修改第二列的样式
    if( $$.index == 1){
      Text($$.text).fontColor('red')
    }else{
      Text($$.text)
    }

  }

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
        })
      Table({
        sourceTitle:$sourceTitle,
        renderColumn:this.renderColumn
      })
    }
  }
}