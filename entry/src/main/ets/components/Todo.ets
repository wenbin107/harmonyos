@Extend(Text) function TitleStyle() {
  .fontColor('#ffffff')
  .fontSize(32)
}
@Extend(Text) function nofinishedStyle(){
  .decoration({
    type:TextDecorationType.LineThrough
  })
  .fontColor('#ccc')
}
@Observed
export class Task {
  static idx: number = 0;
  static id: number = 1;
  title: string = ""
  idx: number = 0;
  id: number = 1;
  finished: boolean = false

  constructor() {
    this.title = "任务" + ((Task.idx++) + 1)
    Task.id++;
    this.id = Task.id;
    this.idx = Task.idx;
  }
}
export interface ITask {
  id: number,
  title: string,
  finished: boolean,
  idx: number
}
@Component
export struct Header {
  public title: ResourceStr = "";

  @Styles wrapper(){
    .width("100%")
    .height(60)
    .backgroundColor("#36F")
  }

  build() {
    Row() {
      Text(this.title)
        .TitleStyle()
    }
    .wrapper()
    .justifyContent(FlexAlign.Center)
  }
}

@Component
export struct TaskItem {
  @ObjectLink item:Task
  changeTaskStatus:() => void
  build() {
    Column() {
      Row() {
        if(!this.item.finished){
          Text(this.item.title)
        }else {
          Text(this.item.title)
            .nofinishedStyle()
        }
        Checkbox()
          .select(this.item.finished)
          .onChange((value: boolean) => {
            this.item.finished = value
            this.changeTaskStatus();
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      .padding(20)

      Divider()
    }
  }
}
