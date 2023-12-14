@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State showbtn: boolean = true;

  build() {
    Column() {
      Text(this.message)
      if (this.showbtn === true) {
        Button("显示")
      } else {
        Button("不显示")
      }
    }
    .backgroundColor('red')
    .height(100)
    .width(100)
    .onClick(() => {
      this.showbtn = !this.showbtn;
    })
  }
}