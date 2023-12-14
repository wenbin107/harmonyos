import { DataObject, default as XTable, titleObject } from '../components/Test';


@Entry
@Component
struct Test {
  @Builder
  render(){
    Text('ceshi');
  }
  @State titleArr: titleObject[] = [
    {
      name: "标题",
      dataId: 1,
      render:this.render.bind(this)
    },

    {
      name: "内容",
      dataId: 1,
      render:this.render
    }
  ];
  @State dataArr: DataObject[] = [
    {
      name:'标题',
      value:'text'
    }
  ]

  build() {
    Column() {
      XTable({
        titleArr: this.titleArr,
        dataArr: this.dataArr
      })
    }
  }
}