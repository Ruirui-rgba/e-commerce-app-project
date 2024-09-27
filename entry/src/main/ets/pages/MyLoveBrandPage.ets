import { ClearMyBrand, InTopNormal, LoveBrand, LoveBrandList, MyloveBrandModel } from '@hm/basic'

@Entry
@Component
struct MyLoveBrandPage {
  @State pageNum:number=1
  @State pageSize:number=10
  @State LoveList:MyloveBrandModel=new MyloveBrandModel()
  @State List:Array<LoveBrand>=[]
  @State Canscroller:boolean=true


  aboutToAppear(): void {
    LoveBrandList(this.pageNum,this.pageSize)
      .then((value)=>{
        this.LoveList=value
        this.List=value.list
        if (this.pageNum >= this.LoveList.pageNum) {
          this.Canscroller=false
        }
      })
  }

  getmore(){
    LoveBrandList(this.pageNum,this.pageSize)
      .then((value)=>{
        this.List=value.list
        if (this.pageNum >= this.LoveList.pageNum) {
          this.Canscroller=false
        }
      })
  }

  build() {
    Column() {
      Stack({alignContent:Alignment.End}){
        InTopNormal({
          title:'我的关注'
        })
        if (this.List.length>0){
          Text('清空')
            .margin({right:10})
            .onClick(()=>{
              ClearMyBrand()
                .then((value)=>{
                  if (value==200) {
                    this.LoveList=new MyloveBrandModel()
                    this.List=[]
                    this.Canscroller=false
                  }
                })
            })
        }
      }

      Scroll(){
        if (this.LoveList.list.length>0){
          Column(){
            ForEach(this.List,(item:LoveBrand)=>{
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
  @State List:LoveBrand=new LoveBrand()
  build() {
    Row(){
      Text(JSON.stringify(this.List))
    }
    .padding(10)
    .width('100%')
  }
}