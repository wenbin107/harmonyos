@Observed
export class SourceTitle {
  title:ResourceStr
  width?: number
  key?:string
  align?:'left' | 'center' | 'right'

  render?:(row?:any,text?:string|number,index?:number|string) => void
}

@Extend(Row) function commonStyle() {
  .width("100%")
  .justifyContent(FlexAlign.Start)
}



@Component
export struct TableHeader {
  private defaultWidth:number = 100;
  @Link sourceTitle: SourceTitle[]
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

  getColumnWidth(item:SourceTitle):string{
    let totalWidth = this.sourceTitle.reduce((a,b) => {
      return a + (b.width || this.defaultWidth);
    },0);
    if(totalWidth == this.defaultWidth) return "100%";
    return parseInt('' + (item.width / totalWidth * 100)) + '%';
  }


  build() {
    Row() {

      ForEach(this.sourceTitle,
        (item: SourceTitle, index: number) => {
          Column() {
            Text(item.title || '')
          }

          .width(this.getColumnWidth(item))
          .alignItems(this.getColumnAlign(item.align))
          .justifyContent(FlexAlign.Center)
        }
      )
    }.commonStyle()
  }
}