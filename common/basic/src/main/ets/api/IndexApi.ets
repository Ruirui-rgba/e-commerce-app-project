import { AxiosResponse } from '@ohos/axios'
import { axiosInstance, Message } from '../http/Axois'
import { IndexModer } from '../model'

export  function GetMessageIndex(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/home/content')
    .then((value)=>{
        return (value.data.data as IndexModer)
    })
}