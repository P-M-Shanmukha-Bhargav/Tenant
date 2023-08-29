export interface ResponseModel<T> {
    model: T,
    code: string,
    messages: ResponseMessage[]
}

export interface ResponseMessage{
    message: string,
    code: string,
    Severity: any
}