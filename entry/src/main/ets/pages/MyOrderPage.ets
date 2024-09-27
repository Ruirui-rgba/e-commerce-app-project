import { GetShopOrderList, InTopNormal, MyOrderCardAll } from '@hm/basic';
import { router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';

class pageinfo{
  currentIndex:number=0
}
@Entry
@Component
struct MyOrderPage {
  @State @Watch('changescroller')currentIndex:number=0
  private tabcontroller:TabsController=new TabsController()
  @Builder
  TabsContentD0(title:string,index:number){
    Row(){
      Text(title)
        .fontColor(this.currentIndex==index?Color.Red:Color.Black)
    }
    .border({
      width:{
        bottom:1
      },
      color:this.currentIndex==index?Color.Red:Color.White
    })
    .onClick(()=>{
      this.currentIndex=index
    })
    .padding(10)
  }
  changescroller(){
    this.tabcontroller.changeIndex(this.currentIndex)
  }
  aboutToAppear(): void {
    this.currentIndex=(router.getParams() as pageinfo).currentIndex
  }
  onDidBuild(): void {
    this.tabcontroller.changeIndex(this.currentIndex)
  }
  build() {
    Column() {
      InTopNormal({
        title:'我的订单'
      })
      Scroll(){
        Tabs({controller:this.tabcontroller}){
          TabContent(){
            MyOrderCardAll({
              status:-1
            })
          }
          .tabBar(this.TabsContentD0('全部',0))

          TabContent(){
            MyOrderCardAll({
              status:0
            })
          }
          .tabBar(this.TabsContentD0('待付款',1))

          TabContent(){
            MyOrderCardAll({
              status:2
            })
          }
          .tabBar(this.TabsContentD0('待发货',2))

          TabContent(){
            MyOrderCardAll({
              status:3
            })
          }
          .tabBar(this.TabsContentD0('已完成',3))

          TabContent(){
            MyOrderCardAll({
              status:4
            })
          }
          .tabBar(this.TabsContentD0('已取消',4))
        }
        .onChange((value)=> {
          this.currentIndex = value
        })
      }
      .height('90%')
    }
    .height('100%')
    .width('100%')
  }
}