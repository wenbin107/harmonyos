import { SourceData, SourceDataArray } from './Table'
import { SourceTitle } from './TableHeader'

@Component
export struct TableBody {
  @Consume sourceColumn:SourceDataArray
  @Link sourceTitle:SourceTitle[]
  @BuilderParam renderColumn:(row?:any,text?:string,index?:number) => void
  build() {
    Column(){
      ForEach(this.sourceColumn,
        (item:SourceData,index:number) => {
          TableColumn({ item:item, sourceTitle:$sourceTitle,render:this.renderColumn})
        }
      )
    }
  }
}
@Component
struct TableColumn {
  @ObjectLink item:SourceData
  private defaultWidth:number = 100;
  @BuilderParam render:(row?:any,text?:string,index?:number) => void
  @Link sourceTitle:SourceTitle[]
  getColumnWidth(item:SourceTitle):string{
    let totalWidth = this.sourceTitle.reduce((a,b) => {
      return a + (b.width || this.defaultWidth);
    },0);
    if(totalWidth == this.defaultWidth) return "100%";
    return parseInt('' + (item.width / totalWidth * 100)) + '%';
  }
  getColumnAlign(align){
    if(!align) align = 'center';

    switch (align){
      case 'left':
        return HorizontalAlign.Start
        break;
      case 'center':
        return HorizontalAlign.Center
        break;
      case 'right':
        return HorizontalAlign.End
        break;
    }
  }
  getText(item:SourceTitle,index:number):string{
    return String((this.item as any)[item.key]) || ''
  }
  build(){
    Row(){
      ForEach(this.sourceTitle,
        (item: SourceTitle, index: number) => {
          Column() {
            this.render(item,this.getText(item,index),index)
          }
          .width(this.getColumnWidth(item))
          .alignItems(this.getColumnAlign(item.align))
          .justifyContent(FlexAlign.Center)
        }
      )
    }
  }
}

