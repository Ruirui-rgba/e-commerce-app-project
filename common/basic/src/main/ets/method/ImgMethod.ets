import { image } from '@kit.ImageKit';
import { resourceManager } from '@kit.LocalizationKit';
import { effectKit } from '@kit.ArkGraphics2D';

export async function ImageMidColor(img:Resource){
  const context = getContext()
  const resoureMgr = context.resourceManager;
  //获取图片数据
  const imgData = await resoureMgr.getMediaContent(img)
  // ArrayBuffer 对象用来表示通用的、固定长度的原始二进制数据缓冲区。
  const buffer = imgData.buffer
  const imgSourse = image.createImageSource(buffer)
  const pixelMap = imgSourse.createPixelMapSync();

  effectKit.createColorPicker(pixelMap, (err, pricker) => {
    let color = pricker.getMainColorSync()
    animateTo({
      duration: 1000,
      curve: Curve.Linear,
      iterations: 1
    }, () => {
      //this.bgColor为背景色的状态变量，下面分别为设置透明度和颜色color 为获取的像素图主要色
      let bgColor = "#" + color.alpha.toString(16) +
      color.red.toString(16) + color.green.toString(16) +
      color.blue.toString(16);
      return bgColor
    })
  })
}
