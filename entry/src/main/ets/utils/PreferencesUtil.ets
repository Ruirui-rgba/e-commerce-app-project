import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';

// 负责所有关于preferences的操作
class PreferencesUtil {
  preference: preferences.Preferences | null = null

  initPreference(context: common.UIAbilityContext, name: string) {
    let options: preferences.Options = { name: name };
    this.preference = preferences.getPreferencesSync(context, options);
  }

  putValue(name: string, value: preferences.ValueType) {
    this.preference?.putSync(name, value)
    this.preference?.flush()
  }
  delValue(name:string){
    this.preference?.deleteSync(name)
    this.preference?.flush()
  }
  getValue(name: string, defValue: preferences.ValueType) {
    if (this.preference) {
      return this.preference?.getSync(name, defValue)
    }
    return defValue
  }
}

let preferencesUtil = new PreferencesUtil()
//
export default preferencesUtil