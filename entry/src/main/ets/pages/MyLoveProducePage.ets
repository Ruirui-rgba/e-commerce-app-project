import { ClearMyLoveProduct, InTopNormal, MyFootModel, MyLoveProductDo, ReadHistory } from '@hm/basic'

@Entry
@Component
struct MyLoveProducePage {
  @State pageNum:number=1
  @State pageSize:number=10
  @State MyFeet:MyFootModel=new MyFootModel()
  @State FeetList:Array<ReadHistory>=[]
  @State Canscroller:boolean=true

  aboutToAppear(): void {
    MyLoveProductDo(this.pageNum,this.pageSize)
      .then((value)=>{
        this.MyFeet=value
        this.FeetList=value.list
        if (this.pageNum >= this.MyFeet.pageNum) {
          this.Canscroller=false
        }
      })
  }

  getmore(){
    MyLoveProductDo(this.pageNum,this.pageSize)
      .then((value)=>{
        this.FeetList.push(...value.list)
        if (this.pageNum >= this.MyFeet.pageNum) {
          this.Canscroller=false
        }
      })
  }

  build() {
    Column() {
      Stack({alignContent:Alignment.End}){
        InTopNormal({
          title:'我的收藏'
        })
        if (this.FeetList.length>0){
          Text('清空')
            .margin({right:10})
            .onClick(()=>{
              ClearMyLoveProduct()
                .then((value)=>{
                  if (value==200) {
                    this.MyFeet=new MyFootModel()
                    this.FeetList=[]
                    this.Canscroller=false
                  }
                })
            })
        }
      }
      Scroll(){
        if (this.MyFeet.list.length>0){
          Column(){
            ForEach(this.FeetList,(item:ReadHistory)=>{
              InFootRow({
                List:item
              })
            })
          }
        }else {
          Text('暂无')
        }
      }
      .onScrollEdge((edge)=>{
        if (this.Canscroller&&edge==Edge.Bottom) {
          this.getmore()
        }
      })
      .align(Alignment.Top)
      .width('100%')
      .height('90%')
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
    .width('100%')
  }
}

@Component
struct InFootRow{
  @State List:ReadHistory=new ReadHistory()
  build() {
    Row(){
      Text(JSON.stringify(this.List))
    }
    .padding(10)
    .width('100%')
  }
}