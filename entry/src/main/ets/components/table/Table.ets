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
  @BuilderParam renderColumn:($$:{row?:any,text?:string,index?:number}) => void
  build() {
    Column() {
      TableHeader({
        sourceTitle:$sourceTitle
      })
      TableBody({
        sourceTitle:$sourceTitle,
        renderColumn:this.renderColumn
      })
    }
    .width("100%")
    .height(100)
    .justifyContent(FlexAlign.Start)
  }
}