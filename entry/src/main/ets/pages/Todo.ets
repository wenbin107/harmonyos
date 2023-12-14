import { Header,TaskItem, ITask,Task } from '../components/Todo';



@Entry
@Component
struct Todo {
  private title: string = "todo";
  @State tasks: ITask[] = [new Task()];

  onclickHandler() {
    this.tasks.push(new Task());
    this.changeTaskStatus()
  }
  changeTaskStatus(){
    this.tasks = this.tasks
      .sort((item1:ITask,item2:ITask) => (~~item1.idx - item2.idx))
      .sort(item => (~~item.finished))

  }
  build() {
    Column() {
      Header({ title: this.title })
      Row() {
        Button("添加任务")
      }.height(100)
      .onClick(this.onclickHandler.bind(this))
      Divider()
      List() {
        ForEach(this.tasks,
          (item: ITask, idx: number) => {
            ListItem() {
              TaskItem({
                item:item,
                changeTaskStatus:this.changeTaskStatus.bind(this)
              })
            }
          })
      }
      .layoutWeight(1)
    }
  }
}