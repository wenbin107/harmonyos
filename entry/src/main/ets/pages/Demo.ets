@Component
struct Header {
  build(){
    Text("this is header")
  }
}
@Component
struct Body {
  build(){
    Text("this is Body")
  }
}

@Component
struct ListComp {
  @BuilderParam slot: () => void
  build() {
     Column(){
       this.slot()
     }
  }
}
@Builder
function ItemComp(){
    Text("this is detail")
}
@Builder
function InsertBody(){
  Body()
}
@Entry
@Component
struct Demo {
  @Builder
  content(){
    Text("this is body")
  }
  build() {
    Column(){
      Header()
      this.content()
      ListComp({ slot:InsertBody}){
         Text("321312")
        Text("321312")
      }
    }
  }
}