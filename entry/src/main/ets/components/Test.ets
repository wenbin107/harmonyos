/**
 * @param {number | string} titleSize - 表头文字字号
 * @param {number | string} dataSize - 表格项字号
 * @param {number | string} maxWidth - 单格文本最大宽度
 * @param {number | string} listWidth - 表格宽度
 * @param {number | string} listHeight - 表格高度
 * @param {()=>void} ItemClick - 点击表格项回调函数,不传入不显示按钮
 */

/**
 * @param {titleObject[]} titleArr - 表头数组
 * @param {string} name - 表头名称
 * @param {string} titleColor - 表头颜色
 * @param {string | number} dataId - 表头标识
 * @param {string | number} cellWidth - 单元格宽度
 * @param {()=>void} render - 自定义渲染函数
 */
@Observed
export class titleObject {
  name: string
  dataId: string | number
  cellWidth?: string | number
  render?:()=>void
  titleColor?: string = "#ccc"
}

@Component
struct Cell {
  name: string
  cellWidth?: string | number
  @BuilderParam render?:()=> any

  build(){
    Row(){
      if (typeof this.render === "function") {
        this.render()
      } else {
        Text(this.name).fontSize("30px")
      }
    }
  }
}

/**
 * @param {DataObject[]} dataArr - 表格项数据-对象数组
 * @param {string} key - 数组中对象的key
 * @param {string | number} [key: string] - 数组中对象的value
 */
export interface DataObject {
  [key: string]: string | number;
}

@Component
export default struct XTable {
  titleArr: titleObject[]
  titleSize: number | string
  dataArr: DataObject[]
  dataSize: number | string
  ListWidth?: number | string
  listHeight?: number | string = "1100px"
  ItemClick: () => void


  //   {
  //   render:item.render,
  //   width: item.cellWidth,
  // }

  //单元格内容处理
  private toValue(obj: titleObject) {
    var valueArr: object[] = []
    valueArr = this.titleArr.map(item => {
      return {
        value: obj[item.dataId],
        width: item.cellWidth,
        render: item.render,
      }
    })
    return valueArr
  }
  // 类型转换
  convertToString(value: string | number): string {
    return String(value);
  }
  //计算宽度
  private resultWidth() {
    const result: number = this.titleArr.reduce((sum, obj) => {
      if (obj.cellWidth !== null && obj.cellWidth !== undefined) {
        const numericValue = parseFloat((obj as { cellWidth: string }).cellWidth);
        if (!isNaN(numericValue)) {
          return sum + numericValue;
        }
      }
      return sum;
    }, 0);
    return result
  }
  @Builder
  render($$:{item}){

  }
  build() {
    //表格
    if (parseFloat(this.ListWidth as string) > this.resultWidth()) {
      Scroll() {
        Column() {
          //表头
          Row() {
            ForEach(
              this.titleArr,
              (item: object, index?: number) => {
                Row() {
                  Text((item as { name: string }).name)
                    .fontColor((item as { titleColor: string }).titleColor)
                    .fontSize(this.titleSize)
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .width((item as { cellWidth: string | number }).cellWidth)

              }
            )
          }
          .width(this.resultWidth() + "px")
          .height("70px")
          .justifyContent(FlexAlign.SpaceEvenly)

          List() {
            ForEach(
              this.dataArr,
              (item: any, index?: number) => {
                ListItem() {
                  Row() {
                    ForEach(
                      this.toValue(item),
                      (item:any, index?: number) => {
                        Row() {
                          Cell({
                            name:(item as { name }).name,
                            render:(item as {render}).render.bind(this,{item})
                          })
                        }
                        .justifyContent(FlexAlign.Center)
                        .alignItems(VerticalAlign.Center)
                        .width((item as { width: string | number }).width)
                      }
                    )
                  }
                  .height("100px")
                  .justifyContent(FlexAlign.SpaceEvenly)
                  .borderWidth({
                    top: "1px",
                    bottom: "1px"
                  })
                  .borderColor("#ccc")
                  .onClick(() => {
                    item.ItemClick()
                  })
                }
                .width("100%")
              }
            )
          }
          .width(this.resultWidth() + "px")
          .height(this.listHeight)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBarWidth(0)
    } else {
      Column() {
        //表头
        Row() {
          ForEach(
            this.titleArr,
            (item: object, index?: number) => {
              Row() {
                Text((item as { name: string }).name)
                  .fontColor((item as { titleColor: string }).titleColor)
                  .fontSize(this.titleSize)
              }
              .width((item as { cellWidth: string | number }).cellWidth)
              .justifyContent(FlexAlign.SpaceEvenly)
              .alignItems(VerticalAlign.Center)
            }
          )
        }
        .width("100%")
        .height("70px")
        .justifyContent(FlexAlign.SpaceEvenly)

        List() {
          ForEach(
            this.dataArr,
            (item: any, index?: number) => {
              ListItem() {
                Row() {
                  ForEach(
                    this.toValue(item),
                    (item: object, index?: number) => {
                      Row() {
                        Text(this.convertToString((item as { value }).value))
                          .fontSize(this.dataSize)
                          .backgroundImagePosition(Alignment.Center)
                      }
                      .justifyContent(FlexAlign.Center)
                      .alignItems(VerticalAlign.Center)
                      .width((item as { width: string | number }).width)
                    }
                  )
                }
                .width("100%")
                .height("100px")
                .justifyContent(FlexAlign.SpaceEvenly)
                .borderWidth({
                  top: "1px",
                  bottom: "1px"
                })
                .borderColor("#ccc")
                .onClick(() => {
                  item.ItemClick()
                })
              }
            }
          )
        }
        .width("100%")
        .height(this.listHeight)
      }

    }
  }
}
