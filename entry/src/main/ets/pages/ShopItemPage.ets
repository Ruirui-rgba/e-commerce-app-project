import {
  AddproductCollection,
  AddShopCar,
  CreateHistory,
  DelproductCollection,
  GetShopItemInfo,
  GetShopYouHui,
  PingJia,
  ReadHistory,
  ReadProcuctCollection,
  SendDiag,
  ShopCar,
  ShopDiagchooseColor,
  ShopDiagInfo,
  shopinfoIndatil, ShopItem, ShopItemInfoCard,
  ShopItemInfoCardNovalue } from '@hm/basic'
import { promptAction, router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

class info{
  id:number=0
}
@Entry
@Component
struct ShopItemPage {
  @StorageLink('login') login:boolean=false
  @State Shopinfo:ShopItem=new ShopItem()
  @State value:string=''
  @State color:Array<string>=[]
  @State HaveNumber:string[]=[]
  @State selectcolor:string=''
  @State selectnumber:string=''
  @State shopdatil:Array<shopinfoIndatil>=[]
  @State shopcar:ShopCar=new ShopCar()
  @State ShopHistory:ReadHistory=new ReadHistory()
  @State ShopLove:ReadHistory=new ReadHistory()
  @State iflove:boolean=false
  dialogController:CustomDialogController=new CustomDialogController({
    builder:SendDiag(),
    customStyle:true,
    alignment:DialogAlignment.Bottom
  })

  dialogControllertwo:CustomDialogController=new CustomDialogController({
    builder:ShopDiagchooseColor({
      value:this.value,
      shop:this.Shopinfo.product,
      color:this.color,
      HaveNumber:this.HaveNumber,
      selectcolor: this.selectcolor,
      selectnumber:this.selectnumber
    }),
    customStyle:true,
    alignment:DialogAlignment.Bottom
  })

  dialogControllerthree:CustomDialogController=new CustomDialogController({
    builder:ShopDiagInfo({
      shopdatil:this.shopdatil
    }),
    customStyle:true,
    alignment:DialogAlignment.Bottom
  })

  async aboutToAppear(): Promise<void> {
    let id=(router.getParams() as info).id
    await GetShopItemInfo(id)
      .then((value)=>{
        this.Shopinfo=value
        this.value=this.Shopinfo.productAttributeValueList[0].value.split(',')[0]+this.Shopinfo.productAttributeList[1].inputList.split(',')[0]
        this.color=this.Shopinfo.productAttributeValueList[0].value.split(',')
        this.HaveNumber=this.Shopinfo.productAttributeList[1].inputList.split(',')
        this.selectcolor=this.Shopinfo.productAttributeValueList[0].value.split(',')[0]
        this.selectnumber=this.Shopinfo.productAttributeList[1].inputList.split(',')[0]
        this.getShopKeyAndValue()

        this.ShopHistory.productId=this.Shopinfo.product.id
        this.ShopHistory.productName=this.Shopinfo.product.name
        this.ShopHistory.productPic=this.Shopinfo.product.pic
        this.ShopHistory.productPrice=this.Shopinfo.product.price
        this.ShopHistory.productSubTitle=this.Shopinfo.product.subTitle

        CreateHistory(this.ShopHistory)
      })
    ReadProcuctCollection(id)
      .then((value)=>{
        this.ShopLove=value
        if (this.ShopLove.productId != 0) {
          this.iflove=true
        }
      })
  }

  getShopKeyAndValue(){
    let productAttributeList=this.Shopinfo.productAttributeList
    let productAttributeValueList=this.Shopinfo.productAttributeValueList
    for (let i = 2; i < productAttributeList.length; i++) {
      for (const element of productAttributeValueList) {
        if (element.productAttributeId==productAttributeList[i].id) {
          this.shopdatil.push(new shopinfoIndatil(productAttributeList[i].name,element.value))
          break
        }
      }
    }
  }
  build() {
    Column() {
      Stack({alignContent:Alignment.Bottom}){
        Scroll(){
          Column(){
            Stack({alignContent:Alignment.TopStart}){
              Image(this.Shopinfo.product.pic)
                .width('100%')
              Image($r('app.media.ic_btn_nav_back'))
                .width(40)
                .height(40)
                .backgroundColor(Color.Gray)
                .fillColor(Color.White)
                .borderRadius(50)
                .margin({left:15,top:5})
                .onClick(()=>{
                  router.back()
                })
            }
            Column(){
              Text(this.Shopinfo.product.name)
                .width('95%')
              Text(this.Shopinfo.product.subTitle)
                .fontSize($r('app.string.MidFontSize'))
                .fontColor($r('app.color.GrayFontColor'))
                .width('95%')
              Row(){
                Text('￥'+this.Shopinfo.product.price)
                  .fontColor(Color.Red)
                Text('￥'+this.Shopinfo.product.originalPrice)
                  .fontSize($r('app.string.GrayFontColor'))
                  .fontColor($r('app.color.GrayFontColor'))
                  .decoration({
                    type: TextDecorationType.LineThrough,
                    color: Color.Black
                  })
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
              Row(){
                Text('销量: '+this.Shopinfo.product.sale)
                  .TextDeration()
                Text('库存: '+this.Shopinfo.product.stock)
                  .TextDeration()
                Text('浏览量: 768')
                  .TextDeration()
              }
              .width('95%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
            .backgroundColor(Color.White)

            Row(){
              Text('该商品分享可领49减10红包')
              Row({space:5}){
                Text('立即分享')
                  .fontColor(Color.Red)
                Image($r('app.media.ic_btn_more'))
                  .width(20)
                  .height(20)
                  .fillColor(Color.Red)
              }
              .onClick(()=>{
                this.dialogController.open()
              })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('95%')


            ShopItemInfoCard({
              lefttitle:'购买类型',
              value:this.value,
              icon:$r('app.media.ic_btn_more'),
            })
              .onClick(()=>{
                this.dialogControllertwo.open()
              })

            Line().height(1)
            ShopItemInfoCardNovalue({
              lefttitle:'商品参数',
              titlevalue:'查看',
              icon:$r('app.media.ic_btn_more')
            })
              .onClick(()=>{
                this.dialogControllerthree.open()
              })
            Line().height(1)

            ShopItemInfoCardNovalue({
              lefttitle:'优惠券',
              titlevalue:'领取优惠券',
              icon:$r('app.media.ic_btn_more')
            })
              .onClick(()=>{
                if (this.login) {
                  GetShopYouHui(this.Shopinfo.product.id)
                }else {
                  router.pushUrl({
                    url:'pages/LoginPage'
                  })
                }
              })
            Line().height(1)
            ShopItemInfoCardNovalue({
              lefttitle:'促销活动',
              titlevalue:'暂无'
            })
            Line().height(1)
            ShopItemInfoCardNovalue({
              lefttitle:'服务',
              titlevalue:'无忧退货'
            })

            Line().height(5)
            PingJia()
            Line().height(5)
            Column(){
              Text('品牌信息')

              Row(){
                Image(this.Shopinfo.brand.logo)
                  .width('40%')
                Column(){
                  Text(this.Shopinfo.brand.name)
                  Text('品牌首字母'+this.Shopinfo.brand.firstLetter)
                }
                .margin({left:10})
                .width('40%')
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .backgroundColor(Color.White)
              .padding(10)


            }
            .width('100%')
            .backgroundColor(Color.White)
            Column(){
              Text('图文详情')
              RichText(this.Shopinfo.product.detailMobileHtml)
            }
            .width('100%')
            .backgroundColor(Color.White)
          }

        }
        .height('100%')
        .align(Alignment.Top)
        Row(){
          // 详情展示页面去首页
          Column(){
            Image($r('app.media.tab_home'))
              .RowImg()
            Text('首页')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.MidFontSize'))
          }
          .onClick(()=>{
            router.pushUrl({
              url:'pages/Index'
            })
          })


        //   购物车
          Column(){
            Image($r('app.media.tab_cart'))
              .RowImg()
            Text('购物车')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.MidFontSize'))
          }
          .onClick(()=>{
            router.pushUrl({
              url:'pages/Index'
            })
            emitter.emit({eventId:1})
          })


          // 待做 收藏
          Column(){
            Image(this.iflove?$r('app.media.lovedo'):$r('app.media.love'))
              .RowImg()
            Text('收藏')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.MidFontSize'))
          }
          .onClick(()=>{
            if (this.login) {
              if (this.iflove) {
                DelproductCollection(this.Shopinfo.product.id)
                  .then((value)=>{
                    if (value) {
                      this.iflove=!this.iflove
                    }
                  })
              }else {
                AddproductCollection(this.ShopHistory)
                  .then((value)=>{
                    if (value) {
                      this.iflove=!this.iflove
                    }
                  })
              }
            }
          })


          Stack(){
            Row(){
              // 待做 购买   上方价格要匹配
              Button('立即购买',{type:ButtonType.Normal})
                .width(100)
                .fontColor(Color.White)
                .border({
                  radius:{
                    topLeft:50,
                    bottomLeft:50
                  }
                })
                .linearGradient({
                //渐变方向
                direction: GradientDirection.Right,
                //数组末尾元素占比小于1时，满足重复着色的效果
                colors: [['#fe9b3a', 0.0], ['#fa4f63', 0.5]]
              })
                .onClick(()=>{
                  promptAction.showToast({
                    message:'仅支持购物车购买'
                  })
                })
              Button('加入购物车',{type:ButtonType.Normal})
                .width(100)
                .fontColor(Color.White)
                .border({
                  radius:{
                    topRight:50,
                    bottomRight:50
                  }
                })
                .linearGradient({
                  //渐变方向
                  direction: GradientDirection.Left,
                  //数组末尾元素占比小于1时，满足重复着色的效果
                  colors: [['#fe9b3a', 0.0], ['#fa4f63', 0.5]]
                })
                .onClick(()=>{
                  if (this.login) {
                    this.shopcar.price=this.Shopinfo.product.price
                    this.shopcar.productAttr=this.value
                    this.shopcar.productBrand=this.Shopinfo.product.brandName
                    this.shopcar.productCategoryId=this.Shopinfo.product.productCategoryId
                    this.shopcar.productId=this.Shopinfo.product.brandId
                    this.shopcar.productName=this.Shopinfo.product.name
                    this.shopcar.productPic=this.Shopinfo.product.pic
                    this.shopcar.productSkuCode=this.Shopinfo.skuStockList[0].skuCode
                    this.shopcar.productSkuId=this.Shopinfo.skuStockList[0].id
                    this.shopcar.productSn=this.Shopinfo.product.productSn
                    this.shopcar.productSubTitle=this.Shopinfo.product.subTitle
                    this.shopcar.quantity=1
                    AddShopCar(this.shopcar)
                      .then(()=>{
                        emitter.emit({eventId:2})
                      })
                  }else {
                    router.pushUrl({
                      url:'pages/LoginPage'
                    })
                  }
                })
            }
            Text('|')
              .fontColor(Color.White)
          }

        }
        .padding(5)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('92%')
        .backgroundColor('rgba(255, 255, 255, 0.85)')
        .margin({bottom:20})
      }
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
    .width('100%')
  }
}

@Extend(Image)
function RowImg(){
  .width(30)
  .height(30)
}
@Extend(Text)
function TextDeration(){
  .fontSize($r('app.string.GrayFontColor'))
  .fontColor($r('app.color.GrayFontColor'))
}