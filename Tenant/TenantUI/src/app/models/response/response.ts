export interface ResponseModel<T> {
    model: T,
    code: String,
    messages: ResponseMessage[]
}

export interface ResponseMessage{
    message: String,
    code: String,
    Severity: any
}