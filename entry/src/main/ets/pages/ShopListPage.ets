import { GetShopClassIn, GetShopTree, InTopNormal, Product, ProductBrand,
  ShopListDialog,
  ShopTreeModel } from '@hm/basic'
import { router } from '@kit.ArkUI'

class pageinfo{
  id:number=0
}
@Entry
@Component
struct ShopListPage {
  @State productbrand:ProductBrand=new ProductBrand()
  @State ids:number=0
  @State @Watch('changeid')changeids:number=0
  @State pageNum:number=1
  @State pageSize:number=6
  @State sort:number=0
  @State product:Array<Product>=[]
  @State @Watch('changeindex')chooseindex:number=0
  @State cansoller:boolean=true
  @State shoptree:Array<ShopTreeModel>=[]
  dialogController:CustomDialogController=new CustomDialogController({
    builder:ShopListDialog({
      shoptree:this.shoptree,
      ids:this.changeids
    }),
    customStyle:true,
    alignment:DialogAlignment.CenterEnd
  })
  aboutToAppear(): void {
    this.ids=(router.getParams() as pageinfo).id
     GetShopClassIn(this.ids,this.pageNum,this.pageSize,this.sort)
      .then((value)=>{
        this.productbrand=value
        this.product=this.productbrand.list
        if (this.pageNum >= value.totalPage) {
          this.cansoller=false
        }
      })
    GetShopTree().then((value)=>{this.shoptree=value})
  }
  changeindex(){
    GetShopClassIn(this.ids,this.pageNum,this.pageSize,this.chooseindex)
      .then((value)=>{
        this.productbrand=value
        this.product=this.productbrand.list
        if (this.pageNum >= value.totalPage) {
          this.cansoller=false
        }
      })
  }


  changeid(){
    this.ids=this.changeids
    GetShopClassIn(this.ids,this.pageNum,this.pageSize,this.sort)
      .then((value)=>{
        this.productbrand=value
        this.product=this.productbrand.list
        if (this.pageNum >= value.totalPage) {
          this.cansoller=false
        }
      })
  }
  getmore(){
    if (this.pageNum<this.productbrand.totalPage) {
      this.pageNum++
      GetShopClassIn(this.ids,this.pageNum,this.pageSize,this.chooseindex)
        .then((value)=>{
          this.productbrand=value
          this.product.push(...this.productbrand.list)
          if (this.pageNum >= value.totalPage) {
            this.cansoller=false
          }
        })
    }
  }

  @Builder
  underTop(){
    Row(){
      Row({space:10}){
        Text('综合排序')
          .fontColor(Color.Black)
          .padding({bottom:10})
          .fontColor(this.chooseindex==0?Color.Red:Color.Black)
          .border({
            width:{
              bottom:2
            },
            color:this.chooseindex==0?Color.Red:Color.White
          })
          .onClick(()=>{
            this.chooseindex=0
          })
        Text('销量优先')
          .fontColor(Color.Black)
          .padding({bottom:10})
          .fontColor(this.chooseindex==2?Color.Red:Color.Black)
          .border({
            width:{
              bottom:2
            },
            color:this.chooseindex==2?Color.Red:Color.White
          })
          .onClick(()=>{
            this.chooseindex=2
          })
        Text('价格')
          .fontColor(Color.Black)
          .padding({bottom:10})
          .fontColor(this.chooseindex==3||this.chooseindex==4?Color.Red:Color.Black)
          .border({
            width:{
              bottom:2
            },
            color:this.chooseindex==3||this.chooseindex==4?Color.Red:Color.White
          })
          .onClick(()=>{
            if (this.chooseindex==3) {
              this.chooseindex=4
            }else {
              if (this.chooseindex==4) {
                this.chooseindex=3
              }else {
                this.chooseindex=3
              }
            }
          })
      }
      .width('80%')
      .justifyContent(FlexAlign.SpaceBetween)
      Image($r('app.media.tab_cate'))
        .width(25)
        .height(25)
        .onClick(()=>{
          this.dialogController.open()
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .backgroundColor(Color.White)
    .padding(5)
  }

  @Builder
  ShopsView(item:Product){
    Column(){
      Image(item.pic)
        .width(200)
        .height(200)
      Text(item.name)
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Ellipsis
        })
      Text(item.subTitle)
        .maxLines(2)
        .textOverflow({
          overflow:TextOverflow.Ellipsis
        })
      Row(){
        Text('￥'+item.price)
          .fontColor(Color.Red)
        Text('已售'+item.sale)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(5)
      .width('100%')
    }
    .onClick(()=>{
      router.pushUrl({
        url:'pages/ShopItemPage',
        params:{
          id:item.id
        }
      })
    })
  }
  build() {
    Column() {
      InTopNormal({
        title:'商品列表'
      })
      this.underTop()

      Scroll(){
        Column(){
          Grid(){
            ForEach(this.product,(item:Product)=>{
              GridItem(){
                this.ShopsView(item)
              }
            })
          }
          .backgroundColor(Color.White)
          .backgroundColor(Color.White)
          .columnsTemplate('1fr 1fr')
          .width('100%')
          if (!this.cansoller){
            Text('没有更多数据......')
              .margin({top:10,left:10})
          }
        }
      }
      .align(Alignment.Top)
      .onScrollEdge((edge)=>{
        if (edge==Edge.Bottom) {
            this.getmore()
        }
      })
      .height('85%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
  }
}
