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
  @Link sourceColumn:SourceDataArray
  @Link sourceTitle:SourceTitle[]
  build() {
    Column() {
      TableHeader({
        sourceTitle:$sourceTitle
      })
      TableBody({
        sourceColumn:this.sourceColumn,
        sourceTitle:$sourceTitle
      })
    }
    .width("100%")
    .height(100)
    .justifyContent(FlexAlign.Start)
  }
}