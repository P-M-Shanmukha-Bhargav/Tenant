export interface TokenResponse {
  user: User
}
  
export interface User {
  uid: string
  isAnonymous: boolean
  info: Info
  credential: Credential
}
  
export interface Info {
  uid: string
  federatedId: any
  firstName: any
  lastName: any
  displayName: string
  email: string
  isEmailVerified: boolean
  photoUrl: any
  isAnonymous: boolean
}
  
export interface Credential {
  idToken: string
  refreshToken: string
  created: string
  expiresIn: number
  providerType: number
}