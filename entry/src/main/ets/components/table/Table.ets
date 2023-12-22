import { TableBody } from './TableBody';
import { SourceTitle, TableHeader } from './TableHeader'
@Observed
export class SourceData{
  [key: string]: any
  constructor(params) {
    for (const key in params) {
      this[key] = params[key];
    }
  }
}


@Observed
export class SourceDataArray extends Array<SourceData> {
}



@Component
export struct Table {
  @Link sourceTitle:SourceTitle[]
  @Link sourceColumn:SourceDataArray;
  @BuilderParam renderColumn:($$:{row?:any,text?:string,index?:number}) => void
  update(){
    console.log(JSON.stringify(this.sourceColumn))
    // this.sourceColumn = this.sourceColumn;
  }
  build() {
    Column() {
      TableHeader({
        sourceTitle:$sourceTitle
      })
      TableBody({
        sourceTitle:$sourceTitle,
        sourceColumn:this.sourceColumn,
        renderColumn:this.renderColumn
      })
    }
    .width("100%")
    .height(100)
    .justifyContent(FlexAlign.Start)
  }
}