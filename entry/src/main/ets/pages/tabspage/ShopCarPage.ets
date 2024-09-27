import { Shopcard } from '@hm/basic'
import { router } from '@kit.ArkUI'

@Component
export struct ShopCar{
  @StorageLink('login') login:boolean=false
  build() {
    Column(){
      if (this.login){
        Shopcard()
      }else {
        Image($r('app.media.emptyCart'))
          .width(200)

        Text(`去登陆>`)
          .fontColor(Color.Red)
          .onClick(()=>{
            router.pushUrl({
              url:'pages/LoginPage'
            })
          })
      }
    }
  }
}