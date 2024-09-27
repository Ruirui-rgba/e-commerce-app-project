import { LoveBrand, ReadHistory } from '.'

export class UserLogin{
  username:string=''
  password:string=''
}
export class UserToken{
  tokenHead:string=''
  token:string=''
}

export class UserRegister{
  authCode:string=''
  password:string=''
  telephone:string=''
  username:string=''
}

export class UserAddress{
  city: string = "";
  defaultStatus: number = 0;
  detailAddress: string = "";
  id: number = 0;
  memberId: number = 0;
  name: string = "";
  phoneNumber: string = "";
  postCode: string = "";
  province: string = "";
  region: string = "";
}


export class MyFootModel{
  list:Array<ReadHistory>=[]
  pageNum:number=0
  pageSize:number=0
  total:number=0
  totalPage:number=0
}

export class MyloveBrandModel{
  list:Array<LoveBrand>=[]
  pageNum:number=0
  pageSize:number=0
  total:number=0
  totalPage:number=0
}

