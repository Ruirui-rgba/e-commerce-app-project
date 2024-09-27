import { ShopClass, ShopTreeModel } from '../model'

@CustomDialog
@Component
export struct ShopListDialog{
  @Prop shoptree:Array<ShopTreeModel>=[]
  @Link ids:number
  private controller:CustomDialogController
  build() {
    Column(){
      Scroll(){
        Column(){
          ForEach(this.shoptree,(item:ShopTreeModel)=>{
            Column(){
              Text(item.name)
                .fontSize($r('app.string.MainFontColor'))
              Line().height(1)
              ForEach(item.children,(itemchilder:ShopClass)=>{
                Row(){
                  Text(itemchilder.name)
                }
                .onClick(()=>{
                    this.ids=itemchilder.id
                  this.controller.close()
                })
                .padding({left:10})
                .width('100%')
                .backgroundColor(Color.White)
                .height(40)
                Line().width(1)
              })
              
            }
          })
        }
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .width('80%')
    .height('100%')
  }
}